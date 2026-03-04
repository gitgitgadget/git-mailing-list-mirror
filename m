Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82101382F2C
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656803; cv=none; b=GuRR6vVbZ4rZK6Ej7HAMlYq+yUgRKbZxSAChrstSid/Rf4epbRxoBIAycLwSoUAKR8/UKvj4NENa61S4wn5VEij/ChdePYVh8fcj9PXUpu4IVq3+1ThIGnwUHBMNXfSJMJsHsL88fTISJhwx5WcF4zvXTZiFWQ0BCluhYpMXsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656803; c=relaxed/simple;
	bh=yJO6AGkW5eGyASPzwY8Fu5UC+RU+eNzyamjhvDCWtIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ke2aNP+CzqB1w2pJ1NQorTVQMrNYPbezIW7aWiKovUIsqvFRildMOeALPfB06mTa2hMpj9Vh4MMIsS0B0T8B2CfThJK9RgSVH0t1VMMrXEDM3bTEON7oCbzFaiP9y8C2mMyudpnpa/w3voNBLDJ2qRxgP8lHCzN8HIHeXvAbXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTsWznM1; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTsWznM1"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40ee9b945d5so1494782fac.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772656801; x=1773261601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FohX+KXbuqigTU7jwLNUyei2fTAk4a24+hwpGKzb4fU=;
        b=eTsWznM1w+Rce5G2rNGc1NXsIFBZn6CMZnS4fY2RZc5g3bKpMuwKIplerRheFxE+I1
         tDIkHFcQEIJskUaLQoPdNJckW6LkJNrPBp6jn2u42XtY05MGUT/iSZRstqsq0+D1egRp
         EZQObuFaxEUSmlBHSCao+oTYIDWxdLw9s+7nytU5HyVi1OQ/RQ4pqN+uOGl6Wljo3YdL
         /MUp/gQC1yeqSyPxIixSWTXLqN9EVVRJmohMKDPyzy61g9EEVrN1NPzuCcAJQqoqlrFx
         v+V2/h7EpW+rpCsBvC6EczOaoUhz2L2hKQTeCYw7aQLsofIgNbbPuvXIR2PdvvdDsjzl
         JJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772656801; x=1773261601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FohX+KXbuqigTU7jwLNUyei2fTAk4a24+hwpGKzb4fU=;
        b=nERE9HLhewMxbeldmlghba5hpnDv/SYQwbwEcKf5T+yjZk/sQFOAsqCX3wibITNB3i
         xLSP101XAHlW6Ngqr84c6269idHJvu9tC+6ZTMb4YVuvMRPIjBUQwf5wB2V9uawKRPQi
         A5wBdTr+oHkupSeMOX+Si9EG3ImjPO9e0UuS1pRshiaGBk62r6hTQhdc0G0dfABIrx7K
         ckb0z0F5PA+phIoVNspgbS+huXze9EsPsze/8v8uilyXj+r6UWgrZTeGqrJtt9HsQITh
         g1FDFX0u9YhHeShcTZGeEiAhLe9hEKOx4Yb+h3pQgbipohhsgfrAjRQ9vdSmpXkmTDO7
         xA2w==
X-Gm-Message-State: AOJu0YzgrorFo6yut68lF1oWkmZ9SnZZiUviiyl8NuUWFVVE8iigY9pu
	E35NJUp7Pw5SErCpt7vFhjNCRgKsx/bySfGvH1qJtOKyPMYmEhdZDNSevfcVYQ==
X-Gm-Gg: ATEYQzwALdXcvar5UU5jAkPUtbUufM4f3LuIMirwus4rGFCWRs1xGzXkaJovvGFEnjR
	e1ZsHw9TmjeKRFD2xSEyUViKRuEBxnGa8mo6WtcAYaQtI9HNUVm1A9XxDElQszg76NE7JyUjakA
	1oyoxBtU6iwQlWwVy5fpS7sPb3pGlu4x9zu4s07Nb8tUlV1HWQTphhg3fXUCHxJcu2oIzv0Kdtw
	rfhbsvPcyQsMGrNPLs32yYPGEkg63sU9QphCb1JLf1/ha4cqTgYYVSxXzEd8AVVm0U70rgMkskq
	VGGfgWvERX6XxbkQ8v25D4o2gAvxNypw8QSTea99JCn6B2q12UbXWKH4MM9Pj1uV4DY5INPqzLO
	momhs0YhFD/QrrC1cK47IwD+I71uNoFBHj/2dWMO+bCIfnvmidof6LoaAx+A5zeyxOL4FWdoGqL
	Y4C8dfMxnoPitqkRxy
X-Received: by 2002:a05:6871:c91c:b0:409:4b01:339b with SMTP id 586e51a60fabf-416abb2ba50mr1997965fac.55.1772656801147;
        Wed, 04 Mar 2026 12:40:01 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b24dsm18977421fac.7.2026.03.04.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:40:00 -0800 (PST)
Date: Wed, 4 Mar 2026 14:39:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/17] odb: move reparenting logic into respective
 subsystems
Message-ID: <aaiSFpWY0YQ6XQcM@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-4-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-4-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> The primary object database source may be initialized with a relative
> path. When reparenting the process to a different working directory we

I find the wording here a bit confusing. Maybe something like this would
be a bit clearer:

  When the process changes its current working directory...

