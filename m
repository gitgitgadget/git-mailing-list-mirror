Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0418D65D
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145249; cv=none; b=j5UHx5On6EBNrj/csx8Y6wgmRgbXbVJ2s3GL2maalD8PalgFBkK0IyUf7tjnNbRW2EiOQEZp0B66yC7axySWV1u5BW2Lg2tRNC5/XMbaFcj+3c8i35PM0lxY6kIK9PkuS2SwEIp1WlH09i8tmHVAJ3/O0aAgCLxzzMW6OINvi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145249; c=relaxed/simple;
	bh=WUwTzbVhMd+XsyzYGB9dd7Zz3sspES2Iq8BdeK5dObQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=jMJONIg84HWe86+F6id+6p7302/5WW7Ms9G2atvoTeT9s6fdEjTaPXb/XI5mm0SkGNPS3s7vC6Vn5psPTPajD2CbBxqzsvhIhtBx0dswRN/d5TCP0V/Eym1wGIxJfDlW8eM7k82PwXL6uWgJVbbelF4dpyS4IcMzBSKPFbXkd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jL5SWivy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jL5SWivy"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2971589916so8295494276.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730145246; x=1730750046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D/bnOdvkkH9UpFIU+es07HmG9hPl4ONSTam0M1s4pvI=;
        b=jL5SWivy2tMqGXJUSfkB6+NBgB0qbGKCQ4ySdtmEX1OeVsvVhw2HF3XPhe2MpgopDI
         4/OhJTD4EC5yd60o9Ys3zwxEtjWwO1GYTOph7I9/DkYfuVovfBCzNTTZ3QSqYLmFisPU
         iyAtI30iX25Io0vtZDmuuEJ+378XNLMah6Av0x/SO9m/56VEFH/y07idQEkGm558aDz8
         0VA0ZqNuDVVVESwlsyUzB0COaH0r/GHAtQf0KiFQhgRGq5KlDeylx6I8P0XYKNWCgC6U
         FM7pwXJ7n83QxZg8okwoDWKE8Ury8VFOzkGz00bu9fIGuniJMVKTkJ3YxhWWMFNI/mMc
         AWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145246; x=1730750046;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/bnOdvkkH9UpFIU+es07HmG9hPl4ONSTam0M1s4pvI=;
        b=gj1jbqPnEMTHB+VUpTh6bKrO61P5EzWiod1ugrdsocH1ZVX+udHlXCztKz8FZVR5Ts
         b/JvXH5ZsUhYKQeAnbf1zpGKFUYhGqQIDYFrc9UgCzdTuz8dgFTmp7exu5tvVL4vYiXq
         NmHNGdKeyhmyW5t470Kl/JKIlzfS2JhuNA52KMOWiKZjetYxS0vCnwO0AFvr/MLAB00w
         zt7asYaKHsiW1HYc8q0cZkwOqXlPPBjQIbIyqiXS020KLuf+0x+ShE5CqOHQipoW82hO
         inyow5nunuCiTevPfCJ4qK4Ue4Swipn3y2rUvR8bVg+h2H0xqFRQrdsxcqc7BsoSTbgG
         lGUA==
X-Forwarded-Encrypted: i=1; AJvYcCUk8PTYYbgRcp4Lu4a8EUVOHogkFQ5xwj9jt9yvHTCPmeFnC/DEiy6D38n6BCmVPJQFt6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkHeBblXv/p2b/FifH8Zrkhl9c5vnW5PSUgYqAfAXpibDfp/7
	6JETqxWHiFy72Rn+GqU2NqOvKtDYp+rNAdXGfztfA2h3cuGx2Gi+kamzI0slNIw2HgV3O+P3t0y
	wx8oWWwSrmRA/EM0wINmcafk1nwq9Cg==
X-Google-Smtp-Source: AGHT+IHmq2Dhs59EoXmH2MvhZkja4xTXRWa44V0IVH0LAG9Or/sQmP1LdNPthkMtK0ha1P8JOD1I3eIH6ku1rubOWycd
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ba9c:8d0f:d4f8:e6ca])
 (user=jonathantanmy job=sendgmr) by 2002:a25:908f:0:b0:e2e:2b70:598b with
 SMTP id 3f1490d57ef6-e3087c247b5mr7113276.10.1730145246624; Mon, 28 Oct 2024
 12:54:06 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:54:04 -0700
In-Reply-To: <f8ee11d3003e743affb39835ba3583dd2498e576.1728396724.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028195404.4119175-1-jonathantanmy@google.com>
Subject: Re: [PATCH 08/17] pack-objects: add --path-walk option
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> This new walk is incompatible with some features and is ignored by
> others:
> 
>  * Object filters are not currently integrated with the path-walk API,
>    such as sparse-checkout or tree depth. A blobless packfile could be
>    integrated easily, but that is deferred for later.
> 
>  * Server-focused features such as delta islands, shallow packs, and
>    using a bitmap index are incompatible with the path-walk API.
> 
>  * The path walk API is only compatible with the --revs option, not
>    taking object lists or pack lists over stdin. These alternative ways
>    to specify the objects currently ignores the --path-walk option
>    without even a warning.

It might be better to declare --path-walk as "internal use only" and
only supporting what send-pack.c (used by "git push") and "git repack"
needs. (From this list, it seems that there is a lot of incompatibility,
some of which can happen without a warning to the user, so it sounds
better to be up-front and say that we only support what send-pack.c
needs. This also makes reviewing easier, as we don't have to think about
the possible interactions with every other rev-list feature - only what
is used by send-pack.c.)

Also from a reviewer perspective, it might be better to restrict this
patch set to what send-pack.c needs and leave "git repack" for a future
patch set. This means that we would not need features such as blob
and tree exclusions, and possibly not even bitmap use or delta reuse
(assuming that the user would typically push recently-created objects
that have not been repacked).

> +		/* Skip objects that do not exist locally. */
> +		if (exclude_promisor_objects &&
> +		    oid_object_info_extended(the_repository, oid, &oi,
> +					     OBJECT_INFO_FOR_PREFETCH) < 0)
> +			continue;

This functionality is typically triggered by --missing=allow;
--exclude_promisor_objects means (among other things) that we allow
a missing link only if that object is known to be a promisor object
(because another promisor object refers to it) (see Documentation/
rev-list-options.txt, and also get_reference() and elsewhere in
revision.c - notice how is_promisor_object() is paired with it)

Having said that, we should probably just fail outright on missing
objects, whether or not we have exclude_promisor_objects. If we have
computed that we need to push an object, that object needs to exist.
(Same for repack.)
