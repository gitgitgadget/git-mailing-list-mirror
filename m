Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88A11F803
	for <e@80x24.org>; Wed,  9 Jan 2019 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAIVVY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 16:21:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35226 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAIVVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 16:21:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so8530908edx.2
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvlH0Cz+xjnNCjteeOv3P+7lPdclGklFSw3LcxFBxoo=;
        b=SlFrMwOKwBNJT059Pil32zy7xPVROy1uAZts5iPModq1MeQsMezagj+tqaDPNYxz60
         o+UsJi4wN34Zt/cfDAlnuRCzLKUR4mGm8veJ2dVLSGY6ddDdsR3i4O0x6rAYISS8LFuk
         lnBsQjaOGDVJet3+Pt85v1uHx0kB50Pb/CHKWwMJoPJbdeQG3IcacF+UVoiuZKrtW9Tf
         ToMLIMDqyd7wIpc/ujDiC2wq4V5MZiSpSnxcgXLS8ctMc87McPcjlm8RdEQvzHA3K07x
         9xUIESuN4TQlmcHTyvGlXf5BaWI9O5J25moEJ+MuY8muB4nMFOPwhjZHqQNSwqyme8ed
         oiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvlH0Cz+xjnNCjteeOv3P+7lPdclGklFSw3LcxFBxoo=;
        b=XDmVW9XVfgJ+yjdAh6A+N8A2a4jo8B8Lclm6VQ59YzKTMy+yTLH4q6Xmq/C7vPbgbJ
         MXZgOwfUut21a8bb/wel4W/h2nqcl9YbgpQxQUer8R0Lg+EbL+SyBscqBI82nkZN/MxP
         e+Nf6i9vxqVnjgNN+XCttckiSvcNyJF1Y9PXcCd6q5HVIZbwEpJrltHaLcSsol0MItAm
         Q5FKuhfpdGfDU9RGxx+q92WN+qzlZqCuh+/83HlrzEXBJuzIWduZ3Vzux1jbc+Xejlyl
         NxtZWb8VqdciUTthzOQG3Ei68mR1t3aR62b9T6J1ad8SG+Et4S9lxr+MXrteEP5EMsau
         qnjg==
X-Gm-Message-State: AJcUukfY1+yPpRTsYm0Vu/OryFpZCmwjK6B2/HLT9SP53JbIzbvgLBZ7
        8feRTQhfh74gR3KHkjWCuS6x4ikz5THauFnaVx6CWQ==
X-Google-Smtp-Source: ALg8bN4J09S1g/t4Zg1r59Q25IYTtl4DEeBsldW1GNSiTMSdXPhZ3sep+8jQDRIBxzQqw3GViBnmkHNjUTHyBzLdKrw=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr7522482edy.191.1547068882528;
 Wed, 09 Jan 2019 13:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20190107213013.231514-1-brho@google.com> <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
 <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com> <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 13:21:11 -0800
Message-ID: <CAGZ79kYFC+ws00isp0F1kxmxVx0geg+R0VjjRf0=u2ocbkFUUQ@mail.gmail.com>
Subject: Re: [PATCH] blame: add the ability to ignore commits
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Barret Rhoden <brho@google.com>, git <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 10:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Barret Rhoden <brho@google.com> writes:
>
> >> A policy decision like the above two shouldn't be hardcoded in the
> >> feature like this, but should be done as a separate option.  By
> >> default, these shouldn't be marked with '*', as the same tools you
> >> said you are afraid of breaking would be expecting a word with only
> >> digits and no asterisk in the column where line numbers appear and
> >> will get broken by this change if done unconditionally.
> >
> > Since users are already opting-in to the blame-ignore, do you also want
> > them to opt-in to the annotation?
>
> Absolutely.
>
> After all, the users of a moral equivalent that is -S
> never needed such an extra annotation, which tells us two things.
> (1) the claim "It's useful to be alerted to the presence of an
> ignored commit" in the proposed log message is merely a personal
> preference and universal users' requirement; (2) if it is useful to
> mark a blame-source whose parents (used while blaming) do not match
> the actual parents, such an annotation would also be useful while
> running -S.  So probably it should be a separate option that can be
> given when any of the --skip-commit=<rev>, --skip-commits-file=<file>,
> r -S<file> option is given.

From a users point of view it may be desirable to express all this
in the grafts file, i.e. -S <file> where the syntax of that file is extended.
For example we could introduce
    !<hash>
to make it exclude that commit.
Of course this could lead to confusion, as this puts 2 very different
concepts into the same option/file.


Speaking of the implementation:
This patch proposes an oid-set that is handled specially
in blame itself. I wonder if this could be generalized.

Jonathan Tan (cc'd) refactored and extended revision walking
for git-fetch and its negotiation leading to
7c85ee6c58 (Merge branch 'jt/fetch-negotiator-skipping',
2018-08-02), and 3390e42adb (fetch-pack:
support negotiation tip whitelist, 2018-07-02)
which implements another revision walking
algorithm that can be used to fine-tune revisions
walked when fetching.

I wonder if that work could be generalized more
to have "generic" revision walking algorithms
and then making use of them in either fetch or
blame.

For git-fetch there is a new algorithm that increases
step size between commits, which would be funny to
try for blame here. It would give the wrong blamed
commit, but would speed up blaming a lot.

Omitting some revisions seems to be applicable to
more than just blame/fetch, too.

Stefan
