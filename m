Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10B8C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 04:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLGEYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGEYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 23:24:40 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976C853EC4
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 20:24:39 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t17so11213054eju.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 20:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmwL0f5kmu+aiYgsnDQpzNtdUXcvzw22DjspMe3slt0=;
        b=gevawrbVd6z+LCTJFK5DGV/e8P4DFBROtBuvjP5qy23P75yZKZZQpJsEkGUuoBerXB
         hewitJ0q0B6tgIp9O7QAeZycLO7etdHNjubgWovIS755LJ6+NVQ1bpLNpDhKslYfnsiQ
         Mb+dXQ0B337E78wC+TsVG84I1netKYwXgfA5vUV1IO/mlZIB+fidPMQ++KjB2Q/8Sm3X
         Im/pNMMXr3VZSkj7CbBy4KAtl4yrPQ04YRx/NRw6D2jg4m517SG5r9ciu7sTcK4eXDmv
         per6Kj0mYw7hcOCiUTcY0pnb0ydtEqT3bv6+UR0sxSt03WaZjhBVDcRiPeKnWXUfjY99
         pYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmwL0f5kmu+aiYgsnDQpzNtdUXcvzw22DjspMe3slt0=;
        b=cpMlWMCk+jw3gdgxjWJv4TLhrQ4/ufVTLdkDSOlnpJZLwoUwLTiMC2p3gAgQBdxPUK
         aejFU40bkHXo7MwfcPHM+dZA/P0cYKM5L7N26bWlubbGtIiGc95acWzgmdCFvNsqJnE/
         WjNWcEZzzhJpdFUUuT/CwrxGpfopxEzdRSRLX/w8azMapfArxdAicWmP/TfR38l9RacF
         0qJ/QpNILzZbd4xxfNgFR4yWdeL31lS3W83qEZi6tCe6LNNvxANjxGTlXV2dJolNdpCX
         jyvSgzU/dmpfpwkRC24ngxQMRXq+vBuIVKgTMwZbjK20Qp7VJPpCOAxDoo/0Z9mSD4lV
         NdqA==
X-Gm-Message-State: ANoB5pkNAKlbaswBs1HBtlUTTAh262ngJVj9QrT6obeIhM0aQQY1q7TU
        L+xbwvuWpFbL1BFt4gg+Y7s=
X-Google-Smtp-Source: AA0mqf4BAsmQMne4OObcJ3cgwKAhLjWN3HZcOaC+p2T9VW4Ae3TS9BOFpVsTStNHEr+QITW1pr8+hA==
X-Received: by 2002:a17:906:a189:b0:7bb:8d9f:bd2f with SMTP id s9-20020a170906a18900b007bb8d9fbd2fmr47231748ejy.578.1670387078022;
        Tue, 06 Dec 2022 20:24:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id n19-20020a05640205d300b0046bf4935323sm1731400edx.30.2022.12.06.20.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:24:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2lz3-004K9P-0Z;
        Wed, 07 Dec 2022 05:24:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
Date:   Wed, 07 Dec 2022 05:05:47 +0100
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670373420.git.jonathantanmy@google.com>
 <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
Message-ID: <221207.86359rc03e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Jonathan Tan wrote:

