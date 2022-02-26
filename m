Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877A1C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 03:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiBZD6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 22:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiBZD62 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 22:58:28 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706E5E0B1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 19:57:55 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 75so6380085pgb.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 19:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edr72QjW2EjiCVALeTYzfh8TjmYuMWLDKzd6Fk0pG40=;
        b=MMAaYd7osARQaVzu0eCaPIeF4ivywXENNjbXyiAax7fXxr+RR2ujRmW/ishtT+f1re
         y8aYS0HsHF+5BWHqj0APmezDR1l+TPFPlWGXJcbWn6216uqZl+IuQBB17znxPNssYmuJ
         ZWNJzYqkwvT+wJkjXzaa29IxtoDHKIodgx4m84Ts67LdHp/LKWUQ5DYm+dmooJRlzM8p
         Ui5hnWomzYie3/VjU2okCV0uWId2naRIiTyeaSC7e61B1z/eUWPeAhHuV3wak9nLBhN8
         Pf87qeW9PNOga3BwiloB72lk2IK2hKUgWLoX9WgZBqDW1SqmtbDHNRLRb+d9LnyTaPz8
         ntlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edr72QjW2EjiCVALeTYzfh8TjmYuMWLDKzd6Fk0pG40=;
        b=XTp4H6rFpYxJ+yCd9PR7KrPThA9c8tVW4BVNRJhR6eKEhEDSc58V8Cizc9EnLFytA8
         0ciED3IFnF1hnoFYl457DrSPNC4KVOnNmEXlRjm4XygdCbWqbX1XPIiBXFVnJoXJY+eS
         twaPd1yuqbJFcjFvjg99cfrBA81X3LvmON6qsTDPn9AOjJyPIgU5xU43tIFLh3VuQ0DJ
         ggQSt8GoycX89F5pANGsQvd5mfDh6ScPJD+A+UQN/5G45EWzWN3XT5o7CLUp7/0EMKeL
         GAigdS+tst8QKBNAUr3n8zpujD4yysUNI5XCUUaK0Nt1HVh4+/BviJsPQcs1sySr1eTH
         gYtQ==
X-Gm-Message-State: AOAM530AHy8fKs058JNDSmsVgp9ZPkCPRI2KMawc244T8/DhUSrjTDU3
        xDHZb9qEESoSj4z3Qc0AIXQ=
X-Google-Smtp-Source: ABdhPJwPDdHOH3oc8N0TA82OmBzhJ6sMIv9lWchwyg8Dr7VPAOrf9s3OqORSny9c2SULHvlqMQCRuQ==
X-Received: by 2002:a63:f057:0:b0:370:23c6:dda with SMTP id s23-20020a63f057000000b0037023c60ddamr8810837pgj.504.1645847874736;
        Fri, 25 Feb 2022 19:57:54 -0800 (PST)
Received: from localhost.localdomain ([202.142.80.180])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a00238600b004e1906b3bb2sm5008485pfc.12.2022.02.25.19.57.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Feb 2022 19:57:54 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Julia Lawall <julia.lawall@inria.fr>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Sat, 26 Feb 2022 09:27:21 +0530
Message-Id: <20220226035721.1219-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqo82ug9jx.fsf@gitster.g>
References: <xmqqo82ug9jx.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> wrote:

> Sorry that I've given you a trick question, when I know you are
> quite new to the community.

There is nothing to say `sorry`. Every review comment is teaching me
new things. E.g. If you didn't ask me this question, I would not go to
the codebase and see the proper handling of `xstrfmt`. So, thanks.

> I think the right answer to "Do we care?" is "In this case, because
> we are about to call exit(), we don't care.  The extra complexity
> and code necessary to retain the memory we get from xstrfmt and free
> it is not worth it."  It's not like we do this in a loop that iterates
> unbounded number of times before the exit() happens (in which case
> we should care).
>
> Thanks.

Got it.

Thanks :)
