Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1692C24DCF9
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991362; cv=none; b=NJix8ZAqRI4oaNDqaoyppUusE/b1cHHj/P7xL6sWhCB3tof0ycxXx2hLRwU8ZA3MZAu0ougfNVBJhKGMwFc35xnX9/ART1eWYlRI3Wr3I5yZwRxSjh2To8CVPC9Y7fy7poHSESjxq0GmS5qtdHavHX4tKIQVS1y5eDFa0a2MRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991362; c=relaxed/simple;
	bh=DLWELWrMIeGSgPhl7sII1GcPCVMxgg+ljpkNdFR/Xdg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Gd1iP48nQ2B7syfS0tXd8R47fB2JFWPyEmGDCF/lBsg9+GPBeMTkMAIw7rZX8L+9iTvwBWLM0gM9py5JSjb5DWl7nm2+218Q1TXV2TQHCcEyELFYU+pMWnO3PcQZDKaW8YE7tWm216jQ9svibm6KJKlE0wgRdfBh/v85fV/irM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyWNHQwQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyWNHQwQ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313154270bbso866124a91.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753991359; x=1754596159; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLWELWrMIeGSgPhl7sII1GcPCVMxgg+ljpkNdFR/Xdg=;
        b=HyWNHQwQ0yV4UcHumAGCk2lo+fYTSFfRHNB8Df1D7xsZXH0E4GUO9kBmXu88V/Bpqo
         fKz740VShOa1ZuC7GqMj1wKZNxy+ABSZwbs4Aty6jukcpXit5vgibRVuJezcZq8ZagVM
         FTPglDs7V6dnprGLw3g8/VJ/vFWtvIkM7LDJ6Pt7zSfPYBvHW9oiRBl4oztT7oALgHAv
         Omj5InUIDx0xD49QPZ0Y12M9vIZIN2oUN3gfek/ooHzRXyiUsrxvSisBcouViTaBlPS2
         aajo3pg51qiXwKx/Psg2i4G98skqiGw4kDtTkmbXoJ7tINreRMZYzvgB30cU/k3ByUu3
         eW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753991359; x=1754596159;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLWELWrMIeGSgPhl7sII1GcPCVMxgg+ljpkNdFR/Xdg=;
        b=R0JaPPYn37awviOofiKGIWBPdNVK8y2uLCSxQAGPUy0j+vJrSQ/zEwmLytr8yhd6dw
         5uvgYcuAqFhGTthxm3XTEXvVhJ/NZlEGViaMYpejgpcCUG475nUQry0YOKzCfbOZ2ENO
         47wpwizELjY9HlJKbX547Q1Qg1+L2h1212q8zn1MjksRciUxlAHpKEssp7Q/fFEU0c66
         7eeukceYh/uDq7yV7u0QGU+W48WBcCxZeV5bwIs0Ixh5tVaVLEks5VIPf2LVxDMb74EP
         jcxayNdIkRXBMDVNbFXb0H2pCynP+ek25NhFf4I4O0s+Sm+QTDRQayoBHHnTdlxZOWAr
         DCtA==
X-Gm-Message-State: AOJu0YwmO4Rz4wEKcXJHllf2dtwbyh+ZzIRLPEtfzI9CZY8mJGB5qIBb
	wxMd9GQCiuKeTR96fysWpDRqqhCBZNeEcUVVjZvreA5EC2mmIguFiA/U
X-Gm-Gg: ASbGncvWmOI0v/hrxgwD+vPSGsLtJmRb+bmhf9jaKPm2d0mqoUREg9t3/OmtNqnjhzO
	WJ0VmgfnqxnxW8jmdY9BugF1aVMGfpUYtaf4PQVN4bss+KAeZ/ajxtIbn+ZhBckyVXN2NbaB4F8
	wcVaUtryqcyVUipkQT5W/Fztv8uF3cvIixftAmxBih5v3syopYVoiZf3VLImL/IBiij39x5byf8
	FDxErn6F9zG06JbvI38Lxxh2I20wsIwQPSbPMKRO/6VIcc8QiLfthT2QH36lWdDkOb76UuPSzzL
	WJCErIZsXrrNDa1vp7kAtfbeGZKQQhMvnErfsjiT6DN+udMWmv9vEEowYgYZhhvU4trLKAzndvd
	KKWdT4HRx/YE3NuUnABGfYJPDswnFwiJarc4cbwZKr1Ooi94WwwJarjE=
X-Google-Smtp-Source: AGHT+IG1nrmygxko2VaURWwmfdwUzmz7FYqnZtoRlcjhDk9otWZeGRWr78jbgLOEPu8Stu1xooc2Fg==
X-Received: by 2002:a17:90a:e70f:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-320fbc0c07emr104107a91.21.1753991359352;
        Thu, 31 Jul 2025 12:49:19 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8c1d:9856:3844:bdd1:13d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc0e79sm2720658a91.10.2025.07.31.12.49.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:49:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aIiV7cz2Tx50JZUv@pks.im>
Date: Thu, 31 Jul 2025 16:49:04 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <3EC7AA57-9863-4F7C-BBB6-D40978CE2748@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-3-lucasseikioshiro@gmail.com> <aIiV7cz2Tx50JZUv@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> And the call to `strbuf_release()` should be moved to the end of this
> function so that we know to reuse the buffer. The above early return
> would then be converted into a `goto out` so that we have a common exit
> path where we know to clean up all resources.

I agree, however, after Eric's suggestion of keep looping even if find
an invalid key, that goto will now be a continue.

But I'll use strbuf_reset and move the strbuf_release to the end of the
function in the next version.
