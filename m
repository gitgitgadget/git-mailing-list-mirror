Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EE328611
	for <git@vger.kernel.org>; Thu, 21 May 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378569; cv=none; b=Ivitz+VOouveGbQcQKMq3F+ynBxRjihOesiHHmy6n4rOdxDbVlLUd0W3PDG+VCt0ZtzwzAmbmdZLEtE2AIuTiPkSbB/jvQ1lAQ+Pzsm5fCBmPN6+/moU3ftZzRqNMRGjxN23XKaQyl+1OWm/7Yr4/imtxYL5WUIQ34aZdZicLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378569; c=relaxed/simple;
	bh=5qGmXqVZ2BvZXPZtCsmdTkBY9sDi4og93w3INfZ5JY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r7doK9FNomgmCmQlEYYbn4UkdmsdDxUXffcHYAttFaucoYYjnF4iAigVpT2zvCASSJiXsfhR2WcUynq6jGX9U6l6bNPOv3JtXArTs/ygjFyVtH6YpNE54tn+guFVnxEbN3dbD0f1pEbG3x7+KJ81dKSvmIE6eGGcaCNpXbUvz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cE4OwZw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hd50Mk+I; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cE4OwZw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hd50Mk+I"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DAC2D1D00098;
	Thu, 21 May 2026 11:49:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 21 May 2026 11:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779378566; x=1779464966; bh=xWcCyicu/E
	x6rGDGxx0rtYFPLZ9cwcj+OvAFfdpWONU=; b=cE4OwZw30I0QERibqZptm96Xm7
	1y0XYbRSC9WoZgn5rylm54fs169/nwQ9RS+/4sldcN+uw4LI7LnFutP8T+K+shIM
	fNyeiw7LtdHq4ERUZbevb/Y2V72jj8kpvlkr19EqGXSVu+hsChC3PunFSH1cbGCb
	3sUTfv/od+RemqEbkxHQEzLYCwgNNfET2WiKv8BGAgIW5mhgUM67UARkFldGBYyA
	62LVPhZJzRTs1fUjSh5jdTU14GPWJ0TZG0GcMSef7JSi6THcaqR5SRi3jo0odyXl
	aQXyZhNcnYeCa1CyXBu+i0b0vjkSDpzD7tbvZMkdCWcda8WpC5AO6mGE0YuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779378566; x=1779464966; bh=xWcCyicu/Ex6rGDGxx0rtYFPLZ9cwcj+OvA
	FfdpWONU=; b=Hd50Mk+ITSeawWC3Oequ8WASgsqRJr/j83MqlzwiT3l9OxBWhLh
	A1htU/wgdKiYma3ZlYgSueyNPSCJ3jFNL6W0RHSyLLouAWurKZDSG9725veYsQU3
	JFX5fb0gy7esWyJOhVnaXbubCUUNSGo2F8to6qpT9eg7b4gWF6ndMEv5VTqkIAJF
	yduUPGFt/csZYvmVaYMZI2huyfodTqpH1QLREUV2YtBIYKs0Gl6jpPqJMFp5F9Q4
	0G3Tzb0kHa+XR6EDZZ503RY3GGyTaUCguTsj/+4Lks3aAg5HV9LeUb1+VKywXu4x
	NtVC9qKJWCyLTbnlKteL+Hp1gGP21nhzWWA==
X-ME-Sender: <xms:hikPanVIkHSe8Qwd9gIyBFUY_h40qIVlrXzIbXQTogxTDgkFSoAzcA>
    <xme:hikPanDvNTbuwH3AKr_i8zr-tipQjN33Be_juTcDUSV8KEjFCQrVVtumZQffuXjDq
    4zh5kdQdNL8I2qvQ9HhAnH_Wi4TQqGO5XYWNGMrP0rn744LOJgO97A>
X-ME-Received: <xmr:hikPagyb05mfBHFkhMDq-_R8HXIx07hMZk8aEw6SOc0_70r7ngGeL2Heb4PYozlo9TV_dsWzQHBBD2yfOmWDs3eSX2vxdYOaGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:hikPasBPQNzta-tvdiO7R6Ix58KNEW6VkLERWXNIy5N7a0-5SA6SaA>
    <xmx:hikPalbwaf6OZq2uMCTnsUb-aDEAVtj9iu5ZBVf2LG_aSCHvTuTJow>
    <xmx:hikPasgZ4q66IzQycJWWiQhm4Mqn0OR9hiJmTqb-K8V75L5DUPlSXg>
    <xmx:hikPav6zoTsyiu56vQRHWtraCPAXRAwzSGHLxslsKajQS6O608O3YA>
    <xmx:hikPanLVzTYPoiDwUzbjbCZ5ebHNwaLl4JhsYoYnfwBz6PSvpUSb-O8q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 11:49:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/18] odb/source-loose: start converting to a proper
 `struct odb_source`
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-3-6553b399be2d@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 May 2026 10:22:23 +0200")
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
	<20260521-b4-pks-odb-source-loose-v1-3-6553b399be2d@pks.im>
