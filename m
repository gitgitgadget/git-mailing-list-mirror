Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B535C677F1
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjALPMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjALPLu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:11:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2406254
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:01:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u9so45487187ejo.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i06YwuyxzUf4mQp+XjQ4QKY+WzDJcTW0+qcmttxNzrk=;
        b=MQ+efd/HXnGgv1XY9O8TAKQXbfut0F+xWiiDS8zt6q3VU4CRZbQ804Tqs532x2N3gK
         WK5ZZAc9bvBe7gcHIMM/0uN3VO6lfpd5A9AYVh21QKNBXmRFN75j3VhHbJ8gfTC7xs9b
         LZTgWY/jaEFqewnp36XrTb+4URDA2d/kGjdAAATA5UMh/LMWOlfeIiprzalvEq1ln+cS
         c0UiSSPCZ0xHiO6anTuNFEh/HepyNSAPPQw5sDHpRSJb8VMR3szG3fz2YCJoXJoFVyya
         XTBh6VoWL7fAlQOZ5pJq7gSo3CAVYx57RMuGIn/RurqngRdPnsrVee8rpyeW0amOfIZA
         jnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i06YwuyxzUf4mQp+XjQ4QKY+WzDJcTW0+qcmttxNzrk=;
        b=NnuKKD/dSV5wrWo+t3+4zi2mcWD7sCJARkW/sbUU6BeBxD/Hww8F8yJCXV+fd2xJ8x
         LxePs9iqVq4K0SoIyxOAo5Y9fS3tb2Tu6MUjHZSxqDHDqFaWlXABtI0ix5C/RDTto0rg
         2VECwow/18I2jysvNsKrOreZJULEVvZqay/gV3fBCGmFmKUm8wigWwu7+wb96PMOiK7g
         z0hOblYfmxqYBp3B596WWsAnyAwO+1nbofxqNhXbrKrZiSyweWWoMI2p4pI5AU+erdBP
         f3uysILy2fkuRPA732eHQM+SnwijEqTGfzGsUh7W9BybdVwM4t1v9nuc/+Rlz1auciY0
         Bbwg==
X-Gm-Message-State: AFqh2kp8xzFvQjM3DDX0iTWnTcbsiusEgHTem+Us1QOUp3lJdarPcxBb
        0C9FCMZNzqRirMoVFqnC4tJ2CNU/SEAv2g==
X-Google-Smtp-Source: AMrXdXu6mNNMcMfpmzcOi9Szjrl1OCSX8yuppgHMTWlSDsl548PGyCgJqAAJ55Eb2KoWdC6v+ovMcw==
X-Received: by 2002:a17:906:33d0:b0:854:6e3:2388 with SMTP id w16-20020a17090633d000b0085406e32388mr10184012eja.12.1673535660363;
        Thu, 12 Jan 2023 07:01:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b007c0e6d6bd10sm7563380ejc.132.2023.01.12.07.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:00:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFz4d-000HSD-1E;
        Thu, 12 Jan 2023 16:00:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 6/6] t3104: remove shift code in 'test_ls_tree_format'
Date:   Thu, 12 Jan 2023 15:56:22 +0100
References: <20230112091135.20050-1-tenglong.tl@alibaba-inc.com>
 <20230112091135.20050-7-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230112091135.20050-7-tenglong.tl@alibaba-inc.com>
Message-ID: <230112.86cz7j23x0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> In t3104-ls-tree-format.sh, There is a legacy 'shift 2' code
> and the relevant code block no longer depends on it anymore,
> so let's remove it for a small cleanup.

Like with 6/6, we can do without an update for this, but if you're
updating I'd say something like this instead:

	The "shift 2" added here when these tests were added in
	455923e0a15 (ls-tree: introduce "--format" option, 2022-03-23)
	has never been need. Let's remove it, as we're not in the habit
	of clearing arguments from "$@" unless we need to use "$@"
	itself (or "$*") later.

FWIW I think this dates back to my
https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/;
where there was no reason to do it either. I wouldn't normally "shift"
for no reason, so it probably dates back to some earlier version where I
used "$@", which didn't make it to the list.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  t/t3104-ls-tree-format.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
> index 383896667b6..74053978f49 100755
> --- a/t/t3104-ls-tree-format.sh
> +++ b/t/t3104-ls-tree-format.sh
> @@ -20,7 +20,6 @@ test_ls_tree_format () {
>  	format=$1 &&
>  	opts=$2 &&
>  	fmtopts=$3 &&
> -	shift 2 &&
>  
>  	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
>  		git ls-tree $opts -r HEAD >expect &&

