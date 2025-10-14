Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502823D7D9
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469435; cv=none; b=X7xo9NnIufw/rZGYBUqQFkgNxyDKSF8nJrGbU2md8Sc9OySbh0HBw+580Knp2Coh6r6zQpxAIicoHZoNr/aWFE6zaIJHf0Z8s310/gRCjgQSswoeqtTqsiAHvZ+F7pbnFQx3t1+EuS6LGZJgaPKbz1ogAeppib0e4afa6JQGCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469435; c=relaxed/simple;
	bh=Eav7pkEnhlbPp9F7Fl3LjHQ6H3ywlcPb18o+E/8F5FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou4lQUoPqiL0Eb1EKdFbjSnNQeceIjtXqV4f6yTCvaH3mbKdkzr+mulNgxmH3zjFkeD4p3n4TmFEtHdA7lBPo2dRtXd1VsVAyJSJiQQpot3irTsn/VXLkfsikdplSFKYw9S8UenRS9lhTQ5M/zbEyy1ogHzOpVom2ThH01MRVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnh1cvpD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnh1cvpD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ae21804971so1995099a34.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469433; x=1761074233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zACexkOk30faGAP47ueDL8JpEiSaNW3WaulGe754rM=;
        b=jnh1cvpDmkigTd3r5Qm+NNw8lbmAYd+DdpawqX/c3gqaaT9dJq8u1Xg7C/z/8l2T1F
         TbXgCp9LIANezP+81iH+3K/3Kr7fpTUvkSGzXs67muHmEphxdxHJ9rK4WRqm4mzvquK9
         8mtvyGu5yKxoN12g6HbTeweqNY4ljXELaX88n34HdFbYeLbXMQVQikUKLgyHfbe28cvB
         2SS2PIz57vlCThhlAbG3wMHYW/jpYx4Djym/1FkdVMV5QRs0RxGiu2UiaeLgbT0XCOtt
         LU4uo5J2YyfKTDMYUwcKTjv3Uxt7WHp+0Q/4nwWpgO+5sRgpEegjONwIJ6Zbc76HNBwh
         7QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469433; x=1761074233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zACexkOk30faGAP47ueDL8JpEiSaNW3WaulGe754rM=;
        b=sXDRvd8aY859LDGFb9ywDMakTF3Fkk9Yg/FOAnx68j4/tc1P3MN+Fs0C82rfiOvaL1
         1pCq5/6QUJMtdRDrWfX23yFaxyTbLZ7SB7/4W/2Fpf8V8aRCrbbOUkBIiFlKTVajUuCN
         dEA2K8TklG+WPmeMqWVDdNvnVTrRTNCJ0OtCMcEr6x6O8aI6ylYgXOtGu22y/EPQ8YtP
         X1UI8KL1cfKm2Uj6wTWtAuCLbDKtlp8K+KVco4+Pww4a7dR1j6Pl8bl7OJoR/cuEsJ3z
         GxmX6I9d3pQVZG3/+DnnkYP+YN0WrkkQvq0QXZDnbvOgqZqgcC/J2z+dwqXn2SQtPYwg
         20kg==
X-Gm-Message-State: AOJu0YyYfW/eT+WsdVVznckwXZwz1NgKiqU4a8w3VO2cD8o/kDFciL/Z
	lbokMHGmcra4m9W2uiEc6IYRW7lBVhK8q46LRiqiX7HOT1DdJlF8QDfV
X-Gm-Gg: ASbGncsx4J9lCyky826GvZzJlAYrUdLX6TUzt1r4a/1tQl3oFxSBujqTToKfj5Ueax5
	hTlcgJLuM6H00yhE2Jz1zsrnX+fKFaABYVaJTtXaxrwE/s328zFoSBaPbqxLlhPuRfbctX4xsNg
	SI2pQIcQy2qXVP0YPbHF/1fqKCuQQJpZrCuNrpQ5OS1GMF+7Sa7rzL6yCkEqmn7WgIiFY9iN6LK
	PlKFnIZ/iYfR+vKa4Syc/dcZ7efXiymL6Laof5dXKDNeYnSEEl9KGnzRzbqDPRB/jjEExzF5QmX
	khU9e+pezG6WV6nexXvq7+YayH1Jj4kYM9oaTXVZAprJ1XnFdObs4oepOF0uTaKueSsI7HbkpZ0
	vhKSc4kZybnujNQIqmO6yVWrRSwqwfaGeNzHPwdfLM/gM/g==
X-Google-Smtp-Source: AGHT+IEzVNv0i6xFRtoM0ZnKEC4YvuPx/PJenIMUadKf1HZHDvxrvalQ39adwkWm88RMZ2+YEO6Eug==
X-Received: by 2002:a05:6830:61c7:b0:759:55bd:9597 with SMTP id 46e09a7af769-7c0df7ff940mr12338050a34.26.1760469432690;
        Tue, 14 Oct 2025 12:17:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f9067887sm4708512a34.9.2025.10.14.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:17:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:17:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 5/6] packfile: introduce macro to iterate through packs
Message-ID: <6w2h4qvnwwci65puh6rmluy4br6m3xku3553473rn3k2dqnx2b@fs7gvglg4666>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
 <20251009-pks-packfiles-convert-get-all-v2-5-0d73b87ce711@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-5-0d73b87ce711@pks.im>

On 25/10/09 10:01AM, Patrick Steinhardt wrote:
> We have a bunch of different sites that want to iterate through all
> packs of a given `struct packfile_store`. This pattern is somewhat
> verbose and repetitive, which makes it somewhat cumbersome.
> 
> Introduce a new macro `repo_for_each_pack()` that removes some of the
> boilerplate.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/packfile.h b/packfile.h
> index 3f38c63476..49484a9b09 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -136,6 +136,14 @@ void packfile_store_reprepare(struct packfile_store *store);
>  void packfile_store_add_pack(struct packfile_store *store,
>  			     struct packed_git *pack);
>  
> +/*
> + * Load and iterate through all packs of the given repository. This helper
> + * function will yield packfiles from all object sources connected to the
> + * repository.
> + */
> +#define repo_for_each_pack(repo, p) \
> +	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next)

The added macro here is a nice quality of life improvement and the
updated call sites all look good.

-Justin
