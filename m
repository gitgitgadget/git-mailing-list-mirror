Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDC18C07
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIE2Nw2L"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbb7d80df8so1053243a34.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703250578; x=1703855378; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiLMIC9nXGD+pkVgQ9Ss/p0oLO43VDhbUaTo98eGrVA=;
        b=BIE2Nw2LU8wdYo1fZUBaV0S7hO8zWH2mpoSPtMjQyUnMwBSb5PiOLQGYKe6NUq4dvA
         nde4/3g7El7tKA11ZuFO5GcwfiI9M4Klx9/9UFyb7gFhOKtj+UABAs5PVAUCtzFRf95W
         YVAaNQ8LP8jJ7siajFIPbhjrxdt8D2qwN99C7iF7ww8ExwRcb3TaqQ2uPt6V1ToFJwl2
         Jks5xnVLeP0fydMzAHOy/eKOIU/mJNX1eICRfrv6c8ImcMRPA5pB6BwbayXF3vEKqz6M
         FpgJiM+1mWMX+lenS7figSsb74Osm2oZ3/NwCsMFv1Zmz8wXzaj8wxJhOUIqNiF/FJdT
         rhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703250578; x=1703855378;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiLMIC9nXGD+pkVgQ9Ss/p0oLO43VDhbUaTo98eGrVA=;
        b=JPtP21I/+VoiIMoCgVu6uVN43AmfKGG09A2v4d9iidr8US4HnyAu/hD+uu0/XWxcre
         YRr3o2HI1HbJ61zbVCJRvdtw/TTR5uIqNoVlJ0G6znLRsEOH5gjcIqCqqnICRJhRyBQD
         U87JGhV5Vfhex+R6Gkye/ObSd9/iDSDaCz7Ygt2TuJMVYOZ5Bu9UgW/ey/CIwKKErCWS
         JTHucxjFXf09dJqCTeMaHIqes8jzTH2FVsTtxA6jD/kc41ZbHglr2uWexCOWzjp/LpAn
         vOi7/pJO3JdzqRGmOuZyi3IMHrGJ7hr+QoSRjbrauKxw7VaSfGZeUZDA6scNjY8M+iss
         TQPg==
X-Gm-Message-State: AOJu0Yw8VKhC4pOxHMM+fKui+Jx1EGqY657/J2F3kMveay+WeXA6fV6b
	fIMQlV7Cr8ngwr/rZmhtc4qLgNFH11IGxOZG+Tkn5uEEW0Q=
X-Google-Smtp-Source: AGHT+IE42HSVE322TIRlnQsMGFwJFsdhpYGdroR6O1fMUvjeqLwlvcl0KP/2bfuTXt0ebAC/63ShvzqmFyAHpkCby40=
X-Received: by 2002:a05:6870:d146:b0:203:a55e:3ecc with SMTP id
 f6-20020a056870d14600b00203a55e3eccmr1627914oac.2.1703250577876; Fri, 22 Dec
 2023 05:09:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 05:09:37 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im> <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 05:09:37 -0800
Message-ID: <CAOLa=ZQLLqj=78dJN0y51EFf3_XsHnTBYNjkB0cAAGf3dXJ9KA@mail.gmail.com>
Subject: Re: [PATCH 04/12] setup: start tracking ref storage format when
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In order to discern which ref storage format a repository is supposed to
> use we need to start setting up and/or discovering the format. This
> needs to happen in two separate code paths.
>
>   - The first path is when we create a repository via `init_db()`. When
>     we are re-initializing a preexisting repository we need to retain
>     the previously used ref storage format -- if the user asked for a
>     different format then this indicates an erorr and we error out.

Nit: s/erorr/error

> diff --git a/refs.c b/refs.c
> index e87c85897d..d289a5e175 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2045,12 +2045,12 @@ static struct ref_store *ref_store_init(struct repository *repo,
>  					const char *gitdir,
>  					unsigned int flags)
>  {
> -	int format = REF_STORAGE_FORMAT_FILES;
> -	const struct ref_storage_be *be = find_ref_storage_backend(format);
> +	const struct ref_storage_be *be;
>  	struct ref_store *refs;
>
> +	be = find_ref_storage_backend(repo->ref_storage_format);
>  	if (!be)
> -		BUG("reference backend %s is unknown", ref_storage_format_to_name(format));
> +		BUG("reference backend is unknown");
>
>  	refs = be->init(repo, gitdir, flags);
>  	return refs;
> diff --git a/refs.h b/refs.h
> index c6571bcf6c..944a67ac1b 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -11,6 +11,7 @@ struct string_list;
>  struct string_list_item;
>  struct worktree;
>
> +int default_ref_storage_format(void);
>

Is this used/defined somewhere?
