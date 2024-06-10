Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105A1B812
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999477; cv=none; b=OpExmjEgEpB4hBIBZPebwhva1QkS5doZ7m2TZB4WjiJQLyHh3Ye8yE1sQne6QP9A69n9ONOt3G8Hr7+M2e9YxQjuWQQnD/c9eXEmY/H9YkOQHIeVzIUxyRbziJ9yM1uJm+0Gx/zUQUMN30dfxYDBo9+EC6gSgmS9YkfGJsQYKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999477; c=relaxed/simple;
	bh=vTmZwcvoKi39PMk/8nsII6Z/BMtGdpoDIEsyX5ZUUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW5ELnHlkl7b7hv6Q0K5ed8xXRK2kkekPm06SiWYhLFfaU73ww+NgJmxH/SXbQxFA7auuZ7ftBHBqcSb//ENyaZNEWEyZXyC1jrl7dG4lhkb3IszycW6Q+7ZGYh2XmVzuGnmjqd55PwbBrwKGl4INDpuG0yObLOTqVjgfdWUpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNNW+V27; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNNW+V27"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f6a045d476so2919145b3a.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717999474; x=1718604274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+KKBjetKPotgBkntCfnCRczFssWoRvkw+mH2DiYQPw=;
        b=aNNW+V27sOrpWF9lLbqyEeHs/EtQTGoT5z1qPj+qnn863d8tdGP6y9+sZl5PDzypi9
         T5srdSozcBL0hEAO6JHG7qh8ZyjdjxXPWrCzc+vPycK5Z1en3XL46WnoRUZ0abeJ3Ysi
         JFefodC1dbS7gzwcpYLjTyHR59PLz+6msaQldbWddFWMMBjZWYshcaKG8zFoaLxKKjKU
         2NrT7A/q1WO81oIZe4I99Exdb/SFjqFB6rqV1sSLeMtaACad0v+L8kHLjcUKvpFVZLsW
         loljHIUWI2hNoud0zs0j8OZ9U2aVf2gVPpbgy0NDZvZB+/nW5dhZN1F24IJnwwc+hQrn
         qQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717999474; x=1718604274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+KKBjetKPotgBkntCfnCRczFssWoRvkw+mH2DiYQPw=;
        b=IjB4hVd60zR3BBtgW8ETVGyFOR0zjUfGY8KPgg9xeIs/Fx86QT1bX6shoG8r6K11We
         /3t2lZrMCrMWSTyAyD961EY4XmoLTtTjKtdQgYmkwtjqc85JkmDSULmzu0CzYYoA9/MM
         mS/dj240H9aQqXjQBmqUn+vc9Lxm1Qanf3dio4ly5amra8F+v4u9DOog+g5d5PkWrV6a
         U91hpUYKm2AFLFC2KCqnaxnnrs86+9n/Rt6xP3a9D7NnkbYeVf4Sl7vkhLlPQcRUK83o
         Ic1OzgQE/tlU3sjs5JKlzrOp9JWbj5MYEs/OF0hTo+Uo6x5UKRFaH9YA1C2jTwxp5bE8
         9pIA==
X-Gm-Message-State: AOJu0YylqmvhvnzMUIqvGOuOOhquAk3gTJ8M2Ks4TOUXZP7io+rdzX1v
	/8+pLalEE9kAqPGLKx8jkXVXZpLOTy+p7mYqL3UCrHbNcQ1bhHgBTF6t+w==
X-Google-Smtp-Source: AGHT+IH+VoFvtrciO3XwJcSHIb326YLi4+fCW5Sw3o7oegcKkaesEx3+1yhis49nxRRTlNg6//cp2Q==
X-Received: by 2002:a05:6a21:6d9a:b0:1a9:8836:ae37 with SMTP id adf61e73a8af0-1b2f969bf66mr8908739637.12.1717999474119;
        Sun, 09 Jun 2024 23:04:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70597b74dd5sm902691b3a.34.2024.06.09.23.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:04:33 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:04:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZmaXcCwLfvXcaTxJ@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

This is my GSoC week 1 post:

  https://luolibrary.com/2024/06/10/GSoC-Week-2/

Thanks,
Jialuo
