Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E9AC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336262072E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 20:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rb/bgNO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgKFUNJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 15:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFUNI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 15:13:08 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FCC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 12:13:08 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 32so2416931otm.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 12:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FtaVXCpJNlqqfC5sCfk85KG4CcgmxF9W3Qnb5GqMz/I=;
        b=rb/bgNO6FEEvJ5GuzIdGOLeNPxvAJ6Wsh9Io6Yyvn0Jp9vjOazvmNOzoWBxrarfhok
         93UjFqo4El1zAh7smxuo1zbrxSMgYb9pm5HSQd/APQfJFOz52FIldr6Z07eJY2RdpKeu
         7hWKM2dUc1KBdc0N0ggKUgUg8RblxTsaDwLWAJz4UIM8UrwPioSeEXsAQfTlV3yg1crJ
         FRJCqdzL4MPoCeuvHuErYOU7nE+X7UBNAz86clRk+9vR0dXWvmXmdCWtQLyjGbi6h2Ct
         DVrXCKroTbcNUiXOXSx6386LdmrnoOXgQHYxmbCz4wcX7P89ctmUq7ayLnGUY7JSFS3S
         wBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FtaVXCpJNlqqfC5sCfk85KG4CcgmxF9W3Qnb5GqMz/I=;
        b=GQUq9fMgWHz8tSdhDS2lGR9qk/Vn1fuSlCWyThvXlBFMefxe5PmVFvuhgmeeqP/6Aa
         Ka52aFeFb4T9MY7JzO0rIL+nY/a1LfaObfSaeU39ZbBD/kjLY7INQB+A+XNyi68dFHld
         EkEjAgnSbBBjKy5NDpLlvVgRvTdsgDLXeLbuKh3+61v43oCuNrKml+2LXS8z9dP0VDLM
         /6BMXvofIl/jyWuJMtzNe5eHHUyNl7w6nBV5sKtaF1Q1TK0o3RNlQtB+C2ZUfo0hWVHJ
         aoz0c9PQD+rAv6wBkXVSEB9qRuIufl1yvSGF3fgZ3K/m0WhzxI3ZdXG8a85wkNtA6b1f
         CN0A==
X-Gm-Message-State: AOAM530PGMP3w+GMmfjNnP6mU19dEKBszJZ+RJKyUg2mQlBM5NEfsBSO
        AjRbxLVdr9CPC0OTgslZDvXoCW6EgbyWwH463aY=
X-Google-Smtp-Source: ABdhPJww/cOkwpSbPyufoODthlWBeuAP2T8VerhZi0dnOS3UrjhM632n8vo04Y+N53QJjt2tyxlFFInuWDVCjyBipjU=
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr2292283otf.345.1604693587889;
 Fri, 06 Nov 2020 12:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20201106090443.GA20407@black.spass-am-geraet.de> <xmqqo8kafjgt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8kafjgt.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Nov 2020 12:12:55 -0800
Message-ID: <CABPp-BGv9goqrYBwgSkmhPYOmwcXeRCzGT2sQbL+xD2xWeT5gQ@mail.gmail.com>
Subject: Re: Suppressing filter-branch warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Daniel_H=C3=B6pfl?= <daniel@hoepfl.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 6, 2020 at 10:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Daniel H=C3=B6pfl <daniel@hoepfl.de> writes:
>
> > Hello there,
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > git filter-branch -f --env-filter '' --tag-name-filter cat -- HEAD
> >
> > What did you expect to happen? (Expected behavior)
> > See below (difference).
> >
> > What happened instead? (Actual behavior)
> > When using git filter-branch, the following message is shown:
> >
> > ----------8<-----------------------------------------------------
> > WARNING: git-filter-branch has a glut of gotchas generating mangled his=
tory
> >         rewrites.  Hit Ctrl-C before proceeding to abort, then use an
> >         alternative filtering tool such as 'git filter-repo'
> >         (https://github.com/newren/git-filter-repo/) instead.  See the
> >         filter-branch manual page for more details; to squelch this war=
ning,
> >         set FILTER_BRANCH_SQUELCH_WARNING=3D1.
> > ----------8<-----------------------------------------------------
> >
> > You can suppress this by setting the environment variable shown.
> >
> > What's different between what you expected and what actually happened?
> >
> > Normally, when git introduces this kind of change, there is a
> > git config variable that one can set to suppress it.
> > That way one has fine grade control when to suppress it (one repo only.=
..globally).
>
> I think this comes from 9df53c5d (Recommend git-filter-repo instead
> of git-filter-branch, 2019-09-04).
>
> FWIW, I personally do not think an environment is a worse choice
> over configuration variable in this particular case.  The large
> scale rewriting of the entire history in the repository by its
> nature is an one-off operation that ought to happen only rarely,
> so a one-shot
>
>         $ FILTER_BRANCH_SQUELCH_WARNING=3D1 git filter-branch ...
>
> that reminds the user every time would be more appropriate than a
> configuration variable that has a more permanent squelching effect.
>
> If it were a new command line option may have been even better, as
> an environment variable can be defined in .*rc and forgotten, but a
> command line option needs to be typed every time and would serve as
> a better reminder (yes, I know it can also be aliased away, so it
> may not make much practical difference either way).
>
> But I'll let the author of the feature to comment.
>
> Thanks.

I agree with Junio that filter-branch's one-off nature means that not
providing a configuration variable seems reasonable in this case.  If
someone else were to go to the effort of implementing some
configuration option here, I wouldn't be that strongly against it,
though I'd rather just let filter-branch lie dormant and stable.

A new command line option might have been better, but it didn't occur
to me at the time this change was made and I hesitate to needlessly
force people to adapt again.
