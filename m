Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE26C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 15:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3621F2225E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 15:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZUvV6+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKNPcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 10:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgKNPcV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 10:32:21 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A09C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 07:32:21 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id 128so6804393vso.7
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IDZB1E0+NTyj0iAHQIfNmZEFKBXKUUeE9igKImz6O/I=;
        b=hZUvV6+uikafF6253NiLvSwyML0sMWCNZZeQg+xp9m8NeCPGQQZunrsQuvrzIyJ6Bl
         Rj7FFC89cx1s92nQVt98MmLlblvGJwDT3JAFyGuShr3dkynmaGm5phK8cKIQE97qtQR2
         DuJen81vAgEKSrrvlfLymXUfKsqNYFFydQd/sc/LzrKiiqSAx8K98WKNn3zcqwTMfnl5
         EDfVG8vSNxjkbCJCuudRBJY40xWvHmwZCNnYXE7XMW4245OmTJhQRZQzeEbxHqUzpSrm
         zhAPQauqSCCngRS0O90wXUNSL2UmjDlFAVpdR8MgWbfXlc/aNtMq4zXIrD7RfU9Onv45
         keUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IDZB1E0+NTyj0iAHQIfNmZEFKBXKUUeE9igKImz6O/I=;
        b=in+c0FlyF1tDoH5yJnXuBzHM9f96PTopidVvZospKidn80JgqkmuxsDLXNzGGCiZQP
         VhINLQcSX4I+RKBffm2IKtjiTLaig0al3KCnbVYlLiMDYv2iPMolHhYDNHTdpJnwfCKd
         knz5mytNs24ai1Z/IZVXDA3M/wpDJY07GOlR+zmVtjHnvIGJwdy0jvvziBHGn1+yIV3x
         tWBA/KbXXFYtNWWakOftArIP2WJfVayL2/9Sx0EGjopljSFEtT5Wn9wxxdPNeQekLipB
         VM3YTkzbGBdgIWDrk54M+dEwdw0ufkssN+a+q9xYo/yRswMUauBoborhY/D//c5O8Z/L
         /5DQ==
X-Gm-Message-State: AOAM5332oqZbl7LJF5aZ3QbNDMuOzrEI8Q7mQ46gSoa6i4UvxRdkv5F7
        nEmLudBN7sX6CdNRDaHqkGcra5g+1XuANtLn2MOQ63oll1OEdg==
X-Google-Smtp-Source: ABdhPJxnkW1+NdcPa5SscXXiWlIOVQO+xHj9ALJFJbvMZ6awiojqGdIBfFKlvDOOjxlxF/8yP4K45GHXPRItgfnMRIY=
X-Received: by 2002:a67:f708:: with SMTP id m8mr4196063vso.58.1605367940702;
 Sat, 14 Nov 2020 07:32:20 -0800 (PST)
MIME-Version: 1.0
References: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
In-Reply-To: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 14 Nov 2020 16:32:07 +0100
Message-ID: <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com>
Subject: Re: phpdoc diff in git -L is not the correct one
To:     =?UTF-8?Q?Gr=C3=A9goire_PARIS?= <postmaster@greg0ire.fr>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi greg0ire,

On Sat, 14 Nov 2020 at 14:28, Gr=C3=A9goire PARIS <postmaster@greg0ire.fr> =
wrote:
> I have recently found out about git -L , which is great! I think I have
> found a
> bug in it though: the diff is correct on the method itself, but changes
> in the
> phpdoc of the method do not seem to be taken into account, while changes
> in the
> phpdoc of the method that follows the one I care about show up in the
> diff. I
> have attached a bug report generated with git bugreport.

This seems to be behaving like documented. Quoting the man-page:

  If :<funcname> is given in place of <start> and <end>, it is a regular
  expression that denotes the range from the first funcname line that
  matches <funcname>, up to the next funcname line.

That range is exactly what you're seeing.

Now, I can certainly understand your wish of peeking backwards to
include the phpdoc for that function. You can do that using something
like

  git log -L46,76:src/Doctrine/Instantiator/Instantiator.php

but it's obviously a bit more involved to figure out which (approximate)
numbers to give.

One way of *only* looking backwards might be to use a regex for the
<start>, then a negative offset for <end>:

  git log -L/instantiate\(/,-14:src/Doctrine/Instantiator/Instantiator.php

Alas, this also requires coming up with a decent guess for how far back
to look. I can't seem to find a way of using a regex for <end> and
searching backwards -- I imagine it could be something like "-/regex/".
Anyway, that would just solve half your problem: You'd see the
documentation evolve but not the implementation.

In the end I think your best option right now is to give explicit line
numbers for <end> and <start>.

Martin
