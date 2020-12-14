Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA5C2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C4222258
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 21:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407405AbgLNVlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgLNVle (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 16:41:34 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972E3C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 13:40:52 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id l207so20942123oib.4
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=dw9HKhHDXzwcqUq8G4DtGcYG9IHq3MNlZIe23p2LFcM=;
        b=e9S1g3gPvbSz/JLQRS5lb5z04xvUsfDg84srxR7SXsNgy2UqN5FDweS2YuCbqtRLNH
         CePtB4Mmb4UG3GwNDwNf1yjX7ElfNuOP1QVrZ7Dk5UwivMvFgkFwUCR8b22TF9Z/CHnw
         yCppWlAjI7n6dHkxbBtCddBmcOclepIN2ber1dju/Qs04WL0ZDGafa/m+1FR3hnXOpmX
         Qxhj7/0T6utNjz67g/OasdH4W7KqqyFDST/Gjc6CGZnVCH15/U/V9IT4wayqDuAdI3m/
         5ghyy3EqlKy3vxiPrT5mPYC9dUESv5/qRqc4HoMl2m/iGhAvb0GYqiQinJ4BI6LxUJKU
         s8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=dw9HKhHDXzwcqUq8G4DtGcYG9IHq3MNlZIe23p2LFcM=;
        b=ii5jU1bd+u9JgxY0/k/fam/ex3/YjpFfY5H2GwPlq0lFOqIE20zH/pLcyyFyDmhIM2
         Fmr6T3+pL35pJsg5RL2dpbugfO3bjNc0ZoE22d3lUfssX8vPfSJNpu75cmZMwkc7rE4K
         efcQ8yZ+4bWi9ealVgdlXFbVr6vXKOUtG43hwxn4DjUV3N9bZiHn8HN5QF0cgundqRdO
         efF3omkLnMd1ZUu3XPG5qI0/pbBzrklU/K6pBc6FnBNGND07NFYJZdS7AHzTgFM/eRQs
         eSByvp7J+2Noic49hbhjpEKS7HnxInWMNbSyhJSl46dwsZRQ02IBYZYGG9ZlXsHXf+lr
         q2NA==
X-Gm-Message-State: AOAM531PJghk7K2JElSdWVc/JPs/5yMZUPtkw6Qo2zMhpL9FSBlfIc9w
        6xZ3Wbx7lYelIfHiIY1VRlc=
X-Google-Smtp-Source: ABdhPJyi5GTKDcPwMmuij6eBhZw3XTSz5JxW6luhHWxBp5Q71A9VNzuSkavNbiD3CYgzTKRbYdPKig==
X-Received: by 2002:aca:4fd6:: with SMTP id d205mr19161825oib.34.1607982052057;
        Mon, 14 Dec 2020 13:40:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w131sm4557506oif.8.2020.12.14.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 13:40:51 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:40:49 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Message-ID: <5fd7dbe1eb26d_d5985208e1@natae.notmuch>
In-Reply-To: <xmqqo8iwje0h.fsf@gitster.c.googlers.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-4-felipe.contreras@gmail.com>
 <xmqqzh2kitn9.fsf@gitster.c.googlers.com>
 <CAMP44s0wjfZ9TeQzpJvVD-OzFA47HFd87TABiJo3Ec9H8j-fjA@mail.gmail.com>
 <xmqqa6ujj3s4.fsf@gitster.c.googlers.com>
 <xmqq1rfvgtvx.fsf@gitster.c.googlers.com>
 <5fd4e94317d67_bc1eb208da@natae.notmuch>
 <xmqqo8iwje0h.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v5 3/3] pull: display default warning only when non-ff
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
> >> The original author of this test cared that pulling c1 with --rebase
> >> into c0 succeeds, and that it does not give the error message.
> >
> > I prefer not to attempt to read minds (plus, the author might have not
> > cared that the pulling succeeds), and anyway; that's not what matters.
> > ...
> > Again, I don't particularly care to mindread what the test authors might
> > have cared about.
> 
> You do not have to read mind.  What is written in the test is clear
> enough: run "git pull --rebase . c1" into c0 and see what happens.

That is precisely my point: it is written in the test, no mindreading
neccessary.

-- 
Felipe Contreras
