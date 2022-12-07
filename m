Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F7C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 11:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLGLKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLGLJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 06:09:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38CCF
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 03:09:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vp12so13116047ejc.8
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ra14sEREuDpskelprKp83h9rY/ox6GZIQzQng/6e0To=;
        b=WlFPA2NXGhmSwATDdhxIEiTirSI9kSVfB23qLt4NYTZ4TKCxXL871uEZpQKDnwKEnl
         6WHMLgugBEPKLVQN8kzu0qJAwXNNXhf5IOAETLP6kMMN4iZBPPiPy1KtgmThJdO3er1W
         +t3xMwvboTuYdHrggvRUtk9jr+Wrdg2fPfs5hXA3NU3b0SAdMoUQuDT+Yt8wog/Y/S8N
         mLuFMZq7mDQigHfsCO1JHVfTn6B76LM4s1fYPZaMyt/r7jx0WLr1MGSvrmJC+YXnse2E
         tdzALCC3OWXmylvs+RhY4xJfUAiLQgg5CDBNn+zYk2yapSsBejOgdVBuX6uv8q6dY8N6
         RvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ra14sEREuDpskelprKp83h9rY/ox6GZIQzQng/6e0To=;
        b=uqLWYJsfRyO9HZiRgrAe8RsevKFs6onf3hU7vg4WnnGg8EEkfdgxgGVyhvoFVXFkXC
         5t198ELJXRd2UPEdT2oK2QZnrVQdJZwd6zEDwU4uOxv0JmCHQgtQrmhhK2FA+A+bXc0a
         G2/3STa9jq/btQXOItsaI5/rJkALaHKigzGjUJ+Iwak8wv/LzSQ5UonV+WQpqJ57sc5F
         3HSdR0ayoFsGzlq2zEdLIARvOtKHqoi9DTNdXqXmiu+bJq2hd1dNouZAL/DmeHzxyL5T
         Ty1F3/Fih90CPBpWDaCnqSVRcLUUVJcG43MJjzRVFpCdl3zAgYW3cj0tBm5Rb3uhw9C6
         xrZA==
X-Gm-Message-State: ANoB5pkKwkn0Lolkj8E3UhpVEvVuJUTad+q5WdHDtborFWWBISVUqudh
        0GZuq8Pyj097tc03149zzj0rPJ1GHdReFQ==
X-Google-Smtp-Source: AA0mqf6kXluBPjux6doXiDjk+Tw0GLSnaHgLOjPVF2etacepsyBp1TMluYK9inzWnvBMWg8V3fCSFQ==
X-Received: by 2002:a17:906:240f:b0:7c0:9f04:1938 with SMTP id z15-20020a170906240f00b007c09f041938mr26706421eja.769.1670411368732;
        Wed, 07 Dec 2022 03:09:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090613c600b007c0deb2449fsm4613478ejc.82.2022.12.07.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:09:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2sIp-004NZ0-2b;
        Wed, 07 Dec 2022 12:09:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
Date:   Wed, 07 Dec 2022 11:33:47 +0100
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670373420.git.jonathantanmy@google.com>
 <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
 <221207.86359rc03e.gmgdl@evledraar.gmail.com>
 <Y5A7qOaxyWxHJiex@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y5A7qOaxyWxHJiex@coredump.intra.peff.net>
Message-ID: <221207.86pmcva2s8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Jeff King wrote:

