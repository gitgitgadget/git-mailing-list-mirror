Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFE1FECBA
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437719; cv=none; b=eVD1al5Z7YNP7Aq2BA/gkZGas1wzY+Sv669xepM+xbcu/TV3y16yhQDhgMOrF58oGmQpQDI2HFLS9i2on6tgg0TRsNfXV+yu8WOiXaxWOqaleMXpz95Dpq8tMGwUtgnyGoeaUqk9nn4OSF86wKFWzNHcXeYOfBl/9yijDMTkXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437719; c=relaxed/simple;
	bh=feS3M/QLh3ZBvNp1pPHbdzgM03ad5AA69b4cEh1fLQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk/rF1Zp/tSQxNiD8U2rBRdQ/lRccbS5kerGX7dy5duLCEcPX3whNegzr5Dsdb5JRMYzaPsBw94WzFvBIAh51fYoa7YGR6FbJZ69KNLOgn4E7b+7efPhVARPq62bM3w1GwMsvdE7akUR24hUx7fBWuuDJmqTyv/JpHwVr/wRieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnr48HnT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnr48HnT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso2376885e9.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 23:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437716; x=1766042516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kw4DrWIsr25/bx8K9YSqOq4Co5SleENjS1Xpkt8RL74=;
        b=fnr48HnTwY2nvdiiP8qmPz6RtKGbHJbnwFgIhxoQLE7fXb0iTHURnsogjMmnM5JhGZ
         Yu4r9XZbb61sUH0YWQ0P97C3DqGPGHiD4bFr79gd/AZWz3gGvzwc97PFm61gpaPI2MSI
         alYIgcoz1wwEgaBq6P5Rkx/L0ZDY/OtbsSrlyFQ25VFx2d1u4YW2B8t6QvJCxSDk2gpB
         nLzHCipGb51ljzusP0ngB1fPUSQM27K5bpkHyloPPXNSox6Imv0Gx19deBQs3IJYZDqD
         Sww9JVym2aQamA+JiQ6AHXOJC5ymSXHMcDYYNNcxom0mH4SUqUVIVySDpMNyX1wSaLWR
         Zh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437716; x=1766042516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kw4DrWIsr25/bx8K9YSqOq4Co5SleENjS1Xpkt8RL74=;
        b=eZAt7YVVXttyTUgsHEd73KUzOB3ZbHnwx0SimevLNq1WqSUiST8LzlC96LkkSKgHR6
         NCZ8TDEoLmvDHoL85wQHFde+3LYGPS5gFe6gcPI2aH9G96ActYmMT7Sw1/3Y34QX2x63
         r7jnjG2GmO3wKKbIbus0ydrCjCmkWcT2S54Mzm/QpO4a0kYWXhNJNsoJdW5Gxuk/bpAC
         5mDgL5JZY/j2T1K8SFdnfV14a/YNlg6Q955b8iCvakVG79UYejkhwkOIDwhJ4l0t6Yda
         OjEbArYacuuxpkIvr9itcGl+dyPODGCDtVmLASnNmMC6z+9s4HlG6np/i3bKst6XafIb
         UP/g==
X-Gm-Message-State: AOJu0YzkWRioQ6SJmYtqzTnEMOIxBEuUMJ6uUKAX7MT+LTn3jX2TDqLv
	+fJJPP1q/t3RLjkRv5ULn600jUX07TqIw5JEnjod8DwOfPW+74s4DVsW
X-Gm-Gg: ASbGncua+Tp2oIncqulvncZxnMyxfCEXo9ejvbN5Ku73s/iPnjRnixM4VfqS+d4incp
	Myuku6PU4pwJaIBDKg6kA8aTEeT8YDBQRlR4QkoRcOjZuEX0ySrxgD6a841sc1plz8AiLNbWugx
	bmekzo3l7dKhegRe9rmuoCS6f51lCVNcTyF2TT1aYwtKMAlB0PwKNvt+mufQzCb3vIW9gJAc87w
	ji4mqP1Wb0NonfxQvX168ECjrQPok5QTYot081DfydEc/x+2CPxGLfaCYSSJ3Knxts+3sn5P+Lk
	NVZNVScZSiFMHfhdCMts93Y9uEje+2SI1NEX+jMvcVqNVdvQZLheBAI6MuvBj/R2SgSB5wU7jdN
	OQ3J9W1aV2AerZMxq7oA21zoN47olQitDio4PXXEShiORsGlWMnxybuAUHUVLhKYt/7bdmRGAHK
	0p5TqcA5X0F4LooEci4HFv3Jbt8X6IazQiJAowpvrs
X-Google-Smtp-Source: AGHT+IEcsM+U4vvMFkX85OblO7dGt2dm+yeQwywtS5xN9mJhVdBhCtxYQXvqnCbZxFckQyV29vSwLw==
X-Received: by 2002:a05:600c:4e49:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47a837a27d0mr59817275e9.33.1765437715864;
        Wed, 10 Dec 2025 23:21:55 -0800 (PST)
Received: from localhost (84-236-78-152.pool.digikabel.hu. [84.236.78.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89d8de82sm7453245e9.1.2025.12.10.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:21:55 -0800 (PST)
Date: Thu, 11 Dec 2025 08:21:43 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 4/8] odb: adapt `odb_add_to_alternates_file()` to call
 `odb_add_source()`
Message-ID: <aTpxB8gS7wG7rRJQ@szeder.dev>
References: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
 <20251210-b4-pks-odb-alternates-via-source-v2-4-eb336815f9ab@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-4-eb336815f9ab@pks.im>

On Wed, Dec 10, 2025 at 04:32:37PM +0100, Patrick Steinhardt wrote:
> When calling `odb_add_to_alternates_file()` we know to add the newly
> added source to the object database in case we have already loaded
> alternates. This is done so that we can make its objects accessible
> immediately without having to fully reload all alternates.
> 
> The way we do this though is to call `link_alt_odb_entries()`, which
> adds _multiple_ sources to the object database source in case we have
> newline-separated entries. This behaviour is not documented in the
> function documentation of `odb_add_to_alternates_file()`, and all
> callers only ever pass a single directory to it. It's thus entirely
> surprising and a conceptual mismatch.
> 
> Fix this issue by directly calling `odb_add_source()` instead.

OK, but:

> diff --git a/odb.c b/odb.c
> index e314f86c3b..d97e50fb61 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -338,7 +338,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
>  		if (commit_lock_file(&lock))
>  			die_errno(_("unable to move new alternates file into place"));
>  		if (odb->loaded_alternates)
> -			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
> +			odb_add_source(odb, dir, 0);

      CC odb.o
  odb.c: In function ‘odb_add_to_alternates_file’:
  odb.c:341:25: error: implicit declaration of function ‘odb_add_source’; did you mean ‘odb_find_source’? [-Werror=implicit-function-declaration]
    341 |                         odb_add_source(odb, dir, 0);
        |                         ^~~~~~~~~~~~~~
        |                         odb_find_source
  cc1: all warnings being treated as errors
  make: *** [Makefile:2864: odb.o] Error 1

Note, that several commit messages also refer to this non-existing
function from the previous round.

