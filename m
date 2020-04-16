Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC70C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 06:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49099214D8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 06:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIElHrvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407559AbgDPGGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407687AbgDPGGI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 02:06:08 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306BFC061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 23:06:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j26so2189757ots.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mHacDEEbor3RUc3esn7hLQsjHrdgVJmH0mle5VaCgU=;
        b=qIElHrvxks4KUEqtdbO/qi6L9txWdtleGopX3eT1voNeg9HlxJdPsOJlHcFVNo6CYE
         AYi/nsuhP6s8kHQg6clTVYzZVgwUAfOlNqJRg3h0acbTAlRuiqguTpI2D4U1trNBqeVc
         Fkw/36vzSbdcBHzFUcumZGxYYjI0om4WwlUBWcH7pP1x3hbqcmKTFMIZ/kuoAu/3OUn3
         jWFIzno8bTRHAkuKqKKrAxnlwuxp0H8EILkR2LjGrnjW5MMCj7pXrqK5GgH/YHCjZbZQ
         SsOm10W+lgzzCrvA4v0BfyGabiuyboUQmV0UyoaZ7FVoq8GwfJQQv/OIHHQ2l8BWJMMN
         6nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mHacDEEbor3RUc3esn7hLQsjHrdgVJmH0mle5VaCgU=;
        b=uR4ST/EJJvHdefiYOtCZBWGuN1lzpierZXd7lmKycXCR1qNczVFKCZ5R2qh0Dy1DiT
         DgW+FXWAbGqkb4Xl07BObpYrdMAM8H0uBCZ6fKjkzVfPUXGZcqdDrkHnj2UbZn7BtOVu
         3FVmF0svgCahhqWc+PtG4eTRY3fFTacaIGtKykDDedz2QRy1GThmG8LXhQZ6HdeMwGvQ
         Id4qokNJa7Ml74u+OcX58iisbKo9NMOQewngsXc3zXIV89LEmLBbBt2gGshhySiuwQTO
         GUpCvubAu1xH5VVDAH38bEhK8qM08YCFrSDM/HE1q2OuixIlcHoj7hXSWW/axqkezWXJ
         ZlwA==
X-Gm-Message-State: AGi0Pub9wwfrcTkg3AXwsJCyadSPbeSAjTGlqtgC+9rKxa1ZtjCXvep6
        h/He+kkd3Q9VpBr0teNsZDGMG7BxKsoj+ghVpEk=
X-Google-Smtp-Source: APiQypJ6Rx1a57YdSoCfzJ/+wxTydTaaii4R3wVdF7Ald3DxYyClpc08KAlQgeM/o0tw2BQcCoehw0LNE5jyp51wSSc=
X-Received: by 2002:a9d:23e2:: with SMTP id t89mr4884871otb.316.1587017166562;
 Wed, 15 Apr 2020 23:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR02MB3715F9566BD9FEFAF832F0749CDB0@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <20200415151128.GA2464307@coredump.intra.peff.net> <20200415154944.GA22823@syl.local>
In-Reply-To: <20200415154944.GA22823@syl.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Apr 2020 23:05:53 -0700
Message-ID: <CABPp-BF7o1ba4=qqkqYjMm=YzuH5A=YU+C5zbd41g4pNY4yRKQ@mail.gmail.com>
Subject: Re: Move some files, with all history, from one project into a new one
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 8:49 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Apr 15, 2020 at 11:11:28AM -0400, Jeff King wrote:
> > On Wed, Apr 15, 2020 at 08:31:35AM +0000, Kerry, Richard wrote:
> >
> > > I would like to move some files, from the project in which they have
> > > always resided into  a new project.  I would like to keep all their
> > > history.  I don't want to waste space by also moving the rest of the
> > > old project's history, or historical file contents.
> >
> > Try git-filter-branch's --subdirectory repository, which is designed to
> > do exactly this.
> >
> > Or the much newer (and faster) git-filter-repo:
> >
> >   https://github.com/newren/git-filter-repo
>
> For what it's worth, Elijah has provided some excellent documentation on
> how to use git-filter-repo to do exactly this here:
>
>   https://github.com/newren/git-filter-repo#solving-this-with-filter-repo

That particular example might be for a different case than what
Richard requested, though.  Let's say the original repo had a file
structure like the following:

   module/
      foo.c
      bar.c
   otherDir/
      blah.config
      stuff.txt
   zebra.jpg

If the request is to e.g. take module/ and all files within it with
their history and make a new repository out of it, with module/ being
remapped to the root of the repository, then you would want:
   git filtrer-repo --subdirectory-filter module
and yes, this looks exactly like filter-branch; that's the one flag I
copied from it.  So this one usecase maps directly between the two
tools.

In contrast, if you wanted to keep all files from the original repo
but move everything into a subdirectory named "myProject" (so that
e.g. module/foo.c became myProject/module/foo.c), possibly in
preparation for merging your repo into some larger monorepo, then
you'd want to pass `--to-subdirectory-filter myProject` as in the link
you pointed out.  filter-branch doesn't have an equivalent.


Hope that helps,
Elijah
