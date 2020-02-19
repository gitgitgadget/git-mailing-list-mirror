Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696EC34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 00:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8BD24654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 00:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTJ+tMMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgBSAqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:46:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35154 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBSAqB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 19:46:01 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so12053824iob.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=C8ocnXen0B4rBuBA/51EqAxbUOJ/n3TIivcOPEZLZBY=;
        b=YTJ+tMMlAMDYlmLpW2/DJ+fg4/IdXie6vkBqzl86CQrGWaZiLQU/YAHWTCaMXowfza
         3z4rlwgaa1Xb2v2V5cbKPaS/rsfPQn/hRw6GHDPPhO85zNpo/p7zg4uf3EJJQAN2BfrB
         iZlfq03Z6UJLJqdpR9sXaLIz17Y7xvUez2RS3+oMRA9YODl6ar0d63Ln+oHzz1iZh8JM
         8YOWPWFbKRh6G+4pv1C1jtKOCF0Pm1wDk5JNpZo3huPZY+6g+iI/RweScnoEVUMSpuRS
         96DvnRHQCoaEvyzxUoSPvC3p9sX8XnCYWLTLJEo2H3GfKcv10KMCEzS2ldPKB3E9cPr+
         VBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=C8ocnXen0B4rBuBA/51EqAxbUOJ/n3TIivcOPEZLZBY=;
        b=lOdU2AgqRwvBUOe0xy0/7LXhFc9sqM8faNQFoFBdk/VgDaLPlC6fh95RchdDxSkzt8
         2AwFEqocGnXbjOeVA2BgTzB3XoAeVKUvDUHazt9r6TTvshsyoMcne4NL5eNYBWiLmM3g
         5YyFGpOuiMImIcZs3hG60WHOrH4O2QcPTfN7ShQqRxU3+5ZRoTW03G1kePufVCV7TQvk
         kLhVF9Tc1UhyfSXkH368yZnMmt6FDIExxcETL4IxzeZtGzBcUW/gMz/PaiAZM/HsmjZx
         swG7PH2Q+FbJkyvBuC7PHCXXOKznZQlBECy/hxGa0yKXS6ZOzC0xqOTDZKcJ2aRP32ju
         X/wA==
X-Gm-Message-State: APjAAAXNGXg5rxjWxL4dLwkmBC/hJq8qlxkCBt5H4mF8xJ8JGibtWv5t
        0NuqSeXb+tFTItnjnUcVgVX3bbIn0MlCAzfSEY0=
X-Google-Smtp-Source: APXvYqxznsJBgCVZEtIiTP/IRCu3fr4a8EJiOKY6NvBn0hLctgwtTB5BfbMi6l4WKdn5QuueefRXp3gxCyxthPQ4w9A=
X-Received: by 2002:a02:cd3b:: with SMTP id h27mr18972251jaq.18.1582073160883;
 Tue, 18 Feb 2020 16:46:00 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
 <20200219000033.GA12115@google.com>
In-Reply-To: <20200219000033.GA12115@google.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Wed, 19 Feb 2020 01:45:22 +0100
Message-ID: <CANQwDwc-Ain79cfetz2YKY5FxrtbWaQgND4xzvg2LsAGOUqQOg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 60
To:     Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Eric Raymond <esr@thyrsus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Feb 2020 at 01:00, Josh Steadmon <steadmon@google.com> wrote:
> On 2020.02.17 16:50, Christian Couder wrote:
> > Hi everyone!
> >
> > A draft of a new Git Rev News edition is available here:
> >
> >   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edit=
ion-60.md
> >
> > Everyone is welcome to contribute in any section either by editing the
> > above page on GitHub and sending a pull request, or by commenting on
> > this GitHub issue:
> >
> >   https://github.com/git/git.github.io/issues/410
> >
> > You can also reply to this email.
> >
> > In general all kinds of contribution, for example proofreading,
> > suggestions for articles or links, help on the issues in GitHub, and
> > so on, are very much appreciated.
> >
> > I tried to cc everyone who appears in this edition, but maybe I missed
> > some people, sorry about that.
> >
> > Jakub, Markus, Kaartic and me plan to publish this edition on Wednesday
> > February 19th in the afternoon.
> >
> > Thanks,
> > Christian.
>
> A couple of typos and an IMO awkward phrasing, all in the "Git tools and
> sites" section:
>
> * In the "Github and Government" entry: s/Ggather/gather/
> * In the "Shell Git" entry: s/that a practical/than a practical/
> * In the "git-tfs" entry: s/no more actively/not actively/

Thanks, should be fixed now.

--=20
Jakub Nar=C4=99bski
