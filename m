Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403AC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 01:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLIBJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLIBJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 20:09:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F434A505E
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 17:09:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so2534773pgh.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 17:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/xIvWUTu3Ma9v1Io6AA87owysMg7wSc0ehrJU3JhYc=;
        b=Kv+Ml4rLG6xj07TiDiJJfP7i++TdCNWmxc0q9LBy14Hnk7E6M4tlY/YZ22wPBxpo4C
         NnYfWbSb3mJOHJlCacKbdha5UbNN9VcGMMaKQWNbrgT603Bcx2Cj0AmdeL6P9jvttpst
         iO57AVRKHRPTM8+PD52iwOnzaV/nPRDSE/zYaEEj7882R5+4smeBc1z0mhuH9MfB0VwE
         tAfT1HADzvrw3h7MYB8r4XPAsoZlltxz+tUFfvNYi0cC1/0cIXwzbozkaUXTnT3SY4CX
         /YlavTi+S3PsORreCWO7uXDZbOjhVbvG0oNyaSMOMPFwlX5oDnqvAeAZJTpOge5I/W0P
         uMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2/xIvWUTu3Ma9v1Io6AA87owysMg7wSc0ehrJU3JhYc=;
        b=rfYIa07Flglbqqf59f+pLYpFsYOCYHBpB8izbRiwoihPxmMdwAjDIk16A+g9Xyl+Gj
         y0uWgm9sfPxrb1o035sGtmuqTQ1HV+Vk/R/mHUt3CbVL+4BPyYpK03rZGk8DPDpsWULR
         aYWF5dYRVrJEZgX61laxMkr4cXEh6nrH33nf8+c3PApmWhF/sUPlEee76GuQPqAKMXjG
         eqrxk1dD+iwmGkOjNGZmNBG9z8chuIwmgq3MfjmrVFB/B4wyq0G9rfMq25V9GTVwOSt7
         +FLnqvI8L7wGe2xJVUrUj5U3KDlMv+jbPAuiRGt8PdsZGQzB48w7NdbXqUzUgAzr0X0c
         SxdA==
X-Gm-Message-State: ANoB5pmy4W1Cln07i+BCKLkvizW4WZPKfGrowiMfKu6uGZWRJDZazLjD
        PO4X6HRL94AzzN1hnCd2gDeCJtpjnWYuOg==
X-Google-Smtp-Source: AA0mqf6rNalVdiUa9AWltSN0cQeNa8VWMaFnUhg3XMfPt+JTlI7Os+f4AZSmTET5EBjXgp+cToyiWw==
X-Received: by 2002:aa7:8807:0:b0:566:900d:6398 with SMTP id c7-20020aa78807000000b00566900d6398mr3355471pfo.24.1670548144624;
        Thu, 08 Dec 2022 17:09:04 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c197-20020a624ece000000b005745788f44csm108429pfb.124.2022.12.08.17.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:09:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
        <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
        <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
        <1b5fc712-9659-1bd6-493c-197b003d21d6@dunelm.org.uk>
Date:   Fri, 09 Dec 2022 10:09:03 +0900
In-Reply-To: <1b5fc712-9659-1bd6-493c-197b003d21d6@dunelm.org.uk> (Phillip
        Wood's message of "Thu, 8 Dec 2022 15:06:36 +0000")
Message-ID: <xmqqedt92xjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I added the restrictions to 'test_todo' to try and stop it being
> misused but I'm happy to relax them if needed. I'm keen that test_todo
> is able to distinguish between an expected failure and a failure due
> to the wrapped command being misused e.g. 'test_todo grep
> --invalid-option' should report an error.

Hmm, but it is not useful if the failure is from "you cannot use the
system command grep with test_todo", as the (implicitly) encouraged
"fix" the developer who wrote the test would pick would be to use
"! grep --invalid-option" which would still fail for a wrong reason.

If a "git" command is expected to run to a completion but is
currently broken and produces a wrong output, it would be very
useful to be able to write

	git command --args >actual &&
	test_todo grep -e "$expected_token" actual

to say "when 'git command' is fixed, the output should contains
this, but we know it currently is broken". 

> I think you've convinced be to remove the restrictions on what can be
> wrapped by 'test_todo' when I re-roll.
>
> Thanks for your thoughtful comments

Thanks.
