Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447291ABEAF
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722691913; cv=none; b=FXYIxGJwuqyb8lZWx5xxebv+utV1ZIMkQBmnabO2oe6V/jdO4wFhAPO74xWZxNnCILsAdX9Z7BjsXHQMQFUQ6ZS30NH99wCGRS427YnSpNa9r/4L0Hak9fAs2SAfYAfdd2ojWPGxV2nrIJndHOtCmU6n7Ru6gmjlzsdX7OBh2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722691913; c=relaxed/simple;
	bh=064gEwp4nmS1Gvr4p9x7fLMbBi6GEB4KKts9ED8oycE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aWpNzdU4vtbfLsvsdyaLngq2KpOad+b00KB7iBBBSsZYqtkxJMujfdQ3ka7RlkyTr9/n4nFEBOZ13pGEWSKvwvuAAd5Lrx8pHinRDAiT8Z2R6B5t0iiL3PDRiHnUYwE5rXr2ZO5hbN7gwsUVCkcfFt2IwPCh/yx2dy9FRsyp3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd2Ul32U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd2Ul32U"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc611a0f8cso68542635ad.2
        for <git@vger.kernel.org>; Sat, 03 Aug 2024 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722691911; x=1723296711; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=064gEwp4nmS1Gvr4p9x7fLMbBi6GEB4KKts9ED8oycE=;
        b=hd2Ul32UqxcwP1FYb1U79F8NWnPe+kV45fUFP3imPHQ6tqyKXPJcaMTkwSB9GQ33Th
         tVhqS6jfcCf6epIDB+9ii+7DxG6DxwyjvAkKeaTeVib91j3EnirJvV80ArlFdXXf7Ql9
         q3Lv4/Hg+xYMP7iik7fUKoc/nPSvoHhOTWrTXTw9D8q70eBH5EBLnq9G7x5WIQP7OTTw
         86f9aNheyl3pxz4KtkAHx5cxBv3bUM9dJzW9BRKFkQ5Ad4DoYKq+yXBPc/anVKWq7Gc6
         LcT2NcZzIGEN+FMa92RhWnASmhyuwrG8Nog+MxiCSdcNGFRE/LRqtsNU2thuZ1/xOhXO
         O9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722691911; x=1723296711;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=064gEwp4nmS1Gvr4p9x7fLMbBi6GEB4KKts9ED8oycE=;
        b=wt+ziuOpv55UVjAUAqWK6Ci+69jhpeh3J/EXi/4Rn2R6go8vNISD1FtTM2eDL3j5A9
         B9OLS50tKnDLwa3jaUJ5cxE6D6Dm1ZcKnyu2cYoRZsMVVRu23shA6DvCtZ/cC3ppgxkF
         G0H2rNzifkbSYP65ETY13rj29vcrhmuFhmjXZIFgZC4ySn0b2etGtFbe8ZApRhYcl4hC
         6m8/NJ/cNZS48vq9kcxT1zBq0yZ5TP6OIh9zDM60T2MTVwBWbDabtdmc+Q/3HlPTVq2S
         GSfBJKGAjMF32kUyR9JGu9Wv7ngKch3ru70ORGMNwlmFi6RE7bU3NuzwGWApm41yfnmz
         QM3A==
X-Forwarded-Encrypted: i=1; AJvYcCUOzbeA4ifbw9XKLDeu7QqNqzlvMaDi2eoWrBurjxKg656D41gZMqDDoeBGVQG3Bssc+6JWUwNMjsO3LP8Clb5DXbzV
X-Gm-Message-State: AOJu0Yw9pVOuW+zjJSHulptDnYP9TuCbP3yqyCgpC3134g0wCpj4eoqM
	0ZThFdLNIVJe4nSvvLQ9x69RNIU1qXDEkaWFa0gYZvpxabVBI0bDnmEsj0IxVrw=
X-Google-Smtp-Source: AGHT+IE0pogEICkOOUkYEAXQoXP4mDFORVzwhoBcpXpz1dZPSGXWS4DoG2vKYKQSpUcHOjtGPkc+kw==
X-Received: by 2002:a17:902:d4c3:b0:1fb:68a2:a948 with SMTP id d9443c01a7336-1ff5728183emr86417445ad.15.1722691911474;
        Sat, 03 Aug 2024 06:31:51 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592af684sm34448895ad.289.2024.08.03.06.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 06:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Aug 2024 19:01:45 +0530
Message-Id: <D36BBC5EWOVX.1CERSXF01H5JI@gmail.com>
Cc: "Josh Steadmon" <steadmon@google.com>, =?utf-8?q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, "Christian Couder" <chriscool@tuxfamily.org>, "Kaartic
 Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: port helper/test-oid-array.c to
 unit-tests/t-oid-array.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
References: <20240703034638.8019-2-shyamthakkar001@gmail.com>
 <db2f97b6-a06e-470f-b1f9-60a78a0a2a7f@gmail.com>
In-Reply-To: <db2f97b6-a06e-470f-b1f9-60a78a0a2a7f@gmail.com>

Hi Phillip,

Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 03/07/2024 04:46, Ghanshyam Thakkar wrote:
> > Note: Once 'rs/unit-tests-test-run' is merged to atleast next, I plan t=
o
> > replace these internal function used in TEST_LOOKUP() with TEST_RUN().
>
> Nice idea

I think the consensus on the 'TEST_RUN()' (which is now 'if_test()')
would take a bit more time and since the v2 removes the use of
internal functions anyways, I think we should not have to wait for
'if_test()' anymore (other things like declaring input varibles inside
the 'if_test()' block can be addressed as an incremental patch once
'if_test()' gets merged). And I've addressed all your other review
points in v2 as well.

Link to v2: https://lore.kernel.org/git/20240803132206.72166-1-shyamthakkar=
001@gmail.com/

Thanks.

