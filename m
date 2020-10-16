Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4F2C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74AB820EDD
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 19:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEqn/fVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393127AbgJPT3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393124AbgJPT3j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 15:29:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D23C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:29:39 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t77so3697858oie.4
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 12:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DKsfCbytzW+GvhtTlxHwwViif+H6euzgVGvwalb+3y8=;
        b=eEqn/fVwh/SCoqPlmkgG0oxKzEEb5jX8zLcF6sl1rMcjY9elIWaN33aDeR6RLjG9DT
         9/T1++jSKviVV5iQy30wnbMxpy5VDhkaeIadFe39kNfGIfyfVAi/JJoh7OOVuXXZ2/VZ
         tPnpagrfK3wPMrVQK72vVrwh1U7lbp4DYWRjjtiYnMWQPaX34VyUHTwq6A4L1GQv8Ib2
         j2v/iE0jDWwlYs99GhCmwVAg60WN9d2kNZOpigf/hzAQsMMN0I6hAkMd7ZNIpwMoTVUM
         3idCNGVrkDRls2eZ6OyzaST6zAC1hjV3czu9BvDMi/vra6ydWzOfzUPYnDqfo46L8J2y
         hd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DKsfCbytzW+GvhtTlxHwwViif+H6euzgVGvwalb+3y8=;
        b=Ox/6ltipI5CRWHIJw1dzZkGnzRbDEyZQfo1S7+Ky4EZJDf4SuQIY4TVv0OnVXEKQm2
         X+xaZGiwEgcXbZ/e/gcFb4gkejYdfkbI2S6sAumQ3ApYwHAhqtlBP491njOPcM3QuAa9
         AIK6nIavF0y7f9ayxUHVXsOHLCLjbm89E50FdAdgrhensK13oHXmBGiZM32kdJ2CWLpg
         S71tU4ud9Ye5145cDHRABC5C/J3dGMFFKBg46IdLIUxCQn2q4TTAIQKGeTWz7HNmkLBV
         vZ76gHqNEDHEBQ7vUG4uxdOKP8mofBVzNdLs4NzAeX9VegrmDbELe80BcHPnH8J+zs+2
         G7hw==
X-Gm-Message-State: AOAM5325loT0W0baTMneDiKj/qIyj8cViT9ec626F28v20RtRTfEVTLT
        xeQO0V6oTwC7Q23MQb4SYEEBxxBF5ib9mksBaMyYBqqsdBxmDw==
X-Google-Smtp-Source: ABdhPJyB3NOE5uXnicdWl7exdDbfN50FwTwxdzN7/XODlphpIXkYddH4btVHhOGyY47sVljXrV5Lv3p7al/19CsRtBg=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr3694762oia.167.1602876578362;
 Fri, 16 Oct 2020 12:29:38 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Oct 2020 12:29:26 -0700
Message-ID: <CABPp-BHQK-AtAJa6V1mtu6_jq3oeUeL_0p00RCRNA6Jw3DpJSg@mail.gmail.com>
Subject: Funny test flake failure: t7518-ident-corner-cases.sh, test 1
To:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On my update to my test-selection series, where I simply added more
text to t/README, I saw a failure in the GitHub Actions testing
despite the same series having previously passed without that extra
text.  The extra text was unrelated; the failure is due to unsafe
environment assumptions (though ones I probably would have made
too...).  See the actual output here:

https://github.com/git/git/pull/878/checks?check_run_id=1266009463

The issue comes from this test code:

       (
               sane_unset GIT_AUTHOR_EMAIL &&
               GIT_AUTHOR_NAME= &&
               test_must_fail git commit --allow-empty -m foo 2>err &&
               test_i18ngrep ! null err
       )

The last line expects 'null' to NOT be found in err, unfortunately,
the file err contained the line:

fatal: empty ident name (for
<runner@fv-az128-670.gcliasfzo2nullsdbrimjtbyhg.cx.internal.cloudapp.net>)
not allowed
218

Note that 'null' appears as a substring of the domain name, found
within 'gcliasfzo2nullsdbrimjtbyhg'.


This testcase was introduced in commit 862e80a413 ("ident: handle NULL
email when complaining of empty name", 2017-02-23), and the reason for
the check appears in a comment above the test:

+# confirm that we do not segfault _and_ that we do not say "(null)", as
+# glibc systems will quietly handle our NULL pointer

Should we tighten the test to check for "(null)" instead of "null", or
should we do something else?  Or just ignore it as it is somewhat
unlikely that anyone ever hits this flake again?
