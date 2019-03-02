Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F9420248
	for <e@80x24.org>; Sat,  2 Mar 2019 01:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfCBBJ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 20:09:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37698 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCBBJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 20:09:26 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so21130759iop.4
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 17:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAtPQFV9Is+esSo3WZu19Z2w/eO7E6H5Er3zuR4B+ig=;
        b=K2PZjjXVxw95piHCK7xtJOhKgFz/8fBs+bquMOygtwy/ns/jde9qDeuZ4nicyOhH9J
         FN3ta2qcxY+OhqSvDz/7Utoo1rWyMT19feBwS12PEJwOF4m+6/s85GC85ywfHebIEdBi
         ujj5oWHaRMhqMdm0v4b3aal42EdauDsnYoBZjlS858Acmb9/9thnvooJBOpB4MK86b2s
         yC4vxJg8AQmI7AtfRruPQU6a52oSVyhivl6kKyhdl9GmGiaWFJzioT3wLK0fm0AsXzmZ
         /g63vYpbPcnxRLvQJcJ73bWjyaE4WMAXvVrEA+Zbr9SoQXrIXcCP50S/ZF/lS3YZv35j
         17Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAtPQFV9Is+esSo3WZu19Z2w/eO7E6H5Er3zuR4B+ig=;
        b=lFt1BNzV76CNoT+FwTijDsp5vwC65L8dz7XvQF3jDMuZ8gzfDDeSVwcRutj1Gt+5oF
         B9W5DvLm4fd8XXw29ln3r8EKiD1EBCb5r3LKA+9NDYwC3mzkDQvUIDbmSEN30VdQRRzz
         m4Js7+DxVsqXnXB3M5FvBDvDzFy/Hug3vmeBhMXdLGqsnYsMBPD08lqx1tSQZCNt6Rv/
         danunA78LZqQjlZiD+k06cbCaKOMH77gDhX4qBKYyc/PJL60Tz5sZvLt5Qcx2PMGK/9z
         ZZuMXgJDr0nyqCzXq1X0Qp8AOWiOBGIyqqy2BNHwqqNSxwqTuM82qwLSAlJuZwzwLeNN
         TVpw==
X-Gm-Message-State: APjAAAUWwbudR4PPbJ4HAunZxVkFSF8QcQSAL19XmmmlKY1qNTTa4F45
        W9PBJuFe4dF3VJSKqjPQiFq4L1XHVg9JN4GMlnQ=
X-Google-Smtp-Source: APXvYqzsq35Ybqt0ovVN+qd9zEnw41fLMtQobPkdHb/EoFcZq+uaSUpQgrm6f8uda5LryGLu9Lu89pySx5nTJHfW5EI=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr3678465ioo.236.1551488965961;
 Fri, 01 Mar 2019 17:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20190228230506.GA20625@sigill.intra.peff.net> <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net> <20190301221551.GD31362@zaya.teonanacatl.net>
 <20190301230821.GA16294@sigill.intra.peff.net>
In-Reply-To: <20190301230821.GA16294@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Mar 2019 08:08:59 +0700
Message-ID: <CACsJy8ATwLyVi5gxO_apbC5CbH3yasW676-1s3VVuQLDK30AbA@mail.gmail.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 2, 2019 at 6:08 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Mar 01, 2019 at 05:15:51PM -0500, Todd Zullinger wrote:
>
> > Hmm.  The comments in list_cmds_by_config() made me wonder
> > if not using a local repo config was intentional:
> >
> >         /*
> >          * There's no actual repository setup at this point (and even
> >          * if there is, we don't really care; only global config
> >          * matters). If we accidentally set up a repository, it's ok
> >          * too since the caller (git --list-cmds=) should exit shortly
> >          * anyway.
> >          */
>
> Well, let's see what Duy says. :)

I vaguely recall that I wanted to cache the results in
git-completion.bash at some point. But looking at that script I don't
think there's any caching. So yes it should be ok to read per-repo
config as well (and adjust or drop this comment block)

> I've never used completion.commands myself, but it seems reasonable that
> somebody might want different completion in different repos (e.g., if
> they never use "mergetool" in one repo, but do in another).

It sounds to me confusing that you want different command sets in
different repos. Which is why I made it global config only. But I
suspect that people who have per-repo aliases may find this natural.
So yeah, no objection.

PS. and thanks for the bug fix.
-- 
Duy
