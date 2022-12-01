Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78DDC4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiLAWpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiLAWpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:45:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707B2654C
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:45:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k7so3032876pll.6
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 14:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLumxDwNQdCESVkZA6mdWnmKkFhGXuUFOUDG9vPML2s=;
        b=eweA4SzgBE/xk09dowPsTNrMkDgem9Bn7GJW/NHQGaW8VW/eE+fg+GNxVhJ3ylBM3b
         1YdCUZ5GIKxghb0xT3d+oixlmLPcGmweOJjqOqOhWIHZAeQBVkG15AERtu2JuxDD2j1E
         ocJfT+uuwufMjqqo8GQ0LqewnUW16DBg4HvOW9qWU7Ll0h5+ih3Ts17j7bVtQfKYO7og
         3byqSjiaHrr8m9U250qclxYhipKqOHQMAmnfWBfF/OXcw0F9fVSHbIrFwX8WL1fvGAuQ
         jIkvtFF5yU2k8e+WJQkelxoBP/z7DaqUetYRn5T0SpbzTVDlY4XY6lljoNdXqnrbP5bB
         yk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLumxDwNQdCESVkZA6mdWnmKkFhGXuUFOUDG9vPML2s=;
        b=YNpXyI5n1c3pNssRwZstuW+6IntmeuNM9jHhFCebsNNrQj0gOzvi9X9ByA2ooqFfv1
         DmUc3MqFualpaHccQcldidzLDyCjVmqinwSV77qdnB3nUU1R063BFvLf/mJn/4uRvUzq
         WrKkuC/ckwOdgJKLiEVJCJNCHGcT5a3lWZvGLb4RM/jD5kS2SafOorwwEJ+LRsfoMFRj
         PMCT7TI9F8xAJfJVD7hoRvKS50Scs8V9DAcyHaac7hwCnHMfBEoYwDxnmnQiavSxvyTx
         GpgilVhNZQwSkmXyicabCpNCWRJSbG2h+c8TUAro6rU/hJIsfCKuZM/9xkzzsFWAlRT5
         kKzg==
X-Gm-Message-State: ANoB5pn7n2jFb4MMdYdLgWIISshLp8pRm69MdPf3BpTrWVjaFMTYg+7x
        qhXrtQ547wTqt3ChWJWi+iw=
X-Google-Smtp-Source: AA0mqf7u1XG0h10JPHNsWsY9lQcM8YX5GQaU8D2qQjaTFET1WrjFrcJ/w+vkL3a0N9Cv3yx6rtET/g==
X-Received: by 2002:a17:90b:3444:b0:214:e1:cabe with SMTP id lj4-20020a17090b344400b0021400e1cabemr50780413pjb.153.1669934748409;
        Thu, 01 Dec 2022 14:45:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s29-20020aa78bdd000000b005749f5d9d07sm3856909pfd.99.2022.12.01.14.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:45:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9] status: modernize git-status "slow untracked files"
 advice
References: <pull.1384.v8.git.1669154823035.gitgitgadget@gmail.com>
        <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com>
        <xmqq4juftyan.fsf@gitster.g>
        <CANaDLWLdkaJs96KTBA2B-h+Ei+f7ayS-gvvN06Y4T7w=GgPGrg@mail.gmail.com>
Date:   Fri, 02 Dec 2022 07:45:47 +0900
In-Reply-To: <CANaDLWLdkaJs96KTBA2B-h+Ei+f7ayS-gvvN06Y4T7w=GgPGrg@mail.gmail.com>
        (Rudy Rigot's message of "Thu, 1 Dec 2022 09:16:46 -0600")
Message-ID: <xmqqedtispyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rudy Rigot <rudy.rigot@gmail.com> writes:

>> (I thought you were going to update the proposed
>> log message, too, though)
>
> Oh, I'm sorry, what do you mean by updating the proposed log message?
> I'm looking back at past feedback, and I can't seem to match it to an
> unaddressed one. It was not intentional, so I would be very glad to
> fix it if you'd like, I'll gladly leave it up to you.
>
> Thanks a lot!

I was referring to this part:

>> ... I don't think it provides compellingly more information
>> for end users, compared to just mentioning time, so I'll simplify with
>> your proposal here.

in

    https://lore.kernel.org/git/CANaDLW+ukK2GU7NzkCvXVNc9DX3_93Pp+PHq-WcLpRJizPidVA@mail.gmail.com/

you sent earlier.

No big deal, and thanks for working on this.