Date: Fri, 22 May 2026 00:49:24 +0900
Message-ID: <xmqqh5o0zrsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Start converting `struct odb_source_loose` into a proper pluggable
> `struct odb_source` by embedding the base struct and assigning it the
> new `ODB_SOURCE_LOOSE` type. Furthermore, wire up lifecycle management
> of this source by implementing the `free` callback and taking ownership
> of the chdir notifications.
>
> Note that the loose source is not yet functional as a standalone `struct
> odb_source`, as it's missing all of the callback implementations. These
> will be wired up in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c      | 17 -----------------
>  object-file.h      |  2 --
>  odb/source-files.c |  2 +-
>  odb/source-loose.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  odb/source-loose.h | 14 ++++++++++++++
>  odb/source.h       |  3 +++
>  6 files changed, 63 insertions(+), 20 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 7a1908bfc0..977d959d33 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2041,14 +2041,6 @@ static struct oidtree *odb_source_loose_cache(struct odb_source *source,
>  	return files->loose->cache;
>  }
>  
> -static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
> -{
> -	oidtree_clear(loose->cache);
> -	FREE_AND_NULL(loose->cache);
> -	memset(&loose->subdir_seen, 0,
> -	       sizeof(loose->subdir_seen));
> -}
> -
>  void odb_source_loose_reprepare(struct odb_source *source)
>  {
>  	struct odb_source_files *files = odb_source_files_downcast(source);
> @@ -2205,15 +2197,6 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
>  	return &transaction->base;
>  }
>  
> -void odb_source_loose_free(struct odb_source_loose *loose)
> -{
> -	if (!loose)
> -		return;
> -	odb_source_loose_clear_cache(loose);
> -	loose_object_map_clear(&loose->map);
> -	free(loose);
> -}
> -
>  struct odb_loose_read_stream {
>  	struct odb_read_stream base;
>  	git_zstream z;
> diff --git a/object-file.h b/object-file.h
> index 1d8312cf7f..02c9680980 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -21,8 +21,6 @@ struct object_info;
>  struct odb_read_stream;
>  struct odb_source;
>  
> -void odb_source_loose_free(struct odb_source_loose *loose);
> -
>  /* Reprepare the loose source by emptying the loose object cache. */
>  void odb_source_loose_reprepare(struct odb_source *source);
>  
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 185cc6903e..ccc637311b 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -27,7 +27,7 @@ static void odb_source_files_free(struct odb_source *source)
>  {
>  	struct odb_source_files *files = odb_source_files_downcast(source);
>  	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
> -	odb_source_loose_free(files->loose);
> +	odb_source_free(&files->loose->base);
>  	packfile_store_free(files->packed);
>  	odb_source_release(&files->base);
>  	free(files);
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index c9e7414814..92e18f5adb 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -1,10 +1,55 @@
>  #include "git-compat-util.h"
> +#include "abspath.h"
> +#include "chdir-notify.h"
> +#include "loose.h"
> +#include "odb.h"
> +#include "odb/source-files.h"
>  #include "odb/source-loose.h"
> +#include "oidtree.h"
> +
> +void odb_source_loose_clear_cache(struct odb_source_loose *loose)
> +{
> +	oidtree_clear(loose->cache);
> +	FREE_AND_NULL(loose->cache);
> +	memset(&loose->subdir_seen, 0,
> +	       sizeof(loose->subdir_seen));
> +}
> +
> +static void odb_source_loose_reparent(const char *name UNUSED,
> +				      const char *old_cwd,
> +				      const char *new_cwd,
> +				      void *cb_data)
> +{
> +	struct odb_source_loose *loose = cb_data;
> +	char *path = reparent_relative_path(old_cwd, new_cwd,
> +					    loose->base.path);
> +	free(loose->base.path);
> +	loose->base.path = path;
> +}
> +
> +static void odb_source_loose_free(struct odb_source *source)
> +{
> +	struct odb_source_loose *loose = odb_source_loose_downcast(source);
> +	odb_source_loose_clear_cache(loose);
> +	loose_object_map_clear(&loose->map);
> +	chdir_notify_unregister(NULL, odb_source_loose_reparent, loose);
> +	odb_source_release(&loose->base);
> +	free(loose);
> +}
>  
>  struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
>  {
>  	struct odb_source_loose *loose;
> +
>  	CALLOC_ARRAY(loose, 1);
> +	odb_source_init(&loose->base, files->base.odb, ODB_SOURCE_LOOSE,
> +			files->base.path, files->base.local);
>  	loose->files = files;
> +
> +	loose->base.free = odb_source_loose_free;
> +
> +	if (!is_absolute_path(loose->base.path))
> +		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
> +
>  	return loose;
>  }
> diff --git a/odb/source-loose.h b/odb/source-loose.h
> index bf61e767c8..441da9e418 100644
> --- a/odb/source-loose.h
> +++ b/odb/source-loose.h
> @@ -12,6 +12,7 @@ struct oidtree;
>   * file per object. This source is part of the files source.
>   */
>  struct odb_source_loose {
> +	struct odb_source base;
>  	struct odb_source_files *files;
>  
>  	/*
> @@ -32,4 +33,17 @@ struct odb_source_loose {
>  
>  struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
>  
> +/*
> + * Cast the given object database source to the loose backend. This will cause
> + * a BUG in case the source uses doesn't use this backend.

"uses doesn't use"???

> + */
> +static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_source *source)
> +{
> +	if (source->type != ODB_SOURCE_LOOSE)
> +		BUG("trying to downcast source of type '%d' to loose", source->type);
> +	return container_of(source, struct odb_source_loose, base);
> +}
> +
> +void odb_source_loose_clear_cache(struct odb_source_loose *loose);
> +
>  #endif
> diff --git a/odb/source.h b/odb/source.h
> index 0a440884e4..8bcb67787e 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -14,6 +14,9 @@ enum odb_source_type {
>  	/* The "files" backend that uses loose objects and packfiles. */
>  	ODB_SOURCE_FILES,
>  
> +	/* The "loose" backend that uses loose objects, only. */
> +	ODB_SOURCE_LOOSE,
> +
>  	/* The "in-memory" backend that stores objects in memory. */
>  	ODB_SOURCE_INMEMORY,
>  };
