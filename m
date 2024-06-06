Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D08F58
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691123; cv=none; b=NfsbxdZJcQuAv1r5qATllA5lMMVQGpt40xiz27L3Z18ziFAknQ9tw1LCah3I1nrLyW6ScKclja3L3rx/ZE1iW5x87B2wq+jdiyc32LZjGEaLDRlMOvOGmajNZXNuov2iZo7i2k7jMnFVDT47vPG8LdeKfQcdUGKyyNdN4pkJ4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691123; c=relaxed/simple;
	bh=0wnOwPcz6zwlL99jPdCcmClJMUuVRDEQvaw7gcB/E0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyMh6UHNXxoO5M9LOPo39+GYhJjQaK/WhAvzaFWabpE9J6vvP3v8PXiIoIjt4FR9Otlgi367JHCeYI/xgeHj4e2b264FHhL0O0ysB5tkGdDuUkqQvqdhG0KyrVzPPAoFHRK8jqfPUbeMC0tSM74KaZ4fBK5Tl8+ZldFWJab6W/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFDx7hgM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFDx7hgM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70109d34a16so1067812b3a.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691122; x=1718295922; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcsGSidAXAhmnCuUmNH/sH3ptmh19pfQpddwcwBnvv0=;
        b=WFDx7hgMmiLSYjoA10QW/d9pxMr2UPlfRrH1sD+jPLV4x6gNfuqLxlrdPtegq0uakx
         9kw0Xd6/K0TiYqxugO/drGh/AT30NdOlCiElBu/aLsn5lZv1YhnS8w6EZYjfN0alktbZ
         CWhC3x11xUWTK8sZL7gViiLasu6UI5fcy8ZamPtjwygR9KdGh7cPSEnJnT+S12l5zrOr
         NcD2cI4KynnLmQxaTk9bu6DN9BRarAayv5JnksXjkXZ904gcL5GuovsWxRBQe4c+Br4L
         1Lco+vKI5N6Q2jwEcCVCSzlUa63+Gz5R6Dk0TynMz8qd0QEvzdyUm6ZP9jKWbbFpbAfI
         ciMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691122; x=1718295922;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcsGSidAXAhmnCuUmNH/sH3ptmh19pfQpddwcwBnvv0=;
        b=jTOHQd21FpjgyqYqAWSNR38fWRYyZdXcltR9U6zGUVmjHVGGtWxDhdoRRZgr3VRlNL
         nyGceNKZWNxGEzTWQv9HPvOFZmKgZW9iNXyGzxyMgG4tqt8C08CJRFbtvan3zKSWZhZd
         K3QtSBMQxaMlT3Wsbf+2lLvCN2LEqJqJaAJ35y3062ceOhUWRuTisSetkLjwNdMYW0xs
         JULFkO+ISlC5m04l6HZfgs4ZD+5ClAquLtviDn858VonnyX0FUfH9kXVyZBnK9yuCDZ9
         PP1CYQu16tdbjpCYKSDkWQ2pyL+mvm/+/Gx0HjuCDLVZ1+X0tPURjWsjcUV2E7CeiXXY
         t+HQ==
X-Gm-Message-State: AOJu0YwsVZ2tCuHUOsLocylM/DEAiG4Otn6dExI/1fVU+8mKbfiPLZJt
	fmWRpxOlqp8dtcBoEAPKVZy8SeA20T8EAS8eppE5Cd5XkfwkD6Ls
X-Google-Smtp-Source: AGHT+IGYle6yPN/tblIS1CW3BZz3ZEOFUgvHLzWVU/6Mj/dPPj8mW+ragfBub02hpzxdEDcHmruEog==
X-Received: by 2002:a17:90b:198d:b0:2c2:4129:91a6 with SMTP id 98e67ed59e1d1-2c27dc60fdcmr6024492a91.42.1717691121540;
        Thu, 06 Jun 2024 09:25:21 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c154d48sm1848068a91.0.2024.06.06.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:25:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] object-file: mark cached object buffers as const
In-Reply-To: <xmqqmsnyppo3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	05 Jun 2024 23:10:20 -0700")
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
	<ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
	<xmqqr0dapq1s.fsf@gitster.g> <xmqqmsnyppo3.fsf@gitster.g>
Date: Thu, 06 Jun 2024 09:25:20 -0700
Message-ID: <xmqqa5jynimn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Indeed, that seems to be the case.  With the attached at the tip of
> the branch and rebuilding 'seen' seems to pass these 6130, 7010, 8002
> tests with SANTIZE=leak.
>
> From f307bbf7bd317d90db29bd1589b49e84b9e37e88 Mon Sep 17 00:00:00 2001
> From: Junio C Hamano <gitster@pobox.com>
> Date: Wed, 5 Jun 2024 23:03:34 -0700
> Subject: [PATCH] fixup! object-file: mark cached object buffers as const
>
> ---
>  object-file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/object-file.c b/object-file.c
> index b5b5a59dc6..2d5bd3a211 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1785,8 +1785,10 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
>  
>  	hash_object_file(the_hash_algo, buf, len, type, oid);
>  	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
> -	    find_cached_object(oid))
> +	    find_cached_object(oid)) {
> +		free(co_buf);
>  		return 0;
> +	}
>  	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
>  	co = &cached_objects[cached_object_nr++];
>  	co->size = len;

Wait.  Why do we need to allocate co_buf that early in the first
place?  IOW, shouldn't the fixup be more like this?

 object-file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git c/object-file.c w/object-file.c
index b5b5a59dc6..0b58751f94 100644
--- c/object-file.c
+++ w/object-file.c
@@ -1780,9 +1780,6 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	struct cached_object *co;
 	char *co_buf;
 
-	co_buf = xmalloc(len);
-	memcpy(co_buf, buf, len);
-
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
 	    find_cached_object(oid))
@@ -1791,6 +1788,8 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 	co = &cached_objects[cached_object_nr++];
 	co->size = len;
 	co->type = type;
+	co_buf = xmalloc(len);
+	memcpy(co_buf, buf, len);
 	co->buf = co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
