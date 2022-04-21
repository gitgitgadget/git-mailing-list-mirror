Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF67C4332F
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 15:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390334AbiDUPwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390359AbiDUPwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:52:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA547541
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:49:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g23so54765edy.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8hbrxJHL3lB+6jTv0rOAOgSNdaSon+NyfkFqXn0Qx6I=;
        b=e8TIhfrhkiFfeIym2E+q2GeTA+wrnUN2fBmEvCFBmK4lgDGgBmBG0PLYy9u9Mot4d/
         qv03goWbsjKHc6x6XpMrw1KsXf+QiHcezrfbgJmP+7AY9osWP2j79Q2RtFfGOm0/rtoa
         UT63u5D8EW+a7wDuujIzlFTVEe5Y5zVUnADu8nYdm1UbK8Uf/350YUURQIbNrKhbL97p
         8eE3B62InMN6V06X9cyD0OTmvsZnLcGFkM+sc9FC0QE3dychHNPnSzXcRAN+SuWqW5Yg
         XvGtuFUEFxyrtPw27J9ddngTh1njV6qRjUuPFs3ePM4tQ8G4qHTCII4dbxd3kTDVoiZo
         CVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8hbrxJHL3lB+6jTv0rOAOgSNdaSon+NyfkFqXn0Qx6I=;
        b=0g+LoDI1v5S/MuZXNqh7SQ5LwPlF802C/BOqFev6Bt0436Oj1G9Rc4LKTNInoO9k7K
         PbQoe/JTwiNq618fFQKq1IQy9fBD45OJWJntz2scUD8Yarv1KgWjBQhwAsXh0O3Xqcsx
         onFsf0IayYxWoK3Vu8YaUIO3gS4nW05vSyl3iJUhOUjhWgfy/th+6qxlae3JAMkeoe0B
         l/zNiWlTTnECLxFQraYw8/cSUoLZSn2MCPqy4WWzSrFw26zvX3akDl07Y20Kc5w6t+Co
         SL9ncvt9mTikZ9Hh+ZBsynyruoA8lnPGP2f8I1M84PIzeD3SBKblaXoul8iNAY+Xvv2X
         alJg==
X-Gm-Message-State: AOAM531vmnKO78AVdXZ7kxb/p5S4E2hmOhGGtpR7gi/UfulERROdfSO1
        GTpwtDQcHhEKFmtGRSjuJ8o=
X-Google-Smtp-Source: ABdhPJyAk0/XlopyfdRmfX/NvSWYKQvrkdW2E4+XTQfh59wmiMnmYUZv49LrEl2tTXEqbpKTkpmoyA==
X-Received: by 2002:a05:6402:270b:b0:424:7dd:9d7b with SMTP id y11-20020a056402270b00b0042407dd9d7bmr229152edd.92.1650556185553;
        Thu, 21 Apr 2022 08:49:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ko11-20020a170907986b00b006e8811cc53esm7922837ejc.137.2022.04.21.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:49:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhZ3w-00823v-7i;
        Thu, 21 Apr 2022 17:49:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: Re: [PATCH v2 5/5] pack-bitmap.c: using error() instead of silently
 returning -1
Date:   Thu, 21 Apr 2022 17:41:36 +0200
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <1a169d7b5ea4b6aec030a48f718dc2c4e922a9f4.1650547400.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1a169d7b5ea4b6aec030a48f718dc2c4e922a9f4.1650547400.git.dyroneteng@gmail.com>
Message-ID: <220421.86o80u77xj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Teng Long wrote:

> In "open_pack_bitmap_1()" and "open_midx_bitmap_1()", it's better to
> return error() instead of "-1" when some unexpected error occurs like
> "stat bitmap file failed", "bitmap header is invalid" or "checksum
> mismatch", etc.
>
> There are places where we do not replace, such as when the bitmap
> does not exist (no bitmap in repository is allowed) or when another
> bitmap has already been opened (in which case it should be a warning
> rather than an error).
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index a1d06c4252..e0dcd06db3 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -328,7 +328,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  		trace2_data_string("midx", the_repository, "stat bitmap file",
>  				   "failed");
>  		close(fd);
> -		return -1;
> +		return error("cannot stat bitmap file");
>  	}

First, I wondered if we were missing _(), but looking at other string in
the file they're not using that already, looks like these all should,
but we can fix this all up some other time in some i18n commit. It's
fine to keep this for now.

But more importantly: I think this should be your 4/5. I.e. just make
these an error() and you won't need to add e.g. this
trace2_data_string() for a failed stat.

You will be inside your trace2 region, so any failure to stat etc. will
be obvious from the structure of the data and the "error" event, no
reason to have an additional trace2_data_string().

Aside from that & as a general matter: Unless you have some use-case for
trace2 data in this detail I'd think that it would be better just to
skip logging it (except if we get it for free, such as with error()).

I.e. is this particular callsite really different from other places we
fail to stat() or open() something?

It's all a moot point with the region + error, but just something to
keep in mind.