> thus have to update this path and have it point to the same path, but
> relative to the new working directory.
> 
> This logic is handled in the object database layer. It consists of three
> steps:
> 
>   1. We undo any potential temporary object directory, which are used
>      for transactions. This is done so that we don't end up modifying
>      the temporary object database source that got applied for the
>      transaction.
> 
>   2. We then iterate through the non-transactional sources and reparent
>      their respective paths.
> 
>   3. We reapply the temporary object directory, but update its path.
> 
> All of this logic is heavily tied to how the object database source
> handles paths in the first place. It's an internal implementation
> detail, and as sources may not even use an on-disk path at all it is not
> a mechanism that applies to all potential sources.

Indeed this mechanism is directly coupled to how the "files" backend
operates.

> Refactor the code so that the logic to reparent the sources is hosted by
> the "files" source and the temporary object directory subsystems,
> respectively. This logic is easier to reason about, but it also ensures
> that this logic is handled at the correct level.

Makes sense.
 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb/source-files.c b/odb/source-files.c
> index a43a197157..df0ea9ee62 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -1,13 +1,28 @@
>  #include "git-compat-util.h"
> +#include "abspath.h"
> +#include "chdir-notify.h"
>  #include "object-file.h"
>  #include "odb/source.h"
>  #include "odb/source-files.h"
>  #include "packfile.h"
>  
> +static void odb_source_files_reparent(const char *name UNUSED,
> +				      const char *old_cwd,
> +				      const char *new_cwd,
> +				      void *cb_data)
> +{
> +	struct odb_source_files *files = cb_data;
> +	char *path = reparent_relative_path(old_cwd, new_cwd,
> +					    files->base.path);
> +	free(files->base.path);
> +	files->base.path = path;

I do find it a bit curious that we consider the "path" to be specific to
the "files" backend, but still track it as part of the "base" ODB
source. I suspect this will eventually change though?

> +}
> +
>  void odb_source_files_free(struct odb_source_files *files)
>  {
>  	if (!files)
>  		return;
> +	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
>  	odb_source_loose_free(files->loose);
>  	packfile_store_free(files->packed);
>  	odb_source_release(&files->base);
> @@ -25,5 +40,13 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  	files->loose = odb_source_loose_new(&files->base);
>  	files->packed = packfile_store_new(&files->base);
>  
> +	/*
> +	 * Ideally, we would only ever store absolute paths in the source. This
> +	 * is not (yet) possible though because we access and assume relative
> +	 * paths in the primary ODB source in some user-facing functionality.
> +	 */

Should this be a NEEDSWORK comment? Or do we expect it to remain this
way for the forseeable future?

> +	if (!is_absolute_path(path))
> +		chdir_notify_register(NULL, odb_source_files_reparent, files);

Ok so now a callback to reparent the path is set up for the "files"
source when it is created. If there are multiple "files" sources
created, each source will be handled separately.

> +
>  	return files;
>  }
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 9f5a1788cd..e436eed07e 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -36,6 +36,21 @@ static void tmp_objdir_free(struct tmp_objdir *t)
>  	free(t);
>  }
>  
> +static void tmp_objdir_reparent(const char *name UNUSED,
> +				const char *old_cwd,
> +				const char *new_cwd,
> +				void *cb_data)
> +{
> +	struct tmp_objdir *t = cb_data;
> +	char *path;
> +
> +	path = reparent_relative_path(old_cwd, new_cwd,
> +				      t->path.buf);
> +	strbuf_reset(&t->path);
> +	strbuf_addstr(&t->path, path);
> +	free(path);
> +}

Ok, at first I was a bit confused as to why we needed this logic for the
tmpdir as well. I thought reparenting as only applied to the primary
ODB, but it looks like the tmpdir was also reparented via
tmp_objdir_reapply_primary_odb().

> +
>  int tmp_objdir_destroy(struct tmp_objdir *t)
>  {
>  	int err;
> @@ -51,6 +66,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
>  
>  	err = remove_dir_recursively(&t->path, 0);
>  
> +	chdir_notify_unregister(NULL, tmp_objdir_reparent, t);
>  	tmp_objdir_free(t);
>  
>  	return err;
> @@ -137,6 +153,9 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
>  	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX",
>  		    repo_get_object_directory(r), prefix);
>  
> +	if (!is_absolute_path(t->path.buf))
> +		chdir_notify_register(NULL, tmp_objdir_reparent, t);
> +
>  	if (!mkdtemp(t->path.buf)) {
>  		/* free, not destroy, as we never touched the filesystem */
>  		tmp_objdir_free(t);
[snip]
> diff --git a/tmp-objdir.h b/tmp-objdir.h
> index fceda14979..ccf800faa7 100644
> --- a/tmp-objdir.h
> +++ b/tmp-objdir.h
> @@ -68,19 +68,4 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
>   */
>  void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
>  
> -/*
> - * If the primary object database was replaced by a temporary object directory,
> - * restore it to its original value while keeping the directory contents around.
> - * Returns NULL if the primary object database was not replaced.
> - */
> -struct tmp_objdir *tmp_objdir_unapply_primary_odb(void);
> -
> -/*
> - * Reapplies the former primary temporary object database, after potentially
> - * changing its relative path.
> - */
> -void tmp_objdir_reapply_primary_odb(struct tmp_objdir *, const char *old_cwd,
> -		const char *new_cwd);

These functions are no longer needed because each of the sources have
their paths updated directly via separate registered callbacks. Makes
sense.

-Justin
