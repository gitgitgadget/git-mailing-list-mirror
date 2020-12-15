Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB05FC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7072122475
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgLOMWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 07:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgLOMWp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 07:22:45 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F97C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 04:22:05 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so19110860oty.9
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 04:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=DUDSzw+tszj5Ai4AopIRhNz3/vNMQ2B4UuBbMLGqLNs=;
        b=s0HGd+1lt6zZx2izxkbV4bmNWrSdwgrgEFzQaWJyHY5/Y1O5yW3vKcU1dD4P5x4p9a
         fa/D8bpU9qQXcvI9Jf3LQjIzmKK7rd+RfYWP7snujhiM+1KxKQ57iD6GepIJyjkduov/
         Py3AAdLxRiXYJJXaY/Pb+Vogc12Ex6qMzr2Fo0DhiFZhyKfes3A/GsKJtW4Lrbf3cENX
         Q+t+wpz1QR/cI053hxB4XfPJSRkU+Ni4Hp+UyPD9psYCTozhU0vhoLwJ6Vkxe+5m1Xn2
         luBfXeFwy35WJXL2d3pPvuF/7R5V20F2gQwGhz+5eiiNQ/K9zPXDfi76aQDN89UxKGcO
         5wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=DUDSzw+tszj5Ai4AopIRhNz3/vNMQ2B4UuBbMLGqLNs=;
        b=VERogy4//VD7PhcV5jR6t9niA+sdvKzZC6uU6sSZzbV5Nw3cE+gQGHBRAUV2A+aU9y
         xQLODa4Jk07ZdeIIMGSMANcZt/juBVLR5d0h5bcSeMEokNqDZrd5C3noaLEX6hn8ViOD
         xSJvm6/borSmeiR6KbYeKXvkmqXXOkasMqeq5HIdowEaZnILPubDhAQvfMM0Nu6PfgP0
         xFIS+AzxhcHTVpcuWPnvdzAh2LEdUfvD4L8loHIEThJfb4dTQVjTNo8gyw/HjRhdJo2p
         PkYY44SfQSMhK0KE26DwTL0VPcSkpizOGRnRgohJwis+IBZPFAJle8SVQOA10tT4SnQj
         K3+Q==
X-Gm-Message-State: AOAM533+cOqVkN8njTF57oO6+yBM4rA7l4WbAA0AR7XI/Y+9V3d42lyx
        YnBUURQ1HROYr+3Hlh8oBWk=
X-Google-Smtp-Source: ABdhPJwTlYMi5rdv4QAi+jDK8jvE7uXuPlwqOiIJfcoIDLl1xIjqxItq1nlC9wjWBzpsJjexytJ1WA==
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr9453102otd.235.1608034924509;
        Tue, 15 Dec 2020 04:22:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e8sm372137oti.76.2020.12.15.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 04:22:03 -0800 (PST)
Date:   Tue, 15 Dec 2020 06:22:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5fd8aa6a52e81_190cd7208c8@natae.notmuch>
In-Reply-To: <xmqqmtyf8hfm.fsf@gitster.c.googlers.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
 <5fd85811c3a6_d7c48208aa@natae.notmuch>
 <xmqqmtyf8hfm.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v7 0/5] making pull advice not to trigger when unneeded
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> To avoid the ugly-looking "strcmp()" in the above, we may need to
> >> adjust "--ff" (fast-forward without creating an extra merge commit)
> >> and "--no-ff" (create an extra merge commit when the history could
> >> be fast-forwarded) to imply "merge", though.
> >> ...
> >
> > Or do you mean --ff doesn't override --rebase? Therefore it's more of an
> > internal conceptual change.
> 
> I meant "--ff/--no-ff" without saying anything between merge and
> rebase would make merge implied.  It was merely for the purpose of
> getting rid of !opt_ff in the condition there and such an implied
> merge would be one way to ensure that rebase_unspecified becomes
> false.

I see.

> "--no-ff --rebase" (in any order) would be a nonsense combination,
> as it asks "please create an extra merge commit even when the
> history fast-forwards, but by the way I do not want merge I want
> rebase" [*1*].  It should error out when the history fast-forwards,
> I think, and it probably should also error out when the history does
> not fast-forward, instead of rebasing.

But we shoud not imply what the user didn't say.

Yes, "--no-ff --rebase" is obviously nonsense, but that's a
simplification of setups the user may have, for example:

  git config pull.ff false
  git pull --rebase

Here, I think the user is saying: "please do a rebase, and ignore the
pull.ff configuration".

But the other way would be:

  git config pull.rebase true
  git pull --no-ff

Following the same logic, the user is saying: "please do a
non-fast-forward [merge], and ignore the pull.rebase configuration".

Either we imply the merge, or we don't.

I don't think it makes sense for the code to imply the user did say
--merge, and therefore don't show the advice (or in the future error
out), but then continue as if the user did say --rebase.

> In any case, I haven't thought the opt_ff part of the expression
> through.

It is tricky.

The reason I think I see it more clearly is that I have explored many
options, and at this point I have 27 branches with different approaches
of this topic. I see the dead-ends because I literally have a branch
with the test-case failure on it.

But as I said in the other thread [1], it all boils down to this:

 1. git -c pull.ff=only pull
 2. git -c pull.ff=only pull --merge

Even if you remove the opt_ff part of the expression, and the logic of
the advice/error is flawless, opt_ff is still going to come bite us in
the end, because it's meant to be passed to cmd_merge(), and it's still
going to fail, just at a different point, with a different error message.

The best way to get rid of opt_ff from the expression, is to actually
completely ignore it, and leave the current behavior as it is.

By adding a different configuration, the logic becomes really simple:

  if (!can_ff) {
	  if (!mode && opt_verbosity >= 0)
		  show_advice_pull_non_ff();
  }

And then opt_ff doesn't interact with --rebase at all, just like it is
the case right now.

Simple.

Cheers.

[1] https://lore.kernel.org/git/5fd8213598c33_d7c4820837@natae.notmuch

-- 
Felipe Contreras
