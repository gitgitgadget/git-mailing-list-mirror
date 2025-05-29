Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B6347B4
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534486; cv=none; b=e5VmvhRGbElDfpPMZ5vdLt7hBH5Z28So36jVtXGz4KXCR6wiP611s/v+sXJJy1r111Rdlx8d73P+nCq+iwEGDynA/mEq8Kg7Mng9TVVPSa63X9Y2yJbz4EKDwQW6Qc02lTSudgLvV4l2dCe3r992zH2hCFhLiBL44Oqlm6cgzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534486; c=relaxed/simple;
	bh=C7Mf+ifzu7jeu5DgKHEIPaSQCEdhUl6eKy/2DEo3I3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3vW6SmvzJJE6XhyiD1K3pkWC3Zp5BnBvwAUX3jfP4Ac13g9VYzc493uYpTsuzjJ0C9LJ1wogYveNxKgByepuqwnHf3FaCdH+em90K6thPAXPyFBM7XCLtha8cae62dqsbvcFGYPzVHBUjIUYm4F+b7p0TfwaExOJXo1fBeMpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn8Lx4o2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn8Lx4o2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450cfb79177so4931815e9.0
        for <git@vger.kernel.org>; Thu, 29 May 2025 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748534483; x=1749139283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B26ynyHJp05vjVWJxYtcIgVffbuM6afPfdnbGUdAmoI=;
        b=Sn8Lx4o2QibGJFvqvpLKUgCJJqx9feFk2f/qZRTpjexG6u/+eOiOJ+bnVd3x9iB2cL
         mZvt8QCcOH5ypQWWxfQHdLulXwqYnzCRZGdwoKFZHR8nuJb0j1zwrsQxrtOR77CuspZ4
         YOg2h5gEKb4Tq/MrFQSK4gETxF2FL9pNzJUk5pWwMtUWkZaPfQVGp82EmsRLzV6IkzA4
         LRM17BB29cg2SC7KmbAT8FHMPQubuZV9obF0Xy/0BayY9CtO18+z3X08C3GBhcSzoJob
         efRupYngUQ2QddsD8jGaJuOhQnDEDl9Mw48pjCha9dZFwiyHcrfQu65Tv4KXCuz1V12P
         Vw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748534483; x=1749139283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B26ynyHJp05vjVWJxYtcIgVffbuM6afPfdnbGUdAmoI=;
        b=bp0+FpD2ohpdoKwzeSKTGuUZOmfpSSroYyyFdtD7idrxdWyLdOM3Od7rqu4wB5IqFq
         E2AkUrhbodEs1yewe8NdpKzAdhSVB5TvSGssi0CpzmcIEVRed3YCqf8HmPgdwWGCGTj4
         5UJpWmqA0CdCKWKZFyMHxna086YrlAD/Iz18EmCtVCgq0fUbo1EwIg7ws0pYs5UNV15T
         UQ4m5uAaeGyzBfVtRiut791RtJ3Oi+MaLg9fcflXZ6hSff+zXyMGPlOkJNA1NXdTMHVA
         Hiq3mLeyHccEj0b1LkzfUjOXVIdCZSdKpGXyAJtVG4Ex2QjACbgP4hkS0s7UxXsfKJ1A
         BR7w==
X-Forwarded-Encrypted: i=1; AJvYcCVBzir5o/Aq7naKTUmxbu/mDush6E1av7LdaUHoUXyZWREeyS+nkPq+6s2gesEcg/MkVvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMuPSntHiFiBVTk4DgYecArrTVsc1WljAKzHudP6jKT1zctbB
	LPKCDqZ23URSZt3bkR7ZBImEi9s1YHq8j1V8WjYHG0VD/dqlwWNOJXxw1IRKYw==
X-Gm-Gg: ASbGncv2BNdHRzlc+HjvLucrKco2SqXGGWW6l08k937XBlTW1kEG3zF7QpFouWGt5WG
	LuTetAxAwnwTvOmaqUWG7jOJ9qZ5tDWkTjyACYOCpmhGPjQ1UoH7ReHKwSZNS+y16TTTudk5u0T
	/K/sJ7214I2iZK0drs8CMBV7jJH97DFyrze65J407WOJYcUhdMFdupdkw38jr5bsid+zFbxatUZ
	DJiycymyJZimezc22hiO39izUHbjmsK9fzK8bhBDzh/Ej9mrCQ1pq7YFbR1wVhYSHHA3E0iLuW1
	l03IHY6AkX6xlUTOtLX/Tsf1QDblv7wVqJQsyCwrnaH8AgzZnU0YPQ9sNvcRO3E6bbEYN7ZJIII
	SldN+pj6JQ3GsqapDLa9MFCwSB5c=
