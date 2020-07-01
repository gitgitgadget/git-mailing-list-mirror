Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A193C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E863B2067D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FRNb2RJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgGAJqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:46:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:55667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgGAJqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593596804;
        bh=3Oj4+M34tG3RZaHxOgQgFaioLhu70sppqxlAqHw4zAU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FRNb2RJWFmfmOcl9yGPSF8iz6p/RPYzE/odxWFFIIidbNFNe4bi2/UrXUJyXcORDk
         I9aDU8jQKJFyk4wHvClx7yGkVWpT5MMxYGKj9pEg6iqLUU4LhimvEVKHJ8uKnMxsk9
         jBcQzJAlGN9v7rhpMQgRxam36vP5ubcsHwi2DdFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1j9I5x3FZ4-00igvP; Wed, 01
 Jul 2020 11:46:43 +0200
Date:   Wed, 1 Jul 2020 11:46:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v4 1/2] diff-files --raw: show correct post-image of
 intent-to-add files
In-Reply-To: <xmqqmu4r3to1.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007011144410.56@tvgsbejvaqbjf.bet>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com> <pull.654.v4.git.1593107621.gitgitgadget@gmail.com> <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com> <xmqqmu4r3to1.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2uPTG6u0xUpdNEF5IXcQS+macA6o6SGld/7YQEctNbKXD3f4L/I
 eDbZC6yjzscMW7ZSnLnvYxynWxCOnmPSHr4XNp77QKTMfhIkN6geQb9XpF8YBWEu9qhHkOe
 0E3vZlSE0YLKV0CHupYP2Mn/Gp9qI/dy68l9nnIlljQcl1CuxcV26a8z9o7tCFZ4rp82l1h
 wGoBo4tJvM9SYJB7ukAsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KTqQcQpitPg=:w2RCElebASNprSJqnnnf22
 NJy6XHgHqC1bK1165bcFYmv6opRmlXXXwyktyP2wssYXQvUyXXF6QBocD70gRFCvlxcRyqA3W
 zdS/eNTA8KcCpK20FyiYCwXRdLN6vwgcYAKinn59zpXOGncgwRppA44sqXU8cFPfV8I9NEsay
 4/crXve0eSjqXULQ2LYWZ147gGHzXajOhja2fq3tSLCw5HD0gZxYS4wOBWESZ/TO5NbMOf5nX
 xfn1a7vGggibYbWPF1lIUmNVJ7dcFWRQd4DyEGEGBB8jaS+SIdIR03sHlhUAXQy5scoeYh2E7
 wTFpT/imCFKlsQ42JblGmCLD3a9NHrDPo7ukCy8mpj4zy2+SInqrIgh+Iu8afRaS6q7Nv1jqA
 sAR5ADv13nkGL0q4Kx6AJRx3AP5yAxCFK0VZlamjj7MDzzyTGM8ZiCDm9ANNOUsiu31HwTNcR
 um25nyWw5/il1D/u0P+lPgr5klCOX1quEFoPWTrhMw3jEeYY8beHkadVa9lDirIg5DSjU6nyT
 AyWjfRkYyjHXQYZSuVeplOyRX32Ty5RHm/HmWpTsaHX4I+1uFxAFmQ/c+EB8efiK41OZXIYOt
 5arxyPaS7QsgeJxrj7HulJD0caTV5vXtO4Vp/gOOfKmNi0G9zcejZOARKeTQmvrwWUEl9iJr+
 Ml1CutqlHXjc56Vcgfr68iBepXE7o7Y2SGPHelEQ5ec2ULRBopbFvJ3g50jRjvKwfXAX463qn
 d6YRvBuTzEkWQ8khO0fsMCljbDuD3PFyD99z4lIT1sRw1RjGWUJBj+3H1Pl1NdsNry/OF9smb
 HeXW3DGHDHSyDliQFBSuK1y1ZDX4alyj14x/9azPEwxnFO0AhdAH4ZHSDE0x6XSlczftlZrCn
 YXuojV7FVqVNJs+ZXQc/gB2qyp1HLLq9rHSuhNuBvvhfUzJQaH6jiAMS7o0Nj+HyOknljf7aN
 Ft5UgADCIdwp5ONlUzX/h+1U4faf1UeIGWJXLVEffEPY0YQA/LPr2XG8Ca76Nk9v9pwYq/obT
 wBfBCc0S5MCP0toFAemn1osvQalO0SK9gWG+cAt0RT+327EwcZfolDThcnkzvQx7up47RLHWr
 h8b1ZvQk4YfXOaK+jXpkwhLvZBWOncHVjBTdR5Y1jaUsngTd9qsZX7jF/B8YIIddcp+KoTcRV
 xP59Y7y3FczHfumEOfHOwBbvxQxyc6pFdIVp+dnd2Z3TOlTo2T7BpZYvkvMrF2pypwPAZ9XqY
 C3Y0mW6JiZp5vhmgf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Thu, 25 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/diff-lib.c b/diff-lib.c
> > index 61812f48c2..25fd2dee19 100644
> > --- a/diff-lib.c
> > +++ b/diff-lib.c
> > @@ -220,8 +220,7 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
> >  			} else if (revs->diffopt.ita_invisible_in_index &&
> >  				   ce_intent_to_add(ce)) {
> >  				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
> > -					       the_hash_algo->empty_tree, 0,
> > -					       ce->name, 0);
> > +					       &null_oid, 0, ce->name, 0);
>
> This (even if the preimage were correctly using empty_blob) is *so*
> simple a change that it is very surprising that the new test in
> [2/2] passes without any other code change.
>
> It means that difftool was written correctly in the first place,
> right?

Well, it means that difftool does not even consume the OID. Sure, it
parses it, but then it ignores it. All it _really_ is interested in is
that status flag (`A`), so technically, my fix in 1/2 is not even needed
after `sk/diff-files-show-i-t-a-as-new` to let 2/2 pass.

Ciao,
Dscho

>
> Nicely done.
>
