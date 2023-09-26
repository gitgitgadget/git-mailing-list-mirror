Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78CE7F140
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjIZWp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjIZWn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 18:43:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9137C7DBF
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 14:20:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f67676065so116420977b3.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695763243; x=1696368043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgk4X0iTp1s/T8O82xzkEUKTA77pqTGNBS5klGv8/9k=;
        b=zMxOii+URbowYrcxN87OdrgLrdlyHlD2O5PWm6+itp1mruFGW5zvl8O4jSpHbGiin4
         v6P0NHnj08RmH3pvclPuMheXMoQVPyixJOGVmmX/Uk+pbNAOc/iXi2uWOiTOAPJLCrxg
         yHwNhUi/Z8Fv9Gg1FieSs5inR3W8Yg3EWNM94GcGsHl6Fh3ghqTLBpDim4JqwWTe0szH
         fc1VR/qxGrT+b+KN4yfvCWBIoQCQVz9qHnW28uiZGLjsH8zqefTyugJwnmR6tzx8MNk0
         fIet4qUxhhBzPeoUujR5rZsFZcbyrgmF+z0shwOdxy9RLYhoDxGyUGx6Qw5IltwFkuPU
         KfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763243; x=1696368043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgk4X0iTp1s/T8O82xzkEUKTA77pqTGNBS5klGv8/9k=;
        b=w2PM3Eyg5DekbH1KVmCpTmAdTs740eaL+zfoKnfAZ0BbZKXLNlx7+QmhGQ8wAM8p8N
         vR7uUNrbX/V8cmW+N3ksJZgqiQm3SgAkFvMT0Cc2qVDQmRr93GWueSazapY2VDdtNSYm
         FF1Ktp/FxpFR9BDmCh5wdn2y5flaVjwYKd2P5DdniXb0j8CFpPfA31Z1GqKDCn1qZz6O
         ZkrniEPMeAJnssNuLPPmFMBP2I1qcrf4MVTMGt7vxmdZ6uNjTJJA7dXhQSvqKEP3JRvE
         HQWSsxf46nk32N7yVlo/LQKOJiQYco/4aF6mUHnJImSZUfIkeJ1K1BIc9ewgLL4Yr0m9
         TPxA==
X-Gm-Message-State: AOJu0Yx2GDfqx2rjbIRWWE+/mYrgVS7epE1ieAG+o4FAbTv7eUZ7aqw2
        hUJsAWqw6bm6HEpSVlGE8HH3/i+1Ew4=
X-Google-Smtp-Source: AGHT+IF9R2VCYzvCKqWrjXPnhArSCDozZI/NPK7d2jAEfeTJPIgHDY3DZnKpzvdOL4qpgD0ipoPAN8WL9fk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:b727:0:b0:59b:eb4d:21f2 with SMTP id
 v39-20020a81b727000000b0059beb4d21f2mr2091ywh.4.1695763242772; Tue, 26 Sep
 2023 14:20:42 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:20:26 -0700
In-Reply-To: <CACZqfqC3HWOuveQdbpVEEO5KOwmnugvUmm6M0WpVu2MtUopm-w@mail.gmail.com>
Mime-Version: 1.0
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
 <xmqqsf75zxbv.fsf@gitster.g> <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
 <owlypm24sr6n.fsf@fine.c.googlers.com> <CACZqfqC3HWOuveQdbpVEEO5KOwmnugvUmm6M0WpVu2MtUopm-w@mail.gmail.com>
Message-ID: <owlymsx8skbp.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
From:   Linus Arver <linusa@google.com>
To:     Josh Soref <jsoref@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

> Linus Arver wrote:
>> FWIW we already have some guidelines about what is acceptable for doc
>> patches in SubmittingPatches:
>>
>>     We currently have a liberal mixture of US and UK English norms for
>>     spelling and grammar, which is somewhat unfortunate.  A huge patch that
>>     touches the files all over the place only to correct the inconsistency
>>     is not welcome, though.  Potential clashes with other changes that can
>>     result from such a patch are not worth it.  We prefer to gradually
>>     reconcile the inconsistencies in favor of US English, with small and
>>     easily digestible patches, as a side effect of doing some other real
>>     work in the vicinity (e.g. rewriting a paragraph for clarity, while
>>     turning en_UK spelling to en_US).  Obvious typographical fixes are much
>>     more welcomed ("teh -> "the"), preferably submitted as independent
>>     patches separate from other documentation changes.
>>
>> and both the 2-space vs 1-space and comma changes seem to fall into the
>> "not welcome" category.
>
> Ok, then, I think at this point I'll abandon this PR.
>
> I could probably find the time to justify rewriting one paragraph in
> this single file to try to abide by the requirements, but it doesn't
> seem worth it.

The change to make a paragraph read better (fixes to awkward wording,
for example) are very much appreciated and would be good as a follow-up
patch in its own right.

> I'm sorry I wasted everyone's time.

Please don't let this experience deter you from considering future
contributions to our documentation. Thanks.