> Instead of relying on errno being preserved across function calls, teach
> do_oid_object_info_extended() to itself report object corruption when
> it first detects it. There are 3 types of corruption being detected:
>  - when a replacement object is missing
>  - when a loose object is corrupt
>  - when a packed object is corrupt and the object cannot be read
>    in another way
>
> Note that in the RHS of this patch's diff, a check for ENOENT that was
> introduced in 3ba7a06552 (A loose object is not corrupt if it cannot
> be read due to EMFILE, 2010-10-28) is also removed. The purpose of this
> check is to avoid a false report of corruption if the errno contains
> something like EMFILE (or anything that is not ENOENT), in which case
> a more generic report is presented. Because, as of this patch, we no
> longer rely on such a heuristic to determine corruption, but surface
> the error message at the point when we read something that we did not
> expect, this check is no longer necessary.
>
> Besides being more resilient, this also prepares for a future patch in
> which an indirect caller of do_oid_object_info_extended() will need
> such functionality.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  object-file.c  | 63 ++++++++++++++++++++++++++------------------------
>  object-store.h |  3 +++
>  2 files changed, 36 insertions(+), 30 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 596dd049fd..c7a513d123 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1215,7 +1215,8 @@ static int quick_has_loose(struct repository *r,
>   * searching for a loose object named "oid".
>   */
>  static void *map_loose_object_1(struct repository *r, const char *path,
> -			     const struct object_id *oid, unsigned long *size)
> +				const struct object_id *oid, unsigned long *size,
> +				char **mapped_path)
>  {
>  	void *map;
>  	int fd;
> @@ -1224,6 +1225,9 @@ static void *map_loose_object_1(struct repository *r, const char *path,
>  		fd = git_open(path);
>  	else
>  		fd = open_loose_object(r, oid, &path);
> +	if (mapped_path)
> +		*mapped_path = xstrdup(path);
> +
>  	map = NULL;
>  	if (fd >= 0) {
>  		struct stat st;

I find this map_loose_object_1() function to be rather "busy". Part of
it's the pre-image.

Callers at the end of this series are:

   1254:        return map_loose_object_1(r, NULL, oid, size, NULL);
   1467:        map = map_loose_object_1(r, NULL, oid, &mapsize, &mapped_path);
   2803:        map = map_loose_object_1(the_repository, path, NULL, &mapsize, NULL);

So, either we know the path already, and we pass it in, or we don't know
the path, and may or may not be interested in what the path ends up
being.

Which is why we pass in both a "path" and a "mapped_path".

Then, somewhat confusingly (maybe I'm the only one who finds this odd")
the "path" variable itself does double-duty within the function. If we
have a "path" already we leave it alone, but if we don't it's NULL, and
then we write our new path to it.

We *might* then have a path already, *and* write to the "mapped_path",
but in that case we'd be xstrdup() ing a string the user passed in. But
this API use would make no sense.

So shouldn't we at least have a:

	if (path && mapped_path)
		BUG("either tell me the path, or ask me, not both!");

But I think it's better to just separate these concerns. Most of this
refactoring is good, but I think this bit went a step too far, and as a
result we now need to memory manage this "mapped_path". I.e. we'd get a
"struct strbuf"'s "buf" before, but now loose_object_info() needs to
have it xstrdup()'d, just to free() it again.

Isn't the below squashed in better? I.e. just always pass the "path",
but maybe pass a "fd=0", in which case the function might need to
git_open() it.

Then have map_loose_object() and loose_object_info() call
open_loose_object(), and pass in the "path" and "fd".

diff --git a/object-file.c b/object-file.c
index c7a513d123e..24793e1b479 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1214,19 +1214,13 @@ static int quick_has_loose(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "oid".
  */
-static void *map_loose_object_1(struct repository *r, const char *path,
-				const struct object_id *oid, unsigned long *size,
-				char **mapped_path)
+static void *map_loose_object_1(struct repository *r, const char *const path,
+				int fd, unsigned long *size)
 {
 	void *map;
-	int fd;
 
-	if (path)
+	if (!fd)
 		fd = git_open(path);
-	else
-		fd = open_loose_object(r, oid, &path);
-	if (mapped_path)
-		*mapped_path = xstrdup(path);
 
 	map = NULL;
 	if (fd >= 0) {
@@ -1251,7 +1245,10 @@ void *map_loose_object(struct repository *r,
 		       const struct object_id *oid,
 		       unsigned long *size)
 {
-	return map_loose_object_1(r, NULL, oid, size, NULL);
+	const char *path;
+	int fd = open_loose_object(r, oid, &path);
+
+	return map_loose_object_1(r, path,fd, size);
 }
 
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
@@ -1432,7 +1429,6 @@ static int loose_object_info(struct repository *r,
 {
 	int status = 0;
 	unsigned long mapsize;
-	char *mapped_path = NULL;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
@@ -1440,6 +1436,8 @@ static int loose_object_info(struct repository *r,
 	unsigned long size_scratch;
 	enum object_type type_scratch;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
+	int fd;
+	const char *path;
 
 	if (oi->delta_base_oid)
 		oidclr(oi->delta_base_oid);
@@ -1464,11 +1462,10 @@ static int loose_object_info(struct repository *r,
 		return 0;
 	}
 
-	map = map_loose_object_1(r, NULL, oid, &mapsize, &mapped_path);
-	if (!map) {
-		free(mapped_path);
+	fd = open_loose_object(r, oid, &path);
+	map = map_loose_object_1(r, path, fd, &mapsize);
+	if (!map)
 		return -1;
-	}
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
@@ -1506,11 +1503,10 @@ static int loose_object_info(struct repository *r,
 
 	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
 		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(oid), mapped_path);
+		    oid_to_hex(oid), path);
 
 	git_inflate_end(&stream);
 cleanup:
-	free(mapped_path);
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
@@ -2800,7 +2796,7 @@ int read_loose_object(const char *path,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	map = map_loose_object_1(the_repository, path, NULL, &mapsize, NULL);
+	map = map_loose_object_1(the_repository, path, 0, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
 		goto out;
