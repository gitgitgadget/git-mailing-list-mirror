Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2125AC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28C7207D3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogYzGlMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbgE1OYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390953AbgE1OYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:24:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B89C05BD1E
        for <git@vger.kernel.org>; Thu, 28 May 2020 07:24:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b6so3166752qkh.11
        for <git@vger.kernel.org>; Thu, 28 May 2020 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0F9Da19lteNpD5Z7+QUNJ0nSohHnUcY35ddph0LpiGU=;
        b=ogYzGlMFh4jTpRJvz/jp+pY/HmEwxJI8FZ756QV/BXK63btJCm3SIE3Uu2ITW75DqT
         Nit03bPmOCNiVAMI3nKkWGlJY7Z9j+KDHcHIYIX3DQ4u5ni5ITkv7D560Ye4yaeSmd+U
         2EQ9XqKzAa/W/apt/jmevbMYQczm5qgbP1s+inNLN5hgM1eA3bu3WxGo1JK00Ky5U/FE
         kyiNGA0TZfyl1sqHgqJOAHEfdVFDqFSSo40mB9OxOiRr+boieEWrBxkJk0kFanTYgLtv
         mJ9dZASJxiy6JX9h3R2iTVY6Q+NAfG2JoKcQAKPD8Zrdo6FX5xp9nsqEnomrMbQUjMsL
         yKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0F9Da19lteNpD5Z7+QUNJ0nSohHnUcY35ddph0LpiGU=;
        b=LkEXBebH4A16kZTxKSTJT54UPJ5tKOFLcdxK99ViRCwOOZsZe+41N0S+TOoZScPnB2
         1Ee1ut9DFWY9n+WxAmUGCbWN4DfkhGiZ0Lf2WnQga0CEHdTZ6Ve+hkyoyTzi06IRCuQl
         r/t0IUbyWKlTKW4yAneqNw7Y28VYvZYK/BSEjVi9pGdkHRUkN44NW8chsfRv28G0V/Fb
         abEcWm2euvQYouwNLLKFIJKLox84K7rwRP2zFBDtdsefC2gHN8/x4YKQCv+OzniPp3wU
         fY4airVNccxBYNGg4ARzYOvBwX1kbycMeovWHFVreb9/anvecG/HeCgVGbe7t9uJA7j4
         dKQQ==
X-Gm-Message-State: AOAM530PU3K2Gfz3WmNfTDCP+7xTVv5MuknTDcCSk9N1/v7dMy3uplXq
        spJRdobO3KkSI4VXprMQsiiGo93J02vQz3gl8WOXjaHk3w0=
X-Google-Smtp-Source: ABdhPJw2rE0H6nsm4ymdQaWPGpfEAVZsaYJeGBAVCtayzq+EeeQ4Nomm/c0EA9OMpaT+KdIlAEAJf36MDaDWBxuNgPE=
X-Received: by 2002:a37:8e85:: with SMTP id q127mr3165165qkd.105.1590675855700;
 Thu, 28 May 2020 07:24:15 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Jensen <report.jensen@gmail.com>
Date:   Thu, 28 May 2020 15:24:04 +0100
Message-ID: <CAHgM7c4PQQvTrfn4fqKy8evQ2ydbO7ggBn4hPUTF5e2G+ApMvQ@mail.gmail.com>
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
