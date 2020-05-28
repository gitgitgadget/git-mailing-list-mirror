Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2EEC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0621A208E4
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FadHRRp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407534AbgE1VFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 17:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407547AbgE1VFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 17:05:25 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D88C08C5C8
        for <git@vger.kernel.org>; Thu, 28 May 2020 14:05:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y18so81221ybb.3
        for <git@vger.kernel.org>; Thu, 28 May 2020 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0F9Da19lteNpD5Z7+QUNJ0nSohHnUcY35ddph0LpiGU=;
        b=FadHRRp+L1KCcUETBVJGZEgRYFDyyuwKNgLiMjnfmaLPaH9TvR3aWAWpIMTd7BCyZD
         1Uk+J5nnXy6/8QsQP8XVwUYluIf3dxL5D6WurRdIsNUKv6g5nxa4maUZ0PGqHMPHxmWG
         2ViklXmsXnJ22n5cJ3SXDQUSpgrMMX8SrUH8bUojXjyX0roexMjYYZKpFfUqIyfUgdim
         E05neyZAWtVboJUiAvZVUgHypikOzFBq49V/PdLz5NgyC84zKJpm3V9wTqTCAbM8An6v
         mIsADaLu/9DeY0Id6Wsd0sFZ3WIjYXyh/lPGuGITmxoZejuOWjTyjXxHHFwKjXOW7jFt
         Pfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0F9Da19lteNpD5Z7+QUNJ0nSohHnUcY35ddph0LpiGU=;
        b=IiqrcPiYI9PO1TlM7X6xBsRDvT3xJi7KY+4k9x/h71dSnfyBSDgynkTWO4E8qmrKZo
         Kq1LWHEz25RgCXrK4/RWsT9txpGFWTchul1cab4uKPG29/pCtSgpwCDuGTQ3zjSgf0Yf
         UbKIjbbK5TpFRE1WMikGbEXw1LMqDIfirslcMmOrBnUX9y5nK1qNhLBdShrOaGvMZ7hi
         D9p+PQHcZui1v1QH0F+0ghYTIk59q+SLqy9Q8VjlZjyWYDJhpRec9cFob3plc/6EBltI
         9XMPbuz/qrRs+atCYqc27ODY1s+lpyEAEbhEQ66fn81sey1hM/DdkiJIvOtQG7ct4Ev3
         t9SA==
X-Gm-Message-State: AOAM532LsyKZ4qP1SFEG8qHWxML8geACKWVPB6anc2F9s+DOWiLyk/SZ
        x+EAU6Nb9vdmooxcfN6PAWD+aKY+cQVCzDAO+9iVITD4Vp0ryw==
X-Google-Smtp-Source: ABdhPJy+W8j7lWI4lYEC1aaDgRweR44pnydSiML/1cuOaKTHEUOOxTce01u0luyEs9vCZwhA81Oj7IkqzJ8FVuMhr7Q=
X-Received: by 2002:a5b:883:: with SMTP id e3mr8350478ybq.452.1590699923164;
 Thu, 28 May 2020 14:05:23 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Jensen <report.jensen@gmail.com>
Date:   Thu, 28 May 2020 22:05:12 +0100
Message-ID: <CAHgM7c5X0W=Dj11SA=xsWC0WfGHs=T27jBqaVaAuwVw+zKwgDw@mail.gmail.com>
Subject: Git gui freeze on ubuntu 18.04
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git gui often freezes on Ubuntu 18.04. I can reproduce the problem by
launching the gui several times. If I press the "ctrl" key then the
gui becomes visible.

Collected information.

uname -a
Linux optiplex 5.3.0-53-generic #47~18.04.1-Ubuntu SMP Thu May 7
13:10:50 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

env | grep -i git
GIT_EDITOR=nano

# Strace up to freeze.
sudo strace -p 568
strace: Process 568 attached
wait4(572,

#Verbose output does not provide more information
sudo strace -v -p 1991
strace: Process 1991 attached
wait4(2003,

Peter
