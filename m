Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445261F404
	for <e@80x24.org>; Fri, 24 Aug 2018 14:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHXSXk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:23:40 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50692 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:23:40 -0400
Received: by mail-wm0-f51.google.com with SMTP id s12-v6so1849942wmc.0
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zGXXviHXJdPN+0SSetS4mTBg8cEZZ7ncwkQX1qwk75U=;
        b=W1718oYpqn1UdznGlcZyCJi/+S8oBCq2qWjA5qe9NH5g6Rih28dgOwvH4xnP1/VVPC
         nR2KlgxBM/37SsallEGC5iFH5T5+u5S28Zisl6t5k0m1G6ViOU/GK6Xgdc+WEV2QxeP2
         AA/6jqLnggkSHx0P8C0VawpsVBONc0fKYPrj7l6lDazBQ+SwcCiNPRZx9o0eI9rgrqJk
         bRWWK8BeLn/tCVZv65Xm3FtvH7egxw55JIFl+Hn39uD5JJ5TSg3jm2h7fyv8upDgyFDA
         gnO3OvxOlyKAJ2fFMQOm7e0uN6QK2z3ZjtWrYICigYBrfMrUAK22cK4SbaSdz8PLLol/
         wtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zGXXviHXJdPN+0SSetS4mTBg8cEZZ7ncwkQX1qwk75U=;
        b=r2Aif+eVs1gZ6GwxqH/Kv8NijGUYw99MuB4h7CSVu1c+VzKTlk2gIbfJ9PhgGm1GNt
         LsOsdB3R36m3KLFIamTWbnyorn/1GOj0Hn4rDB3kDKTSGZzVzsWfNM6LYJrUY2K9f0rJ
         BLs4NbjzJaQcOUtXR71maOTwSJIPGnSGgnaoF/jBcho/lHfikeY3aH+byiyujQJj/xGF
         mltGC8KfiDMDhfdjkTog99HISKfB0ii2MDIAX4DWvbIbqlNWxIU42llOmsuOFx9xCgye
         7Ds331pNOH1SwEhcyuXMxcBW3qu7JAWNn5wq73Rme1pF1K+1ONqJIJ0SIlZM88RzJu07
         dV6A==
X-Gm-Message-State: APzg51Bij4Z7YWmqwY+98F9aCT/boJLo+9ZejrCZY7BCrZ6HfC7rxWWi
        59VwnZizrvuv5y+P8qQ8M40=
X-Google-Smtp-Source: ANB0VdZY7mg6EaSIm4q46AeM+5eZ/8ZCtBRMghxWVMDWxHZ6hAoDELqApiUOXgGqUeeoggg71ZUWiA==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr1648433wmh.134.1535122119099;
        Fri, 24 Aug 2018 07:48:39 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id 88-v6sm6117229wrf.95.2018.08.24.07.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 07:48:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: clone, hardlinks, and file modes (and CAP_FOWNER)
References: <20180824121407.GA19597@inner.h.apk.li>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180824121407.GA19597@inner.h.apk.li>
Date:   Fri, 24 Aug 2018 16:48:37 +0200
Message-ID: <87tvnjes6y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 24 2018, Andreas Krey wrote:

> I'm currently looking into more aggressively sharing space between multiple repositories,
> and into getting them to share again after one did a repack (which costs us 15G space).
>
> One thing I stumbled on is the /proc/sys/fs/protected_hardlinks stuff which disallows
> hardlinking pack files belonging to someone else. This consequently inhibits sharing
> when first cloning from a common shared cache repo.
>
> Installing git with CAP_FOWNER is probably too dangerous;
> at least the capability should only be enabled during the directory copying.
>
> *
>
> And the next thing is that copied object/pack files are created with mode rw-rw-r--,
> unlike those that come out of the regular transports.
>
> Apparent patch:
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index fd2c3ef090..6ffb4db4da 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -448,7 +448,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>                                 die_errno(_("failed to create link '%s'"), dest->buf);
>                         option_no_hardlinks = 1;
>                 }
> -               if (copy_file_with_time(dest->buf, src->buf, 0666))
> +               if (copy_file_with_time(dest->buf, src->buf, 0444))
>                         die_errno(_("failed to copy file to '%s'"), dest->buf);
>         }
>         closedir(dir);
>
> Alas, copy_file takes the mode just as a crude hint to executability, so also:
>
> diff --git a/copy.c b/copy.c
> index 4de6a110f0..883060009c 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -32,7 +32,7 @@ int copy_file(const char *dst, const char *src, int mode)
>  {
>         int fdi, fdo, status;
>
> -       mode = (mode & 0111) ? 0777 : 0666;
> +       mode = (mode & 0111) ? 0777 : (mode & 0222) ? 0666 : 0444;
>         if ((fdi = open(src, O_RDONLY)) < 0)
>                 return fdi;
>         if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
>
> (copy_file is also used with 0644 instead of the usual 0666 in refs/files-backend.c)
>
> Will submit as patch if acceptable; I'm not sure what the mode casing will
> do with other users.

This is mostly unrelated to your suggestion, but you might be interested
in this thread I started a while ago of doing this with an approach
unrelated to hardlinks, although you'll need a FS that does block
de-duplication (and it won't work at all currently, needs some
patching):
https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/

I don't understand how this hardlink approach would work (doesn't mean
it won't, just that I don't get it).

Are you meaning to clone without --reference and instead via file:// and
rely on FS-local hardlinks, but then how will that work once one of the
repos does a full repack? Are you going to inhibit that in some way,
e.g. with gc.bigPackThreshold (but then why doesn't that work already?).

If you have such a tightly coupled approach isn't --reference closed to
what you want in that case?
