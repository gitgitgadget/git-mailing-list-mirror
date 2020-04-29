Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2817AC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0286C2076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="Ylbh12tY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD2QbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2QbZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:31:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3544CC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:31:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w2so2045786edx.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rXXzWLBtn1nzH++/JYo3K2TvQZOBll42ZExbCPCUuj8=;
        b=Ylbh12tYWJx0Vf5+uKc1azCpK+o1brSrr0ph/VNHwT5o8X1ShmUNWN10trXZQUW0mG
         nH4LyRcxR2TEwO6wGbcN5fcE/8eOuLL3cskCxXdNGhZTJRFgSbyVoPSOUIpm1B3fDJyY
         PQTurqI/o18QOAjnQl8ZwP4cMCBLxl2CKyVGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rXXzWLBtn1nzH++/JYo3K2TvQZOBll42ZExbCPCUuj8=;
        b=dxjxsk4w6zZ0eZAjAZIMjtV886KvJ4OGFfU8/yH6w8Dk8bTagAcW9DlmJhUNnNnRSX
         cQjzMDstoicklXhvRcmmcbD6BMvZLFJCdj5J4lVr/DK/Kw/jljs43coRXcgjIRW8HweZ
         oeFtm/ucnTnUcrPaQ7kCHpkCmvwTmQ+6KGRcE0qymKxU6ufqvj3jDJJ/x+8puhy3kMc7
         bJPAc2r3rRgnEmJo9Vm5WhKPI2iA4UD2eMckNe8U6CNX+6P+EEbtg7m3JkREd0CxhxNS
         bhnKw6bjXuqltjpdO9gfMmGKfmE8YcyNdMKjNfq3/YnbjnAFrEaUJR68P9oWiA22uQak
         GOVg==
X-Gm-Message-State: AGi0PuYi8vGzAza44hyOH2eZ9S2mnnOdRY22f/VafufpbSJzk7MU0ZEE
        WgWJyJJ9HHbhUsYH6rhxyNW52ab5JQXadjey0vC6hOvxOLJD9g==
X-Google-Smtp-Source: APiQypIPb/OXGtIjZME7V57B4mVY1L1zdRAPvyNJpT4ty1dPceZPmTUAkjKpBPlUkQDbNWdgV/L+Mcdl18ZXsonJzUg=
X-Received: by 2002:aa7:c5cf:: with SMTP id h15mr3325744eds.213.1588177883430;
 Wed, 29 Apr 2020 09:31:23 -0700 (PDT)
MIME-Version: 1.0
From:   Nikolay Rykunov <nikolay.rykunov@jetbrains.com>
Date:   Wed, 29 Apr 2020 19:31:12 +0300
Message-ID: <CAES10x_TAozxTuR-NXH99u8E28Wv_+KN6Sx4huG2eW8UpReFfg@mail.gmail.com>
Subject: Rebase merge backend
To:     git@vger.kernel.org
Cc:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,
Since git rebase was moved to merge backend I can=E2=80=99t find the way ho=
w
to get information that branch was fast-forwarded or it was up-to-date
(it was provided by the apply backend). And a similar issue: I can=E2=80=99=
t
get information about commits skipped during rebase because they
became empty. Using apply backend I could check that because `No
changes =E2=80=94 did you forget to use =E2=80=98git add=E2=80=99 ` line wa=
s printed. Can you
please help with these issues? Are there any ways to get such info?

Thank you!

Nikolay Rykunov
Software Developer in VCS
JetBrains
http://www.jetbrains.com
The Drive to Develop
