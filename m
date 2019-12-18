Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A04C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A346C218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brightrockgames-com.20150623.gappssmtp.com header.i=@brightrockgames-com.20150623.gappssmtp.com header.b="ExJF3qh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLRLKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:10:40 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34108 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRLKk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:10:40 -0500
Received: by mail-ot1-f44.google.com with SMTP id a15so2091726otf.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brightrockgames-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=MVXfUuHKxtN4n3xOAn3tAdDdVEIgzOISE3jpVp0kGHM=;
        b=ExJF3qh3V93V88m1DAWN43mAuIXx9RxlejwF10CfuWnA+80NEwhtdsv+YklqsmL+xt
         JlIMcJCVs2NPrT9NQcnFZDpsFn+pRNPT6WLKvVAsEFrnB0KFBCIA0Y+imMM2MNejgb8U
         iDMWGZ9o699L7oOKu+FxUqW6npCD2XAYgCSV8ZE8aad6GJ8eAPC7L1D+bLpQM0WUarac
         7RMGEZ54bb8pKq69+KYeUFKjSc1P7rNj1LTbL2jq6ZIW8lhzh1FLgHdm+JW7KMae/JP0
         /1OtIjk1iRy7Uf/vfFxOkUpI2epgE/5n59kJg6ptJjI07O7Cy3eQBUKD9X/XnJ7Rp6f1
         juPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MVXfUuHKxtN4n3xOAn3tAdDdVEIgzOISE3jpVp0kGHM=;
        b=UBYl5GcRreQOPEvSWODcgc0dhmx533WmNYSZz2BXf9CRQwYWd/SDRpkcFBXtU/NEvF
         4D6yvKl76fhUV6eKXPG+5N3B60pDTY2/0X6iGzUvxyzTKySTBlsiP0wx/XRnbAf2wqLH
         ngHPOdBnjYbS3/t4IoE6MxjtReSVFCpTMdzoXoKyHBnmBoI3CiQl+ZjPFJhKKu6Vur0z
         h3IIiK97cN4rpJfEUJA05QH5/WmyDT9d3jhIc9i0gLJYh235B0hvlyHgLYtOs7ukWrbJ
         WlAi00ngwoAY39h9it6f8joAH+PFh/4W3068COD5DAZeE+W37+HT0LaJK+WSHaGFfMgq
         1AUg==
X-Gm-Message-State: APjAAAUQ3F7RNesOEZl7HAhEgLO9BrzVQSTU01aIqmGWnxd/YEhLmURv
        ChiqaC200hsZeDOJ/NsAGgAE0x9A5mIdJe13oCQMmT9j0BXlQQ==
X-Google-Smtp-Source: APXvYqwyORCWafKf9iBybnEbisR5JYzP+Qy8AmFMv40gWZtTRto9L7Rrdl6HW/w++gglnyL0BaLyJLfgnBP3a4AMxp8=
X-Received: by 2002:a05:6830:2110:: with SMTP id i16mr1922750otc.337.1576667439534;
 Wed, 18 Dec 2019 03:10:39 -0800 (PST)
MIME-Version: 1.0
From:   Scott Richmond <scott@brightrockgames.com>
Date:   Wed, 18 Dec 2019 11:10:27 +0000
Message-ID: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
Subject: Ability to ignore EOL changes for certain projects
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Problem Domain
In certain dev environments (Unity3D projects) there is (AFAIK) an
unsolvable problem where some files are often modified with line
endings that aren't the native system or not the committed line
endings for that file. Secondarily, in this case line endings don't
matter - Nothing in the dev environment "cares" which kind of line
ending is used.

The Problem
Git always cares about EOL. Git has options to transparently modify
EOLs when files are checked in or out. However it is not possible to
tell Git to ignore EOLs in other commands:
Git status shows the file modified.
Merging/Pulling has to care because it can't merge with a modified
working tree. Which means the user has to care - They have to either
stash the EOL changes or wipe them out. Sometimes, if the user has a
particular app running, it may automatically reload that file and
recreate the modified EOL changes, causing an endless loop. This
problem is often made unclear to the user how to solve, especially if
they aren't domain experts.

To be clear, in this particular dev environment, I can say with
confidence that this particular issue is a major and common pain point
for users. It is made worse as many users in this environment aren't
programmers by trade and aren't domain experts in version control. I
also believe this environment is becoming a non-trivial portion of the
Git userbase and it would be worthwhile looking into resolving.

Solution Request
It would be fantastic if we could tell Git to stop caring about EOL
changes on a per-repo basis, with the effective output being that git
status shouldn't show changes for files with differing EOLs.

I'm experienced with Git, though I am not expert enough to consider
creating such a change myself - It is unclear to me just how
complicated a change may be. However maybe I could look into it if it
was made clear that this improvement is possible and has no serious
side effects.

Regards,

Scott Richmond.
  Director, Producer, Programmer
  Brightrock Games
  T: 07480795661
