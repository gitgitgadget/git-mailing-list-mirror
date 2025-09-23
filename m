Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBA61FFE
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640795; cv=none; b=JApvRfQiuxaxsTSeOIeaVYPJ5+/30GtEZxONWeDj546jeBgg23ka4yjO8OuVIer77wb8XeV3gJtBxD8BOv9hsQK3oOD2If2nqYX+huMJIgN+v1MoHTBshcWGru/UVCDEt+UosMaonNDMN7WUw6J2gtWxQEibRioihph41wWlxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640795; c=relaxed/simple;
	bh=iOcGfOClVVt1pMDFLMFCVd+ub2TBh8EVGUamVIHoiZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIYQUdk4JNrI3BP6TZoJ7cq1zxf/Eze1AKgn+ci9qclaqe7m0unfBasNqWP7Z4vSbOZiWzte5TL2wyLryEJmdKYc7JLAbvo7WPvCoPqE6ZRuoD+Xm5yqyO5qPYHSQlwfQnO3KdPJyg21jPg9/1v82Apvzo9tpT1RNDDW1elutUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb0MNhlA; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb0MNhlA"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-32bd4f1b671so4624918fac.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758640792; x=1759245592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUaBE02vmMVsmdKDv4syz//fpm2NqXbweXTeF49Gf50=;
        b=jb0MNhlALLZTTLTUlWmcdKJ81A+EAjmgZq47oq4yDX37sKYbPbf6wmIs2e3/gvhZLd
         br6WlCO4UWYG0to4AwaGeHGk2MOc6GtOJRBgjGwDrNE439K8yF626WqZDJpEoKRzKd6R
         wjNlq5aDlHpF7XRrVA4b8viUUCwb2aXLmdlD2V0gEOHsM61J+zBLeqeWefRM2h01W/wU
         iXm9J4oKKbfVJ8BhOfD6xgJCFX7mERIy5bIbbHmkFotwsd0Ayqkv4FgaOIfXRbwKX8mH
         mFlbUqvOWSBfw6IVnlgT52YrBGWFlY0D8K/vSt+lz3318NKJm+xVg0YqCETjR8ynOQUY
         RxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640792; x=1759245592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUaBE02vmMVsmdKDv4syz//fpm2NqXbweXTeF49Gf50=;
        b=TIabL8nafXceowdcLopkjTKOcnjRjMi1zr0YByATbwhYCk9s1NTqOZfcoVhfEhTIey
         EAki0+h88CfQlbwSEFrQ157TOsj10sMWhLN5Pmhayg1VRzdwcRZ0DSW6xI1AcMQaNCuc
         aK4n/e9yHLPCttQYC68cIfuZo+/FCU8G+qCt7/GotuVOcVu53oyXD4jl0ZhTt7NX4NP2
         YGGaKzq7K0D/vk0XVH9snagXWnYOD7N5gEx1JcnWq3YqnExcUyPA2nDTmt8NS+HzU9j5
         Zb67XYbjzYO1skzekxIVm2WYzAliRvTCUg5SflCGPxxBn9l7305YNB8mROvZHyNwzvgP
         cHTg==
X-Gm-Message-State: AOJu0YyAkjY8wwPMb7DyWMwUsFANklFNymr8RjOA6ckXyDH7mgP9aTGl
	gTHX1ufmMKa7QlCfEEQ7JlKGWYnCU9dpP7ohPt9pUEoj/wqMA2JJSrlx
X-Gm-Gg: ASbGncsYryvynC5f2C8ECSrSIRPZnwma/8vwhUE3C7HhWIout0S7e+CgEZ/dcP6zEna
	lm4rsx/hgEHyqQHAvcAclPsfiOmhi7UcuBH8/Udazz8wctobWiMMx1y2wNauMDv1ZEyw55rHtSn
	UqpBRkhAcqlPQRNOsGXb/IAvpSEmjrQ5NvCblaaACet3NiymJ4wGE+Hqiin4Lox/HnzVGzDLEBL
	fIP1dmD909rzZuK5t7HtK398ufitXfCJuwsMDSL+5cKwE6Jd+5Z2myjwExr771LOS0bv45AaGuv
	ip8DWgIuS5Nqx5u03Kj6aMd2trot2zTZqlMtwPkpOpGmTLNxw/pGI4U9EacRcQzDU5UzG8b1ROV
	XzYlYv6uL0YhGOfww
X-Google-Smtp-Source: AGHT+IHVRXIYz8DrUG8gdxg/f7LkqsWCNx3hUFz97G/g4xda8Z0SDsd9UZv9NOL/QVT9uzq4bldU2g==
X-Received: by 2002:a05:6870:4cc4:b0:33d:c5bc:1a05 with SMTP id 586e51a60fabf-34cc1ea0f34mr1778006fac.10.1758640792141;
        Tue, 23 Sep 2025 08:19:52 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-336e5f5479bsm9643178fac.26.2025.09.23.08.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:19:51 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:19:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 2/4] builtin/repo: add object counts in stats output
Message-ID: <rarmjytj4aci2uwewga3firgh3py65cd4nuu3dq52bxvjejp2a@hg2i3fpzjcir>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-3-jltobler@gmail.com>
 <aNJ8BvTZ_yNSrBA6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ8BvTZ_yNSrBA6@pks.im>

