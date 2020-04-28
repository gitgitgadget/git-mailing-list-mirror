Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E9C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 06:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7082F206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 06:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmqBiANU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD1Gws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgD1Gwr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 02:52:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49888C03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 23:52:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k8so16345649ejv.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 23:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nUtTVIHRD94oD87sSmcQdp20b6D5/zbiYTmjO5OuHIo=;
        b=OmqBiANUITS1cOiTdQECEZqiOnZu1X8U0hjrteVQ6dYVlJ+6XRsVI8V1NmrIkV8SfW
         nUDDsTSa0YQAzhRHmGnNazIJGcdp+uH0Q8LKarZhViuSTS6RKi/1qEyFyiUCMtrM2Vsp
         wgWMASfQABhF7h1nixM/lgbl/26UEt2nNGXu2ysEuWkBOHQzjdDeG4aOTm+gcwvdEIB9
         B1dbOmKc2hU00m6ueoVJHZdF8HbDY19bIA8877gUcznF9moUkauTqjedbUDNkQFGOeIT
         Rv/xQPC+oDwGn1IlBEJ1VnpF1Z7vBgffYihKw3aE/GxNoHcfYMFL3ivDSdaDj2itjNhN
         3TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nUtTVIHRD94oD87sSmcQdp20b6D5/zbiYTmjO5OuHIo=;
        b=A4mOelfDHOoVT1PJdIcaUZ1UsTeFtnFOUf3razaegaOJniFZon12XeAi/tgzLhvpNB
         hZi9BcPV1GSVhmg6DPcuL/2bno4uUmHap2xw5IEivewuddHBI728k0WG+72ngG1VBN3T
         O6tWPrrUA187of+OBNpmSHM6HPEDulsicmoWLYYPTMMX+mpqTVzyDtclSdZo9WwbVi63
         NL956CRJf67DRWV4/Vco+Lw0+pb6B0sxDHFmrfZJ1NMhE+b6LUo2R1ofrKIX8jylzEwL
         nT2e4hPyJYaYfTtmCSLLLB7j7G+KjC+RFy+tm+9y2iJd0nb30kS/vOmy08o3c3E1CAQy
         LrIA==
X-Gm-Message-State: AGi0PuYWLgkQ2ukYR3bAxt5LjihjEiyaZk/tHLd2vVlmSQp0SITgUCZT
        jdTIdncT8y8rdcShKHaVUuc2UaDMrSroBzzu/m9oaGNM4Ys/bQ==
X-Google-Smtp-Source: APiQypKy+W8g/c8Y9iwLbyP+Sxc6pgQT1/9bS69+R734nAgve95+46Zc7ZQeDc98J/MNfRk0gq4D220snU26G99/VqA=
X-Received: by 2002:a17:906:2488:: with SMTP id e8mr23253754ejb.157.1588056764747;
 Mon, 27 Apr 2020 23:52:44 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Tue, 28 Apr 2020 08:52:34 +0200
Message-ID: <CAL3xRKc6Q1m=9XJYcafhczCU+ONYjapkUgBi0nKMFoMr+bgjYg@mail.gmail.com>
Subject: t0000 failed
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks,

Running t0000 with GIT_TEST_FAIL_PREREQS=true is failing.

> GIT_TEST_FAIL_PREREQS=true ./t0000-basic.sh
t/./t0000-basic.sh:836: error: not ok 45 - lazy prereqs do not turn off tracing
#
#               run_sub_test_lib_test lazy-prereq-and-tracing
 'lazy prereqs and -x' -v -x <<-\EOF &&
#               test_lazy_prereq LAZY true
#
#               test_expect_success lazy 'test_have_prereq LAZY && echo trace'
#
#               test_done
#               EOF
#
#               grep 'echo trace' lazy-prereq-and-tracing/err
#

This was added recently with
https://public-inbox.org/git/f35830c0eba216b7b4f144409e302a87ff8b5c06.1585236929.git.gitgitgadget@gmail.com/
Is this intended?

Cheers,
Son Luong.
