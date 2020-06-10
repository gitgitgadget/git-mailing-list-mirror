Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FEC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39EC206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMCfXDY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgFJNz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgFJNzX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 09:55:23 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7575C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 06:55:23 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g7so1723408oti.13
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bTSAuFy+zV0oTaq0y8zk+Q07m/dvzhDWXrPMVqkghsw=;
        b=RMCfXDY3LOv0vs/fyQNG+l/PP1OVZKkDQFqKrVjA7Fh5vsptbEAVUcK+CR3sDSJCDh
         w2nMpYgRUnK/6RLI91WRWimsvT1L0RDF3C1EIeYsjdIS5MvHGxCmAG3BNfkSje7R/jFH
         W4QUtdcHZ9qSiUQXR9ybqjd4T/wIlQBki9YolBpah3wmle4xJvb2E2U4V7SjtknNYTQK
         S7p70EPNdnQYCddcXJWHmsdZnpg6LVpAPA00ApZqqy0ZxxgC0sX3q27ZxQ5C+fzCsv1I
         4Oko2HAKMqyzdKeNqE3gSuB7JZpQzLpQxiiVjfMPpTGCxClFh6RT/XJzIQPiY7LEZRaG
         DKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bTSAuFy+zV0oTaq0y8zk+Q07m/dvzhDWXrPMVqkghsw=;
        b=Yqx4GpmtzU8cQmNl56pkGKji33QmzmHXBTpCGSYTsXl+V312wwh/o7Gt+DbFx0cqLa
         qu6DnWQ8k5Z50FIqO5MAN/KjMLLxOHZhUj1tLs2/kxFs3lbgTkBA4l3jbSjB+opEEDeq
         C9jBeTvjT+pI64mfF8qFQFfkYmDDrYwLRpiyhC/tKVfBK6vQK4pMQQ9Gkgt1PJJdP/+p
         hS6201jrRP9HTMNydYFgu0kGzmTkRo5gQYhs/T/dV90JrrQ/VpYrn1eMX8FmUOQogqHi
         dCT22IAotttWQhepRQTwGTOaPDVDgbFdzaKLdJsmwkeFSGpFoda4L+VmgBGmQMYC5UsN
         0eKA==
X-Gm-Message-State: AOAM531BQ089wDOx+Zf+6BfOIoVd46bm6kFWIjIp46iccKwhnQAMuSR2
        4Wbc48G+f/V8W9niJZvwNHVwRGTjj12Bz0wX90w=
X-Google-Smtp-Source: ABdhPJym8dOAgEJ6ScXMKdRB/5VKM4MbugzfKxftiWOqlY6zZNC9FARxO0Zt0LplwhWCGGyXRbUcqUSGOO6rt5rORCo=
X-Received: by 2002:a05:6830:17d0:: with SMTP id p16mr2701461ota.148.1591797323090;
 Wed, 10 Jun 2020 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net> <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
 <20200610000358.GR6569@camp.crustytoothpaste.net>
In-Reply-To: <20200610000358.GR6569@camp.crustytoothpaste.net>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 10 Jun 2020 09:55:12 -0400
Message-ID: <CACPiFCKEGXK+TJtQiPub3dW6dYKJ7a=mXL+UCDP57N-3XtRYLg@mail.gmail.com>
Subject: Re: osx autocrlf sanity?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 9, 2020 at 8:04 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-06-09 at 23:31:23, Martin Langhoff wrote:
> > good question! There is a .gitattributes file, all the files affected
> > have these attributes
> >
> > *.py     text diff=python
>
> By default, Git will check out files with the text attribute with the
> native line ending, and it will check them in with LF endings.  That can
> be controlled by core.eol and core.autocrlf

Why is core.autocrlf false not working for me?

I want to work on a repo that has a mix of newlines. I'd like git to
completely ignore them. Treat all files as a bag'o'bytes.

Assume I am running git rebase over commits that have .gitattributes,
so I can't "just remove it".

regards,



m
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
