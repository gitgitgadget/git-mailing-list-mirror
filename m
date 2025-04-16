Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32D1A08A0
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819356; cv=none; b=JgvIESUvEnJy2eiBQn5VtHv4MqN8LPuxpRVVPY0glRY8IpmhjQh0S47YAplrztyVaGZgMkUSvj8cB7d/sDqoUvSC2RKeoNvxjhmdIEVk6/NI8IChyR9xtsNapbISUuQl8DkWWawTMubHek0qmwIr7Krxw5MpTxf52UAtUuUacoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819356; c=relaxed/simple;
	bh=pd2CEBQG6rJuKuKMJLYXliv+1XSR4JBjh8RUUK8Auuc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kJrLBSwnom33xc6N/8chSqMNVozebG7nv6gAKWjSdN17OpVu6pNgpuf0RlbNzhyyTj1Uqmr5W1t76t2VA8pMSBq2r9IV0Mznew/Ay4caj0cXdtmGEV5/FWlCxKa4x34l35o3K80pyThYP2bXzYLuxdt4MMiimLcBVALT1aO5WGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdz4ZeIG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdz4ZeIG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so5389417a91.2
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819353; x=1745424153; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd2CEBQG6rJuKuKMJLYXliv+1XSR4JBjh8RUUK8Auuc=;
        b=kdz4ZeIGHRcTvaTohTuFGhStqMdTWMpiDcTOBVRb/Bt4JWIE3xCMKifPOBXzFjLluc
         zI56MUySvFJo3s6CP/ats3TlhIPEj2g5X3SBAA2UWt6DjUjzstYwD43JsZQ9oK1pwEby
         cxxyzbkmM+C4f9G8uFsKaRAlagsrRLrnrQ9OLiKfmp+4vH4SHfE/lnGJPLEnMd0UbTfS
         lsM4ydbSoT7DIvobmIb1OFRkwrVj+K7k6r+xNkdmoIs4Xpd8gKfv31KWig1YD6tkalgN
         gKyQFJZgb08GB9fXq6aqm6Z88b42Nn9biabuPqK/P80N+Qu6vj9laeK5s2UCPZqgvhGt
         nCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819353; x=1745424153;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd2CEBQG6rJuKuKMJLYXliv+1XSR4JBjh8RUUK8Auuc=;
        b=HxcnfJ3H88A9mQjZFNLB5uQJutajOBz/SwXMYneZ6L8WHXj3VtmmYrFsJ/uAdBqNFJ
         Rxmrc9TpkkV6T7X+kExr3pbhHN4/JFeuLJ3VR3UEva+70lnVYHNa0HyucGncqK9ZGfGf
         g4Yul5as9zT4srpY6k1G68rlnax7mJCMMXs8hFI9WmCzVDeEdbhd4n4Syesc3TIKXf/L
         wZu617shvVfoi2GCp0jk55VCz+1+VkJElvwWy191V7jbFZ4tzoUomXnH/pGFPS64AwbX
         Rm5PACPMKT1K6a8sSqiqTomjN0p405zQjn9seATVnDi+Iczor5DSJgY6ZvN8Z/LU+2+4
         Hfkg==
X-Gm-Message-State: AOJu0YzGLi/CSS8bewH8UwGuSPnH2usqJ5rNI0pqZbZ4Qijeqj8a/mwZ
	j6JYmWMbY7bTqxWjSdx/jfYrgxbqplbvP/IM+kA8r01NTQ5ryLB5r+gt3Q==
X-Gm-Gg: ASbGncv9aqfnbI+9Bu6gpw8HkTaUWIetwNDj7L9TuhL2nsyfaCtP0CoSbU3nESYg3S3
	bcjfIFDkhDEVxyXUgNDSL09gPXSAVyPdRJkkKf0X2hj//dZotQbZ+4Dqw2C73cM/0uqIW5815DS
	xrVwc6qegWmzVw34Pj1//TgnDpZj+MiDoqxSoWIjixV0/C/msU1YAIIDZd9AHq9UgC0rgWrAEfE
	Lw/kcWcYRZ8++9SHa2hsprjHBtNcFy5n6Wb9R3IDg4L5xysbeOA8G0CnHO1L2f4a0kTuQMePoIk
	0Gk60DYVWsAFZxPPovxJc266oxdgmBOxQ2hEtFQSWQbvm8nBiPX+qTeleD7f+Tts8NNm7PgPNPM
	IqeI=
X-Google-Smtp-Source: AGHT+IHn5YXiprvaA3AQON7qcKb+FzdIhsraw71vAdZrZthpaezEXo2RJBiS0GoFJjBwyTULMPp8xA==
X-Received: by 2002:a17:90b:58cd:b0:2ff:5357:1c7e with SMTP id 98e67ed59e1d1-308640279fdmr3978925a91.20.1744819353540;
        Wed, 16 Apr 2025 09:02:33 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:899b:9db3:7efc:4ac2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611f3f31sm1791465a91.16.2025.04.16.09.02.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Apr 2025 09:02:32 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC PATCH] revision: remove log_reencode field from rev_info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <Z_9wQLTtj9t45Wjj@pks.im>
Date: Wed, 16 Apr 2025 13:02:19 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C8DDA8D1-A241-4DD0-876B-F2F859FD6073@gmail.com>
References: <20250414151438.22232-1-lucasseikioshiro@gmail.com>
 <Z_9wQLTtj9t45Wjj@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> Nit, not worth a reroll: historic information like this is always a nice
> addition to the commit message so that other people don't have to dig
> into history themselves to figure out why the field isn't used anymore.

Ooops, sorry

> The patch looks obviously good to me, thanks!

Thank you for reviewing another patch of mine!



