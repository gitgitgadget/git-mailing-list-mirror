Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE91BC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 21:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiBSVqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 16:46:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiBSVqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 16:46:15 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D89D63
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 13:45:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p14so23190443ejf.11
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JJPd51Awv9jORzhMAdo8KNj8TsLna+74j1M1Vi3/HmQ=;
        b=nryDiMThxmAOb3jt/FYUULIbBePAlnbM60+o7G87lI5nIPW/+42yk6cd6Wbii/mX+L
         LW2Kc5YoBJH4G4V8gNrrkQJplMHveOxS/laQcu9iaRnVrCA8aeFrpONPtqsilBeW2VFT
         3J4L6x+s6CBjgUY30I6Go3dT/6VxdYRjX2L1qdF8Vh51XeIcUxqS11XVxDbZ6Shvqhv8
         aqpUB5wc/htcSUgUZYxwYxOY4J7cAPLentltANTwMB/5esQmRmUb5jtean0J8htG9VtI
         dVGxyg4x84ERbVkpPUXsvPLf+M+D7REUKosfwG8g44UG24MoU453Xmn8tzEY/esiIxBE
         1hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JJPd51Awv9jORzhMAdo8KNj8TsLna+74j1M1Vi3/HmQ=;
        b=1gUfEzKZTApUxBFTlFNwYvWpSGHAo4/js/AxJt5aQeUvKJDBajowa3pscUcnz4mhur
         OW+5uM+3BVNV+71EHk6FXvBbvEiScSrsaVM9CFNkki+lEpPfbozoBQBxB4z/4srxZben
         fACLo39PosSYCFNiA7Gcq3ugm7nn0H0NSmf3UkbHJKMqHQPGY/z2tl63upaUyTpZWmPI
         IV+Z4SikECotBCETuvF5gQQGhui6FwHvfmJN2skFgwARDaej2PoqT9bcuJszR/rG2Olg
         O53ouLdW+vZPq3GedXZv/dsj/GMiSsoBGviCTI2mgfxOfnBa0d3VeEpBp3qx2TbyhPs1
         Vnrw==
X-Gm-Message-State: AOAM530bBgzzvNOBO/Igq8BGUZppi7uvJWpiQmHSeNQYaf89+yRhjRCr
        N1vYkmM2QLOhsE2ZiT7BWauJw1J9QxiaDw==
X-Google-Smtp-Source: ABdhPJxB3O/1mFAAIVwQWyIJt19te7p5vhLJ6yACIsV/2CqK5k3T7BsbSyB3fmEjvFN85jPT3UPWZQ==
X-Received: by 2002:a17:906:bcf8:b0:6cf:6223:8995 with SMTP id op24-20020a170906bcf800b006cf62238995mr10933009ejb.467.1645307154059;
        Sat, 19 Feb 2022 13:45:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j21sm3541354ejj.193.2022.02.19.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:45:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLXY9-005FZP-56;
        Sat, 19 Feb 2022 22:45:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] merge-ort: fix small memory leak in
 detect_and_process_renames()
Date:   Sat, 19 Feb 2022 22:44:19 +0100
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <f0308de28e49fb9bb1239fdcbc839097f5afa62a.1645290601.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <f0308de28e49fb9bb1239fdcbc839097f5afa62a.1645290601.git.gitgitgadget@gmail.com>
Message-ID: <220219.86sfsecyy6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 19 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> detect_and_process_renames() detects renames on both sides of history
> and then combines these into a single diff_queue_struct.  The combined
> diff_queue_struct needs to be able to hold the renames found on either
> side, and since it knows the (maximum) size it needs, it pre-emptively
> grows the array to the appropriate size:
>
> 	ALLOC_GROW(combined.queue,
> 		   renames->pairs[1].nr + renames->pairs[2].nr,
> 		   combined.alloc);
>
> It then collects the items from each side:
>
> 	collect_renames(opt, &combined, MERGE_SIDE1, ...)
> 	collect_renames(opt, &combined, MERGE_SIDE2, ...)
>
> Note, though, that collect_renames() sometimes determines that some
> pairs are unnecessary and does not include them in the combined array.
> When it is done, detect_and_process_renames() frees this memory:
>
> 	if (combined.nr) {
>                 ...
> 		free(combined.queue);
>         }
>
> The problem is that sometimes even when there are pairs, none of them are
> necessary.  Instead of checking combined.nr, we should check
> combined.alloc.  Doing so fixes the following memory leak, as reported
> by valgrind:
>
> =3D=3DPID=3D=3D 192 bytes in 1 blocks are definitely lost in loss record =
107 of 134
> =3D=3DPID=3D=3D    at 0xADDRESS: malloc
> =3D=3DPID=3D=3D    by 0xADDRESS: realloc
> =3D=3DPID=3D=3D    by 0xADDRESS: xrealloc (wrapper.c:126)
> =3D=3DPID=3D=3D    by 0xADDRESS: detect_and_process_renames (merge-ort.c:=
3134)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_nonrecursive_internal (merge-o=
rt.c:4610)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_internal (merge-ort.c:4709)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_incore_recursive (merge-ort.c:4760)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_recursive (merge-ort-wrappers.=
c:57)
> =3D=3DPID=3D=3D    by 0xADDRESS: try_merge_strategy (merge.c:753)
> =3D=3DPID=3D=3D    by 0xADDRESS: cmd_merge (merge.c:1676)
> =3D=3DPID=3D=3D    by 0xADDRESS: run_builtin (git.c:461)
> =3D=3DPID=3D=3D    by 0xADDRESS: handle_builtin (git.c:713)
> =3D=3DPID=3D=3D    by 0xADDRESS: run_argv (git.c:780)
> =3D=3DPID=3D=3D    by 0xADDRESS: cmd_main (git.c:911)
> =3D=3DPID=3D=3D    by 0xADDRESS: main (common-main.c:52)
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index d85b1cd99e9..4f5abc558c5 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3175,7 +3175,7 @@ simple_cleanup:
>  		free(renames->pairs[s].queue);
>  		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
>  	}
> -	if (combined.nr) {
> +	if (combined.alloc) {
>  		int i;
>  		for (i =3D 0; i < combined.nr; i++)
>  			pool_diff_free_filepair(&opt->priv->pool,

This looks correct in that it'll work, but I still don't get why the
pre-image or post-image is going through this indirection of checking
"alloc" at all. Wouldn't this be correct & more straightforward (the
memset part is optional, just did it for good measure)?:

diff --git a/merge-ort.c b/merge-ort.c
index 40ae4dc4e92..a01f28586a1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3092,12 +3092,12 @@ static int detect_and_process_renames(struct merge_=
options *opt,
 				      struct tree *side1,
 				      struct tree *side2)
 {
-	struct diff_queue_struct combined;
+	struct diff_queue_struct combined =3D { 0 };
 	struct rename_info *renames =3D &opt->priv->renames;
 	int need_dir_renames, s, clean =3D 1;
 	unsigned detection_run =3D 0;
+	int i;
=20
-	memset(&combined, 0, sizeof(combined));
 	if (!possible_renames(renames))
 		goto cleanup;
=20
@@ -3181,13 +3181,10 @@ static int detect_and_process_renames(struct merge_=
options *opt,
 		free(renames->pairs[s].queue);
 		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
 	}
-	if (combined.alloc) {
-		int i;
-		for (i =3D 0; i < combined.nr; i++)
-			pool_diff_free_filepair(&opt->priv->pool,
-						combined.queue[i]);
-		free(combined.queue);
-	}
+
+	for (i =3D 0; i < combined.nr; i++)
+		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
+	free(combined.queue);
=20
 	return clean;
 }
