Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61894C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16CD21941
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpoh7d4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIJSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIJSKp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 14:10:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B8CC061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 11:10:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm21so404539pjb.4
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hCaNyhXCRFKX0f1EuFwxR69kdcARhmWGVUeO37pfNR4=;
        b=Jpoh7d4E6bl7+hIkQvGvPADN/SX3PX973s2V+mdpl/aasmIPnzmofn95LWDG2nh/ZQ
         JiOZX01HG6O3a61sr3j72IMkSrCSP9Fjkq4JGnO0n24rlq/Sh84fnSxxcS9PrDZtJcqa
         MbOfcltuAGm93923MYJ7cpA5MVbtwJG5dFWXmKI7qPEpP+Gp8Y+oPcrkfxcdBD0CKan1
         N6+NZHQr4SjjD+9mZ98gv7CHdsi87WhPhU0P6rbQshYPpVyu+sOJ+ZLKex1PslVLIBDo
         daUJ/BZVtEj2Bzh5NGrTP1NEggZUwPEK1EHfK+pITu1xfFO8mNvPHykZ5XGjoMVX71P4
         uqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hCaNyhXCRFKX0f1EuFwxR69kdcARhmWGVUeO37pfNR4=;
        b=KGMxKylNz9EF2LX4nFYluEyf565pzPKx0iv3fICz4eytUsQHc9QLfdOSAu9q2cETKO
         f1+b8MfbxhBKQNVL8o5NuBGEklZjfpAN4SszXZfh7jme2KrE9gZswyET5N7YBjXdSujX
         IhIkUI5Xh/MJAiYl+jzptrjtLliK1HQt4uD9NAL/k3AmMl3kTdNIWG0ojnAxq3zwZjV5
         o/q/iMgo1gWiZNXcUq+PKvfZotjTCpgYsORl2CPBX6802qzj2/8x382jjqPCiMmeDAyR
         eHxRAvkAmDkJjbJiVNdgFxcB8Uk8oXvS8ORxHcmlXPFECj13T1zaEeB1Yuz3PrbaXyUB
         eCrw==
X-Gm-Message-State: AOAM531wP3e9L3/N5nvjL2trac7kY7j3SINGVh8eeIB0DMIP7W7dnZaZ
        KYJ8dC3ODskLr0eqHkZqFWd5FLG/u32aGI9t2LyfA0g20Km8Ow==
X-Google-Smtp-Source: ABdhPJx+lhT/MPFrc19CdTstMsCgIVCiXLkwq4Mz+2XHTk0zjeJaODtLsRjTcpXutlZLDCXXCfdpjWyU0y6njPCAEkc=
X-Received: by 2002:a17:90b:110a:: with SMTP id gi10mr1108327pjb.206.1599761444175;
 Thu, 10 Sep 2020 11:10:44 -0700 (PDT)
MIME-Version: 1.0
From:   Hans Henrik Bergan <divinity76@gmail.com>
Date:   Thu, 10 Sep 2020 20:10:32 +0200
Message-ID: <CAJmy8YF7GpTO08DEShj9L+HuC0bBar75MZyL_vu99YDOO7kKmA@mail.gmail.com>
Subject: "--color-moved" ignored in "git diff --word-diff=porcelain --color-moved"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

using git 2.28.0, and when doing >>>git diff --color-moved
--word-diff=porcelain lines.txt<<<
the --color-moved argument seems to be completely ignored, and seems
there's no way to differentiate moved lines from added/deleted lines
in the output, is that intended? if the 2 arguments are incompatible,
wouldn't it be better to throw an error? or at least print a warning
in stderr? instead of just ignoring one of the arguments?
