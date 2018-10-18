Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963621F453
	for <e@80x24.org>; Thu, 18 Oct 2018 12:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJRU1c (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 16:27:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40613 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJRU1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 16:27:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so56784wmc.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ewilc7XCbYaCQzhscTP1A1icPA4znvBG8fGE/QQQ9H4=;
        b=AGwEa8wGqfxQfStdhR1e5KYE3xfHmqVqprAiP/1ZfktCMULr6rXFBEVMesal2PV3gY
         56c2RaC0rCxpZdsffB/7rz0BhH6D/Cmsgrci34Fql2S0CCN9oBUoQQEtrsEuzLzl+F6v
         YlNg8yJtUHM2T0uORIvMTKw4asF/X4WqwAehsu+7fuGxuQo945sFIzS0W88pnUuQhxHh
         YTHnu8YBjOzEQk+eTjybnBx35HXkGpF9z7IwjGPb5A7Ucg5o22D/M7yWLHth1nKnQ0My
         aT2j4coAZb2Td2ZtfPg/YNdzGIvtoRXELTayFwe6OuFvOftJvM3W2AtrfeBAU5qkVi1B
         Na+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ewilc7XCbYaCQzhscTP1A1icPA4znvBG8fGE/QQQ9H4=;
        b=LLwC0MVCIL4zDHkLxan3lmevuZ/mE5Q54OXdslfNcHLvNxGLmq4Lp31GV6bRtv0G4d
         72HAIvtB5OYgfWqa5S+v389JAMW7gAkJXWXjPS08Txt1hscxfC8pirtw2LeLoSiI6t5b
         PRCv+eTBytsjOWtsv1qYzK+/BmjgCK1afE3A5pAG36IgZ+VZLnMwlb5N62rao1PRkN87
         RvhRun0oWt8PI2BlGpN+toiNAT1zIg4/ut1fdOonA8/cBGgi75OS4kbwJ56pgfA5Xwdd
         hZF5p0RSWfwqwrD25bcq6aVJ02LK/fl+J7arxtekFYSfLjo927SnCNL4umxQNOReCkvx
         NoHA==
X-Gm-Message-State: ABuFfogoZXxKEKsst/FfyZh8I5ZDYatlVojJEDFlhOLoPh+DsQaEBBRp
        R7eoDbBHvqz2CQ9Puivy8sA=
X-Google-Smtp-Source: ACcGV62GMeWfYqufznygV7CRGEAkZ1MskBTZu5Aj3SGAtriAxCoAzblMYZFEsgsDGWIiV1SWk4sgNw==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr84076wmd.112.1539865603082;
        Thu, 18 Oct 2018 05:26:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 63-v6sm65404wmd.5.2018.10.18.05.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 05:26:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     peff@peff.net, git@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [RFC] revision: Add --sticky-default option
References: <20181016212438.30176-1-agruenba@redhat.com>
        <20181017091215.GA2052@sigill.intra.peff.net>
        <CAHc6FU5mXL2j=jL=LqtRt30uBt8tGop350FnwK845fci-Qc=tg@mail.gmail.com>
        <20181017181350.GB28326@sigill.intra.peff.net>
        <xmqqva60uedt.fsf@gitster-ct.c.googlers.com>
        <20181018064845.GB23537@sigill.intra.peff.net>
        <xmqqlg6vu4dw.fsf@gitster-ct.c.googlers.com>
        <CAHc6FU7m=ikPyvzh0ztyOgfQjGD0oKEfGVxeRPRBy1Lh0VD+Fg@mail.gmail.com>
Date:   Thu, 18 Oct 2018 21:26:41 +0900
In-Reply-To: <CAHc6FU7m=ikPyvzh0ztyOgfQjGD0oKEfGVxeRPRBy1Lh0VD+Fg@mail.gmail.com>
        (Andreas Gruenbacher's message of "Thu, 18 Oct 2018 14:17:58 +0200")
Message-ID: <xmqq5zxz5tku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

>> >   # is --stdin a selector, too?
>> >   branches | git log --stdin --not origin/master
>
> Yes, it's a positive selector (since --not doesn't apply to --stdin).

But you should be able to do

	printf "%s\n" ^maint master | git rev-list --stdin

Replace the second one with ^master and now you have nothing but
negative.

So, no, the line is much blurrier than you would think.
