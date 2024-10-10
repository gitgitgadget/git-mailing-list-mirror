Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1229442A8C
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573259; cv=none; b=qb1Z7NMGMXMCBpa/Y4dapWPOB9ZWfPz56iXC/RgIhIaTpT3Cbx/a8nlWKZKIYQtiMI3wWJmEdiE2OUflzuViLRKmo6ONWODo6G1gxWHNFxg2vcxEOXkDZEUu89zvnFqLJ+svK9EBG+oWf5JcdYrYjLh8A7MNIBfO38r0seAhe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573259; c=relaxed/simple;
	bh=UwOwwqlOx5WJIpAjgQPxawgCbC9+5MGuNXSp3QbdZes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7tEP8N45+CWfGx2AhgRCA+UfCHJON3s/IUz1iHCU7IJAxWbJtTc8PkVz1fcMr6V0PAAjKjLI4OzvUEW0KWzZmIfT3EwXQzcwneRc7CMuvtefU9J0MTYWk0GvtOA7H6Dzmi1Ioo+17tKOGqzw0x70nu8TwRw4mbyYZkcANCj2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBhyrpYI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBhyrpYI"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5399651d21aso947190e87.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573255; x=1729178055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BUdGUFn0VpAjycFQQM2J1No7SlAgFUfHRx5KUxpU18=;
        b=HBhyrpYIhoiWO1itqs0BkeXJN6xcZYJkUw6+ZeZzvIkwrSLQABqEEfncBhYGC1eoTd
         N18T4aumWy80treE/r3Taz1+C/tAKXvBc1RknJs3UBdTd4LZkflNgdmd5jAC0zMlpvZ8
         gq1StfKdaXmN6IbbjHa8pBizGLVhwYsEz8PLURlJaBrt320tAOvzgXrfT7o0cc9tRYIx
         nWSPkl38znNUxhxYHwzaKr1pKW1fst3Dr8TGzQNRjGWRqoDantdVUamUMaEb6m3oMDld
         /ix6CrCJTlqjX6y/goLNKzeqyVlfZ5fg1h4ZB/yZQsivIpHj41ZcGIfljj39r2v1EBn+
         83lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573255; x=1729178055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BUdGUFn0VpAjycFQQM2J1No7SlAgFUfHRx5KUxpU18=;
        b=WK+5KguwUEQWuYTH8j3xY0U/bWsXpAKN2Xb1iLu67oWR/15PXQCYonmJWG5tmYxGHp
         Y0dq6KVNK1PebmRvhZ5M+b3sPdox3xiRPPl05nDyb8UwICgsbG4dTnu/JoKDYmC9fYTQ
         qCyEYTvRys2Xm1aqFzOfAWgryGNBNXdnysYGtoExqChvWDwKdp+woQFg7C3OcPlpcxG8
         UpDGKbIjpNah5JB73lzd4OUm1YUyvDL6j1TMm/IpRxw4E9mzOWKVi2LjjjZ6eMXilQCZ
         +UtENi1um5EhJKSnMCieUYRs9TXOfqXvwdYCbTgC43W1f8eQ/uuhBaX4Kkc6iA1qsHcl
         /I7g==
X-Gm-Message-State: AOJu0YyCDfN5qhcq4eVE3wOrD1vzfEleTg9jh5ddr+m0D4Dr8kvqeX08
	wYBqnslX5TFBC5Cf89Fr8B6pK+Sf3XIQQs5k0ns7yqjIIFWeamOrmYXv33eNdL4=
X-Google-Smtp-Source: AGHT+IH2lCPoHYUG5E/H7+hahIo+qMQjgCEk6aVFitvJzSq9uz1O19KDfcAwi7yKNLrcb3xor6cU0w==
X-Received: by 2002:a05:6512:1592:b0:536:53b2:1d0d with SMTP id 2adb3069b0e04-539c488a58bmr3768445e87.9.1728573254819;
        Thu, 10 Oct 2024 08:14:14 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f254bbsm101450266b.61.2024.10.10.08.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:14:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 18:14:13 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] compat: fix typos
Message-ID: <ZwfvRTGPFDb6rzt5@ip-172-26-2-149.eu-west-1.compute.internal>
References: <20241009114940.520486-1-algonell@gmail.com>
 <20241009114940.520486-2-algonell@gmail.com>
 <Zwd6TGeksR9UiM8i@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwd6TGeksR9UiM8i@pks.im>

On Thu, Oct 10, 2024 at 08:55:08AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 09, 2024 at 02:49:34PM +0300, Andrew Kreimer wrote:
> 
> Do we want to fix grammar while at it? s/all group is/all group are/
> 

Absolutely, thank you.