X-Google-Smtp-Source: AGHT+IHPGVBwhAYfQeD+pR3mdS+Zf4ALl5TmGjlzifSP04MIx9lt03dFhsmqNnUVepRGpiQM37D+5A==
X-Received: by 2002:a05:600c:3482:b0:44a:b793:9e4f with SMTP id 5b1f17b1804b1-450d64fb131mr2459355e9.19.1748534482035;
        Thu, 29 May 2025 09:01:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d6406d43sm2181905e9.37.2025.05.29.09.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 09:01:21 -0700 (PDT)
Message-ID: <3d0697a6-e337-4b58-98d3-304e0f17ae66@gmail.com>
Date: Thu, 29 May 2025 17:01:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-4-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250522185524.18398-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2025 19:55, brian m. carlson wrote:
> In a future commit, we'll use this function and the corresponding free
> function to read the entire reflog.  Expose it in the header so we can
> do so.

We already have refs_for_each_reflog_entry() and 
refs_for_each_reflog_entry_reverse() for traversing the reflog entries 
so I'm a bit confused as to why we need to make the internal details public.

Thanks

Phillip
> Include the appropriate header files so that our header is complete.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   reflog-walk.c | 17 ++---------------
>   reflog-walk.h | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/reflog-walk.c b/reflog-walk.c
> index c7070b13b0..b7a9d70966 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -9,19 +9,6 @@
>   #include "string-list.h"
>   #include "reflog-walk.h"
>   
> -struct complete_reflogs {
> -	char *ref;
> -	char *short_ref;
> -	struct reflog_info {
> -		struct object_id ooid, noid;
> -		char *email;
> -		timestamp_t timestamp;
> -		int tz;
> -		char *message;
> -	} *items;
> -	int nr, alloc;
> -};
> -
>   static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
>   		const char *email, timestamp_t timestamp, int tz,
>   		const char *message, void *cb_data)
> @@ -41,7 +28,7 @@ static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
>   	return 0;
>   }
>   
> -static void free_complete_reflog(struct complete_reflogs *array)
> +void free_complete_reflog(struct complete_reflogs *array)
>   {
>   	int i;
>   
> @@ -64,7 +51,7 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
>   	free_complete_reflog(array);
>   }
>   
> -static struct complete_reflogs *read_complete_reflog(const char *ref)
> +struct complete_reflogs *read_complete_reflog(const char *ref)
>   {
>   	struct complete_reflogs *reflogs =
>   		xcalloc(1, sizeof(struct complete_reflogs));
> diff --git a/reflog-walk.h b/reflog-walk.h
> index 989583dc55..8f0640f662 100644
> --- a/reflog-walk.h
> +++ b/reflog-walk.h
> @@ -1,9 +1,24 @@
>   #ifndef REFLOG_WALK_H
>   #define REFLOG_WALK_H
>   
> +#include "git-compat-util.h"
> +#include "hash.h"
> +
>   struct commit;
>   struct reflog_walk_info;
>   struct date_mode;
> +struct complete_reflogs {
> +	char *ref;
> +	char *short_ref;
> +	struct reflog_info {
> +		struct object_id ooid, noid;
> +		char *email;
> +		timestamp_t timestamp;
> +		int tz;
> +		char *message;
> +	} *items;
> +	int nr, alloc;
> +};
>   
>   void init_reflog_walk(struct reflog_walk_info **info);
>   void reflog_walk_info_release(struct reflog_walk_info *info);
> @@ -24,4 +39,7 @@ int reflog_walk_empty(struct reflog_walk_info *walk);
>   
>   struct commit *next_reflog_entry(struct reflog_walk_info *reflog_info);
>   
> +void free_complete_reflog(struct complete_reflogs *array);
> +struct complete_reflogs *read_complete_reflog(const char *ref);
> +
>   #endif
> 
