Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AACD26056D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207533; cv=none; b=LOL2EpNAGmxrUCCzGs/2wUpysrxnoBJ15OEO6s/C9Wjqtu+CC8MmtvxLXcwiWvFZs7Hpz5hwwEcnXoER5+2ySR7nEMKrBvvDgzyMdtISKqbmxmO1PTjtUkvCu4tIabW0FUfdF1/j+WLMlc7tv1d3DtmfE/BudH8QP4QPsvgdces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207533; c=relaxed/simple;
	bh=QSyVViiJRJRmWmn//BwBpK4u8pj9a20mik5XmegjObI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8+TXMPHrYT4GmNBTDJyol2g8YuRvJ1znSYWNgBypmR+jy5V7kL2K5y1MIdqh0wKGllorag/k6HL9i/8Tbxg/H2g3SIo96A6dUGp02pi1ufYgotDiGBZk29SgDPJV0sEuiAqzkg/fpj+d0fNdy7onywK3L0ovwTxui6o4ir8LXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkpQSFPE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkpQSFPE"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so132665e87.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753207530; x=1753812330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSyVViiJRJRmWmn//BwBpK4u8pj9a20mik5XmegjObI=;
        b=KkpQSFPEA3nVr39vt4oBux4qIRlZY5O8sW3E+vcfsZbF8pkjcNiiXv4SNjMUD1YeuJ
         487VfOwcClZG7Fe9x9d3cZjuyuPiXRyg82uoCHYhuBAVSTh8KxnSJG2QyDITBebAV4wJ
         aTY0Sd7mxqHHbkgmeTwwv6itaTfaF8IYtsxCFIILHL5ptvmQ8apry2Vorl1uF1st6EZy
         5HXRLC/Tsw4NizRxrkE9g/19CilcNkqUyEOtPFmH29sG7p21Q6r920N0Ca2BZXU0eT5Y
         DbYaoWXjaA3ApV336To3asCitUw+RB+gHnPcEt39g5+rIvZG7iXQ1hIQdVDqiPLGT1ml
         OOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207530; x=1753812330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSyVViiJRJRmWmn//BwBpK4u8pj9a20mik5XmegjObI=;
        b=lci6VazhRTqpP5N8VKE5kjfLocOJ5gL5IR5/B1adot1j9j0XknKhx9433AlvEAvAvY
         ZplMUqNJihscdm7+4gbqSPMl6/hkG17MqnCy6rndQg8Ms/qmZ7D1bM/RvF1gxWg1X5A9
         vYtvWcK9JPV5iHBrTzP2iI28PbrzFAqfNNiqrG4lZLbvNMKkpoh+aLVjS0+tM+b58aS9
         aw5clBZeZNLe5y6Fl6CHrV6IaLA+nCAGJlhvi9KLqmSS0/KI4BICK3UnVEm+EsgxF6s7
         shtdWqNWI9rj1U8lzXA/UXdw0GsJWZg+C6iQ3vXtXTswmW5wF3YM1IMLlR9/TmpKH6u/
         3IWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9rE9pq0I2arHkeMgzOeqgFZzaSd1k3fczN4L4XXDGcnqKOXXniL4/RqZbYcpHNFZXFb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg23xksyAiTNHasw0clx+KDtupVUElyvlBldBJDsWKgyl6haxP
	OW6PPEBwyVqz1f6wAnUGAVtJAifgehGGYgy94ns/ukNLsmJsyLJnQQGcLLrMWoFJkslxBoWBRNa
	GvqfHV5fXacmH7tuZDdlTACj35w1PjL4=
X-Gm-Gg: ASbGncuy6ky8u9p3F5i3VdmUKvK2j/SB4QZpkvB6d6USw18Q6031RHhvSXK0NRy3gKp
	5WCZG1HqYLKWTbeAiYTumrmuA5cWWWQ0uBrZVbCrgiog1nsFQ1XYs7B3hGu6Ms3E//Zzfdwlo5F
	etKT+RpnuNVBFI/d/H4T2Q1CcFNNLgQdMjj+Z5SVNUB9d3IKPnQ7IiS06kcAwbACGJiDdp9ujIz
	VTSa315hK0s7+iTU/vh4pugXwl8skUHy+zwhz7z0A==
X-Google-Smtp-Source: AGHT+IHkzN9Vc+ETmwemK14Gv37tirv5WkrnHkeo6Ht9GWEOtNG+p4uipCM0dUIQaPPcqMHDDE4tmTwup2vkcA8y86U=
X-Received: by 2002:a05:6512:b09:b0:553:2375:c6e8 with SMTP id
 2adb3069b0e04-55a48e960dbmr1779964e87.1.1753207530013; Tue, 22 Jul 2025
 11:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com> <2774b930406819ea60f522e0e0741e4046ee01ee.1752928113.git.gitgitgadget@gmail.com>
 <076bb5e9-e8c4-466d-b8dd-bc84bba708b2@gmail.com> <CAP9jKjExau58dP+=MJXiKWvCcOaBmhB-yta0x76s7b0XWqBQxw@mail.gmail.com>
In-Reply-To: <CAP9jKjExau58dP+=MJXiKWvCcOaBmhB-yta0x76s7b0XWqBQxw@mail.gmail.com>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 22 Jul 2025 19:05:19 +0100
X-Gm-Features: Ac12FXxGIfaLGdrWSlu-r-mYQ68gdae50fjTbHtqaDhOMT0hX2KfTdVRA7lZC_U
Message-ID: <CAP9jKjE3FT4c-0gphCmo2yDmMPni-d3vOhcJXUb1PPm=p5_GMA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] add-patch: add diff.context command line overrides
To: phillip.wood@dunelm.org.uk
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Apologies for the top-posting above, this is not my regular workflow!
