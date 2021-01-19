Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE3DC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A721523123
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 06:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbhASGja (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbhASFkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 00:40:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988EC061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:39:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j12so2412786pjy.5
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 21:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:in-reply-to;
        bh=0yMugCYaBE3ZnUaI6cnccvV1FlqJcu1N71/wKbwFN88=;
        b=JkC/IFAn3ukwO6GDbHiMBO0/Jt7BybVdd8DQCVJ79jFwJ5jyQC5dAGa9z9Uqd7ybWd
         4dp3q04JY0UdXKtF1TnWDnW6EXDlgJaOVTOK4jmnq4EYpYRRGDGAMu0yM0oQFGUCw0DL
         BUhz7rnzkdhLaV/yayzvV3gmROb1AmajtkjISky+zpinLJq/zftssN2yXqg+1P+u9rPj
         mrlbAYtv5QlxhTKolyT/RQhfJ3SHfLbk+IgBfIV6gzoti9WhX9sBNwyMoo6mFtIIgMdh
         NljkvvhFHXdIQ6GQzGkuoLBemRll68t8so0PUoIiAAoM5klLvBuJb0OmscAwKeSLvD7a
         ZRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:from:to
         :cc:subject:date:message-id:in-reply-to;
        bh=0yMugCYaBE3ZnUaI6cnccvV1FlqJcu1N71/wKbwFN88=;
        b=tvYziOIDnB0jqpdYClLqf9OCoommepWUILos7T2WVA0RZzUSTkx9ed7XJwGX1W+E4b
         lofORq1dZfeSm2SsPPqR6h1FxVzjcxr61vs3FHX43zdFaYj45dixYpEwa6hihYZnUtko
         eBMg2HsKityz9Ei7YBj5P9mU2R+8VEdLh+KYDdRBqNnoK/Z24BHmu0KmQYRZiufM9gFD
         DjDKdhPkNfT7FI/9hZDJrj3tmI1lqM93iqOC6mYNZB3nlOVJBCthy3684cNip7pMrG4N
         VfqxZP2aBjOwmomHotcctfj4KzUW/sUbZHzZOcQRtBJLbqS639sL+o0vgZbHHocFxpxC
         Wnuw==
X-Gm-Message-State: AOAM533Azaok+gEWkvZzw6yUMJiwbyuHW7zT/LXsiqp5ltQ9zE7N+mP+
        83AIW/SwJxvmbmB3yf/yvTurCtp/n5ZsEOzL
X-Google-Smtp-Source: ABdhPJzAydMWW+T7JjvLbvt7gaJWgak9gdBGbxs5CtZntHDHCrApRa2TKjqk7sZpEbWsznsf9NFzHw==
X-Received: by 2002:a17:90a:1c02:: with SMTP id s2mr3426558pjs.212.1611034772518;
        Mon, 18 Jan 2021 21:39:32 -0800 (PST)
Received: from localhost ([193.37.32.27])
        by smtp.gmail.com with ESMTPSA id n15sm1220659pjk.57.2021.01.18.21.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 21:39:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     "Derrick Stolee" <stolee@gmail.com>
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Antonio Russo" <aerusso@aerusso.net>
Subject: Re: DEVEL: Help with feature implementation
Date:   Tue, 19 Jan 2021 05:38:07 +0000
Message-Id: <C8MW4U7TN2CA.2NMNG05BE2J97@localhost>
In-Reply-To: <5e5ece7c-3f34-caa1-db87-084b42c1cb62@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick and Junio!

Thanks for confirming my suspicions, that there isn't existing apparatus
for doing this, and a new bit can be added as a flag. Thanks for the
*pointers, I'll try working it out! With Antonio, in fact, since they'd
need the same thing for implementing the opposite feature.

As for the justification, to elaborate on what I said in the opening mail:

This option would be pretty useful when used with diff options, to see how
much two forks have diverged. I recently wanted to compare two long-running
forks of a project and see how far they have diverged. I used the options:
--simplufy-by-decoration --decorate-refs=3D"refs/remotes/*/main" -p

But currently with this history simplification, the diffs for both divergen=
t
histories will be created against the last "relevant" (decorated) commit
instead of the last common ancestor, which creates pretty useless diffs wit=
h
a lot of intersection between them.

You're right that the option doesn't sound very useful when thought of in
regards to history limiting by path, but IMO it's pretty useful in cases
like these, when you use simplify to get an 'overview' of the history.

Also sorry for the blank/duplicate emails everyone! My email client seems t=
o
be misbehaving, largely because I tried to tinker with it :P

- Aiyee Bee
