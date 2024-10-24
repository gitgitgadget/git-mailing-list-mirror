Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF51B6D0A
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770295; cv=none; b=gwp1tcsA+mqY/Ryn2lBv0wBa0z6/4dsD4Z3WcOz1Bsj5KBKYX5CFOorvH+BwhEktcbVobhEY4mZvBSBte6kB2QkyPHkYb1cIaUhKZ7gx2mMSmcKO65zKvghMEjHqMUz4r+ygzf8pP700I+hPEhCHaJEM1UKoOvzvigWi+K5f94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770295; c=relaxed/simple;
	bh=+haouLqKDq5Dr5WzizxrydudjKxrJmiDsnlarn8lUYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM2PCUobZk+skQAVwkYf1VOBx1MhCuf/s2vGvHXvWB6PwVP8WYPZuFJ1hQuhZT+ijzkBy8vrvf8w6SSJl90VfEzpRN4SJOS1B172EJRndWuuqDxFouCOMP9hg2+kA4/bLOCyQLWGMu6xr17Y/MDVj9WUN4h+/euWkLn/PpxEY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx54YCtg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx54YCtg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so8455135e9.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729770292; x=1730375092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAlQextOnASUMRwK54xMZx8H1cGGDkyo9hhmU7LcddQ=;
        b=bx54YCtgfLBHEXpDblR8l2nNpXQ5ApLRIh8dUNJ21FrTF0a4wpxh1YazK8RzFgxZRc
         WrOtJbrmWXmre62LnkBMgnwo5KZfJunU/yzniqoe8ZzVf6gBkTw07CaKIgNT+cZPwjps
         egqVMZbrOfnrBjKiMwEn6tDH462LEYRAJ71S0ms3DwAbEnULgxWxCwSkhGcH7Y8PQiku
         MAEEPN4/tGaPTklv5hfzbm1LgVarCUEykSlmuQwAkPG2n/FPFWs6kj64jRfM/EE6Y89/
         4fbdwuyJvBg7aG9HTBeOM1ytlOK3qxPMPkEolhzJ3Se7tevu9sREtLqYcVc5cPbxnWoy
         gUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729770292; x=1730375092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAlQextOnASUMRwK54xMZx8H1cGGDkyo9hhmU7LcddQ=;
        b=vd/IoPcA6KxYu6W/yLXYCnzuqWyepPAzUfCMmSC0VWgC8lnbexvwZdBuCjM3boJkCL
         B/+wCgli2EzLYE0WA6XyJLhwpY3vXCRx1TMAJ104WvPDPppomJ+t/pXt5wbX6tIe47Ai
         kXM7Db2JxTCIzp0w2XRb9sXXaZOISbmKsw3261sG7bcqrA3o1xr9zhjI5g20bvl6DQoV
         3MybzQjA10n960+a1V16ZNPl/RI9BfHFVEY7fkJUIyOoSNAxCl9OVbMUiL1Nuk1EWm22
         2Ekva5l8JcA+qL9H/qbhEYdqsaHqSTpInfvqVU3qlrOo0R/7H7KZo26p2FWCpYNjIslK
         2BDA==
X-Forwarded-Encrypted: i=1; AJvYcCUDNAHe7JCOr8SmJwkj+ChRofGR0bqLIiSSPo9Asu5Olug1lBAwtOTBbUMkyh2W+HOAcMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIubsTgpXUW0o1h7u/cvO7GJ4wGUoUo1nCzX8fP4/m0lqXK69D
	2xglVnoCF5JEjFylnLppSqpaH0f2/WzFCPLL27t5msdy6VZXWsPp
X-Google-Smtp-Source: AGHT+IH0oVj+KpaDmkIXjgJPcYz8wzawIyE/K5WCSveVlQbasfNrp5W4anhVU6mksZIFVcEGPCRzQA==
X-Received: by 2002:a05:600c:510f:b0:431:5655:1ef3 with SMTP id 5b1f17b1804b1-4318419a3ecmr45243995e9.23.1729770291888;
        Thu, 24 Oct 2024 04:44:51 -0700 (PDT)
Received: from void.void ([141.226.14.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f784sm14872435e9.19.2024.10.24.04.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:44:51 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:44:49 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxozMR6CebV5J7H7@void.void>
References: <20241023170111.6638-1-algonell@gmail.com>
 <fa5d771b-5819-4ede-bc95-9d50c456c619@app.fastmail.com>
 <ZxlBedgkkNfOJ8BX@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxlBedgkkNfOJ8BX@nand.local>

On Wed, Oct 23, 2024 at 02:33:29PM -0400, Taylor Blau wrote:
> Yeah, I think "to fail" is what was supposed to be written her, but "a
> failure" would also be acceptable.
> 
> Thanks,
> Taylor

Thank you both, on it.
