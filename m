Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35825208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 06:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbdHKGuO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 02:50:14 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33900 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdHKGuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 02:50:09 -0400
Received: by mail-qt0-f173.google.com with SMTP id s6so16686162qtc.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 23:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EQNi3C+FqaGyn0jlBOcQ/osdaBiIjykvAPEekbsq4zo=;
        b=Y0elP4McPnHpgRjcfEgzmK3SQripKTUWZ0A9GemRQlqe7JePwywoKQrA880fNQGdgt
         5HMSQ67Q+Q6a1PzudnXC0j7xhyuUyyO9MIwt72MirXHLjMCWgjw/eIfkMNDRNAekIIP0
         CkhD8otevYgTKyAHAAxc+0MTxKe6fkB4fcM3Q1rCxIT/5jepVFNFUhjAgY2uwrn+JPDl
         WI/BckKZGIDNVdyWTIKcmBvpDHuBh7xL6Fph2e/tveHz/iBrAxnh/6q38FYevjvjXe+d
         15kOKVQEcG7ArtYzZueNnbEP0/FkHGUGFnflFO46J9iE2jEFB7xtPgy19SWg9e3cl8Wo
         do5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EQNi3C+FqaGyn0jlBOcQ/osdaBiIjykvAPEekbsq4zo=;
        b=QaG7z/J/rkGAP8FU32y/tyzBLuIk7x1pN/IXpsowRaRhLSGWeltiia9J3gnFdrZOzw
         ygoi4lfspA7uyVc7b8C/LjMXIEj61YSlS3VTTyd0zpFWdiX9f0Dx6Q+KtglmxrYS6H2+
         8M8erRcbXRW+fAyG2pfyoEkpK2LY3skzFv4tUAKvmjNknGQIuLeLTteNBc2nt36QfEq/
         KjyjXv4h0T9+MO+0PRZWKW7feVh37raoO7KI0kx8apF2YryIB3ZdGG864cFvkn11kkXR
         e43qtf1gxHzfmd3ON25mv1L/elFZknaj+0Hc8Zq/KKSV+VuCtoO6C5dR38QyoTUJI89F
         0Aww==
X-Gm-Message-State: AHYfb5jd10T9oZVbT4u7MYaNaPLwq7dWINZLFgN1QNQ6JStMl7EJDntv
        TEKY3/+/9+BYQKOOVpfs+KAcTha6Mw==
X-Received: by 10.237.49.194 with SMTP id 60mr19055978qth.73.1502434208827;
 Thu, 10 Aug 2017 23:50:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.32.165 with HTTP; Thu, 10 Aug 2017 23:50:08 -0700 (PDT)
From:   Davide Cavallari <davide.cavallari@gmail.com>
Date:   Fri, 11 Aug 2017 08:50:08 +0200
Message-ID: <CANOKeme4j9fHuQoQY3MQeoNuietjez8m1wPkAO=1eSDtHG3J9w@mail.gmail.com>
Subject: git-describe --contains
To:     git@vger.kernel.org
Cc:     davide cavallari <davide.cavallari@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please help me understand how this command works. There is one case in the
linux kernel repository that puzzles me. Let's consider patch "drm/i915/
execlists: Reset RING registers upon resume" [1]. This patch was committed 641
commits after version 4.8-rc2:

~$ git describe bafb2f7d4755bf1571bd5e9a03b97f3fc4fe69ae
v4.8-rc2-641-gbafb2f7d4755

So I would expect to find it in version 4.8-rc3 and later versions.

However, if I search for the tag that follows (and hence contains) that
commit, I do not find version 4.8-rc3, nor version 4.8, nor version 4.9, but
4.10-rc1:

~$ git describe --contains bafb2f7d4755bf1571bd5e9a03b97f3fc4fe69ae
v4.10-rc1~154^2~44^2~178

Why? Why not v4.8-rc3? This means that the patch has been included neither in
v4.8 nor in v4.9, but only in version 4.10-rc1, right? Why so much time was
needed, considering it was the 621st commit on top ov v4.8-rc2?

BTW, what are the numbers 154^2~44^2~178 that follow the tag name?

Thanks & Regards,
   Davide

[1] https://patchwork.freedesktop.org/patch/111587/
