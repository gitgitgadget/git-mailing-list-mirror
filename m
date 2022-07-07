Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E5C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 12:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiGGM06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGGM05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 08:26:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32D1EAFC
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 05:26:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so22904624edb.9
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 05:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=00jQ6DWDYVY0Z8Ru3Yr/me331PtViX5SC4RyumypU8A=;
        b=IWQi415hn9wTfQBXNPwg7IXydIiv1omV58Jan6HSe5lBCeTi8SUE1zKYr+EhKOcli/
         ti0LYtulcTLck2gqdg7Q7ZmRuAHO+6+Qu72lekbqRA6c3i3+2nky17Chz7ckNbnfqQAT
         z5EMD1J4MQhPslmKPqGyQAHw9Ia5g3T0IiHXizr9u4wFGxARnFC+6txnbqB+1RCJQqK+
         nuZUX+GCPgUMLLQz8LevSP3w3hLEllqgm8QAK/ZzrxluSyc7abPwpafvuYtG17ET6Tva
         r4IZoBIkB5NU9jieXbgc496uId/Gl+WFQdJhjt0OE5G2cEWlsXR0h5Nn4kaK260Q9AWf
         eU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=00jQ6DWDYVY0Z8Ru3Yr/me331PtViX5SC4RyumypU8A=;
        b=XSuqV0itWblsTRxLZbfREKEIu79GdiuvPKYxXuVPuQ+BCzjs+pEAtoWR8cqzVDZHVg
         B9FDbNzxnj6nBiHcRzWPsAUGhMHZ7vYQ1YtxOWYExc4f/ZYfs72hw0mzJj0hJ1YU7JcA
         jNtrJtvECqwdS+hn0Ayyjfg2zW2bav0Ivvx5DT1T+eA9K9JZhi4raW63t3KhyBgb2+f2
         KZTJ2C4+yq0l0MVXR6EZIMJHcXvlTuO53+yCIfLnkCHZatKGZHcDvkfeMCGHG6p+56jE
         mGGbbXOsE/mLUD/dT1MrLnq1fiySanOYh08BqGrx46XT6r4mM8DuhJP7dtbAFA2qcjBU
         CONQ==
X-Gm-Message-State: AJIora8E0gvlfDoTbzB4hsO5ZH3/SW8Xr4UrU4A1R0ktWrZ+3FduZTop
        eGb7nU8VrkNVXI8G/5SeVyk=
X-Google-Smtp-Source: AGRyM1uHPO82O4oNqR2Zpky4A1Suw48ryUriy5WyQsMEVuoisSccpGOJ5jyqOvGfFk6py0DJLhIjpA==
X-Received: by 2002:a05:6402:4518:b0:43a:3b90:7457 with SMTP id ez24-20020a056402451800b0043a3b907457mr32320700edb.422.1657196815363;
        Thu, 07 Jul 2022 05:26:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b006fe8b456672sm12443968ejt.3.2022.07.07.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:26:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9Qas-004HEz-1R;
        Thu, 07 Jul 2022 14:26:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
Date:   Thu, 07 Jul 2022 14:11:22 +0200
References: <xmqq8rp54r4l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rp54r4l.fsf@gitster.g>
Message-ID: <220707.86y1x585wy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 06 2022, Junio C Hamano wrote:

> The variables 'source', 'destination', and 'submodule_gitfile' are
> all of type "const char **", and an element of such an array is of
> "type const char *".
>
> Noticed while running "make contrib/coccinelle/array.cocci.patch".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * There is this rule in the array.cocci file:
>
>         @@
>         type T;
>         T *dst;
>         T *src;
>         expression n;
>         @@
>         (
>         - memmove(dst, src, (n) * sizeof(*dst));
>         + MOVE_ARRAY(dst, src, n);
>         |
>         - memmove(dst, src, (n) * sizeof(*src));
>         + MOVE_ARRAY(dst, src, n);
>         |
>         - memmove(dst, src, (n) * sizeof(T));
>         + MOVE_ARRAY(dst, src, n);
>         )
>
>    but it triggered only for modes[] array among the four parallel
>    arrays that are being moved here.
>
>    There are a few tangents.
>
>    * Should we in general use sizeof(TYPE) in these cases, instead
>      of the size of the zeroth element, e.g.
>
>  		memmove(source + i, source + i + 1,
> 			n * sizeof(source[i]));
>     
>      It would have been caught by the above Coccinelle rule (we are
>      taking the size of *dst).
>
>    * Shouldn't we have an array of struct with four members, instead
>      of four parallel arrays, e.g.
>
> 		struct {
> 			const char *source;
> 			const char *destination;
> 			enum update_mode mode;
> 			const char *submodule_gitfile;
> 		} *mv_file;
>
>    The latter question is important to answer before we accept
>    Coccinelle-suggested rewrite to use four MOVE_ARRAY() on these
>    four parallel arrays on top of this fix.

