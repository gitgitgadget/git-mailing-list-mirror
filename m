Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA7E7E65E
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjIZSw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjIZSwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 14:52:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3D10A
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:52:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so19294202276.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695754338; x=1696359138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qvsLwvGzwCOisYbJ9OGlCyaTg9y52X/S+//koXenxg=;
        b=JCEWY9XNk9JXp69OFLPVBIWAbf9wCHEwf0q3+bSQcufCTetYdlrSkwfQ7hApnAVnzY
         CTMOa6ktE2b6UILflYzurBIdBvs01jfFsyLu2dqzhHmZy+icWsEJTGmsvlkDao4L5iZX
         ZfRDlscpRuNGWqzln19jNWoOjXj1xmumwhzPBc/7Sh3Iku8DBxtspiCUBVOgqX92Im2G
         BjIjKSeD908EdArvxZlyR+M8Qmg12COKszwZXsT5afKkfbKVBJ3Ad1Jg7fMQMjNWaIYR
         PFEQCwk/wARGA23JG5kB5rfZhGRUWCmx81sj51kUKgPQcJIAnwmQVhPw6Opf7BmohaYB
         bMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754338; x=1696359138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qvsLwvGzwCOisYbJ9OGlCyaTg9y52X/S+//koXenxg=;
        b=canF9HzhahsD5i9WQCW9GHX7x+eIKr4+RSdq9JnnjPLSe8HjRWR/bo/uNU14Knh2kn
         UpMrbvv8l7MvEGUD8M8P9G9zNnA076PeXJgF7n1LMpXD7Y12lIN+pX8isS/epGoLqBGo
         oKCBiiX4wPY4anDFD5DloC47lm1X4eIBHvBuPONlj+Y0LWj7HuPiG61wf44P7xZPj6y+
         ZJwwd/mc/NyVAczjye9ak9RUg/7652mkipQq/tpKBM2x7vhXX9u0K1uH0gQFbn0SUgrT
         o0hx8+LItp6qoWKaR2sQl5b4Ikeo5bLiXR+YxaGjNO8XzGlQqwH9Gs3eaw6OdHMINSNR
         mpLg==
X-Gm-Message-State: AOJu0Yx85UOW0cied6D7qmQbVwpSHL9BR516l8AepPd4R7/6yzJ/+qaY
        CW5pb58Da1+ZKnAjpowYktuOrU2Obfk=
X-Google-Smtp-Source: AGHT+IFQGB0Rq4VXX/9CxyH9BfhqtG3PguPbw4FM+JuiHWjmln6e6m+XFcOl0WQXJkeMXNqW+c3zMbiGJik=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1347:b0:d81:57ba:4d7a with SMTP id
 g7-20020a056902134700b00d8157ba4d7amr61168ybu.6.1695754338107; Tue, 26 Sep
 2023 11:52:18 -0700 (PDT)
Date:   Tue, 26 Sep 2023 11:52:16 -0700
In-Reply-To: <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
Mime-Version: 1.0
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
 <xmqqsf75zxbv.fsf@gitster.g> <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
Message-ID: <owlypm24sr6n.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
From:   Linus Arver <linusa@google.com>
To:     Josh Soref <jsoref@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref <jsoref@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> > * space before `(`
>>
>> If you mean by the above that we used to say
>>
>>         ... as described below(see linkgit:git-config[1]))
>>
>> and you added a SP before "(see", that is a definite improvement.  I
>> however didn't find an example of a line that lacks SP before '('
>> that got corrected to have a SP there.
>
> I'm pretty sure that's what I meant, but I can't find the change in my
> git reflog, and I'm not quite sure how I could have made that mistake.

I too would support this sort of fix (fixing a missing space before
`(`).

WRT 2-space vs 1-space, I am not sure we need this because this is a
stylistic issue. Same thing for the commas. I am much more in favor of
changes that would actually help users find the information they need
(e.g., fixing spelling mistakes so that users who type in the correct
spelling can get the expected documentation hits).

FWIW we already have some guidelines about what is acceptable for doc
patches in SubmittingPatches:

    We currently have a liberal mixture of US and UK English norms for
    spelling and grammar, which is somewhat unfortunate.  A huge patch that
    touches the files all over the place only to correct the inconsistency
    is not welcome, though.  Potential clashes with other changes that can
    result from such a patch are not worth it.  We prefer to gradually
    reconcile the inconsistencies in favor of US English, with small and
    easily digestible patches, as a side effect of doing some other real
    work in the vicinity (e.g. rewriting a paragraph for clarity, while
    turning en_UK spelling to en_US).  Obvious typographical fixes are much
    more welcomed ("teh -> "the"), preferably submitted as independent
    patches separate from other documentation changes.

and both the 2-space vs 1-space and comma changes seem to fall into the
"not welcome" category.
