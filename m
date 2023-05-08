Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8367C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjEHATy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjEHATw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 20:19:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399266595
        for <git@vger.kernel.org>; Sun,  7 May 2023 17:19:51 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-392375de3edso1385669b6e.2
        for <git@vger.kernel.org>; Sun, 07 May 2023 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683505190; x=1686097190;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsnubTMN8SkorLLwAttuhJWhmGE3riJUNtiVsCLoz/A=;
        b=MqgZ44KBU6kDQv5JQr4jMZunqoLww6fK3ZTT3PwoU043Wq4whQUTF02EAxcmCNOhEB
         KPyrCQ6KnQbV1PPwQzymADuBWlboKwqY/MCy6uMzEl6baBcFp8vrVSWUShcp6mVSwIcR
         zzGR60qJH/XWpiULvtkPx2b9juqonc3WgwfFwYpD/i8Tg28MvL+2Lwt87ECdfbAs2ooY
         1ti91eGfwyttXVJkmoLcS1uyGioLsBgeLmJdHXxF3jZmxbck7L3ghDXdRq0P1eAufTJA
         qiHz/zMH+iUzaDywgGAuViN9BXEmvkZlg3/qaoxnE9ISPXLaO4pKVGAzGwg3Ft5Vy5hy
         gV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683505190; x=1686097190;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EsnubTMN8SkorLLwAttuhJWhmGE3riJUNtiVsCLoz/A=;
        b=EtDw84c/VQEF2OgQwCaJbQn2uaPa4zgk/kRAvnu5n5sqJKFP6KL+l/k+4rH/+lJeEf
         daQ3kKBx0HHE1Yy86LyzNbFK1S3ioriAqogQMMlrb+tpStXcb9xdff0204u288rIpHL4
         182dWp5XT7MdGVewv6IhZhXWYZfOljSk9Vw+nGc5grzSGdqpvzwDmaoDXOyJ63qmbHEh
         JqmBP0683htXy2X2lNJztPkvaYlR3jOOGTbNwkmeppyP4FHqyUVIsJFcM8VWNEkjQDCs
         yXSAJOfyH5gtHVkjR4srM0NYUKEYjmEy8Tas/WoUhpiT9lVEoKEeWjInfIyqjg6UdXue
         Dwag==
X-Gm-Message-State: AC+VfDzOSYPi7y138bn2KUA5WozNW1foEv4ZWuzGachv3JWpRAlcRnxe
        uNsjOvP8YzDAiZEmcBVMR2M=
X-Google-Smtp-Source: ACHHUZ65qaskRRlJIFeQBZ8ROBgQ2pYPnOCLfN86Pej8TZgzllYKq08GxLEOgexqp1E5WPpH4qtQhQ==
X-Received: by 2002:a05:6808:92:b0:38e:2f8f:e53c with SMTP id s18-20020a056808009200b0038e2f8fe53cmr3600026oic.21.1683505190440;
        Sun, 07 May 2023 17:19:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id fe9-20020a0568082b0900b0038bb2f60064sm5089532oib.30.2023.05.07.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 17:19:49 -0700 (PDT)
Date:   Sun, 07 May 2023 18:19:48 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Message-ID: <64584024e6fa6_4e6129413@chronos.notmuch>
In-Reply-To: <xmqq7ctps438.fsf@gitster.g>
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
 <xmqq7ctps438.fsf@gitster.g>
Subject: Re: [PATCH] doc: manpage: remove maximum title length
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > DocBook Stylesheets limit the size of the manpage titles for some
> > reason.
> >
> > Even some of the longest git commands have no trouble fitting in 80
> > character terminals, so it's not clear why we would want to limit titles
> > to 20 characters, especially when modern terminals are much bigger.
> 
> I agree with the general thrust, but I do not think we are the ones
> who limit it to 20.

We are not explicitely telling docbook-xsl to limit the title to 20, no,
but we are limitting the tile to 20 by choosing to use docbook-xsl.

> It is a value that is "reasonable but somewhat arbitrary", decided by
> somebody, and may even vary across installed versions of DocBook XSL
> Stylesheets and their customizations, isn't it (in other words, for some
> readers of "git log", it may not even be 20,

No. Just because docbook-xsl says X doesn't mean X is true.

> if their distro tweaked the value to suit their needs)?
> 
> Perhaps rephrase it ...
> 
>     DocBook Stylesheets limit the size of the manpage titles to
>     avoid it (often shown twice, from both ends of the page)
>     overlapping with other elements on the same line, such as the
>     section name (for us, "Git Manual").  They say it is set to a
>     "reasonable but somewhat arbitrary" value by default, and
>     encourage "experiment with changing the value in order to
>     achieve the correct aesthetic results, where they document the
>     man.th.title.max.length parameter [*].

But this isn't accurate. They don't limit the size of the manpage title, they
only do so *by default*.

>     The longest title we need to show for the Git manual pages
>     currently is "git-credential-cache--daemon(1)" that is 30
>     characters long, but I've seen on my box with docbook-xsl
>     1.79.2+dfsg-2 installed that the "reasonable" default was set to
>     20, which would cause the title shown like so:

This again is not accurate, because I'm 100% certain this is not just in
my box, as it's also the case in git-manpages.git:

https://git.kernel.org/pub/scm/git/git-manpages.git/tree/man1/git-credential-cache--daemon.1

>        GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
> 
>     We could raise the limit to, say, 32 as a conservative choice
>     and can get this line show the full title:
> 
>        GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)
> 
>     but because even the longest one we currently have would fit on
>     an 80-column terminal, let's make it unlimited for now.

This is not why I think we should do it.

> ... or something along that line.

Except I don't agree with what was said on that line.

Let's keep in mind that docbook-xsl is not the only way to generate manpages,
so I don't think we should concern ourselves too much with what they do
or don't do, nor what they say or don't say.

> I did NOT verify the claim that even the longest will fit in
> 80-column limit, that credential-cache--daemon is the longest one,

Me neither, which is why I did not attempt to say that, but also: I
don't think it's particularly relevant which is the longest command
today, because tomorrow somebody might propose an even bigger one.

> or that the box the problem was observed was using which version of
> the stylesheet.

Again: doesn't matter.

> The above example illustrates the level of detail needed for a proper
> log message,

I don't think that level of detail is needed, or even desirable.

> FWIW, my primary motivation behind suggesting update of the above
> log message was to make sure that we document that we made a
> conscious decision to make it unlimited, instead of choosing another
> arbitrary limit (which we can do when we actually need to).

The conscious decision should be completely orthogonal to what
docbook-xsl developers considered a "reasonable default" some time ago
(probably decades ago).

The options for our conscious decision are:

 1. We don't limit the length of the title
 2. We limit the length of the title to some number

If we never made the conscious decision to limit the length of the title
to some arbitrary number, I think we should not do that (regardless of
docbook-xsl's default).

In other words: I don't think we should be burdened by the poor choices
of some other project regarding the default values of their weird
features.

Cheers.

-- 
Felipe Contreras
