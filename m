Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F089C3DA7A
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 08:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjABIiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 03:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjABIiB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 03:38:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DDBC19
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 00:38:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 83so28742996yba.11
        for <git@vger.kernel.org>; Mon, 02 Jan 2023 00:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WC9zvfzhmbjyN5oHblaphQIgWLy/OTxHLzd7EQtVw24=;
        b=h9nM9AQ6fDCj4QbR9NeW+Up5ETg7GSgWDLA3nmOrvHaBTotTcCBCgAb9DqXGKynuWv
         WVh+4E3Xn+rsEykhDwH09NnQz6d37Be6D/0JlrtMMS8bZif88G9j82WI8LXcdB7VDQj+
         2yvUlWT1uxwYqt8VFnl9pjvF8F5Y88qhSarmcbIgv4VMhMHmbZjiYyV2KMpUiX/KIqjD
         2K1KNo4b0oWYXyxUAoRfF0ynoV/oNawE0ueRtvFUih+l5fBn3TYtVp1+YzvT1MGqaZ6y
         huzev4jiIhv7fx3efICqEzCJ8MbwT56D+/i0C+TXwyNKqU3CCeowSfpb/ciLsP1ZduWf
         V1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WC9zvfzhmbjyN5oHblaphQIgWLy/OTxHLzd7EQtVw24=;
        b=gabMF8A6oz+WUxrT+6uWaNgmds0yOHrCf+x1u+PK1HdqczuL1VFVUfGmosjUBdC650
         e3WhTfdaPzhCgd8mFLXuRGM7shgpOc7ZW6hwLrz2NTt5mle/SaTnHuKe6naqX75LdRck
         Qq3Cf1VXu9zzeFzyD583PjfbwteyWS0sYZxBndig5lbfXtpsQHsm/Z/JVKazBWPABnn+
         ZcHxLH06R8DcYftH1oWL2gQ3rJCoe1UpX82hPfPEZv5f173S25Wm1pKqkWnCSwekYRoo
         NkMjnsyyGTCPTuCgF4d3bSfhF2SljUhlvHLZ63B/lknNS2cvFbL8QVB7qEllxBcIzAlS
         KjNA==
X-Gm-Message-State: AFqh2kr2+YqiXqdXQunBTTArVn6TiRdeKPlCu6/QEVsNF0pqLipu4i9I
        mQ0bITpHLUbJc7GZBFwEKFUmYfq0oSLf1uXSO+psSmNyZ+s=
X-Google-Smtp-Source: AMrXdXuWy4bPYT+XHUbV/Qco3fYr8lgnocPeWzVQNIaTDhadvIKBt50+KqP1sRz7RHyVFfpZ8uT2H5WPQWkLn3g76yg=
X-Received: by 2002:a25:6dc4:0:b0:75c:55f:b0d4 with SMTP id
 i187-20020a256dc4000000b0075c055fb0d4mr3907379ybc.13.1672648679685; Mon, 02
 Jan 2023 00:37:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
 <xmqqo7rpvb83.fsf@gitster.g> <CA+PPyiGPRztaLsty5LqT-7GfjPusyt=7hi22z1aPdm-G8pZpuQ@mail.gmail.com>
In-Reply-To: <CA+PPyiGPRztaLsty5LqT-7GfjPusyt=7hi22z1aPdm-G8pZpuQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2023 09:37:48 +0100
Message-ID: <CAP8UFD3i7C2c79V2ORxh-Q-rNuwKVqkMRX0VoXy3iugw=u5K+A@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 2, 2023 at 6:01 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:

> > Handing the !arg case first will make the if/else if/... cascade
> > easier to follow, no?  Also the body of the function may want to
> > become a separate function that returns one of these S_FOO constants.
> >
> >         static enum signatore_option signature_atom_parser(...)
> >         {
> >                 enum signature_option opt = parse_signature_option(arg);
> >                 if (opt < 0)
> >                         return strbuf_addf_ret(err, opt, _("unknown ..."), arg);
> >                 return opt;
> >         }
> >
> > where parse_signature_option() would look like
> >
> >         static enum signature_option parse_signature_option(const char *arg)
> >         {
> >                 if (!arg)
> >                         return S_BARE;
> >                 else if (!strcmp(arg, "signer"))
> >                         return S_SIGNER;
> >                 ...
> >                 else
> >                         return -1;
> >         }
> >
> > or something like that?

[...]

> > > +             if (strcmp(name, "signature") &&
> > > +                     strcmp(name, "signature:signer") &&
> > > +                     strcmp(name, "signature:grade") &&
> > > +                     strcmp(name, "signature:key") &&
> > > +                     strcmp(name, "signature:fingerprint") &&
> > > +                     strcmp(name, "signature:primarykeyfingerprint") &&
> > > +                     strcmp(name, "signature:trustlevel"))
> > > +                     continue;
> >
> > And with the helper above, we can avoid the repetition here that can
> > go out of sync with the parser function.
>
> I am not sure I have understood this, which helper?

I think Junio is talking about the following function:

static enum signature_option parse_signature_option(const char *arg)

he suggested above.

With this function the above code could be just something like:

if (parse_signature_option(name) < 0)
                    continue;
