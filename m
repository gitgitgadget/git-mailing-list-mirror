Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6081C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKIVkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKIVkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 16:40:14 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3B2A41E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 13:40:13 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id l6so127641ilq.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 13:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QM2ROdxcpCaWxpXBdS4BgIuIhDVISStYTIygYgW70G4=;
        b=Wfs8ma1ldyrG0DIfQk5akq2acFWoKjqIba8pJqIo881dV5S8PITGXEU3YCzMVJhkPy
         Gkfk/T+ZLBHq98/IHNu76rs03AWtdX1uFDS3pYlSfO0m7FM+064S/W6foDHU3ZvR9s0k
         8xp+YK8G5UYcBNgm6yMG9GU1w2qr0WpP+FAJvMhIr0ZlOwBW2IfKwAKHzmovUQkrjcZF
         woR0eBBVxclVHVrJwUorVXIjKqh9dwrx4Kttbywcl8mjsSGla67dgOz9m+OHAtau0F77
         PwYF0VouveVWcZ3XIQnj/Yx5XlwO5oPFnHsWMeb3DokDnMxNRhGHP2sQHYqqQ7DwMNET
         FjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QM2ROdxcpCaWxpXBdS4BgIuIhDVISStYTIygYgW70G4=;
        b=DtqqWabVUXT+8f0QHYGPy9CIMJBUCyeHw5qbBV6LK/LCyn6/2/1c+OjggNhZYbD0LN
         Eim1z1wNWCx1tljsgQskuHuPneu0ahoLaqGOskhB0GLW02hbapfq5gzgNTJhyou1VoF2
         PYklDiKIVq1C2xWkxo0D9YgFMqFSFYyv90aH1tsUyKiv0BDSd1ZeVW/zB6RPlm70AMfm
         Kaemi4AgSK2kViAZv1x8foHPMNK9LGzGGnonJULK5Pwo06B7VESGpkbJrZCFF3T5kuu4
         npD/enmuENAhE6yHjzrmycYzLRM9tQvT26IMeUS88b1gR2pUA0e7KJbggaYLj9ksaQTV
         QstQ==
X-Gm-Message-State: ACrzQf3FRwtyBJeFE5TiWsntNcAqXr5cQplKje4MDolXzKddZc/RivWs
        xLsp0nhlc1WbRnu3l7JCF+xXeA==
X-Google-Smtp-Source: AMsMyM4LPRRn7S3s+6HNtYWvkoOALOW4Wb3tUA9O2kpSgqgRydUeF+MyJR6B8YOOTjWcMGf6pMOY3Q==
X-Received: by 2002:a92:d747:0:b0:2f8:f87a:d23d with SMTP id e7-20020a92d747000000b002f8f87ad23dmr2312976ilq.130.1668030012751;
        Wed, 09 Nov 2022 13:40:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o127-20020a022285000000b00363c2c5f229sm5186553jao.128.2022.11.09.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:40:12 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:40:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Max Coplan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Max Coplan <mchcopl@gmail.com>
Subject: Re: [PATCH] po: use `switch` over `checkout` in error message
Message-ID: <Y2weO5PczNYAJs/s@nand.local>
References: <pull.1308.git.git.1668018620148.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1308.git.git.1668018620148.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 06:30:17PM +0000, Max Coplan via GitGitGadget wrote:
> From: =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
>  =?UTF-8?q?an?= <mchcopl@gmail.com>
>
> Small change.  Since `switch` is suggested for changing branches over
> `checkout`, this commit updates an error message to use `switch` as the
> default

OK.

> Signed-off-by: Max 👨🏽‍💻 Coplan <mchcopl@gmail.com>

Hmm ;-). It is generally preferred that you use your real name in the
Signed-off-by trailer. I am guessing that your name does not have emoji
in it.

See Documentation/SubmittingPatches for more.

>  builtin/checkout.c | 2 +-

>  po/bg.po           | 4 ++--
>  po/ca.po           | 4 ++--
>  po/de.po           | 4 ++--
>  po/el.po           | 4 ++--
>  po/es.po           | 4 ++--
>  po/fr.po           | 4 ++--
>  po/id.po           | 4 ++--
>  po/it.po           | 4 ++--
>  po/pl.po           | 4 ++--
>  po/pt_PT.po        | 2 +-
>  po/ru.po           | 2 +-
>  po/sv.po           | 4 ++--
>  po/tr.po           | 4 ++--
>  po/vi.po           | 4 ++--
>  po/zh_CN.po        | 4 ++--
>  po/zh_TW.po        | 4 ++--

Changes to po/ are coordinated by Jiang Xin, and the changes happen at:

    https://github.com/git-l10n/git-po/

and are then pulled into this tree.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 29c74f898bf..51f9f928113 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1222,7 +1222,7 @@ static const char *parse_remote_branch(const char *arg,
>  		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
>  			     "you can do so by fully qualifying the name with the --track option:\n"
>  			     "\n"
> -			     "    git checkout --track origin/<name>\n"
> +			     "    git switch --track origin/<name>\n"
>  			     "\n"
>  			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
>  			     "one remote, e.g. the 'origin' remote, consider setting\n"

Now we get to the main part of the change. And here I am torn:

  - parse_remote_branch() is called from parse_branchname_arg()
  - parse_branchname_arg() has a single caller in checkout_main()

...which is called from 'cmd_switch()', 'cmd_restore()', and
'cmd_checkout()'.

So depending on which of those three we are being called from, the
advice will or won't match up with the caller.

I haven't looked further to see if there is some mitigating condition
that prevents us from ending up in parse_remote_branch() from callers
outside of 'cmd_switch()', but I'm guessing that probably isn't the
case.

So in that sense your patch isn't making anything worse, but I think
empirically it does seem worse, since 'checkout' has more staying-power
than 'switch' (at least at the time of writing).

We could set some static 'source' variable or some such to indicate
which caller is driving us, but that feels a little hacky.

I dunno.

Thanks,
Taylor
