Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBB6C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D07C60EFF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhJYQrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhJYQrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:47:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D291C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:45:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s19so10377201ljj.11
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=pqtK6hjzPTMdiI1THS808ZG+I1TH0OpI1SLXbP6KZRg=;
        b=hd3f7M6WGUNw+HUXnjP5Mwf0ncaky59ONS9HcxY7Tku8ARXnCJSY7ZvyW7GX4YVezp
         E7WI2bZwrfgjEtmlKyZW8IzO8pWnqM3yCGR02VqIYNs7v4QXOKg3rHNlGDU64xIsFeU9
         Kfcir5oDcff1aZDLAUyfDwNcRdb6lklN538zkmmORORYk8N3ubA2uNPGpsJC9aaBpDHX
         /497xX9YzNjzseCV3JLXvIQEw3EW8bVcimEyLjqE/4K7EoQFd5Skbr2JUh8nZinzTHxF
         aqnzgBGVj72+Lht2Gg7Um6y+h1e45N0ds/wWC0D+8wnb/pbD2hyPi+h/LKgK0s72wwOA
         AYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pqtK6hjzPTMdiI1THS808ZG+I1TH0OpI1SLXbP6KZRg=;
        b=oV02/DTekQqjT/VbsVvYBYiAW7uH9Aplv58Ue1Usv8u3GKIVgaWPi0np9bw3OcoQMl
         +f2An4bpfdELZ/8TxlwWvmUgr59pChfYjWQEbO8v/IhSlGpY5q4mJL1xbwGhYFyb3Eyp
         E4KTQ8FEF8KjUUv1Uof4+jqvtwNPK4Vcq8SjA9/zvKa4TaGYIZ6oR/P7RUVnqELvuwcu
         h0ZwfNFDidKGefc8wBP7IS475GkNi8z1Zjyww21hbJAWM/veQetbwok8U1+3ofsR3tpe
         E2IWcCpKBE33wDknwQhzVGlmQ99pZxu5/TZsxMPCejvjl4gCSlcWPxFLnf4JYlBqu/Zv
         ySBw==
X-Gm-Message-State: AOAM5331nySquITuHxYBfilvaeL6TUUKy2QC0uHhybSWwayPsbK0w2+b
        FnCEm3pSVRfDRe8lXwD4RNmAlbNT3jc=
X-Google-Smtp-Source: ABdhPJyN/g2DYYfJJIvxntv6Hk/pWzlQERerD1NEecceIBowxZetPl/xyzcRLFaknsUauH2MMIvknw==
X-Received: by 2002:a2e:8153:: with SMTP id t19mr17790002ljg.36.1635180298592;
        Mon, 25 Oct 2021 09:44:58 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d14sm1967155lfb.210.2021.10.25.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:44:58 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
Date:   Mon, 25 Oct 2021 19:44:57 +0300
Message-ID: <87h7d5yrxy.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

[...]

> I really don't know, but I do think that the most viable path to a
> better UX for git is to consider its UX more holistically.
>
> To the extent that our UX is a mess I think it's mainly because we've
> ended up with an accumulation of behavior that made sense in isolation
> at the time, but which when combined presents bad or inconsistent UX to
> the user.

Yep. Moreover, this practice of "making sense" being the primary
reasoning factor doesn't work very well even in isolation, for single
Git sub-commands. As there is no defined underlying UI model, or rules,
or even clear guidelines of how to properly design command-line options,
multiple authors, all having their own sense and having no common ground
to base their decisions on, inevitably produce some spaghetti UI.

The UI model to be defined, provided we are serious about aiming at a
good design, in fact has at least 2 aspects to address:

1. Uniform top-level syntax of all the Git commands.

2. Uniform rules to handle command-line options.

Being hard to produce simple yet flexible design by itself, the problem
is further complicated by the need to absorb as much of the existing UI
as reasonably possible.

Once a model is defined though, we should be able to at least ensure new
designs fit the model, and then, over time, gradually replace legacy UIs
that currently don't fit.

As a side-note, from this standpoint, discussing deep details of "git
switch" options, or even relevancy of introducing of "git switch" in the
first place, has still no proper ground.

Not even touching (1) for now, let me put some feelers out to see if we
can even figure how the rules or guidelines for command-line options
design may look like.

1. All options are divided into 2 classes: basic options and convenience
   options.

2. Minimalism. Every basic option should tweak exactly one aspect of
   program behavior.

3. Orthogonality. Every basic option should not "imply" any other
   option, nor change the behavior of any other option.

4. Reversibility. Every basic option should have a way to set it to any
   supported value at any moment, including setting it back to its
   default value.

5. Grouping for convenience. A convenience option (usually with a short
   syntax), should be semantically equivalent to an exact sequence of
   basic options, as if it were substituted at the place of the
   convenience option, and should not otherwise tweak program behavior.
   I.e., a convenience option should be simple textual synonym for
   particular sequence of basic options.

Please notice that in the above model basic option having a short form
is formally considered to be a short convenience option that is a
synonym for long basic option.

There are obviously some other useful guidelines that could be defined,
or some alternate approach could be chosen,but the primary point is that
if we want a consistent UI, we do need some rules, and we need
convenient implementation of the model agreed upon, and then ensure that
from all the designs that "make sense", only those that fit into
underlying model are accepted.

Thanks,
-- Sergey Organov
