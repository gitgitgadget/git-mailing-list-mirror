Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4117C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B5E2073E
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhYI41Mx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGFKUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFKUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 06:20:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A503C061794
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 03:20:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c11so22226501lfh.8
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rautANqfXId7O2IRZacUmbRESuHo642yp1bzN5Q/KSY=;
        b=AhYI41Mxu6LUbpcZ4CKrGlPH+mImhFqJq5dVNAm9R6j28oASY6++zAIzzfT/EAn5rs
         CHiEhvbHQ6hl3XsIRc01zTXdVMm0+q8mjvlaCTXatTMZlLcFrTcFPtzkYutIgtvBd5bT
         SSz2rlxbBqGGVY6VtKkoKTeqRXNhimfvcbhBk7sbw3kVQVNaVgbOopvG5ZQYk/xQC0oe
         Tc6RXwzTY4Yq71uYtbiP/hPwwmQ/5qf2lqzqtBNat0qdc4gGUxaPMShpyvpCYVnTflhY
         E86Eb5gKYyiI2iUwuaKivM/CK8Zwqe/QQM1WW4abgTObz4CyKc0Xrt2XXHAstq/wHgvZ
         EAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rautANqfXId7O2IRZacUmbRESuHo642yp1bzN5Q/KSY=;
        b=nhXCilBxtvvDwXvHrst0sRb6LUi9OGRVBK9xwAV7tewgWpRKotGKrAVzzDafUh6UxK
         FaSWE0PrCvQAamNyOG+jEMsloopJfk8E8S8vI+GvLNFp0wLI6ynIp278I9GjaA0AUcXJ
         zHRdrBF9GYzVHSaK3A8gvpraF+DZweDSnZ3/VDcvRbCiwRDUZFPXowg1iFElrnk1aWs4
         MmYDQrIqAhGuD/teM44XiicagZO4u42x5ydNRXHAj+cBaToap8XohDbneqMwW+YS1RR/
         0yoZcD6emxr4CM8v7ZSsMv+jXRyDdE3+5sE9Atyq7fR9AMHBEGoBr8kJQ3bWJSb0DV6N
         K0wQ==
X-Gm-Message-State: AOAM532VmJWOAJp4IeQ9aKjZLbhBHKBzmXKEjEwAOrFnCP1W+jkheM5l
        FpmUiO/mKOpPxqTlFfGYt1a4eXCBGco4jC3j9kh/aRAzuwI=
X-Google-Smtp-Source: ABdhPJzMO2/AO+aYorMPT9YL0dvldgpnlXDfOLhS5EWaS529nnbMtDN+bdNqd2Ec5U6+fXC/LXiZmv2hC8VMR+Mts40=
X-Received: by 2002:a19:8806:: with SMTP id k6mr29258783lfd.189.1594030807351;
 Mon, 06 Jul 2020 03:20:07 -0700 (PDT)
MIME-Version: 1.0
From:   4dr14n31t0r Th3 G4m3r <4dr14n31t0r@gmail.com>
Date:   Mon, 6 Jul 2020 12:19:54 +0200
Message-ID: <CAOKK28C4-3-+rxcggYdYuzuxNqdstA8BfJtY63KkHF=iZ+soxg@mail.gmail.com>
Subject: Feature Request: Add 'active' configuration to .gitmodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are cases in which reading the 'active' config from the
.gitmodules file can be useful. For instance, if you are working in a
feature branch in the superproject and that feature requires some
submodules to be active, it is redundant to each time any new
developer that checks out this feature branch to also mark as active
these submodules. This way, when you record the contents of the
superproject in a commit you can also record which submodules where
active at the moment.

You can have git reading first the active config from .git/config, and
if that configuration is not present use the one in .gitmodules to
allow compatibility with older versions of git.

If you read the url configuration from the .gitmodules file the same
way, you wouldn't have to initialize each time the submodules.
