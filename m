Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7024FC433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CA320890
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 22:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzN6A454"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGMWEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGMWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 18:04:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA57DC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 15:04:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so18619137wrw.12
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+5iOnVYVRuumrou1C4qwqDLHsWPMpkTXVzOKe/r0DCw=;
        b=PzN6A454nd1tcrybrxn67a7dio4RAyW3EvgK205NfN4S7/WF9NGLyS5/rjtnpaq6Xe
         GkuG7bVNKRsDHhNMvgf+dGkO2PLqgWaYyAOBvzBDMfNKUwe0SsPpXZ8L6OZA+HzudViL
         SajCtQCITgIGAKkSX51b90fJpaBdq00pGSQMpjdpIC+oXI8UN7GSqIyeBYXSHLpXrT/H
         S+3eI3QDCHrZzqehvxlPt11Bti7EcYo3fcgSzH3EQCG2dIa5+GM1abz39DsUhlBEJHd0
         gfnzZD4bRDR64H9Hoigj8gqr5F8X65FnlBgjIQSryMze4cJ2X4ROkPTFOZ4W6IbyAlTg
         9Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+5iOnVYVRuumrou1C4qwqDLHsWPMpkTXVzOKe/r0DCw=;
        b=A/Oo00MNSi6JHC2llknNhG9BJTDYbTdIDUtNbVqCfrTn0FB749b4M5peKstsHM5/29
         zT1vnORjIkJNEz3+aag9lAJ/u9PF4ESaw5xtxKo6JZbpl3uiJROGOKQEybZZ4qBgxWdX
         Eed1uJrBXTJk2AoP+Cilwbv3azsyxaho6XICPjTLCUTo38FunLlIDVVIKEDGHnxJxWwK
         iHt0wsJmA2VGONCXFswEl2Mx4/ERK5hH/gUWR7gZcjuqrzcfhliDjHoetXEbEvBaMCTZ
         n/S+6sYZKKW/lS0QCXYhzUJCqV5zbul6B4ZPeGJV7eRKYXdQxRSiG3bpuCaaJyqSuhr+
         KjZw==
X-Gm-Message-State: AOAM530DR5Lhdvb6rXIEGhxyTohJ5rfPE/w79qRm7Fh/SPwPD1+qZRHN
        +g3+JMSgpfOiAv9eIK2sMK1gtWZml/IpTJq8RAE=
X-Google-Smtp-Source: ABdhPJxvgxJ3zs/p4PB8RP91p98j8JU6xXempnooksYwx+Syg39qDpDOMnGHNAppuap0jhu9SSGUOqJGK4GnpHxP4dI=
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr1527481wrx.50.1594677873673;
 Mon, 13 Jul 2020 15:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594666410.git.martin.agren@gmail.com> <280943ef56a2a777ab0162b8ec4ba0166cc2095c.1594666410.git.martin.agren@gmail.com>
In-Reply-To: <280943ef56a2a777ab0162b8ec4ba0166cc2095c.1594666410.git.martin.agren@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 13 Jul 2020 15:04:23 -0700
Message-ID: <CAPx1Gve7Sy5BUdRztVoVNVZgdqm14dvD=36eYzLPed5YMQeMEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-diff.txt: reorder possible usages
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 12:10 PM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> It then goes on to say that "all of the <commit> in the above
> description, except in the last two forms that use '..' notations, can
> be any <tree>". The "last two" actually refers to 6 and 8. This got out
> of sync in commit b7e10b2ca2 ("Documentation: usage for diff combined
> commits", 2020-06-12) which added item 7 to the mix.

Moving this down (as you do in this patch) is the right thing to do,
but I'll note that formally, the word "that" in "forms that use ..." is
part of a restrictive clause, so it means "find the last two examples
that use dots".  (In American English at least, the unrestrictive version
would be set off with commas, and use "which" instead of "that".)

> An added bonus of this commit is that we're trying to steer users away
> from `git diff <commit>..<commit>` and moving it further down probably
> doesn't hurt.

Q: Just how hard should we try?  In particular, would it be good to mark
the two-dot form as deprecated in the documentation?  I anticipate
objections because it's not possible to omit `HEAD` without using
the two-dot form.

Chris