This seems to be the same sort case as noted in 7bd97d6dff3 (git: use
COPY_ARRAY and MOVE_ARRAY in handle_alias(), 2019-09-19).

I tried (going aginst the warnings in that commit about the
non-generality) updating the rules to catch these cases, which yielded
the below. I wonder if we should apply some version of it. I.e. one-off
fix these, and perhaps have the cocci rule BUG() if we see this sort of
code again (the form technically could be used, but it seems all our
uses of it are ones we could convert to the simpler one...).

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..eff338d3901 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -915,10 +915,9 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 	file_diff->hunk_nr += splittable_into - 1;
 	ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr, file_diff->hunk_alloc);
 	if (hunk_index + splittable_into < file_diff->hunk_nr)
-		memmove(file_diff->hunk + hunk_index + splittable_into,
-			file_diff->hunk + hunk_index + 1,
-			(file_diff->hunk_nr - hunk_index - splittable_into)
-			* sizeof(*hunk));
+		MOVE_ARRAY(file_diff->hunk + hunk_index + splittable_into,
+			   file_diff->hunk + hunk_index + 1,
+			   file_diff->hunk_nr - hunk_index - splittable_into);
 	hunk = file_diff->hunk + hunk_index;
 	hunk->splittable_into = 1;
 	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
diff --git a/builtin/mv.c b/builtin/mv.c
index 83a465ba831..f6187d1264a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -282,14 +282,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 remove_entry:
 		if (--argc > 0) {
 			int n = argc - i;
-			memmove(source + i, source + i + 1,
-				n * sizeof(char *));
-			memmove(destination + i, destination + i + 1,
-				n * sizeof(char *));
-			memmove(modes + i, modes + i + 1,
-				n * sizeof(enum update_mode));
-			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
-				n * sizeof(char *));
+			MOVE_ARRAY(source + i, source + i + 1, n);
+			MOVE_ARRAY(destination + i, destination + i + 1, n);
+			MOVE_ARRAY(modes + i, modes + i + 1, n);
+			MOVE_ARRAY(submodule_gitfile + i,
+				   submodule_gitfile + i + 1, n);
 			i--;
 		}
 	}
diff --git a/commit.c b/commit.c
index 1fb1b2ea90c..c23d3e3678f 100644
--- a/commit.c
+++ b/commit.c
@@ -151,10 +151,9 @@ int register_commit_graft(struct repository *r, struct commit_graft *graft,
 		   r->parsed_objects->grafts_alloc);
 	r->parsed_objects->grafts_nr++;
 	if (pos < r->parsed_objects->grafts_nr)
-		memmove(r->parsed_objects->grafts + pos + 1,
-			r->parsed_objects->grafts + pos,
-			(r->parsed_objects->grafts_nr - pos - 1) *
-			sizeof(*r->parsed_objects->grafts));
+		MOVE_ARRAY(r->parsed_objects->grafts + pos + 1,
+			   r->parsed_objects->grafts + pos,
+			   r->parsed_objects->grafts_nr - pos - 1);
 	r->parsed_objects->grafts[pos] = graft;
 	unparse_commit(r, &graft->oid);
 	return 0;
diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index 9a4f00cb1bd..988ff9a3fda 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -73,6 +73,15 @@ expression n;
 + MOVE_ARRAY(dst, src, n);
 )
 
+@@
+expression D;
+expression S;
+expression N;
+expression Z;
+@@
+- memmove(D, S, (N) * Z);
++ MOVE_ARRAY(D, S, N);
+
 @@
 type T;
 T *ptr;
