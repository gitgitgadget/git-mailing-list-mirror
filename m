Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B42BE7C8
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420755; cv=none; b=rPpauAZo5g0e4j76CktXij+GfgH8OuRgT66p6E93oE6aRh5BApnOQ+h71rsOwjW1+xL7Ot0KoCydAykg9p+LrmJ4fhxJhiJXzXbiFPBmSbHn2CA7rgNxxzPPn76+wlnCZuFYhYWMXxHnAtnGUU1ZpYKjLn+iWMMoFywxpDYPfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420755; c=relaxed/simple;
	bh=YTlZXNbH91iEIOCLsZVbhDmEmAzS2kZlIIZVvZGSvJw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F2Y9YgxermSEajiD61YgTcB56vKLumioD0yJW4OKONk61KKazGihNS11Qsuhwe6rDPeAhgMJfPv01dWwP+fu/RXvQLaTiQ4h85iXH1n1iGZ2XWh/RbYeyZ7dtT5gGrRPm2yphDQTopZN6QCeYbPl9Qxj7yLnfrhJ23QdTcK6G84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2LGsa3S; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2LGsa3S"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bc55f6612so207821b3a.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754420753; x=1755025553; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTlZXNbH91iEIOCLsZVbhDmEmAzS2kZlIIZVvZGSvJw=;
        b=T2LGsa3Suqbqercvp4YTyjayS1jTknA9K9igh6qtHLSAk8ad3iDVAEtT/66XMJ5nZu
         lqRmc5JL4JwUeEvWaxwxRh9kKvIADHeyrBMQKytFPVYIXC44CQnB6In32ASWffgBYsG3
         GRKhPgpoL9UnjwF88yPsj4mnt29JBCtzdIh5AWviNzApk2o0NzSKXjCMZTjg4Ddi3fAT
         lRwI1jn17rEjlrwB0Ad969DM+fCefkEaVco8p3gVxsWp7D9AuuH1wF9ufa23GwYQgES0
         KUeOsWN4J+raKY3nGNQVSMsuG8z57LaUajQBQyUi7inUt4erOxEjiqTsfkny8KDEhgCH
         sswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420753; x=1755025553;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTlZXNbH91iEIOCLsZVbhDmEmAzS2kZlIIZVvZGSvJw=;
        b=APRbk2EWkj2D/ngJ0kKu3cH0eP5aHfDvnGT1tiP20vsB3aS202qIioLZRwHXyI8G/e
         +DcXHm8Hu4DjB608qFOHiXQ3KUJr+CqU3j71ggXCzzP8uDM0IqJ7qZIJxw1dsLrD0ZlF
         EkhiMrAF56asfL8Q2pWvtNjswkEZ+PB2ikP8tTv9VWpYNtGFUfxkUHQ8qxqs9cSBJeS/
         B7JA3p1fr1P23EQEA14QCiVZdSKdhKVSFK7DQNb9rRQKjjjABqyzOw95qhxgSz8LM8PO
         H1AFPtETdPXEEXIrEB966KtMxQ3CBOysO6LBtDMJfFTDu5CJloyZzQC68tnNE0PavP9m
         p77A==
X-Gm-Message-State: AOJu0YxgQWvjA1bOSoeozTFdkAVinJjJyKTSCmPNPfMmzVtwtpPWKes4
	j+ijbPDp5aLOJ70EnMkkZOjHoamoTdRfS7UJmoeasfVxW37+0uSuyBkSxJuPl/vr
X-Gm-Gg: ASbGncsBfXodPndLa+wSf9hbAwfhrc2P4IdXEDttN71Bw6VKj94g/PMFPm+GJq7cO+W
	WAwcAJ+h3tBlZyvI5iYe+AmBExThlCrHDcbV1mIE1Xe021on3pKOhmKUb+Q9BtnCdEBTqT4d8Ee
	bKtSmxiNmvdq+Ye/abnGZDrL+S2OToI9K37VPvBvu4svr4yHtXcLQpKvvHMjelkYXsnGpJmXs6P
	Dmo3WoICN6v0dDfAsxSes3E0xWgmgTXOfMY3p28jkkFliUFgqP4N3mu55eXW3Rk224wPn8DHMrw
	/mGrQuJZIoaRY5A9ph+6nL68zL3xDySRVXWcHvi1cBY4tnUHc3kkSMYelUkaq6Yls+bNANl8ALL
	O/s0yi1A80t/oetqmC7GvmkkryAkhA7e1M71JVmlHHU9Rv1b3XQNkjwT0
X-Google-Smtp-Source: AGHT+IF4cb8hIz11JyDrrwkDrdCKPn/JKadn4Rehl1PcCdT6GUH1hFBbLmm0i9S4gaJY7O4l9eNtAw==
X-Received: by 2002:a05:6a20:4309:b0:220:1843:3b7b with SMTP id adf61e73a8af0-2403190690dmr127013637.4.1754420753098;
        Tue, 05 Aug 2025 12:05:53 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7be31dsm11729769a12.14.2025.08.05.12.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Aug 2025 12:05:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC] Blog: Machine-Readable Repository Information Query Tool
 (week 9)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
Date: Tue, 5 Aug 2025 16:05:39 -0300
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: 7bit
Message-Id: <31429FDA-8F4E-4BA4-AC53-825E00F24856@gmail.com>
References: <A203C3BB-AEC9-457E-87B8-189B81C579BF@gmail.com>
To: git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)

Hi!

Here's the 9th update on my GSoC blog:

https://lucasoshiro.github.io/gsoc-en/#week-9-jul-28th--ago-3rd
