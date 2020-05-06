Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51FCC47247
	for <git@archiver.kernel.org>; Wed,  6 May 2020 02:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722CB20735
	for <git@archiver.kernel.org>; Wed,  6 May 2020 02:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN/jwNfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEFCvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 22:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgEFCvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 22:51:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36FC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 19:51:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u15so735912ljd.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 19:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yeilZVacrr6ZIFDBzTQ0lpfTtw3THa4KXhMqLfpQ+E4=;
        b=KN/jwNfIs1j93ZSbRezBdiiUkwip3U9ai6V2dSvvLSo2OqTxmsOB/5n+S8VypJplS8
         XYE0Q68PKG4X90ZNR2/torcSNg6WlgkBNKrwz/2wfffKitYzv0fK6A8nHvmZMQxvZY1V
         CIkxswPz7W8IuIvTCI3+25gDCeSO622cwkZWtupBkGVopV2AqbXtiE4iEVPYHzDnbDsp
         Hv6EvXw+ZnRu6bcyeNPWlDgCgfvj+XngfrHwvOdkIKWgvHyIWPmyWf4jM0M10xC/FiDF
         LQWMgKuUpX4XBMoEbamgP2nq/fFdmQttjuKajiHSXbUB4rtX0QAlKbXXeHHcK6MHGN7g
         tIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yeilZVacrr6ZIFDBzTQ0lpfTtw3THa4KXhMqLfpQ+E4=;
        b=lcRju1E0y7mW/a2QV1B6llAYXPBjLFFZafATHbg9y6ey2GUffbsF1uXCYp+Z34H7UP
         V5AuCPZpZdydBRZC5CqrjyRZtuuEioLdenzsmijyfRoq078/hth7axxYCRZGeHBnBPpk
         P4VZM7YDFixZ3jzx4FSwMEJ9SXFD9eTAfNbWG7RBPQ1UAu9VQTMLya/HcpS9Ouw3jV2k
         E7krCVhZyBNF+NWYlRs47abDNOmLXvXCJhz+IIC/Ibx2bb32ULQxBLNPHRcwPI77fF0S
         RMIRJbVQQPswLcrtTeJB5IgDnBhSP9DMt7z4oR4cOf7ZoffyV3uOBrpti+19OcMaiQVD
         PNZg==
X-Gm-Message-State: AGi0PuYa0Bv8E9vpPjBkekMz5Jn24pfV32U/KqyEhE5+xi4Gwuu/FYIy
        FjTxZXu+vJXJqdhqc8pXD2h0ZPHve/PGn56IgekYl9Lw
X-Google-Smtp-Source: APiQypLYlM1W7ky4gWn1TzhmCbo/ij1D+JVnNcSehSvfM5qS5hvpAaM0mr9dDxRutQEculpBxhh8Zn7LfE2kIwrAAl8=
X-Received: by 2002:a2e:731a:: with SMTP id o26mr3678139ljc.189.1588733477935;
 Tue, 05 May 2020 19:51:17 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Byrnes <byrnes.anthony@gmail.com>
Date:   Wed, 6 May 2020 14:51:06 +1200
Message-ID: <CAAULzeKqsx=ajDQ3y7F=UXUok1ep9PFkEeh0ZL34+765WQ9xvg@mail.gmail.com>
Subject: newbie question - how to upgrade older existing git version
 2.9.3.windows.1 to latest release
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,

I have a working git version 2.9.3.windows.1 on a build server.

What is the correct/recommended way to upgrade to latest release
without breaking any git settings?
I am very scared of breaking any settings ....

Git downloads page implies this might work, but I am unsure as to what
this does....


Git via Git
If you already have Git installed, you can get the latest development
version via Git itself:
git clone https://github.com/git/git



-- 
Hello World
