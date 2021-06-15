Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F68C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 04:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3B8613BF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 04:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhFOEVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOEVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 00:21:53 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE8C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 21:19:48 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l12so9126177oig.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 21:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nXseMigI/mAF9lE2d+6aRgDznAxiI8mq3n20yhoEJgs=;
        b=kTQYqPSbk+nWU//YwdFTPbb67D7GyCSw8QMePGQ2wLuqDbV3JlgTyxpAKPPt8cr1H2
         OptsJyWSn18BObrcM5QC+FA0x45clspy58Sm5E3cOspsDPCjUhIOudWygrlTvBK6EVU8
         HIHqzvJzhVdwuydx/mU5c3IHXb2eUrFMxZvjWdLJQN+MBkDBzU6XymUTrmWov5NdkWFE
         ap1XYZBi7C4dVG5m59EWIBjAcOchbtJNweF3F7z5mlchefD0WpdQt82LAzUcUZ43uVOu
         DUBO8S8fmbQoJIfSHWzY6dimYbq79pWx412Yk7Z4h1NZXRCak3tQa4ZPs6qXLrwoVP60
         MzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nXseMigI/mAF9lE2d+6aRgDznAxiI8mq3n20yhoEJgs=;
        b=muDPoyzVTR11TSOMcoGy1xAO09qdJE9vFovJyfo2ZSErAXqAJnH+Qe1r1PrxY/G4VZ
         Q0QLUybdna4R9laOlMRcwDu1zY+63cjB+TB+dAIlEMIhYpb0FHTDbXkD2Uz1g9u7z66O
         ekr0Ea4zkHP7ppA45uSsDig3eFFFq+GNR8yBzOVQKvIZApA1FEKhgsp/bLULeQWCswqg
         aQJADu/CZLTTMytQX90g+RVeRKQgzhZE7SGWrIJ9vopZv2pz4iWgbMAyOm3AvJJqtwNe
         sQFJO2KIqAjJDBioWWvM3ayAN4qKnXii6KUYqKau/MH3rAO5b3GhPOYI4ri34H4lyHjf
         VqOg==
X-Gm-Message-State: AOAM533HUnNdFpY7+qshK5dq/jzpEgylgeOqDkIp6Ub6qDOEuiYq5gXO
        s7Pzl+xLGkoq3Qlx6T1+zkJ6aQeXqOq+nw==
X-Google-Smtp-Source: ABdhPJxNQNWXkCYHWurEzjQzyQlE9gnEXPtRGCRW5J33VyO/fYPVKEtVSQ6EpvGPlT+j/aju/LHBhQ==
X-Received: by 2002:aca:407:: with SMTP id 7mr1684178oie.22.1623730788048;
        Mon, 14 Jun 2021 21:19:48 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v1sm1408832ota.22.2021.06.14.21.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 21:19:47 -0700 (PDT)
Date:   Mon, 14 Jun 2021 23:19:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <60c82a622ae66_e5292087f@natae.notmuch>
In-Reply-To: <YMbexfeUG78yBix4@coredump.intra.peff.net>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
 <YMbexfeUG78yBix4@coredump.intra.peff.net>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sun, Jun 13, 2021 at 01:00:33PM -0500, Felipe Contreras wrote:
> 
> > > > I'm re-sending this patch from 2013 because I do think it provides value
> > > > and we might want to make it the default.
> > > 
> > > I take it you didn't investigate the segfault I mentioned.
> > 
> > I don't know how I was supposed to investigate the few segfaults you
> > mentioned. All you said is that you never tracked the bug.
> 
> My point is that if you are going to repost a patch that has known
> problems,

It was not known that it had problems.

That fact that person X said patch Y had a problem doesn't necessarily
mean that patch Y has a problem.

  1. The problem in the past might not apply in the present
  2. The problem X person had might be specific to his/her setup
  3. The problem might be due a combination of patches, not the patch
     itself

Plus many others.

A logical person sees evidence for what it is, and the only thing that
person X saying patch Y had a problem means, is that person X said patch
Y had a problem.

-- 
Felipe Contreras
