Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C1C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 04:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiGAEe7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 1 Jul 2022 00:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGAEe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 00:34:57 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CE65D47
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:34:55 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id d5so2067139yba.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LIGFuSzZ9aFajrz7/WrL9+La3Q+G1OzGv7k2NXCT4RI=;
        b=c9DkM33VVWJvAxfVKYJPXc11nomY32mtsTAeeQesXN9zLntKbu7ELdE73W7xMim+52
         JQx/58QWbEeH7XGQ9+4LRkPpWK92FV3e5Kxi10JvYn/eFLclnvPC+mI/YeMokwfIzyxn
         BCLmWkDqAgeFTIq358Qn1tUcbqr70jcM9b5BKI2hu+KS9HM3W/qRyo9XI6UomMOj1N75
         brEGs2bSEQ09tXPgqBSFlpAgfEzZZ8I4KWkFOxtSqwJCRRMKJ2HChbJeOGltdrM9pt6Z
         VgAfqF9Pjsvc0YZs1PpZeDKBK8PPmUZpJfTSB3nNNCTu5NRDyVEG6wlevJhZwW+2wlxM
         XeaA==
X-Gm-Message-State: AJIora9WfPXooDrJNqaXaVHa/QLF6Xbhd/+baqZyEVR8Q25a4/kOzpMl
        jP7IIx6k8zSsS39wk5kXYvKaeHlmxL8Xy3ono+I7Q241ePY=
X-Google-Smtp-Source: AGRyM1tsdoGjdJOyvE3QvkkFopohRHEHs/Ok2JO6TCLxIcCw5muxFTB8C0v4a8AA0LLx8/buWCERfc2Ih2Xmyi00nFk=
X-Received: by 2002:a05:6902:1d0:b0:668:b5ea:10ec with SMTP id
 u16-20020a05690201d000b00668b5ea10ecmr13395110ybh.419.1656650094284; Thu, 30
 Jun 2022 21:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <patch-7.9-bdb467d1414-20220630T180129Z-avarab@gmail.com>
In-Reply-To: <patch-7.9-bdb467d1414-20220630T180129Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Jul 2022 00:34:43 -0400
Message-ID: <CAPig+cQeR6Ku-RCEa6qvrzq7wF+cSDYRUREofwDTeYNB-iw7JQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] test-tool bloom: fix a memory leak
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 7:51 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> test-tool bloom: fix a memory leak
>
> Fix memory leaks introduced with these tests in f1294eaf7fb (bloom.c:

pure nit: the subject talks about a single leak but the message body
talks about multiple leaks.

> introduce core Bloom filter constructs, 2020-03-30), as a result we
> can mark almost the entirety of t0095-bloom.sh as passing with
> SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true", there's still an
> unrelated memory leak in "git commit" in one of the tests, let's skip
> that one under SANITIZE_LEAK for now.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
