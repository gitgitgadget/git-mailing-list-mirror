Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F00DC0015E
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 23:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGOXgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOXgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 19:36:22 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1916B10DC
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 16:36:20 -0700 (PDT)
Date:   Sat, 15 Jul 2023 23:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689464178; x=1689723378;
        bh=xCFtUO285aRNGqn0sfup5Jle6WGuuNFn87Jz+O15m1c=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mPxTNo9/VmTcK5HvA+Lhb01tvfYuIdGHueTK0D9qBfc/jED+u3E1AnUJx85Rj5Yjt
         Sd5Tk6ubthtHUKBDHf74UvaZAagd1P2oNjWA6Txjz8DSHNqQoHUBxthwpzajwxMPxd
         vfujK1n++bLZmDurAZ5OSJ2x3sCH3oXtksD5IkFi83cR6HIdLVSohDFH22rvOF0IdX
         NK6eipW8y11KOOd51WYa5VXZcQCM/AJFSgNGnYnhrEuVufM8GnXDadVkpnkPMurUv2
         9Fr24oV8sXPt1t7M/ZQY2PFfhGiYotTu3HtSIRBCLtneg2SBNHk87snJr2oFsqBTo5
         NDT/hIGuhPeRQ==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Message-ID: <bi4cirtujekrbbzdyjdimgv7shqumvniwqmsyoryfjd4ar2nan@66kcdfsdah3m>
In-Reply-To: <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/15 07:15PM, Jacob Abel wrote:
> On 23/07/15 09:59AM, Phillip Wood wrote:
> >
> > [...]
>
> [...]
>
> >=20
> > Using grep like this makes it harder to debug test failures as one has
> > to run the test with "-x" in order to try and figure out which grep
> > actually failed. I think here we can replace the sequence of "grep"s
> > with "test_cmp"
> >=20
> > =09cat >expect <<-EOF &&
> > =09HEAD points to an invalid (or orphaned) reference
> > =09HEAD path: $headpath
> > =09HEAD contents: $headcontents
> > =09EOF
> >=20
> > =09test_cmp expect actual
>=20
> I'll make these changes.

Actually now that I'm sitting down to make these changes, I'm a bit
hesitant as to whether this would be a cleaner solution than what is
currently there. I say this as the contents of `actual` are about
10-12 lines in length and some of those lines would vary between the
different tests that use this test function. Those specific details
don't need to be tested for as they are validated in prior tests and
building a perfectly matching `expected` would further complicate that
fairly large test function.

>=20
> > [...]

