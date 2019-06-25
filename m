Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A481F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfFYLno (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:43:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43874 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfFYLnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:43:43 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so654623ios.10
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZjO8SnJ4JlroacxgF+4hv7iiVhiCfpWoXv6CrPiBv0=;
        b=YOFQDZ1hrDVSf6oTSLFibRYUkyrRLnlmUzFJldPE/EQLXDT54p3X+nVjTNOIj9cWa5
         vaum6GF237qJenYc5P2xukRcjk04YEbO5mzYYBdbrtaCOe5t7H5aOe9CEKY3VPzI73GF
         q4lk0Rx3PCUcD2N0IFF8GW1x7ZYDH1mQhoW6GwGVLo0RTHv9jjixvJb/70kr6CBrAK+2
         Wh+zscQzbkg7ko0Lch7fhjM6HbmF4HJz8ebH0cZX6Cpi1YRPdJauodE6Zi8KJOBp6Ugn
         hf23+a3ZfxzfKHIUezu28+ptj+SYMIhrJR+vq+O2cQpR5lzHJBBE1zzXr6Tm1YI9AGS7
         iauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZjO8SnJ4JlroacxgF+4hv7iiVhiCfpWoXv6CrPiBv0=;
        b=LmJrA/wN4ipgxP3sK88TjWr8/ROJAI6AqGvTM3r3Llu8UkvPCcEXoyOGQvE1XNiefX
         +RI1uY5xodSxiVghI/RpHTGYGrNGk27EoGbOsqDLvnjG75mNlUPbZ7Kpt6Sme3asA8Cn
         n6XW+Bj9jq8/I9lCnVP36yOsRh7nn2Fjkgi/QJQFX1EyRD9HH+EQGkjiUiasct/WoNKC
         0u1W8X78FlZK9N4XZD6rvaz4v1hO6YLJMd0mVESbVremLeiSCen7rW6YtJmGHEmifUKw
         CZzmoFzl/rdGZnn4/K9WjJ3qJFpFSsiELNJwBcyl8/OK3EdGCfLGBdHn/llw2uE2oLeA
         dDqA==
X-Gm-Message-State: APjAAAVPmUWPMHP719/gB4Lt8CNt64PmNNboadx6sQdUjJrAKUdMVnug
        G9AvTXOwRH3dFggQZhxn8WxscNvtHgZ5RC+qApU=
X-Google-Smtp-Source: APXvYqwZg/WZ0FcTrny+ikSKufUWJw0NevzGXyXdsnvqBOTtMvkeBFzl+CFEpif5jRBrGLCKsz8hsP9r9X5W7U6Zwlc=
X-Received: by 2002:a02:a07:: with SMTP id 7mr39034316jaw.65.1561463022938;
 Tue, 25 Jun 2019 04:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
 <87sgs3rhpo.fsf@kyleam.com> <xmqq8stvklzd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8stvklzd.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 18:43:16 +0700
Message-ID: <CACsJy8CBQhF2=nZ4tZj_h6Gr8PjK3amANjT38uhnurS0dehyiQ@mail.gmail.com>
Subject: Re: specifying revision - how to enforce matching a tag/branch-name
 or revision only
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 10:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kyle Meyer <kyle@kyleam.com> writes:
>
> >> git rev-parse "${BRANCH_NAME}"  || git rev-parse "refs/remotes/${UPSTREAM}/${BRANCH_NAME}"
> >>
> >> Unfortunately somebody used the branch name "add-gcc10" and `git rev-parse` which didn't exist on one repository. However `git rev-parse`
> >> also supports to parse the `git-describe` format which resulted in checkout a commit starting with "cc10".

I wonder if something like refs/heads/foo-g<hash> could trip the
parser and mistake it as a `git-describe` output. Staring at
get_describe_name() alone the answer might be an unfortunate "yes".
But maybe something will kick in earlier and reject it.

> >
> > Can't you prepend "refs/heads/" to BRANCH_NAME to disambiguate?
>
> Yes, that is the kosher way for most commands.

Some commands always prepend refs/heads/ to the <branch> argument you
give it if I remember correctly. Or I think I accidentally made
refs/heads/refs/heads/something once with some command (then hell
ensued). If true, prepending refs/heads/ is not really foolproof.

> It gets a bit tricky for "checkout <branch-or-committish>" that
> changes its behaviour (a local branch is checked out and the next
> commit extends it, other committishes like tags and remote-tracking
> branch tips are checked out on a detached HEAD), and has special
> rules for a "${BRANCH_NAME}" that is both the name of a local branch
> and something else.

I think "git checkout --no-guess --no-detach <branch>" should only
accept a branch (i.e. ref: refs/heads/<branch>). Dropping --no-detach
should allow any ref, which interprets refs/heads/foo as an absolute
ref, not as refs/heads/refs/heads/foo.

> Hopefully (Duy Cc'ed) "git switch" would improve the situation.

"git switch" has slightly saner defaults, but with --guess being
default to be friendlier to interactive usage, it's still not that
much friendlier to scripts, unfortunately.
-- 
Duy
