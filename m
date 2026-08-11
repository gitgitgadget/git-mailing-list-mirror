Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC41F30A9
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487480; cv=none; b=tBsTVUIZyUz053fagwI0KFsMIkHuAR4sr8L6CYx0KmoYaJmDywo4zR8h0FRhlkIg6f6hDgv5pj+lHZg3y6IP/CNU2csTOMLdTk7g6x+/6GntAdWrAN63s6ftoXe0aXQVmJJBGPr7eKGhIgTPAdGXkIFzDZcOuQIIuK81Dl37bVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487480; c=relaxed/simple;
	bh=l7a0xV7HHcchSAFJgfsiJLyO02xR8JnDnqQDUN8dyT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE0doZR9wpFw0GMakqGKXDwjwp4qPIn/TAqw6RYYnPsy/4LR6WgNGYYSeIc6NfyBTqqsXuySPRCNIgMqbnsCvQwtqF1ZoYD8d39Q7jxqCXBF+hiAitupxNQI8jHIOczNtCBYSFZMomer5+ZgbKYwHcLSmBT7dEt1I88bVRWAocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSSdDYAc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSSdDYAc"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a168dc590cso300698eaf.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786487478; x=1787092278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qUH+JT0Dq32fXPOjVpE4Y0jROnDABK1iRytELdVU2kc=;
        b=KSSdDYAcoCU50etNf1LYscAqfPnwe9aykmPRd47ve6owoijhoJBx7eg7tTPs0nHybS
         ogL0HEzbjn7Sw0fCErXfOS2ZTyq4jNT9nA+UWQ8EKMGWdhxZiSN/Vf3Bn+hiVwePgWs4
         UHTb4T1u7DI1Cjwj37szl+1T2Jl75AoAiYTiRqd8Etw51yl7PvI1Ihn0IJhR+8JLmT+b
         n7mWh3HHeji4dHH6DSE86sksRDgMX7G7Y4ijTNjFJfFfObd07WRFaHYgFsd/rB0vdUcA
         yfrQqzcbxjgir8zQ+P9yiCdlpU4lpRYjoMMLEXMQyVhwLp9nMOsYEgSLm9WXJkd5IUYx
         8m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786487478; x=1787092278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUH+JT0Dq32fXPOjVpE4Y0jROnDABK1iRytELdVU2kc=;
        b=rC3EswsawGWScj4uUZxxw2RH4qgyHcqSYbmU3mGrNPrh4/zNSSDLOjiagKthSdjMYv
         Dw5Hd+6lax1LLhadSXoCwrWgPngo8gjE8adqj1rgjranA74c20ESlMgy77gck8uUI4Df
         deSqHPam7UORgoCu09CLnJ47pUPXnW0OOyFxwzGIsRoonA7+I1OPv1WT2PyUduANg9cW
         SXdNT3GrJQpCCDt1QX8/LUsXj8CnKDyll/dMpRLxaCYU4+biNMpUIun7l1BK5cRu6fXl
         6hvvKT2/aanvjQV6Yz+LuSOUQKH8NI1UhsYu/9MxXA7chqibHiUs6k/kmXtmPAnrt1Cc
         VrKw==
X-Gm-Message-State: AOJu0YyKIlLlpaLlganK3ZzwVJ1ck2vAzGO327x3GSvOrcahhb5o4SwC
	x39HBX733WzbsYqfUFwE4y6YtbQtIgSXq80gcRhyQQ0eGDOgtflZ0IaGYGh4ow==
X-Gm-Gg: AR+sD13h1OmxAngQCRCqQO6xO91y/+q98jgcA7tRA9wk+M9uC0LKhcSRKYdbcxAdMzE
	YiU+7zXoIh9+j8mhRve9N0Y5anVXRz5WCeJpXpgiaPppmatJOfl99o/saP4qCtWt01ZSyB7Ttqy
	og9ZE0187ArME41uBRI1oB66pasuUZCSpjuP/yzgK8uoKZLe4pc2wsB7DU7qzSlIkKJggswaGFG
	UKoUVE0Nj+5nQVr70GiBTMzO0aQoWJRQSKuYCVhQ7vJ9FL3vQd1z0EyJDCrfdNLvG5NLSyC/wCT
	qRZUVe4/dd15En5zyo0iHTU3IBSrdbzqZjTuXC1/1c700MN/YshyHM3qU5HToHJhHwk4MERXTIp
	N3GnCk8b1MfmijuSXYXi3jc1YVLPYvtre2wRGlsJf2jowJxA3UdCA8uJJuivl41FPoKsJbJEFm5
	zP4IdyfAa/5HvQCgBiYme74UXonfpeSrlP0jd7HYd5vZA74xZ5m/EJaQ==
X-Received: by 2002:a4a:ee10:0:b0:6ae:51a6:8548 with SMTP id 006d021491bc7-6b0b26b3983mr272497eaf.26.1786487478390;
        Tue, 11 Aug 2026 15:31:18 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad671caesm923749eaf.9.2026.08.11.15.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:31:17 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:31:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] odb: drop `alternates_db` field
Message-ID: <anug-cxSSsy45swy@denethor>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260810-pks-odb-eagerly-prepare-alternates-v1-4-f0fa4a4004e1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-4-f0fa4a4004e1@pks.im>

On 26/08/10 03:33PM, Patrick Steinhardt wrote:
> The `struct object_database::alternates_db` field tracks the value of
> the "GIT_ALTERNATE_OBJECT_DIRECTORIES" environment variable and is
> used in `odb_prepare_alternates()`. It's not necessary to store it as a
> separate field anymore though, as we stopped lazy-loading alternates.
> Consequently, we can simply pass it to `odb_prepare_alternates()` via
> `odb_new()` now.
> 
> Do so and remove the field.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -1126,7 +1126,7 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
>  	 * the lifetime of the process.
>  	 */
>  	if (flags & ODB_PREPARE_FLUSH_CACHES) {
> -		odb_prepare_alternates(o);
> +		odb_prepare_alternates(o, NULL);
>  		o->object_count_valid = 0;
>  	}

Naive question: is the reason we don't need to wire the
`GIT_ALTERNATE_OBJECT_DIRECTORIES` environment variable here because
they have already been added as sources? IOW, when we invoke
`odb_prepare_alternates()` after the initial set up, we only really care
about re-reading the alternates file.

-Justin
