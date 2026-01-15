Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6A30DEDC
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513506; cv=none; b=UAXQYxKBo8mLjBGnM1pVlQE9N+y2qJUWqVBD9HVtZVDwm5Pus/rpR6eFJi2a7gBvJFMqjSLhFxytmyMPp37HUuyZ/NWlgeIiLFAjjOLqf8En/+kp3VML8f64+V8iqdPQHowWudWwLkKaZx7RDNZvg9iYNVcBtFc/7zm/YGSpe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513506; c=relaxed/simple;
	bh=YXQpyANoXzp7VXziIJJhMPCDDMvaxKwYWbmATrTTNzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH41OwS6zDyX3FxvfwNnzudeOUlIm3TNqKNRzjC5HcPe8XoLK2jls25M6EUTAVKzr10pREAhtDhZqXwcTOyWHBDZuTmBKcyF9YQc6J8+SysxXYSbQVkRCzJyF4PE426n2cyO2r+1ftBm5DFLXDvQBJs6iw4pcx7mALPlbjumusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/sghrrQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/sghrrQ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c798c92edso835442b6e.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768513494; x=1769118294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpSElHq5jh5w3pR64oxQYIRL6guglknP2Ajr4YAPBbs=;
        b=B/sghrrQ/L4X06RjvRT57SiN8XU7Mg8rwZrSyem0saKsUBO17SKJGBO9Dujs1ghSIU
         iGv5sQafcpx0KmQZuc+UJt7t6+f+Ih2RP0TAEFkTo/VMU5Paec0AltlLdlZK1VvMWj6B
         CTCQ4F0xFMYOvgEmSUYQWQlPqd/bnput9ZHEXlAkdEumK9/bd+kVjTllSyUwRPWj8FsN
         X8z4LUN68hHuph5aQO8MrPZoJzZoNxvBH1r3EVV/+iqvX4hgecd+XM/z5uK1WwFLCYMt
         7KbNmREXUSby3uWQsPMeVfvl9bQ+1Tdl0vAIIhFSmiSWdk4wlACUxtiDKf+pCJzORmKB
         104g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768513494; x=1769118294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpSElHq5jh5w3pR64oxQYIRL6guglknP2Ajr4YAPBbs=;
        b=N+RGvH3NCGRv5s5PQliB1I+V/11WPvNQXl9QgGx189q2rcxDJM2W+2qzjilRF43PIO
         weJpt794dZJNgHb17lMEXhzl2vNeryNav99phgt37OWEeUHq0/tJ4EDiB00d5P+vn00r
         MuPYk5rTpqZypfV2N28vDHkhl4eR/uiZ6uaVWaGkb3mWuBCptnie6y3ixsUPJSoH40AE
         mQGeiqYpqR3YsosFzwUU+2aD+apaqcUi6Gs96GJ8H+KwqMBGPc+eRnEHvQzZIhG5zC67
         N84kw8sEoETR9zkcnmB/KWVxzFoUFFWh0ZXxbIvyhoHFuDXwyMgzPkvqCFcdOy6z7okX
         W14Q==
X-Gm-Message-State: AOJu0Yxpm+Hfn7MdK+IQAWuoDaAtfG+wkcOCfAAzBRed77RZBQ2uhVZi
	4vj50/J3DYR5PXxvmyb77KIKcnYUqGdseuLNNFygzwYETyxSlGOy1RzokUKAWA==
X-Gm-Gg: AY/fxX6GXrqcEIKehtSDc/wpJZKDrf6GLMRWj+xbT++ZGVojmMy01J1HppHh8w9bqAy
	XWpxwFPOgbHHKZJ3djUGXycElnvg7/bnKs8Y+Z3sDltZeFmWME6zhGwWc51KK7oPJEPs4U8YvWd
	ax/Xz0mQh7XiHrnURpktt5g7SxULpYo7mmqs95aFAYyqSMDFnCkjxUie3aeatwKI5S7Ggdt0iVA
	gu/saMhOsX+upFbFPgGtQvvGudcICqFBJmlqlMWlqq291t8GCS/7vBdEwxF0CsP765exLFEn2ME
	Y5Grmwtwtq9qHfqfrAamlSFJhg9IgGRC5vjakPMWbsXaUEdRNNuzi86fEtdMVbkLpaBfc55GvhW
	CSkQNhZh+NRqr7Qdz3i/QrDTRR9GphNRg4hdTiiwg+Gq5r6O28OLHis60slrBeHq7u9AZ18CQLg
	N6WfHH
X-Received: by 2002:a05:6808:c18d:b0:450:db06:6079 with SMTP id 5614622812f47-45c9c1157dbmr428508b6e.53.1768513494039;
        Thu, 15 Jan 2026 13:44:54 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e03e817sm295581b6e.16.2026.01.15.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:44:53 -0800 (PST)
Date: Thu, 15 Jan 2026 15:44:50 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/14] treewide: drop uses of
 `for_each_{loose,packed}_object()`
Message-ID: <aWlemFAu9HwKgpOe@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-10-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-10-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> We're using `for_each_loose_object()` and `for_each_packed_object()` at
> a couple of callsites to enumerate all loose and packed objects,
> respectively. These functions will be removed in a subsequent commit in
> favor of the newly introduced `odb_source_loose_for_each_object()` and
> `packfile_store_for_each_object()` replacements.
> 
> Prepare for this by refactoring the sites accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 28 ++++++++++++++++++++++------
>  commit-graph.c     | 44 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 6964a5a52c..7d16fbc1b8 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -806,11 +806,14 @@ struct for_each_object_payload {
>  	void *payload;
>  };
>  
> -static int batch_one_object_loose(const struct object_id *oid,
> -				  const char *path UNUSED,
> -				  void *_payload)
> +static int batch_one_object_oi(const struct object_id *oid,
> +			       struct object_info *oi,
> +			       void *_payload)
>  {
>  	struct for_each_object_payload *payload = _payload;
> +	if (oi && oi->whence == OI_PACKED)
> +		return payload->callback(oid, oi->u.packed.pack, oi->u.packed.offset,
> +					 payload->payload);
>  	return payload->callback(oid, NULL, 0, payload->payload);
>  }
>  
> @@ -846,8 +849,15 @@ static void batch_each_object(struct batch_options *opt,
>  		.payload = _payload,
>  	};
>  	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
> +	struct odb_source *source;
>  
> -	for_each_loose_object(the_repository->objects, batch_one_object_loose, &payload, 0);
> +	odb_prepare_alternates(the_repository->objects);
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
> +							   &payload, flags);
> +		if (ret)
> +			break;
> +	}
>  
>  	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
>  						 batch_one_object_bitmapped, &payload)) {
> @@ -861,8 +871,14 @@ static void batch_each_object(struct batch_options *opt,
>  						&payload, flags);
>  		}
>  	} else {
> -		for_each_packed_object(the_repository, batch_one_object_packed,
> -				       &payload, flags);
> +		struct object_info oi = { 0 };
> +
> +		for (source = the_repository->objects->sources; source; source = source->next) {
> +			int ret = packfile_store_for_each_object(source->packfiles, &oi,
> +								 batch_one_object_oi, &payload, flags);
> +			if (ret)
> +				break;
> +		}

Huh, I was a bit surprised to see that we are still handling object
iteration in a backend specific banner here. I would assume ideally we
would want to transparently iterate across objects wherever possible. I
assume the reason here has something to do with how iteration is handled
with bitmaps?

-Justin
