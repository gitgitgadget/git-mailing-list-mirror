Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8260885
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854188; cv=none; b=aeeLNS9JACWqTWnHU47XWHXBePs/PmOxtxiGx5EwfSeqMI6hXzOzGVcg1oXANUrmMBKyinpg0fyuksV2mDlThFsM4HnBjWSf1JeM15oNYQUIC6alNUuIkUqvfSjRtV/3tJJNfkgS7WHCEfLC2PCQlHnIkzgjmrrqHtPBddrx5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854188; c=relaxed/simple;
	bh=2yBBby/F6An5L7dbpqEPAaHgITOZqNIyGoBP0/gpghM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R94jjohJ66r7/OO3H0rxvmK7vatZYWxDWcswRhFuHl+M+F3kyHRp2H3EJ15b3Lh8v/rBaMExUfmCh932Z/SQ5EiVNIXJEx0G5wFW3jYa1EJw2TDv1J7ozW3IczXvR132JZw5Ibj7uykxcGtJtAl8ffzhLHAYNqnNBIEGaKiFBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac5aq70l; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac5aq70l"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33934567777so3123087f8f.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707854185; x=1708458985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A43pN9ePSuAQGRYDWOoYVyNTPAr0R8DEAGIvrpQiraU=;
        b=Ac5aq70lKC+nYmzOCKkAzVIUp+QAqX5m5rMhoipn2LEblqNM9uZ6NuIlSTt/H0e39W
         TIha8wH8YHMFn4yKmN3YxFU/6VA/dJp3XxML7nPafc1sdOw2DOfc0V5LbxyifQYI0WAu
         2woxRZXaeEact4Vuy3SRYos+B/3jdepxv5kGI5+N2xjbWHMX/8hgPjJXSGlbV7dgHiOM
         /qM3KB4r24imUMaizwgisPioqDizM4RCVBfGFTLV5u+U3QnLbxmPeX77B3yLdKb9vP1R
         wVcU7a2jI22GKV05BYnwxNIfrWYeJtKk3l30agb1zqL2REBJid8wduO1YlGqAx7rihHQ
         oAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854185; x=1708458985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A43pN9ePSuAQGRYDWOoYVyNTPAr0R8DEAGIvrpQiraU=;
        b=IoGXNF5c7UM6+//ONKx2aU6w4lzr2cjbb/4unstQJyXux8vGdvUX3mr5zR1u9hQVDU
         VzZ5OuCCLv5LL/92LGS53c7MPMucBxTZb3FS+jnOoWjSKDXmO5rls4+xAw9UDhB3iezx
         8wjS22NOsT3IciSi2XU+oy/aKFY5/unjqycccBwBo03MTMOgIDnmn6gGx5IcGi2wM26g
         +doKPBLdpGnc9ixhfFKZlgsKPOH9bFZ9VwaaYsOhTnCntYKX1yK4YDhNRlP72VzUS/7k
         kTFLNVmLNUI0dLekwCfYmwYz7i9pb6N+l4NVzwuy5rz+DLO8DFuSnsphlu9kOrnSgXH5
         SlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwyceRBP5fTVgLVuuxqOu0ndKy9X01LYx1eNEQr3n0ZbftrP0RJ7MDRa6idU7X7yDZGZYV63CEqoWkz+u+acfG6yi4
X-Gm-Message-State: AOJu0Yw5uS/SZQ2oiZj0F3dT7sE73TuMqzwzQUMxMgLXFG07FP6L3SjW
	f4mQEAm+mOunsQvpFJRdBcPSauKg9IZopYdfScvX1zKjeCoGjK8l
X-Google-Smtp-Source: AGHT+IETSiQmI66Mejbu+6Zh3OQMZShFUwEtkEVm/etKk3Q+PKjy0M0wzGSLbQIwUl1TNOKlN/6iqA==
X-Received: by 2002:adf:e410:0:b0:33b:4e38:b878 with SMTP id g16-20020adfe410000000b0033b4e38b878mr230494wrm.26.1707854185232;
        Tue, 13 Feb 2024 11:56:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRM02j49RrjubHDWiUoZt7/e/ShTYYi5rJsDoII4AZF7R1s9NOemi/PFcP9JTjsUL2a5DNdqdAUM19fBdebtlzAYwt
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c3ac600b00411d4202033sm992593wms.41.2024.02.13.11.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 11:56:24 -0800 (PST)
Message-ID: <b9ca1ab7-f8f6-4fe0-885a-51728d9ec708@gmail.com>
Date: Tue, 13 Feb 2024 20:56:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
 <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
 <xmqqcyt08fa1.fsf@gitster.g> <69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
 <xmqqle7o5f34.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqle7o5f34.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13-feb-2024 11:39:11, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> This one happens to be safe currently because "git tag" passes 2 in
> >> opts->padding, but I do not think this is needed.
> >
> > At first glance, I also thought this was not necessary.
> >
> > However, callers of run_column_filter() might forget to check the return
> > value, and the BUG() triggered by the underlying process could be buried
> > and ignored.  Having the BUG() here, in the same process, makes it more
> > noticeable.
> 
> The point of BUG() is to help developers catch the silly breakage
> before it excapes from the lab, and we can expect these careless
> developers to ignore the return value.  But "column --padding=-1"
> invoked as a subprocess will show a human-readable error message
> to such a developer, so it is less important than the BUG() in the
> other place.
> 
> There is no black or white decision, but this one is much less
> darker gray than the other one is.

I've checked this, without that BUG(), and the result has not been
pretty:

diff --git a/builtin/tag.c b/builtin/tag.c
index 37473ac21f..e15dfa73d2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -529,7 +529,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
                if (column_active(colopts)) {
                        struct column_options copts;
                        memset(&copts, 0, sizeof(copts));
-                       copts.padding = 2;
+                       copts.padding = -1;
                        run_column_filter(colopts, &copts);
                }
                filter.name_patterns = argv;

I can imagine a future change that opens that current "2" to the user.
And the possible report from a user who tries "-1" would not be easy.

But I agree with you, that BUG() does not leave a good taste in the
mouth.

Maybe we should refactor run_column_filter(), I don't know, but I think
that is outside of the scope of this series.
