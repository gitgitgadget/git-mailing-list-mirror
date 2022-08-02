Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD59C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiHBV4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiHBV4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 17:56:04 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71871EE36
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 14:56:03 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10edfa2d57dso8043179fac.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ejoc82BSgUsEOGci34tRpOSxiqnv/s31t7kN6yoG1tY=;
        b=YNM4jX5EL8wFyjzrcysogYcWFK5XnfmhgbRPfJr6vdwi+GnX1lxzBd2SvnzKboAPUW
         wcLCvGonxnUYc6c0p8SvPGrpbGICMhEVOcFIUGjv+533mas65+ZRebCy9bH4hudBFQF1
         yCFiwPc1e7WhVf8wbTPmHTzY0VoXAS9Gdi3KKe/YucvievJnbW5qLm+8a12eP3j8bFEO
         8g2/FfdnIGOgvkM+ReugDdEARUjP7Ls7gp1upmdsuHzK83gMT8uPy+iGCJ8VExqNBZMJ
         Rl3VmSTH7FBz8n2yZ57Fy+eanc6Jxm8bOMssDrlZsubs3DI8BwtBmAX2yMs6/FhlxDv+
         DGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ejoc82BSgUsEOGci34tRpOSxiqnv/s31t7kN6yoG1tY=;
        b=Xjcl03Y12zVdme06PtYeyGCIMMZHENhQ5EnT/9pT5ALWw8q2GyU6827Pl76RKliBRK
         13o6Gai8HOyAYJ7gU4MmsXlVL5CGe+lyRpcnEeQmJG3oU94rYA7Eb9a0BI2NIXHbGjuO
         gY0Tq39EyAREJJK2N86wH2qRLpRpBVxAw/mziNEEDn8elaaNmgi/1oY9vAj3KNmciNe8
         us1ave/4slXooRW84kd0zDK2tHmon6nAzga9j08k/mNtlpjE89vZ47yqqYT04989yacf
         d4NlU4w36BpBfYi0KNz42wnpc/m0gK/hpFeI3UCPKZY+PtNxycB3sj5ths/42z4x/p4k
         LbrA==
X-Gm-Message-State: ACgBeo2olFSU4C3LRXv1UPeQq9FPip4cuIY0ZL9q1qmpDXDgDPU6J1Y/
        6kyv65zPeMtqGt0HafLiKTexFmDAL4E+MaR3DiD4xA==
X-Google-Smtp-Source: AA6agR51fIcXaw7k4Rh1TyJ+5y6mx4bflGtp3ZXrOiSb101L/1nnmIVarHKhEO73RY4l3OefVe6I38pQnMpg2337IXY=
X-Received: by 2002:a05:6870:2191:b0:10e:75b6:fc3a with SMTP id
 l17-20020a056870219100b0010e75b6fc3amr627393oae.236.1659477362776; Tue, 02
 Aug 2022 14:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210020.3397249-1-calvinwan@google.com>
 <20220728211221.2913928-1-calvinwan@google.com> <xmqqpmhjjwo9.fsf@gitster.g>
 <CAFySSZCEWX22h1FBX65=eofNm+WU97DtL7P+11WFie72DQLDkg@mail.gmail.com> <xmqqo7x2fj05.fsf@gitster.g>
In-Reply-To: <xmqqo7x2fj05.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 2 Aug 2022 14:55:51 -0700
Message-ID: <CAFySSZA2FzUfN94Gr6a_470GzjeT7V1zqHrdBe6YUQ0Tv3pdvg@mail.gmail.com>
Subject: Re: [PATCH v7] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm starting to think this is getting out of scope for my patch.
For the errors, "not checked out" and "commits not present",
I will have a NEEDSWORK bit attached to them in
print_submodule_conflict(), and if any of the submodules has
those errors, then my message won't print out. That way,
we are guaranteed to have 'a' checked out when my message
prints, rendering it redundant.
