Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC339C35249
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854A6206D3
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 21:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BijLxgXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBBV2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:28:05 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36748 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBV2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 16:28:05 -0500
Received: by mail-qk1-f169.google.com with SMTP id w25so12357754qki.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 13:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rzU2VMf1N+CPZKETH6mOZm/hoaiCRcFkxfi67raTPYc=;
        b=BijLxgXAwuWe46zURqvxzyzoVxBxsxrDbW7+FLYi0A2B6Gne8h4T4GSk7aMxGrGFId
         Cjgd/v/CIH4dDsa8LteimYcZMSzz18rIQAzl+92tZyG4/+aG80miOThg9UiuBJBn+MC5
         C/ybHp589faDwukkBE8PW8RDWlU4wqpVg9mY8F19mwxAEDafIH088yez3PVqDqXHecjU
         hGAE+2UyGbYlITGMQp0MrYVypI/ZpNjvs5oJMKIgRfIsdlrqrz/KkO1y251vHqaJbkj5
         EgHkaKuI/yCOvN7GheRwDsjZljrVeKgJo8QTrF9Az/WeDmKR1gTPIxgj5QRughIr80fa
         3+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rzU2VMf1N+CPZKETH6mOZm/hoaiCRcFkxfi67raTPYc=;
        b=HrTZOuLt6z3r+jN9KofChXgP4FSKMxm6uWVCOt93HM3sG1NhPY6v2UeTLtRbHLFc0d
         23HYAoTZBeMHsUpIn86OnAmp7CMqNSdrvUsdwHpSiXeuwofNQxtLasE147d3KD//7fBq
         rMG7X5d9PNFDjI/IOh2XlxkKMvA+Gq+fAlHaGKkXnv7pvrTU5bmIzd0U6iWbGRtikgYY
         CabzY50E6sfEVRKL2D/XPVtVTeEPHe+cJctxPJybeVw64WUXLJe7CjQUrKfJZAzamkZO
         EBKJrohaZTx/AtFdI5IFA/wY3PMUfe9cwYqsnCwaRXkGvi+AUAazyAnNZilfA+TtLtSK
         juqQ==
X-Gm-Message-State: APjAAAVCxAVM9kMgS44stkQYfvm0Wc1psJ0CHhNZMeDYMDttTzdzNlW2
        tJvbbVW9ygn+HrVpELEfyhLfwI7a15WJz77bBGSYBrxB
X-Google-Smtp-Source: APXvYqytSRe/NNN/PVNnPMsdJdJ31WW95KiJ5sVqOnTvBbpO/JYgbIEO/oWuhf4FI4YRR+o80sy0/auskpIJC8vGAmo=
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr21023985qkj.497.1580678883895;
 Sun, 02 Feb 2020 13:28:03 -0800 (PST)
MIME-Version: 1.0
From:   Chris Packham <judge.packham@gmail.com>
Date:   Mon, 3 Feb 2020 10:27:52 +1300
Message-ID: <CAFOYHZAx-MM26AuJmscK=kGgukQ62vkyqAqU49U-5WRaTp4mGQ@mail.gmail.com>
Subject: git log FILE vs git log --follow FILE missing commits
To:     GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've just hit a problem where git log doesn't want to tell me about a
commit that touches a specific file.

I wanted to point someone at a particular change that I knew was made
to a file so I fired up 'git log FILE' and to my surprise it wasn't
listed. I wondered if I had remembered wrong so went grepping to
confirm the change was in the file I thought it was, sure enough it
was there.

Poking around a bit I found that git log --follow FILE shows the
intended commit but git log FILE doesn't (it does show other commits
that touch the file, most of which have tags if that's significant).
The file hasn't been renamed so I didn't really expect --follow to
change any behavior.

The version of git I'm using is 2.25.0 from
http://ppa.launchpad.net/git-core/ppa/ubuntu bionic main. I also tried
2.24.1 and 2.23.1 with the same problem.

Any suggestions for tracking this down?

Thanks,
Chris
