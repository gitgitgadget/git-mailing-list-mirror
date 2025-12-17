Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B76264A86
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987849; cv=none; b=DrwiG7cmEBZoGG/yHSu21pmcUxQCHy1Co6ArzHpB42K0RzhncHrliuPeKzg4Ao4zLnwIC4MIowED/WEDe//YbuCTAY4yQErxCB1wCUa2JTOshhN0uGmWdMF5JctkNrz0bDPO9Xtacv7MCJIiP7g31Uv6TWFmdinIo4dzKdwts8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987849; c=relaxed/simple;
	bh=pah1hC1eWB/o09RzKJ0Mzn/xK18SLFMBS1cHXqTX8ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZkFvEblqlR6r8q01oOLS5EgVJIy7BRuOgAIQVIXZuoJADvqiS4IZ95TE3zavGA7ehObjMihh49FWgP2AXgMyUD27jGE67kToDP4aFSxgIiF5OoTCVprqkAwn7+ThAeHNKQ0Nd186THSJxFTHGx3UhoGEn1+eM9hjJbd32I35Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJch0SQV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJch0SQV"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c7533dbd87so5070614a34.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765987844; x=1766592644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2xzA0duV9/QGvAaoVzf72xLaXPaxcfOyMhPPDMfVNk=;
        b=kJch0SQVsbngNBs7cWrmtFjbKydHF/fcrm2EohOeoPaTpxf+GgHfjvbyKFaKmJF9X0
         3tb6NTYBo1ZJCqa/53Z0vglJS9T2yltsVVIYRIfZ3fm8xUyaUCb0TM7eRj8LxqpGVbNJ
         VauVxEOzj44J7+7L0hhGHQyEt8DUoGH9W2MwN4UknB+eD/joOuywlk51A8TsdGwqVkpe
         LZ9GCqWx1Wz67SIS2MnMlBNImc55s1TfnGTQngDBcz1oCOc4QiLI1VkZua7Sf4tzsENu
         +Ta5KEfcTwL4oxXXTnx3IMI8P7Agu+Xt68CjC+eZlQaeCNzGAs4qwH6VEV8pjcjvgxoC
         ABlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987844; x=1766592644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2xzA0duV9/QGvAaoVzf72xLaXPaxcfOyMhPPDMfVNk=;
        b=MNZ++dTSIaJ+J+9UwRfndI3KRe8Leo1I4gcmO16XTHqYXuGU9b08MNN+4khlWCyEwj
         BeYb3Qa1q0BsmPjTBil/+SOsPyjAmuBHco6n5rwdtKQIPG8xEn4rlsJoDzViJa2zNIcS
         Jorn0RN+Hqo2zPAi7sxpGyc0xhZqqA3+K0PwMdu8Zgd7w4EsAiqWiZoxw7poUDr4xBMu
         GCyXXj2AVTkq1o7DTM6EEKR+9Po2ViyFKEEzyMs/H/kp1tRsQOn9C8LPfIKZNK/PdN3r
         ylKnwJzzQFln+RK3aCr+qOBZHJIN0AmxBVFeWgHliwzkQqto5bkjqvy4T6ecpQMvPCKm
         87gw==
X-Gm-Message-State: AOJu0Yzi0Ztw5dQcgeJpeSvUfHz/gsceaQ7mV6mOOZvGV3EaQ5HWJRoC
	IRYg7078eD9r0DTpZNPuvZCl3BMjaPWPkvRTpHiecBNzITOTQjaWBNnU
X-Gm-Gg: AY/fxX4QFoBS6VxstpaJJw9fkeOwF5LBsNtbzwgosvmwnbUBCvoi9w36H5Qj6a+W1iE
	XNMIG5vWufFMefxsbuMnN2INRnJfig3vum/WVvZwNADAxz7jluAApDLspeyidYuY+62VdUQ00lu
	MTBO7fY49FUum+UCuQ8K0Uj2/PAO/DMzLbipCjXQc4mNtdE/LGX6Kg7nnHRJmHCMl0gcIKzWAom
	N/KKGnEb4eb9HMSPNDtGJTLp0aKci5pgxWWrui1vEdAdZh52tmqAJPxCSNuO31eAeZOmczkCwMu
	TuYEIyJnzQjeYinqDbeqij1bj1pOyTtEWEdRA5WQ1zRqYVG6Uu0OlkS946Cwzc3y/Y5V+ERL8UA
	Vk2oXWPH8WlMu5xjzjYLBFqw51i4LsmX9zuPdAVPDCEb1uSvv5op7oaYU0r5qJqHKTaMnSA6DVG
	wd+Eqq
X-Google-Smtp-Source: AGHT+IHEzRruxVqT9bu8Pvh8H6FGPtiXRC8Z+PCAbDOiPi42VUsCNpHhDcLjyEwLbZN41qCQKc4E6Q==
X-Received: by 2002:a05:6830:2b25:b0:7c7:5349:4e31 with SMTP id 46e09a7af769-7cae835db3cmr11188642a34.21.1765987844376;
        Wed, 17 Dec 2025 08:10:44 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1d1d71sm13561806a34.2.2025.12.17.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:10:44 -0800 (PST)
Date: Wed, 17 Dec 2025 10:10:43 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Subject: Re: [PATCH v4 4/7] builtin/repo: add inflated object info to
 keyvalue structure output
Message-ID: <ygljaf4o7mgsvzz6upybtj3fslpdk7a5j3jz3lxjhho4is5cjf@o22or2lcvhep>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
 <20251216173842.3357832-5-jltobler@gmail.com>
 <aUJVyHOCsCjjazB-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUJVyHOCsCjjazB-@pks.im>

On 25/12/17 08:03AM, Patrick Steinhardt wrote:
> On Tue, Dec 16, 2025 at 11:38:39AM -0600, Justin Tobler wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index 9c61bc3e17..e207108346 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -495,20 +508,39 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
> >  {
> >  	struct count_objects_data *data = cb_data;
> >  	struct object_stats *stats = data->stats;
> > +	size_t inflated_total = 0;
> >  	size_t object_count;
> >  
> > +	for (size_t i = 0; i < oids->nr; i++) {
> > +		struct object_info oi = OBJECT_INFO_INIT;
> > +		unsigned long inflated;
> > +
> > +		oi.sizep = &inflated;
> > +
> > +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
> > +						  OBJECT_INFO_SKIP_FETCH_OBJECT |
> > +							  OBJECT_INFO_QUICK) < 0)
> 
> Tiny nit: there seems to be an extra tab here. This really is only worth
> fixing if you intend to reroll anyway.

I had that initially, but it was failing the check_style CI job so I
just opted to what clang format wanted. I can change it though if I sent
another version. I haven't quite figured out the best way to wrap long
lines.

-Justin
