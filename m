Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D539AC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 20:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA720731
	for <git@archiver.kernel.org>; Sat,  2 May 2020 20:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N92pKjEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgEBUcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEBUcE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 16:32:04 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13CC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 13:32:03 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a16so1627923uaq.5
        for <git@vger.kernel.org>; Sat, 02 May 2020 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6b9QdJvD3wWBickw72/iUneScDqEmbMkT5LBGTWz4N4=;
        b=N92pKjEHkQjQkvkrCnyLXr20sZ8S9tbAnbe8pxcjX1WcPSq1v8KCna10gvANbhlNm3
         pDdhn3Wsq02yqgg3IrK69EE6WxiWjTGJ+unRHHkZBCtmgfAmIwEPRN7lPWcb4msnijJa
         WknWApS7nf1rxZ2MjuEkSlS9TRLoCo12WK4OrfUgie9cNssyZrzRlNqpGCzO6XXYewPj
         O6eEYl3yxv8W9EHGMcDShVkiYNFWBR9Nnf2BSQU9EIt5qsDqdUgmvn/+CgOk3t6RT94V
         Z8/Pm4AtvgpxUgx5TMGlLPJEjSlkF6BTrdQeA8jei7/1A/+xfRVeRMXNQYmbHuhwYCSz
         B2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6b9QdJvD3wWBickw72/iUneScDqEmbMkT5LBGTWz4N4=;
        b=mMxyUK2+zAJjjRY6TCohkKgBfHWLkpfVorPBLDEqaFdaV6plLpH55tlC7P/yWeEyp4
         7zoyfa1XCREbE3cKjKHoDQN5jaIYjkW7igJsrRffktjtGQxtHYrOBbNrG9irtLcYzWQH
         Oh81N6FjHlB44GCzpQdtSNmM6yDjKG4j3H6r6//jtmutcpRP8PcimrLCgjyWBT2cYN1p
         shY2GKQIyw/P7U4utECE1Z1bj2jSvAOcK0Zm2BhG0hrJ5QiP3sSq4pvgG/DwZb6ZVRbP
         bWelX2MaUqy/ds1ZPDoDGUSWkTtpYomiJlzkDRazNFfGxDwwb5ZHIcqPs4YISx5722vT
         wZKw==
X-Gm-Message-State: AGi0PuYuzpSHkZ3+83xXbK2miMwq5el9xzaAYPm0HWqPxdGbBtGB1a4A
        xlnuKNO8GWRpQOmMTTbIFmD/ivss0xbqL5BwVATYUl3k
X-Google-Smtp-Source: APiQypKJzOHW98kq8+w0w+FOf1Gl+HHT7a4soLot7uv6grebL3J6zM+Tn/wvkz+6hBaTSmxiACkFEZXPWV5YHQGg1Eg=
X-Received: by 2002:ab0:5a84:: with SMTP id w4mr6768793uae.61.1588451522460;
 Sat, 02 May 2020 13:32:02 -0700 (PDT)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Sat, 2 May 2020 22:31:50 +0200
Message-ID: <CAGqZTUvuJgZH-YUxDTYunng3QD4-wwPgquZX1P=1P1R=Ku0s2g@mail.gmail.com>
Subject: git for-each-ref - sorting by multiple keys
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have the following command:

/usr/bin/git for-each-ref --merged="${GIT_HEAD-HEAD}"
--sort='-taggerdate' --sort='-*committerdate'
--format="%(*committerdate)|%(taggerdate)|%(tag)" refs/tags

I thought this will use: -*commiterdate as a primary key and
-taggerdate as a secondary. According to man page for --sort: "You may
use the --sort=<key> option multiple times, in which case the last key
becomes the primary key."

But that doesn't seem to be the case. I created a repo with a single
commit and created annotated tags on the commit in the following
order:

$ git tag -a -m "foo" B
$ git tag -a -m "foo" C
$ git tag -a -m "foo" A

Yet the order I am getting after running the command is:

Sat May 2 22:10:30 2020 +0200|Sat May 2 22:14:49 2020 +0200|C
Sat May 2 22:10:30 2020 +0200|Sat May 2 22:14:45 2020 +0200|B
Sat May 2 22:10:30 2020 +0200|Sat May 2 22:14:51 2020 +0200|A

Is it a mistake in man pages? Is there any way to sort by multiple keys?

Thank you
clime
