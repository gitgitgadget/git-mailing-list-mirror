Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7CC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 07:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE5A204FD
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 07:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2D5P6z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfK0Hct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:32:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39302 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfK0Hct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 02:32:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id n26so18787175edw.6
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 23:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZCaqYom2yaFcGgExgZ8ztuia1uGVzZJkpbHtQKfsC4=;
        b=a2D5P6z1cGchz83F8taKlU4CiTGlYbcgPhrqCdIaZVpF7OMbEEB6hoxQn7uX0vXHhH
         VuuPPstOALQtIZHWOhSRZA9VOaE7Ui4D5cbjs33xInguxolSYBA/OBQPkB8ozTu61wYi
         cKFzxZ7ivc868xTls5W5zy5eAS/e5PGa2UyNkoA/AsPZP7/Mgw6EHKCki2mgP2a6RKfC
         ebB2ojmvcDEReMOchBWnPZzHyPC3P2+r+pN7yy5Lp/MJHBk65PbVdMbR4advw/ePMiL8
         KH/PeH+HHewuJLGOmBWsLsmEoxkKJ2+GeD4kiPRoiKIwo7VzuNKY5CuMKQ1UfPdlM2Zb
         7JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZCaqYom2yaFcGgExgZ8ztuia1uGVzZJkpbHtQKfsC4=;
        b=nt3WK6UxvAPx0fTfp7jyfZ6kP1DbIOXQMq3+wgzt2HTvNBwX7OHIyMIix9mK/QUQ8F
         XC1vHQ4E39OGPIUFbgTmVAxSC1MOg1IPXgrnQT3sjuxHyXzzKh7WaWd/4yjTBbQx45UA
         BsVvRIF9Jke9lZRmzkvb/quWP+p0o3ymUIg0J8syHIkR4Z9UrnO6F3QQpBKcXFQMEq/I
         CJKafnjksnmU1gPBMXTPvpv/be8BCsTpZFzgvegaanr+2DWwU0PBIeC1DJ9NPt8DMcfL
         6Evfz5IO63wzabE3lCO7Qe/53cFDSgUmXNC0CbwfZceGO6C/49giboT7NuOFVK2fR3PF
         OuZw==
X-Gm-Message-State: APjAAAUE22D6/J5f+8xRP4yAQ65aYsuGMGw52yQIHdnN435PGLRx1OTd
        aoo9rLMgr2fsPSxrq/dzUZPiQEEGJLOg0w5sPhA=
X-Google-Smtp-Source: APXvYqwBKvXAI/hCQeLX1i5KoPqUZSEt9r+mNyYamoldU5aHZeo0iWgLf2oC1SvwJ69aoDRyKpdbVLW9LNBjgHAiJRk=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr30378842edw.280.1574839967659;
 Tue, 26 Nov 2019 23:32:47 -0800 (PST)
MIME-Version: 1.0
References: <87o8x06sbw.fsf@sydneypc> <20191125141635.GD494@sigill.intra.peff.net>
 <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com> <CAAE-R+8dqbxWr9an63OGCL2g1sm1h-ds3yKrzz7Shwq3UyfWxQ@mail.gmail.com>
In-Reply-To: <CAAE-R+8dqbxWr9an63OGCL2g1sm1h-ds3yKrzz7Shwq3UyfWxQ@mail.gmail.com>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Wed, 27 Nov 2019 18:32:37 +1100
Message-ID: <CAAE-R+8yZOchnsa-au+w4JveCQffw9bpGZ54oL+DApa8Y094=Q@mail.gmail.com>
Subject: Re: A new idea to extend git-blame
To:     Jeff King <peff@peff.net>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI, Jeff,
Just double checking, the feature I suggested is fine, right? I will
send the patch asap. It may take 2 weeks to implement.

On Tue, Nov 26, 2019 at 4:36 PM chen bin <chenbin.sh@gmail.com> wrote:
>
> The problem of recursive blaming with 3rd party script is it's slow.
> The script have to restart git process multiple times. Besides, as I
> already did in Emacs (see
> https://github.com/redguardtoo/vc-msg/commit/1f7775f951fdd9e6571afbb3a767c42d20617f52),
> it's still lots of code.
>
> So if it's possible to use a simple cli option like `git blame
> -S"text"`to do the same thing, it would be easier to migrate vc-msg's
> functionality to other text editors.
>
> On Tue, Nov 26, 2019 at 3:55 PM chen bin <chenbin.sh@gmail.com> wrote:
> >
> > I re-tested `git log -L20,20:README.md` in git's own repo with HEAD
> > d01d26f2df. Looks git log is not what I expected. The output contains
> > many unrelated commits. So it will be slow in real project.
> >
> > A recursive blame with the algorithm I suggest will get correct commit
> > in short time. So my suggestion still hold.
> >
> > I could submit a patch to enhance blame.
> >
> > On Tue, Nov 26, 2019 at 1:16 AM Jeff King <peff@peff.net> wrote:
> > >
> > > On Mon, Nov 25, 2019 at 11:41:55PM +1100, Chen Bin wrote:
> > >
> > > > The key algorithm is simple,
> > > >
> > > > The algorithm only works for one line blame and the user must
> > > > select text inside the line first.
> > > >
> > > > Step 1, `git blame -L6,1 --porcelain -- hello.js` output,
> > > >
> > > >     4f87408612e0dacfd89a1cd2515944e21cf68561 6 6 1
> > > >     skip...
> > > >     filename hello.js
> > > >      doit({bad: 'destroy world', good: 'hello world', ...});
> > > >
> > > > I got the commit id (1st column), the line number (2nd column),
> > > > file name (hello.js) and the code line (last line).
> > > >
> > > > Step 2, if the code line does not contain the selected text, the
> > > >   recursive search stops
> > > >
> > > > Step 3, or else use commit id, line number and file name to build
> > > >   new git blame cli, like,
> > > >
> > > > `git blame -L line-num,1 --porcelain 4f8740^ file-name`
> > > >
> > > > Step 4, execute new git blame command and start from Step 1
> > >
> > > This sounds a lot like how git-log's "-L" option works, which tries to
> > > find the history of a line over many changes.
> > >
> > > It's also similar to the "re-blame from parent" feature of many blame
> > > viewers. There we have a human in the loop saying "no, this is not quite
> > > the change I'm looking for; go back further".
> > >
> > > -Peff
> >
> >
> >
> > --
> > help me, help you.
>
>
>
> --
> help me, help you.



-- 
help me, help you.
