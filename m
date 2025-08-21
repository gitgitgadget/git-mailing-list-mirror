Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF43314D7
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782625; cv=none; b=bvJg3iFLKsDff417uSSNLI4ul6V7JrqchIus6lkss6u28niYboz0xJgPPpmp5+bYbIAtL7CEfkU+N3mIQOQPRNL0XLASYoW7VHrJuNgPSEorY+byTdCFciNa4YCLH3KJazqnyDXYm7cgeVebjAZK6fIRIc5JTofo0cYpm4qJ0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782625; c=relaxed/simple;
	bh=4vNIVmkoa6Z68DoKK6FCzK6kcRLE7T6tVI6848qJ0c8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LqniMQbndxg3VhFmYBTmfL/qqfKcnlJSlX2SllkiQd7JnpC+JLDUiFp6qxkEm5KrpRdWg3nf0/sFHbATeDMjtKlqWChhg5GhPgzNlzr23PO2NTtpsDc2l7vX3dQNuYQ3mpPyOfaI9j7k4BmVQZgTxp4+Lh5Vvd9v4tDUt0SBNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzMBW/7D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzMBW/7D"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e1ff326bbso1588414b3a.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755782623; x=1756387423; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vNIVmkoa6Z68DoKK6FCzK6kcRLE7T6tVI6848qJ0c8=;
        b=DzMBW/7D6Zg3ynnFTsfFBMsQIwv+c/qetlyoBJUIVuWw3PWJ44puihu2CKG5G9+ecV
         Ud1SJilaPBH8DWTKgWcsBmW6QEL2ZJb6lVTs3uB0YfYV7TcIZvtLMGPCQ1ts1X6QsI0Z
         JUqU8faP9SLoVGg3j7LBaiASEplr7p5JGQZSo83j0XjAdgOqgkjEfl3WwadVOwqSIUGV
         jJR9ZogyVJpGw4JLNLdvIKcaq8IUj+wjNK8euqPLDA5fb/X8EMgkAl4Z93wQoOqrgXtd
         Nr+W6V3o7v+Yx6oa1qePun+RwyLaouzn4xPzeD5CllzwZATVNUcp2xGnsBhqTasV7Xna
         8E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782623; x=1756387423;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vNIVmkoa6Z68DoKK6FCzK6kcRLE7T6tVI6848qJ0c8=;
        b=m05m3s6i/11ym/gZWcfyQoIbtsXmvGQmjB19H5RqmKysz9NykkHCOqcWahK4RKMSNy
         5KgGiWFHcWYzqzBJkRS2KB729mX5SK89kkvRcFUkA2se552JneKV+uS7CYcWPqeiE7tg
         OPsb4REsZWtPTKvJSTIFtEwFsCMsxMQXsoPz16nabpifOoutBYvRNq5EPFI3r8kWcQRy
         3ppJ+Ylq2D0fb7Ht8HlwiI2O+E9gf/mqgJ7NUPf0c6wQjQa9PKAMwg2RsS0VSkGJf8mw
         9AWsalQQmTx+4xI3oDFNvJMSUVpT9SgmzkEdRd26BW63EhyYYwU7I7xw2l1L5hWlJAbG
         aBSA==
X-Gm-Message-State: AOJu0YyVkl9W5EoPIkyQqB4YQSSsYLNTeD6qsd+HHRumIbiWPScsOYp9
	J9Ixy6LCHtLBgO6YywbXMLc00UqTbciluJFJbedhyEGCXJGrN487yK69
X-Gm-Gg: ASbGncuPt1C8b4CXQYubUGu6iTPVp552PQdiLjWv7JxtrGbR2DIUBO4lyl3oshfLeZy
	z7ue+ffY1SkSKCGZz1VLZUNqNS3unHxxIWgUQ8FCpkuk2WWi+1NiSQ/eSwhmb5kb6lrhjG9Pf2q
	OzVaDyu1+IL+Y701SUjnMZoTYrEqy09nPGSLcJy9Xy2AvXRCW1oPzafCPiFATfwKSO19idx9RCU
	4xTc+OKUW/ZQRFx3u8iDFkTG37aT4V/gKd0AkH/32ZkdvFVcHVkjtXg2q7PUt6nZhBVJ9dBJRnu
	N22RRJ9tXXvOqaB8lYhccsEDAdd54N7sYe857gLGNJhwUILOrjD93WRxgAQQONlCs6kTl0ntavp
	NUdTVp5D7/5ZagkU0HtiyqiWUCAoNhj5qhs+nVlbIsDp2WEtIWtp46na0
X-Google-Smtp-Source: AGHT+IHB4/SFuTolZLD/y4FFR2qHTXTnely/tJiUIoq79etHPH6+XGUbgWFoEBShlBrk8jnaoIZIhA==
X-Received: by 2002:a05:6a20:748c:b0:243:78a:82d0 with SMTP id adf61e73a8af0-24330819e8dmr3334840637.29.1755782623205;
        Thu, 21 Aug 2025 06:23:43 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e81227473sm7676284b3a.51.2025.08.21.06.23.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 06:23:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH 0/2] repo: add -z and objects.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aKb1AfeIWB_SfJiI@pks.im>
Date: Thu, 21 Aug 2025 10:23:29 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <2AE1A298-97D9-411A-A3B4-AB0A48D71536@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <aKb1AfeIWB_SfJiI@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.700.81)


> What this cover letter doesn't mention is the base of the topic. I
> assume it's v2.51.0 with lo/repo-info merged into it?

I was assuming next, but I'll make it more clear in the next
version.

