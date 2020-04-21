Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D4EC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F066F2073A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2fbsNOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUU5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgDUU5K (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 16:57:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529CC0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:57:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k6so89785iob.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zGdyWCZk57dvcg+w7/5ktGG/ApxUHWDzftHyjsfyJ7k=;
        b=j2fbsNOKMR5V2wj/9q10ZiN0sVeCCIkzOfUUI8L1sEcPOx7EZAtujTpTzIKOgtaCzI
         49zTWWkGMSIGdD2MKy1m8VW7U4fngjmWZiScEq2uKNOL+0dOYQaQcC4ujxc1FLDtJwmH
         1NUjAoCdaSQjiYbp7F9zIwIF5J9DzBzXbWK111FKWR54hOmtrDt2mS92HwEfNq446GUJ
         h6kmunqjkI0XWLv+C4sGgRXAGHWWjc0HUuZFJJm0xnRC+hXhMyw1tuzUYLQpXUpcaOYz
         87FWo4IGas+C0P8C2YEDDDTxsfISoCN5nEn+MNjNivoA4D9Oy9btoytTAVlV1lb7v/5o
         FH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zGdyWCZk57dvcg+w7/5ktGG/ApxUHWDzftHyjsfyJ7k=;
        b=WTlze7qVofh4m+ShXJCB1pIA1w99mFftLvAGd6A44goDWbHsxDtcHLQouU8fFW79E1
         wrn+NmxmCgtFrKtZW9EZQadjlpyhMuyHdxWY5bpUglRx1fzLCncBx+YVai73EVLRE0BG
         84XPbPf+wugvSgwfc2DXdr2lmY1hpL/JvU1BIZxpLVkictFQHrsr18CoTGST1EpJv8FA
         Hf2k3hQbNjajZ36hi+wQ5R1Qtp3w1KqDOPRwfrztIBxwTqVHtTypNzbYB9zriDs50/gG
         9sfMt+WplMbln+jNrK3vYuej5p6O5snUYHH06ESgxv5z6RToh4D3xYIwKwS06n7u6JYb
         f/UQ==
X-Gm-Message-State: AGi0PuZJnsLxpQxS80ZKx7xG7BOWwvCeyaTdIWd7uXvquMiJLRtRoz4r
        nTRNJ2AmM4/FAwudy82LdOk5b5ERIsH7ZhXGsUZ9JzsF
X-Google-Smtp-Source: APiQypLRZpEbU35flSScizWRzBoqV/ZlcDTTyXUsvtaLqVg612KZKF9TwzBAVneuT+xcLohf0VkAteFmmTV1uB5ESAQ=
X-Received: by 2002:a6b:7903:: with SMTP id i3mr23488424iop.66.1587502629460;
 Tue, 21 Apr 2020 13:57:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 21 Apr 2020 16:56:56 -0400
Message-ID: <CAH8yC8kOT3Ur9AEyNEHynxvhkr5W0WOD1V8rgp-L5tM6a2zWhw@mail.gmail.com>
Subject: One failed self test on Debian HURD
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Debian HURD is catching a self test failure. It looks like its been
seen on both 2.25 and 2.26. The report below is for Git 2.26.2.

Also see https://buildd.debian.org/status/fetch.php?pkg=git&arch=hurd-i386&ver=1%3A2.26.2-1&stamp=1587409938

Jeff
