Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C197AC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6038820878
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 11:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slzoz8y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRLOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRLOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 07:14:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A95C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:14:04 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a8so5862458ilk.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vfQkr9dUw573XP4v7SZ9ztbc95zUtU6LCE/TlIppobU=;
        b=Slzoz8y7hVezpvceXJQ/BiRff9a1jkTQB1+Ct5DrFfl3j8XHcudv7zgHHfB0usoK0f
         McHRwf/eOjqt/w1+e7qxWVENRej4erDaUHFON1Eo4Etwib+jTJ8z+GRnBXfAX07bk+tM
         EG8xy4CEZ8Dwg5ZY+kwnrQ6dRqgV0SgfTtUQBwR/c09x8E0T5QdoOrhMW7N/EUsqXQen
         BQhknfirl9hojX4Hbb6CGbrmnPVbAj96Ub3neTfRjG6F0j1qLK/nHs7TYEEJJHXN+37T
         gfe0oCMe/l3P951XuN8gF0iuUHGnX5lp70OxfSLnii9vCGTCdnUpHQK9RZ3dIt1UAkfE
         AyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vfQkr9dUw573XP4v7SZ9ztbc95zUtU6LCE/TlIppobU=;
        b=I8RVXI3ZOjtZ+UsZYCmYKN1p1ItrzM60oUOVnxbDg32AQzvEalr/PZRKDL1bwbRUKk
         42xM1uFjAESU/OX8UzKCoRv0Dp3IiRc+/68oxbFH5dP4clOTrtywnZuq6v73Ob+Q/zFx
         cSm1sJXzD9DW7nLdq53t1rp5nZL1u3IZ81rmQ0Xg5WxDXm9NuYAPTfZBptIxeh8k1OvC
         ne23PJRGugncZzBSsHvC4ClNhjSvoyhwkMHrZvQqPUiu75OqUwPPPYREJ0+2BBTrZ4qX
         w+2Pl9QCRj97yDQb4IVTto08krgzyJhMm8ezBu9gQV93NRRKfu2EqTpqjOsLPEQMXGLM
         aoug==
X-Gm-Message-State: AOAM5335dZxs22468Yf6kHX/ysqJVriBDcZ8yAY32trAB1NYI1qdoeqs
        dZQUazaJmSdJDUjVL9YO9umETyGLPMwwq55WFXXsZ+g6Gyw=
X-Google-Smtp-Source: ABdhPJwuVplXMX7js3UJ3rzYd4i+ZP8tGig11iekRDNeaQqCJgggeECqpvyNn7ZTusTrbnsXxDsxCjo8rP7iZGOkxu8=
X-Received: by 2002:a92:98c5:: with SMTP id a66mr29308348ill.50.1600427643660;
 Fri, 18 Sep 2020 04:14:03 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 18 Sep 2020 13:13:52 +0200
Message-ID: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
Subject: Apply git bundle to source tree?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm wondering if there's a way to apply a particular head in a bundle
to a source tree, for example:

  $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
  $ cd linux-5.8
  $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1

That would allow to reconstruct either the original repository or just
the underlying source tree, so the bundle could be used as a kind of
super diff.

Thanks,
Andreas