On 25/09/23 12:52PM, Patrick Steinhardt wrote:
> On Mon, Sep 22, 2025 at 09:56:58PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > index 7762329551..2a67abfca8 100644
> > --- a/Documentation/git-repo.adoc
> > +++ b/Documentation/git-repo.adoc
> > @@ -45,8 +45,9 @@ supported:
> >  `-z` is an alias for `--format=nul`.
> >  
> >  stats::
> > -	Retrieve stats about the current repository. All references in the
> > -	repository are categorized and counted accordingly.
> > +	Retrieve stats about the current repository. All references and
> > +	reachable objects in the repository are categorized and counted
> > +	accordingly.
> >  +
> >  The table output format may change and is not intended for machine parsing.
> 
> I already wanted to mention this on the first commit, but would it maybe
> make sense if this was a bulleted list of information that we surface
> right from the start? Then we don't have to reflow the whole paragraph
> every time we surface new information.

Makes sense.

> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index 15899dd74c..a24ea0e66b 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -159,13 +161,25 @@ static int repo_info(int argc, const char **argv, const char *prefix,
> >  	return print_fields(argc, argv, repo, format);
> >  }
> >  
> > -struct stats {
> > +struct ref_stats {
> 
> Nit: let's call it `ref_stats` right from the start instead of renaming.

Will do.

> >  	size_t branches;
> >  	size_t remotes;
> >  	size_t tags;
> >  	size_t others;
> >  };
> >  
> > +struct object_stats {
> > +	size_t tags;
> > +	size_t commits;
> > +	size_t trees;
> > +	size_t blobs;
> > +};
> > +
> > +struct stats {
> 
> I'd maybe call this `struct repo_stats`. `stats` feels quite generic and
> very close to a collision with `struct stat`.

That's fair. I quite like the name `repo_stats`. I'll use that instead.
Thanks

> 
> > @@ -207,15 +221,27 @@ static void stats_table_add_count(struct stats_table *table, const char *name,
> >  
> >  static void stats_table_setup(struct stats_table *table, struct stats *stats)
> >  {
> > +	struct object_stats objects = stats->objects;
> > +	struct ref_stats refs = stats->refs;
> 
> We can avoid the copies by making these pointers. Not that it'd really
> matter all that much.

Ya, I'll change this in the next version.

> > +	size_t object_total;
> >  	size_t ref_total;
> >  
> > -	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
> > +	ref_total = refs.branches + refs.remotes + refs.tags + refs.others;
> >  	stats_table_add(table, _("* References"), NULL);
> >  	stats_table_add_count(table, _("  * Count"), ref_total);
> > -	stats_table_add_count(table, _("    * Branches"), stats->branches);
> > -	stats_table_add_count(table, _("    * Tags"), stats->tags);
> > -	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
> > -	stats_table_add_count(table, _("    * Others"), stats->others);
> > +	stats_table_add_count(table, _("    * Branches"), refs.branches);
> > +	stats_table_add_count(table, _("    * Tags"), refs.tags);
> > +	stats_table_add_count(table, _("    * Remotes"), refs.remotes);
> > +	stats_table_add_count(table, _("    * Others"), refs.others);
> > +
> > +	object_total = objects.commits + objects.trees + objects.blobs + objects.tags;
> > +	stats_table_add(table, "", NULL);
> > +	stats_table_add(table, _("* Objects"), NULL);
> 
> Should we maybe say "Reachable objects" here to clarify that this
> doesn't count unreachable ones?

Good suggestion. Will update.

> > @@ -282,25 +308,80 @@ static void stats_count_references(struct stats *stats, struct ref_array *refs)
> >  	}
> >  }
> >  
> > +static int count_objects(const char *path UNUSED, struct oid_array *oids,
> > +			 enum object_type type, void *data)
> > +{
> > +	struct object_stats *stats = data;
> > +
> > +	switch (type) {
> > +	case OBJ_TAG:
> > +		stats->tags += oids->nr;
> > +		break;
> > +	case OBJ_COMMIT:
> > +		stats->commits += oids->nr;
> > +		break;
> > +	case OBJ_TREE:
> > +		stats->trees += oids->nr;
> > +		break;
> > +	case OBJ_BLOB:
> > +		stats->blobs += oids->nr;
> > +		break;
> > +	default:
> 
> Let's `BUG()` here. This case should never happen, and if it does
> something is seriously wrong.

I agree it doesn't hurt to be more defensive here. I'll update in the
next version.

> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void stats_count_objects(struct object_stats *stats,
> > +				struct ref_array *refs, struct rev_info *revs)
> > +{
> > +	struct path_walk_info info = PATH_WALK_INFO_INIT;
> > +
> > +	info.revs = revs;
> > +	info.path_fn = count_objects;
> > +	info.path_fn_data = stats;
> > +
> > +	for (int i = 0; i < refs->nr; i++) {
> > +		struct ref_array_item *ref = refs->items[i];
> > +
> > +		switch (ref->kind) {
> > +		case FILTER_REFS_BRANCHES:
> > +		case FILTER_REFS_TAGS:
> > +		case FILTER_REFS_REMOTES:
> > +		case FILTER_REFS_OTHERS:
> > +			add_pending_oid(revs, NULL, &ref->objectname, 0);
> > +			break;
> > +		}
> > +	}
> > +
> > +	walk_objects_by_path(&info);
> > +	path_walk_info_clear(&info);
> > +}
> 
> I guess this can take a while, so having a progress meter would be great
> to have to give the user some info what's happening. I guess it doesn't
> have to be part of the first iteration thuogh as long as this is
> something we plan to add at a later point.

Ya, I was planning on adding a progress meter in the future. It may not
be too much to add it as part of this series though. I'll take a look.

-Justin
