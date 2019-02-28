Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4194620248
	for <e@80x24.org>; Thu, 28 Feb 2019 02:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfB1CrD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 21:47:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39983 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1CrD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 21:47:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so15741056ljd.7
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 18:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9yynQGJxVNfnjR4ZkUzi3eEXMqYBvDJx32ElmMujuo=;
        b=qvXUPrEzU2HFLxER5r5C7ktMmbhbLDN/FDUktUL0+2Evvi3yQJol2hBKUbVmVbDn6C
         9Vprw2VbEXBoXLadohL5oxpqzQNCOvHIikqsy+c65IszF2x2ZnjUbhTaEs5Qjxnzm77k
         IFs/EM47WMdF9PnzVoKvwKic2RDeSIl2tJqAWoI5sNSDaNy0dFrjDpEbUXdQwn+U7mrW
         wIkKDONp/AaNO9HV2Drjlini9VCb1wPPRv0IH1w+QQcvnfWSR9YC6RyhfYSKCQOUiCWi
         4/tbhfsmiebKmOMOMOa0od/niv5dfRmVXN7H8UJLjt+okv+pCC8kJX8BCKsIEFPvaB7R
         4XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9yynQGJxVNfnjR4ZkUzi3eEXMqYBvDJx32ElmMujuo=;
        b=mS7HBru96EPxCifGK+CD0o8XrfZTIbuhlMOKQ4s+WSFWfno5TbIPVnu2hmHz9tJqIz
         UdaoZ6r06Ggdkg1WOETL4fYcx90BwthEsGAbeRrjDDlA7g9LAR7a3rf2UAEc9DX1KpUI
         oX2Xu8vtC5xytMYMbzVut1kj0PrpsATvX5cakyRhP7C/Yh31ex3ZNaisyl6lILumg+cV
         XnjUyC4M05VO8uqNoWR3wkBlOagfe7q57XFa1vvCRAgHItZxbjDvRXk7EF8rs+apxiFD
         WIxa7a4ivpJrY/NZG6kgx2dJVbJQ4+j3LP1i0+U59nvKF8Lp9XbKmyw303PXQWdoM5Yr
         FjlA==
X-Gm-Message-State: APjAAAV9SNFD8vEJPj6sWq0nPaw/jSR9dtbpBQKyumvA425GPxlEEm1s
        BoFagq5v577s7lNjsRgxb6nqYbHxcc4vq6P5M2w=
X-Google-Smtp-Source: AHgI3IY1bcQ9Vcw/utg7H1mSTvEpq3ArjDuilFITgXczvra5tQzHQLEGCSsqaidv+7u7llZ5m3rlbAyhMVsrO831HKw=
X-Received: by 2002:a2e:6d02:: with SMTP id i2mr2910417ljc.6.1551322020604;
 Wed, 27 Feb 2019 18:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com> <20190227163522.GA25188@sigill.intra.peff.net>
In-Reply-To: <20190227163522.GA25188@sigill.intra.peff.net>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Wed, 27 Feb 2019 22:46:49 -0400
Message-ID: <CAETBDP42djjmSXeLig6mcRJVR0YMPnDUfCJT4z8SU==Ei62N4w@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

> One of the reasons I did not bother with that condition when I added the
> OPT_NEG() and OPT_ARG() variants is that you can only get an unexpected
> NULL argument if you explicitly give the NOARG or OPTARG flags. So it's
> very easy to _forget_ to give such a flag, because you simply aren't
> thinking about that case, and your callback is buggy by default.
>
> But it's rare to actually think to give one of those flags, but then
> forget to handle it in your callback.
>
> So I'm not entirely opposed, but it does feel weird to add such a macro
> without then using it in the 99% of callbacks which expect arg to be
> non-NULL.

I'd like to agree with you here, especially given that commit-tree is a rather
small part of project source. Experimenting with it a bit, I found using
BUG_ON_OPT_NOARG() to be a big clunky. Like you said, we could
end up with some less-than-ideal usage. If I were to use this in commit-tree,
it would look something like this, which isn't very appealing:

static int callback(const struct option *opt, const char *arg, int unset)
{
     ...
     BUG_ON_OPT_NEG(unset);
     BUG_ON_OPT_NO_ARG(arg);
     ...

However, I do still see a use case for a new macro for options that cannot
be unset and arguments that must not be NULL.

> If we are going to go this route, I think you might actually want macros
> that take both "unset" and "args" and make sure that we're not in a
> situation the callback doesn't expect (e.g., "!unset && !arg"). That
> lets us continue to declare those at the top of the callback.

In doing a quick search, I found a fair number instances of this:
...
BUG_ON_OPT_NEG(unset);

if (!arg)
     return -1;
...

So a macro like this could be useful. I've also found a few instances of this:

BUG_ON_OPT_NEG(unset);
BUG_ON_OPT_ARG(arg);

Perhaps two new macros BUG_ON_OPT_NEG_NO_ARG() ("!unset || !arg")
and BUG_ON_OPT_NEG_ARG() ("!unset || arg")? I'm not a big fan of those
names though.

Brandon
