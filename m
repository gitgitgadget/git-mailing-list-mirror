Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B946C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 00:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9E461037
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 00:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhKLAEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhKLAEc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 19:04:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B949C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 16:01:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y124-20020a623282000000b0047a09271e49so4683003pfy.16
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 16:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VCuJCbgz6Magdr+FNmEjPG8Sr2SSNtf2ozXPJmm93Bo=;
        b=ry5nC5CeUalvz91+1fq6BF++S5+4vdWTm/+zQVJT3Ne60qgalXO6PKgxGcIX10Zt+s
         HwPM9z6gaL97kcWEr0RvhBXLY8Xpm8EwcSRpKKzRPKDwuKuNHOx5haomVvByJuxZ5LHM
         N4hIlujzCSeUkPpLCtEGcPgtfmuMQ4G8InyzBG/OrdqjwvPHpDYfeT9NIH33LCG/Ya8J
         Aguv6A7r9o63OSPKjbIPEiojuDYf4OSY0TqAYeuTwvQpi7o+sDz0PxCok4BcKdBDsytS
         lA9OEra7lT3l3IwXYypipwmp+Y18r8MkQgsq/8xWN/pFjCV9gcLr0xwVBEBLAiu5WSGB
         n5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VCuJCbgz6Magdr+FNmEjPG8Sr2SSNtf2ozXPJmm93Bo=;
        b=HFcNaVWfn4X4+QKTy5ZmFTAklYXVOu/KBpkX0Zi8HXVn3S/sQ9tg3KBzXtGfJHmx5x
         yJ2w/Dy2Zx8c3Nj6E4IX6/oPmyBxgLautyYqnUhrezOqHseyn/wXhmR9QSVbpm/aUbiF
         NxEG9468bht4s4O6u8C/GUju3NiyMVRZtHXsMmfN4PdY4ai/hOUGSMpDGnUonL+Nq5/S
         rU/SzSi898E41kiB40PKsOJaMNWA9fZ0IuidH75QwFIXRusJ5nAKbhyx0RIbON1Vgc3U
         NrrFnIPwnjeSb8s+a0b7js0cX8VgD+tpfLQdQmsMVM2SeI+BVBPAIymkzX6A9z7cMoAD
         Di7g==
X-Gm-Message-State: AOAM532/eeWlHkscPsB2ojUuCrM96f3kB47b/ZgF0SextxsA19YmXpPw
        u6A0yG5vFLOzeIHMtjVNM5L+CFmKTkTxJx/feohGR1f4/gLs4xKPu3TR8X2zBE28lillXX/SLoE
        2SLIOYDHd4HQFnja1O2Ka3n3t+4W9dRZH2dL9u3eTkOLmYKi8xRP9O+zFvPjXs9o=
X-Google-Smtp-Source: ABdhPJyoXasL8vz0wsis+spXS2hBoIqpbOkijfg7H+bgMZ/YwnyAgofe+aQZSSsThFOXi+u/KQs06ZYIP05OZg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2288:b0:141:e76d:1b16 with SMTP
 id b8-20020a170903228800b00141e76d1b16mr3158537plh.21.1636675301954; Thu, 11
 Nov 2021 16:01:41 -0800 (PST)
Date:   Thu, 11 Nov 2021 16:01:40 -0800
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <kl6ly25utf6j.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
Subject: Re: [PATCH v4 0/6] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi everyone! I'd appreciate thoughts on the design presented here. I
think Junio and I have explored a good part of the short-term design
space, but it would be great for others to chime in - as Junio mentioned
in [1], this series isn't exactly sufficiently reviewed yet.

For whoever is taking a look, here are some pieces that may be worth
paying special attention to:

* [2] Junio expresses concern that struct branch depends on struct
  repository and accepting both of them as parameters might be unsafe. A
  back pointer from branch->repository might solve this.
  
* [3] Glen and Junio discover that branch_get() can accept NULL and return
  NULL. accepting NULL means "give me the current branch", returning
  NULL means "detached HEAD".
  
* [4] Glen questions the design of the current API and wonders what an
  optimal API might look like. Junio and Glen agree that we can remove
  global variables now and rethink the API later.
  

[1] https://lore.kernel.org/git/xmqqlf1ujo4g.fsf@gitster.g/
[2] https://lore.kernel.org/git/xmqqr1cnbgmw.fsf@gitster.g/
[3] https://lore.kernel.org/git/xmqqzgqwzvwx.fsf@gitster.g/
[4] https://lore.kernel.org/git/kl6l35om9wn9.fsf@chooglen-macbookpro.roam.corp.google.com/
