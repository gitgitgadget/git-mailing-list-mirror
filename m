Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864DCC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377396AbiDDGRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 02:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiDDGRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 02:17:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214536338
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 23:15:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a6so6724193ejk.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 23:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=O1A0MjIsrS42VnpaosmXQYv8VqJV6KVfV8Un1/1Hs8Y=;
        b=Vebb0Q+RDFZGQpPgr7xzSBkI2Qw9AVEkY1yOZKv374DUer+CVVCu0l1YXhCKmU9leb
         rQT5Im36xQfilt6aXg0zEAQVgIO+hXG0npGn3e/GNhHFpGEoTXSO6XjVs0HQlAGBPKJn
         ckEjumN9zw2pgVSPgvmI/vJ2tuHJIK8RXMEqILpjOZ4YcJJuYw2tmDYEFgDNA71qY5as
         2WAlOSl/lgKx1MTxRGLhVOPnj7psUeP2dH22Z0xlaMcl9zco+c9b92CZVtzijnm5GZGG
         U8jULVABE3Gwfrhl9uQJk3yObaXBdc6HWdvxQ6+FRueErmoMGAvB9Se2nKjtiIomp/fW
         G8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=O1A0MjIsrS42VnpaosmXQYv8VqJV6KVfV8Un1/1Hs8Y=;
        b=EEewjZ4WwMo1Esd1oIVixP6I8mJP57smX5LKYyqztY1S/79IYvIw3RsSEq5eDGR4Ai
         uh8mPWIVVzYitiI/IqFZh6U2xPKSPCWkH4SI3SDoMa/DK4iK+eg9zSClqmb1lsCeHNTn
         HQtrXwN3ojzE3ggm5J8Ncb6tSSj9q4OFhLf4s2xf6jf42gvH/9DzfdW5m92+Swz9ZJXq
         x53TptQUky21ec1jwsBhrkdbdiQ36RPcq2rNZvW48Ydld/ek2wrPEcp5TTTq3oTprPAd
         R5vOF/gqrnr+m8wNKB5rPG8Gp8+H3bVm/fcu2CGLr1tfgFrykZ0Y9boi0Un/B65bM/5F
         rIRQ==
X-Gm-Message-State: AOAM530h4vk5C0D1p+XExbfgxh6yuQEOLf7TIjdOSyEbxX/TohJIAUSM
        nOwvRRIhPr8a3qZiU6GQ56NOaye1i+A=
X-Google-Smtp-Source: ABdhPJyfcuUGByMkyZnRe46xGl6YBO287KFXYVEpG9cLBmyGpmoKEgJ2JPAJUIhfdzUmi23t66v9nA==
X-Received: by 2002:a17:907:2ce6:b0:6df:a489:d2e1 with SMTP id hz6-20020a1709072ce600b006dfa489d2e1mr9594237ejc.264.1649052924699;
        Sun, 03 Apr 2022 23:15:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7dc42000000b00418ef55eabcsm4774146edu.83.2022.04.03.23.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:15:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbFzn-002JRL-CF;
        Mon, 04 Apr 2022 08:15:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] blame: report correct number of lines in progress when
 using ranges
Date:   Mon, 04 Apr 2022 08:12:06 +0200
References: <20220403165038.52803-1-eantoranz@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220403165038.52803-1-eantoranz@gmail.com>
Message-ID: <220404.8635itl6h0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Edmundo Carmona Antoranz wrote:

> When using ranges, use their sizes as the limit for progress
> instead of the size of the full file.
>
> Before:
> $ git blame --progress builtin/blame.c > /dev/null
> Blaming lines: 100% (1210/1210), done.
> $ git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
> Blaming lines:  10% (122/1210), done.
> $
>
> After:
> $ ./git blame --progress builtin/blame.c > /dev/null
> Blaming lines: 100% (1210/1210), done.
> $ ./git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
> Blaming lines: 100% (122/122), done.
> $
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
>  builtin/blame.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 8d15b68afc..e33372c56b 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	unsigned int range_i;
>  	long anchor;
>  	const int hexsz = the_hash_algo->hexsz;
> +	long num_lines = 0;

Here ranges's nr is unsigned int, and the "num_lines" is an int, and the
argument to start_delayed_progress() is uint64_t, but both of "start"
and "end" are "long".

But we appand multiple differences to num_lines, are we sure we won't
overflow here?

>  
>  	setup_default_color_by_age();
>  	git_config(git_blame_config, &output_option);
> @@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	for (range_i = ranges.nr; range_i > 0; --range_i) {
>  		const struct range *r = &ranges.ranges[range_i - 1];
>  		ent = blame_entry_prepend(ent, r->start, r->end, o);
> +		num_lines += (r->end - r->start);
>  	}
> +	if (!num_lines)
> +		num_lines = sb.num_lines;
>  
>  	o->suspects = ent;
>  	prio_queue_put(&sb.commits, o->commit);
> @@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	sb.found_guilty_entry = &found_guilty_entry;
>  	sb.found_guilty_entry_data = &pi;
>  	if (show_progress)
> -		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
> +		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
>  
>  	assign_blame(&sb, opt);