> On Wed, Dec 07, 2022 at 05:05:47AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Isn't the below squashed in better? I.e. just always pass the "path",
>> but maybe pass a "fd=3D0", in which case the function might need to
>> git_open() it.
>>=20
>> Then have map_loose_object() and loose_object_info() call
>> open_loose_object(), and pass in the "path" and "fd".
>
> I like this direction, though I'd give a few small suggestions. One is
> to make it unconditional to pass in a valid "fd". These kind of magic
> sentinel values sometimes lead to confusion or bugs, and it's easy
> enough for the caller to use git_open() itself.
>
> In fact, in the one caller who cares, it lets us produce a nicer
> error message:
>
> diff --git a/object-file.c b/object-file.c
> index 24793e1b47..7c2a85132b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1219,9 +1219,6 @@ static void *map_loose_object_1(struct repository *=
r, const char *const path,
>  {
>  	void *map;
>=20=20
> -	if (!fd)
> -		fd =3D git_open(path);
> -
>  	map =3D NULL;
>  	if (fd >=3D 0) {
>  		struct stat st;
> @@ -2790,13 +2787,18 @@ int read_loose_object(const char *path,
>  		      struct object_info *oi)
>  {
>  	int ret =3D -1;
> +	int fd;
>  	void *map =3D NULL;
>  	unsigned long mapsize;
>  	git_zstream stream;
>  	char hdr[MAX_HEADER_LEN];
>  	unsigned long *size =3D oi->sizep;
>=20=20
> -	map =3D map_loose_object_1(the_repository, path, 0, &mapsize);
> +	fd =3D git_open(path);
> +	if (fd < 0)
> +		error_errno(_("unable to open %s"), path);
> +
> +	map =3D map_loose_object_1(the_repository, path, fd, &mapsize);
>  	if (!map) {
>  		error_errno(_("unable to mmap %s"), path);
>  		goto out;

Yeah, I think that's even better, although...

>> +static void *map_loose_object_1(struct repository *r, const char *const=
 path,
>> +				int fd, unsigned long *size)
>>  {
>>  	void *map;
>> -	int fd;
>>=20=20
>> -	if (path)
>> +	if (!fd)
>>  		fd =3D git_open(path);
>> -	else
>> -		fd =3D open_loose_object(r, oid, &path);
>> -	if (mapped_path)
>> -		*mapped_path =3D xstrdup(path);
>
> The other weird thing here is ownership of "fd". Now some callers pass
> it in, but map_loose_object_1() always closes it. I think that's OK
> (since we want it closed even on success), but definitely surprising
> enough that we'd want to document that in a comment.
>
>> @@ -1251,7 +1245,10 @@ void *map_loose_object(struct repository *r,
>>  		       const struct object_id *oid,
>>  		       unsigned long *size)
>>  {
>> -	return map_loose_object_1(r, NULL, oid, size, NULL);
>> +	const char *path;
>> +	int fd =3D open_loose_object(r, oid, &path);
>> +
>> +	return map_loose_object_1(r, path,fd, size);
>>  }
>
> It's also kind of weird that map_loose_object_1() is a noop on a
> negative descriptor. That technically makes this correct, but I think it
> would be much less surprising to always take a valid descriptor, and
> this code should do:
>
>   if (fd)
> 	return -1;
>   return map_loose_object_1(r, path, fd, size);
>
> If we are going to make map_loose_object_1() less confusing (and I think
> that is worth doing), let's go all the way.

...maybe we should go further in the other direction. I.e. with my
earlier suggestion we're left with the mess that the "fd" ownership
isn't clear.

But what I was trying to do was fix up the ownership around the
"mapped_path", but we don't need to xstrdup() it in the first place. We
already have the caller of open_loose_object() not doing that, we can
just say that you're not going to open two loose objects at a time.

Then this becomes easier, and we can just pass the maybe-NULL "const
char **oid_path" all the way to open_loose_object():


diff --git a/object-file.c b/object-file.c
index c7a513d123e..6e900737b76 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1176,7 +1176,7 @@ static int stat_loose_object(struct repository *r, co=
nst struct object_id *oid,
  * descriptor. See the caveats on the "path" parameter above.
  */
 static int open_loose_object(struct repository *r,
-			     const struct object_id *oid, const char **path)
+			     const struct object_id *oid, const char **oid_path)
 {
 	int fd;
 	struct object_directory *odb;
@@ -1185,8 +1185,12 @@ static int open_loose_object(struct repository *r,
=20
 	prepare_alt_odb(r);
 	for (odb =3D r->objects->odb; odb; odb =3D odb->next) {
-		*path =3D odb_loose_path(odb, &buf, oid);
-		fd =3D git_open(*path);
+		const char *path;
+
+		path =3D odb_loose_path(odb, &buf, oid);
+		if (oid_path)
+			*oid_path =3D path;
+		fd =3D git_open(path);
 		if (fd >=3D 0)
 			return fd;
=20
@@ -1214,19 +1218,22 @@ static int quick_has_loose(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "oid".
  */
-static void *map_loose_object_1(struct repository *r, const char *path,
+static void *map_loose_object_1(struct repository *r, const char *const pa=
th,
 				const struct object_id *oid, unsigned long *size,
-				char **mapped_path)
+				const char **oid_path)
 {
 	void *map;
 	int fd;
=20
+	if (path && oid_path)
+		BUG("don't tell me about the path, and ask me what it is!");
+	else if (!(path || oid))
+		BUG("must get an OID or a path!");
+
 	if (path)
 		fd =3D git_open(path);
 	else
-		fd =3D open_loose_object(r, oid, &path);
-	if (mapped_path)
-		*mapped_path =3D xstrdup(path);
+		fd =3D open_loose_object(r, oid, oid_path);
=20
 	map =3D NULL;
 	if (fd >=3D 0) {
@@ -1236,7 +1243,8 @@ static void *map_loose_object_1(struct repository *r,=
 const char *path,
 			*size =3D xsize_t(st.st_size);
 			if (!*size) {
 				/* mmap() is forbidden on empty files */
-				error(_("object file %s is empty"), path);
+				error(_("object file %s is empty"),
+				      path ? path : *oid_path);
 				close(fd);
 				return NULL;
 			}
@@ -1432,7 +1440,7 @@ static int loose_object_info(struct repository *r,
 {
 	int status =3D 0;
 	unsigned long mapsize;
-	char *mapped_path =3D NULL;
+	const char *oid_path;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
@@ -1464,11 +1472,9 @@ static int loose_object_info(struct repository *r,
 		return 0;
 	}
=20
-	map =3D map_loose_object_1(r, NULL, oid, &mapsize, &mapped_path);
-	if (!map) {
-		free(mapped_path);
+	map =3D map_loose_object_1(r, NULL, oid, &mapsize, &oid_path);
+	if (!map)
 		return -1;
-	}
=20
 	if (!oi->sizep)
 		oi->sizep =3D &size_scratch;
@@ -1506,11 +1512,10 @@ static int loose_object_info(struct repository *r,
=20
 	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
 		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(oid), mapped_path);
+		    oid_to_hex(oid), oid_path);
=20
 	git_inflate_end(&stream);
 cleanup:
-	free(mapped_path);
 	munmap(map, mapsize);
 	if (oi->sizep =3D=3D &size_scratch)
 		oi->sizep =3D NULL;





