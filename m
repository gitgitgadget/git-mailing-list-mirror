Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAA1F3D42
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439516; cv=none; b=qp5TQ/IRmoIgby0e1ofae9I0XUHesSKeQVBdhrCXuyJtmlOwGYpHSDdwcKCcJ/LpOmrRNmtM5mGxFHBgzzkjfgQ+BpPjjRD4YWUrrQxZmYwTKPL4WxnqbfHUJuhSvkteZJRvY+ZoEXr1DhxFgXOAvQglxnvwEhiheqvihSN2hOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439516; c=relaxed/simple;
	bh=urw9Nhdq5mWwqwleTfOzm7BiPN90hkBG9RlX9qPI48w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/55/WDMvDrbQMwq5eVrVnxi/7/7WH35MuD5I3Du6WZY7mEVvqReVDrPb9K6NRSPlo8+neVD5sp40w3sUU6q10tX1JUA7mLkfq5n9lSghOmGq7XdQruKebqM6BiOcvWH3KZsa4tNNRj33C2rGbJLzrm2I0vL7q5a+H5Gpl+rXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF1U++MQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF1U++MQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21669fd5c7cso45093385ad.3
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 04:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734439514; x=1735044314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ib6ap4f3bkUgqpwiqDzIV6o1ixwKZ9a4qqVsDMLAn0=;
        b=CF1U++MQoncULtkrl3YTH4vQR3IiWbDWQs0YJ2F3Qui/rAuwEPEHorw+w/udPG3b+7
         jhV7V4+GFjKxkOKD1KJc3cxYtseAZpWwba1BY4tGpQZag+BfzQGAc3T4mkUVvDQU2zA1
         Z6Qc+NROg5pLzrPj6SMUYguCVkxAaddWAJt4Ak2qdtGbMvxFGqxxmE3hq7098dHDb3Wa
         eXBgrqy14Ks84yEX77s2hkNBGeRVaWI0Ej67n1/2xh9Or/Z9OstWtV3ayadxCTdjQOds
         u7N0CvJBvqAZfcATE7DPPok4iqZhBg5ee4dIa0VSw/tEDQSh5gAQiWz7nWyDF/lGdXOB
         AwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439514; x=1735044314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ib6ap4f3bkUgqpwiqDzIV6o1ixwKZ9a4qqVsDMLAn0=;
        b=fzyNo6w3F4tG8SaCRqHm9UVWCEAbOD8zSW6tgz1wQh8KUHXNUjQMcYky1Hsd5AF+QO
         mdLLY2ZBAjt8+Otnd6vP04oYrAF9hnmg/nlWNE4ZZk25RB56VApg+x5TqyR3J51TXpPc
         AtGNXHzAD58AgSTdc05jUwhnvLn4b9XHSNo91Rw8TiBGMtdmtSkBfom4xGmotn9yUeq6
         VasXZZBAdNlv90FSVFkMjvvGyhrcYCKCRwd1DfQcaSUZWLOjrKbq8obxn1qZaEXLRM8E
         28UntemGi6xk5Vk83N1NVOy5OFh7q33aap5mz8SO59Mnyp9303s8rCZBe047oLVmpL9L
         W35A==
X-Gm-Message-State: AOJu0YxaIubAPz4JNQt6Zi/7Pe24l76kyVmxIkXYWykslRsx9p3Qcg56
	lWx8SL8ezK00hsjh0GYS4aDIA33iXvmF6+t8vhwmjWZCBDRaOS/AV2OAFA==
X-Gm-Gg: ASbGnctnXp8nTa2om+SnQUQp7AlyDGUpY6WX62CEE1erESIT7x8KK3Lc5lH5nyHpY71
	AnGcQiEgct4MLqZukzafZKHDDX44fYqIAL8cKzksmXXAzBAz22GRmqiSEsQJPnVZ85fK/buUzxe
	sOLrc/FL/SgIN7ewsejkyGZJdhhM14cLkMES9r5CES29jwQZXQXjQIoADywvHuX8PivvCMC+Maw
	LixhUVZgwj1LdA0Lucw2qcoGv9XB8WPNALYlBqeRTa3G1vx939r
X-Google-Smtp-Source: AGHT+IGNTis4gQ3ownm9tRGF5yHJs4QlnUeaczSpf9A67uU0riTn3V0YgOKE8bNo88ilt5+fpau2fQ==
X-Received: by 2002:a17:902:f648:b0:216:554a:2127 with SMTP id d9443c01a7336-21892a5871emr241342435ad.41.1734439514148;
        Tue, 17 Dec 2024 04:45:14 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50ab8sm58110305ad.115.2024.12.17.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:45:13 -0800 (PST)
Date: Tue, 17 Dec 2024 20:45:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/14] Stop using `the_repository` in some trivial cases
Message-ID: <Z2Fygp-5pFQi1p41@ArchLinux>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>

On Tue, Dec 17, 2024 at 07:43:47AM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series performs some refactorings to stop using
> `the_repository` in several subsystems. There wasn't really any
> criterium for which subsystems I picked, except that all of them have
> been trivial to convert.
> 
> In this patch series I'm merely bubbling up `the_repository` one more
> layer even though some calling contexts already have a repository
> available. For the sake of triviality I decided not to handle these
> cases though and instead let a future patch series worry about them.
> 

Actually, I am excited to see that we remove the global variable
"the_repository" in some subsystems because I have seen every patch with
"<subsystem>: stop using `the_repository`".

By this, we make the problem smaller, which is good. I have read through
all the patches, which looks to me.

Thanks,
Jialuo
