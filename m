Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BC7C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 14:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiIZOzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiIZOys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 10:54:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBCD75381
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:23:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 30so8995120edw.5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=yGvLq/cRSxI2zdFEney9xC+b6R/+iWSQyGynM7emFng=;
        b=nJLLuhyCYs4Ds5hEIziKjqNxni7uF85ks/4+yjBtRlV9tULOLkT8MX3pmwktxz8kfP
         mvWS3A4GTP5JqFfLCZD81zegjUO6fCo8PcrzhegdtkfM6UmIHau3CMHr/SRTg3s6fmm5
         2Gmm2QbEWll3har4dtiWsuYsHmzDZM+UBkEEnF63C668Leb+KW/lU3wa2dQiUpSBklip
         UR8qJpAAL77/vkTh2H7Uun/8Zh8qCGsYQz+iv4sw1Uy4DX/4CxdxQxy7+Q6TU+/IGYj9
         /+hUGa92LcB50DP2v0Te6sNhbGDIQlyCPs36rxSelsJl9JH7JhQ4V77OqnIx6AWlYuXg
         IFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yGvLq/cRSxI2zdFEney9xC+b6R/+iWSQyGynM7emFng=;
        b=69mJwzS3dlYZ01+rrSVvOn/oN4RLk9YlYnSznA2XtJqEosOn2lvttyjvnbY56Oy8Fm
         eJ/aIyMvBLPAHZMmZUI0rHZ+Oz53cFQls1+oGsSrkRD4vL3XXg+cj7WOrpiuqmr6mrCs
         iDVWBNh8igc7J95LRO+KyTnuUTHtKs/GQzb8gyFBShh2RcB9jW9Ub0kzomphT5t3aWtV
         6hv0iI9TQhTGv1pmXUCzri4/yOu/gm1B/VjCBZnKMoRzT8AiJANSjl1rS+rZ3kPfg1sE
         TQHSVM4E7SkHcId2pWMw0tdJCB6sJlZy+Nc6CcoH3EbakZ3/qj6hG0pSE9Am5YysU2v4
         4rtg==
X-Gm-Message-State: ACrzQf3AjcQx4kcbOHc5US5bokMThYDSTE+HjYaNilJGDD6XqKnOyqLI
        HvGsFo+GGuIGrlqTWkhMmSH5qwB6F0o=
X-Google-Smtp-Source: AMsMyM5rda2mtq/gQ5kooUQNivfrpsEqAJhP5txorJIbVniuOXxP/JqN4EAp8y9fU7UHbN3Yy3GT9Q==
X-Received: by 2002:a05:6402:1e8c:b0:44f:f70:e75e with SMTP id f12-20020a0564021e8c00b0044f0f70e75emr22032405edf.405.1664198603461;
        Mon, 26 Sep 2022 06:23:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906185300b00781dbdb2917sm8031227eje.208.2022.09.26.06.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:23:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oco4w-0005fB-0T;
        Mon, 26 Sep 2022 15:23:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com
Subject: Re: [PATCH v2 1/2] cat-file: add mailmap support to -s option
Date:   Mon, 26 Sep 2022 15:16:57 +0200
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20220926105343.233296-1-siddharthasthana31@gmail.com>
 <20220926105343.233296-2-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220926105343.233296-2-siddharthasthana31@gmail.com>
Message-ID: <220926.86leq61d85.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 26 2022, Siddharth Asthana wrote:

> Even though the cat-file command with `-s` option does not complain when
> `--use-mailmap` option is given, the latter option is ignored. Compute
> the size of the object after replacing the idents and report it instead.
>
> In order to make `-s` option honour the mailmap mechanism we have to
> read the contents of the commit/tag object. Make use of the call to
> `oid_object_info_extended()` to get the contents of the object and store
> in `buf`. `buf` is later freed in the function.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  Documentation/git-cat-file.txt |  4 +++-
>  builtin/cat-file.c             | 13 +++++++++++++
>  t/t4203-mailmap.sh             | 10 ++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index ec30b5c574..594b6f2dfd 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -45,7 +45,9 @@ OPTIONS
>  
>  -s::
>  	Instead of the content, show the object size identified by
> -	`<object>`.
> +	`<object>`. If used with `--use-mailmap` option, will show the
> +	size of updated object after replacing idents using the mailmap
> +	mechanism.
>  
>  -e::
>  	Exit with zero status if `<object>` exists and is a valid
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 989eee0bb4..9942b93867 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  
>  	case 's':
>  		oi.sizep = &size;
> +
> +		if (use_mailmap) {
> +			oi.typep = &type;
> +			oi.contentp = (void**)&buf;
> +		}
> +
>  		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
>  			die("git cat-file: could not get object info");
> +
> +		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
> +			size_t s = size;
> +			buf = replace_idents_using_mailmap(buf, &s);

This is partially commentary on your already-landed series for cat-file
--mailmap support. I wondered why we needed this temporary variable, and
why we needed the cast_size_t_to_ulong() at all. On "master" we have a
size, but e.g. for cat_one_file()'s *current* codpaths we just pass it
to write_or_die().

So the net effect is that we refuse to use write_or_die() if the number
in size_t doesn't fit an unsigned long, even though we never need an
unsigned long in that case.

We have *other* things in the object code that need unsigned long, so it
probably amounts to no practical limitation, but it's confusing & I
think per [1] below we could do away with it.

There's also a subtle gotcha on "master", we
replace_idents_using_mailmap() with a possibly NULL "contents", which is
a misuse of the strbuf API (the "buf" member should never be NULL), but
we're about to die anyway...

> +			size = cast_size_t_to_ulong(s);
> +		}
> +
>  		printf("%"PRIuMAX"\n", (uintmax_t)size);

...but expanding on "master", here we have seemingly the first use of
cast_size_t_to_ulong() thaht's actually needed in this file. I.e. we are
about to use PRIuMAX.

But why not skip the cast(s) and make this more obvious by having the
printf() argument be cast_size_t_to_ulong(size)?

In your 2/2 you then have another use of cast_size_t_to_ulong() which
*is* needed in that case (we're about to stick it in a "unsigned long"
member, and the "size_t s" temporary variable is also needed in that
case.


1.

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 989eee0bb4c..676c34cba4b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -178,11 +178,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
-		if (use_mailmap) {
-			size_t s = size;
-			buf = replace_idents_using_mailmap(buf, &s);
-			size = cast_size_t_to_ulong(s);
-		}
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
 
 		/* otherwise just spit out the data */
 		break;
@@ -218,11 +215,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		buf = read_object_with_reference(the_repository, &oid,
 						 exp_type_id, &size, NULL);
 
-		if (use_mailmap) {
-			size_t s = size;
-			buf = replace_idents_using_mailmap(buf, &s);
-			size = cast_size_t_to_ulong(s);
-		}
+		if (use_mailmap)
+			buf = replace_idents_using_mailmap(buf, &size);
 		break;
 	}
 	default:
@@ -391,12 +385,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 
 		contents = read_object_file(oid, &type, &size);
 
-		if (use_mailmap) {
-			size_t s = size;
-			contents = replace_idents_using_mailmap(contents, &s);
-			size = cast_size_t_to_ulong(s);
-		}
-
+		if (use_mailmap)
+			contents = replace_idents_using_mailmap(contents, &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
