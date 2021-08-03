Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0863BC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AB96056B
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 02:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhHCCe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhHCCez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 22:34:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B198C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 19:34:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c9so18606919qkc.13
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 19:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jna+F3QdeaPuBmi4c6GzlkarZylYeGoo2ziRF+u+imc=;
        b=J7yN4KXI/4PsQia+anQElsftsXE+Fibq2PItWNElnztBZWRX0bVtZtkHcnONpZjeNV
         AxrnjhhFvrPhuImHxpVrRLeYEZoQaHPh3TC8oz31uVLhuTm9A4O8JRqWhwgGKF1hJLzd
         ZQzSiLZzUpmuo55v2ZKB1kI+BSNmr+lmVUarTat++YDT+LmIZnjhfOfjeFFYK/Foue3q
         zRQtF/4jkuopeWjbOWxmCYFCHCY+J0f20MlgUu56vLWU35a0htsKDWDoLvQwA+vmQ7TA
         mHAzSHZcFjoHMD/urHgvnhl6lbrGT7vLupww6chVeDTaTas2BXM7GLv2RY/S/PQmTDAN
         5rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jna+F3QdeaPuBmi4c6GzlkarZylYeGoo2ziRF+u+imc=;
        b=gjh9z49Us6UrkjQLihTSlxeRDzRF4/ftZAAhjzlPXRdQHBTsgb4VDUY4C5N2eZErKw
         cVVd8pS6KT/JihMaYl796oMXIqe7WhLmBUjMN/v5vVzWOJVr0MJNqPguVHfsMJFvWiuY
         IJu+pXfKLGi14TSVvt8Y8LlswLfvJ4K75AWSXmPmYEhgU8raThiQQ2NiGWpL8zkJoHzi
         0zx2NfL0NesSJ2JwIk8lotkFnog0T+ETDCkKa2/azHvz5b9XZT4OjJKxp3vfSrs+Jzmx
         +BMso+/Rvn6khBQ9BJB4heIt6jOL3iEwNnagsp15Z/VVqbTkOz8IKYc2NRSS5ku0sX4m
         Z1Rg==
X-Gm-Message-State: AOAM532Yfu6bLO94V8SNu6DCxceRvAa39VO5Y491XHOMX8ifCBcX997T
        O4oIoX2a9qcv0o4FDdIWS4HnF3MWTOXBrX4DRFo=
X-Google-Smtp-Source: ABdhPJziwTFfWihohySWne8KI0nckaxxPZ17Tn94bTCxch9/Uv1vzjKtBifCdrES9S9ASNazVaTfifyqJ5Y6hk7F/JM=
X-Received: by 2002:ae9:eb97:: with SMTP id b145mr18535614qkg.111.1627958083677;
 Mon, 02 Aug 2021 19:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
 <875ywoqldr.fsf@evledraar.gmail.com> <YQgahVPT8g0+U1B3@coredump.intra.peff.net>
 <xmqqmtpzwzbm.fsf@gitster.g>
In-Reply-To: <xmqqmtpzwzbm.fsf@gitster.g>
From:   heapcrash heapcrash <heapcrash@gmail.com>
Date:   Mon, 2 Aug 2021 21:34:32 -0500
Message-ID: <CAM1Tk16Duh9ySS1xwW3yK4ogz=HbMp9k5B7bjCGSgqOEx=pdtA@mail.gmail.com>
Subject: Re: Enhancing --show-function and --function-context in default configurations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks all for the feedback!  I'll try to address it below:

> Two other places may be diff hunk headers and --diff-words output, I thin=
k.

I didn't think of those.  Does this mean that diffs generated with a
given e.g. diff=3Dcpp configuration might not apply cleanly if run on
some other user's system without that setting?

> That depends.  If you are going to introduce a mechanism to
> introduce hardcoded configurations, depending on how it is done, it
> will become a huge security headache.

I don't intend to add hard-coded configurations, just hard-coded
defaults.  User configurations (~/.gitattributes and gitconfig
diff.funcname/diff.xcfuncname) will still take precedence.

> It makes emitting the diffs take more CPU, but the same is true of other
> options like colorMoved etc, so that in itself is not a dealbreaker.

I didn't think of this scenario, that it would add CPU time even
without -W/--function-context/--show-function.  I'd definitely be fine
with preserving the current behavior in these cases (more below).

> As long as the default built-in ones are
>
> (1) at least 90% of the time improvement over, or at least is not
>     broken compared to, the unconfigured case, and
>
> (2) at the lowest priority that users can easily countermand for
>     the rest 10% cases
>
> I do not think it is too bad to resurrect the old patches from these

The currently-hard-coded regexps for e.g. cpp, python, objc, etc. (in
userdiff.c) are all VAST improvements over the default, which is
effectively '^[A-Za-z0-9_:]+' (i.e., any word which starts on the
zeroth column, IIRC).  This has lots of issues for e.g. Python where
the function name is often indented (e.g. inside a class definition)
and cpp is compatible with, and an improvement over, the default "C"
setting (which is particularly broken as it marks any "goto" label as
a function start / end).

All of those points covered, I think we can make this work in a way
that preserves backward compatibility (no defaults at all, user must
manually configure ~/.gitattributes) by only setting "smart" defaults
(e.g. "*.cpp diff=3Dcpp", "*.cc diff=3Dcpp" etc) when the command is
EXPLICITLY invoked with -W/--function-context/--show-function.

Another case I didn't think of in the original post is with the "git
log -L:funcname:path/to/file.cpp" option, which tracks changes within
a function over time.  Having "better" default function boundary
detection here would also be useful.

Ultimately, I agree we should not have any extra overhead for any
commands (log, diff, grep, etc) unless the user EXPLICITLY uses flags
that indicate function boundary detection are key to functionality of
those flags.

On Mon, Aug 2, 2021 at 12:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Mon, Aug 02, 2021 at 10:45:25AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> >
> >> I would like to see us have a setting to turn these on by default, but
> >> think it would be better to make that a diff.* config setting to put
> >> into ~/.gitconfig, i.e. we'd extend git itself to know about a list of
> >> extensions for the given userdiff drivers, and use them when rendering
> >> diffs.
> >
> > A long time ago we discussed doing this. The relevant thread is:
> >
> >   https://lore.kernel.org/git/20111216110000.GA15676@sigill.intra.peff.=
net/
> >
> > which references a few others:
> >
> >   https://lore.kernel.org/git/4E569F10.8060808@panasas.com/
> >
> >   https://lore.kernel.org/git/4E6E928A.6080003@sunshineco.com/
> > ...
>
> Thanks for pointers.
>
> One good suggestion given there was to use diff=3Dc and diff=3Dperl in
> our own .gitattributes to use the patterns ourselves, which we seem
> to have been doing just fine ;-)
>
> As long as the default built-in ones are
>
>  (1) at least 90% of the time improvement over, or at least is not
>      broken compared to, the unconfigured case, and
>
>  (2) at the lowest priority that users can easily countermand for
>      the rest 10% cases
>
> I do not think it is too bad to resurrect the old patches from these
> threads.
>
> Thanks.
>
>
