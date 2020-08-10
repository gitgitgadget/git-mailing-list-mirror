Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD5C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 05:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2F5206B5
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 05:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgHJFlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:41:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40851 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHJFlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 01:41:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id k20so7107843wmi.5
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 22:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNKyGEp+lagd0iAArK2oDYrAJMkP14MzIhseqzjA/Eg=;
        b=j3UFQF8nvQXb77yvAWpwyJLFy9qJue9Z3Jxn+OVL1WwhFUCQw6T7ezQhx6DZhWo+47
         6/sMaf34gI9VqINyr+ZdX9lOTlWN2tMHL4kfcOQR1TG6iNTgcTRztgJqbFYqOd7KoPXI
         mNmqptSgbr5J9581Di2MMYIM9jRu5wAF3c08edCTvHA35KdvQ72XSNjL0QRBmxP3QH7P
         DpUZm4VL0selgsu/5k7llNoeQIAPni8VXSKF+p0+RzZSi3X/Ub8FTDPK60OspojOMQCa
         TmxfK9EX44bkRvKuhvo+MEjvi+RnS2vMi+DlwelRxj82TbQ158AqXnz7aS/pGso6YF0c
         bKug==
X-Gm-Message-State: AOAM533T/rdGozPxdicNp8YZ74L7jy4OvnRGA+G0w2+SG7bDqLVPRK4u
        5vdO/LJanzFegYEQK4+b1QQSIKF/FKnrdIqTubA=
X-Google-Smtp-Source: ABdhPJwvrt+K5oA3XEyUPFr7CGJcuKm34UtGvRsRXtzXpGdPoM6RMgaSOuS40IW7R6cOx0p/Fidr5J0UOf4lExQGeV8=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr23438359wmh.11.1597038098378;
 Sun, 09 Aug 2020 22:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200808213457.13116-1-me@pluvano.com> <20200809230436.2152-1-me@pluvano.com>
 <CAPig+cT3aMUQapU7i0C3jZaLd2XJwP9SbxFEm_tG_1wj8w1PKw@mail.gmail.com> <20200810031123.GA3565@pluvano.com>
In-Reply-To: <20200810031123.GA3565@pluvano.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Aug 2020 01:41:27 -0400
Message-ID: <CAPig+cT2dFLHp6YhUmD7SeGBy3u1mQMhTTCefRzSfz3sTC0OhA@mail.gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
To:     Emma Brooks <me@pluvano.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 9, 2020 at 11:12 PM Emma Brooks <me@pluvano.com> wrote:
> On 2020-08-09 20:49:59-0400, Eric Sunshine wrote:
> > On Sun, Aug 9, 2020 at 7:06 PM Emma Brooks <me@pluvano.com> wrote:
> > > +mailmap::
> >
> > Is this setting global or per-repository? (I ask because documentation
> > for other options in this section document whether they can be set
> > per-repository.)
>
> Global. I'll add a note that it cannot be set per-project, or I could
> add support for setting it per-project if that's wanted.

If it's not much extra work, it might make sense to support
per-project, if for no other reason, to be consistent with other
nearby options.

> > Should there be any sort of support for functionality similar to the
> > "mailmap.file" and "mailmap.blob" configuration options in Git itself?
> > (Genuine question, not a demand for you to implement such support.)
>
> Yes, that would be useful and should probably be supported.

I don't insist upon it. It can always be added later if someone needs
it. I was asking about it now because it might have an affect on the
design or type of value which the 'mailmap' option you added above can
accept, and I was concerned about getting locked into a design without
taking these other possibilities into account. For instance, rather
than being a simple boolean, perhaps the 'mailmap' option you added
could be more expressive, eventually allowing support for an explicit
file or blob. This is another reason why I asked if 'mailmap' can be
per-project, since an explicit mailmap file, and especially a blob,
would belong to a particular project. It's just something to think
about. (Then again, I'm not a gitweb user, nor am I familiar with its
configuration, so take my observations with a grain of salt.)

> > > +       open my $fd, '-|', quote_command(
> > > +               git_cmd(), 'cat-file', 'blob', 'HEAD:.mailmap') . ' 2> /dev/null'
> > > +               or die_error(500, 'Failed to read mailmap');
> >
> > Am I reading this correctly that this will die if the project does not
> > have a .mailmap file? If so, that seems like harsh behavior since
> > there are many projects in the wild lacking a .mailmap file.
>
> No, this error message is misleading. The die_error is called if there
> is a problem executing git cat-file, but not if cat-file returns an
> error. I'll revise this message to be more accurate.

Okay, that makes sense.

> > > +       return \%mailmap if eof $fd;
> > > +       foreach (split '\n', <$fd>) {
> >
> > If the .mailmap has no content, then the 'foreach' loop won't be
> > entered, which means the early 'return' above it is unneeded, correct?
> > (Not necessarily asking for the early 'return' to be removed, but more
> > a case of checking that I'm understanding the logic.)
>
> The early return is intended to catch when there is no mailmap, so $fd
> does not get initialized. Without it, you would get an error when you
> try to split $fd's content:
>
>     Use of uninitialized value $fd in split at [the foreach]

Right. This follows from my misunderstanding what happened if .mailmap
was missing.
