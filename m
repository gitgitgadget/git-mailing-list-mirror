Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CFC2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 16:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6085622B51
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 16:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLPQN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 11:13:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:46755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLPQN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 11:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608135141;
        bh=KiEa7dowyiU4EucE0YDd0LNItlxsrUKar2iwEMCc4P8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VDXksFQGE7HNCnQ4tT+Dn9C5LtwAgh0097Knr2ZO0lG050VMzjhRJHbNC78Mfjwl2
         4+U7DiiP35cbzPUQM3yujjcJEJCXxglFo+Pmxnf8x6/mbDx1zFQItPFHLH4gpiC6Qr
         37ckP7Cuem3LOrMr93jAmZdq0OYY/x+vRDWQNp0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([89.1.214.172]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1kGmcm0MoD-00ZfCv; Wed, 16
 Dec 2020 17:12:21 +0100
Date:   Wed, 16 Dec 2020 17:12:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] merge-ort: copy a few small helper functions from
 merge-recursive.c
In-Reply-To: <xmqqh7om5z50.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012161710170.56@tvgsbejvaqbjf.bet>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>        <0b455bd6fe7dff72c1849eb8466b97b96b2b90a9.1608054807.git.gitgitgadget@gmail.com> <xmqqh7om5z50.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7z3kbsySj70bDWgLQeEMhAsOOdHPbOimMLGHtBXOVlDUZKkyw7H
 SNeHU6Emd2fiukslJZ5BlfivKpcXw6Wd3BFlLSGLb9MGlasFhbxp50nEX2vddz0w/E1i+wN
 VR1OVHdzT+UuT7pAMUPLHNCv4V3s5xo7yObT5QZX02t/ZFuERWViiBiJmdwQHLtKzWLiYys
 fpf1zHAMDi0oIKXDpbnbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nqTcGF5KU9Y=:mx3R4l3c1nFbJQthgBdXux
 XalGyUFJ4q/lmNsf8HILXpSgf6zQmRhG8VJGphEDVCICx0kCO/UpIY4v2+O1ZNJebr+xMF2P0
 dDANfQMTnfBXKxa0ceWsTjIWylOkbCn3+KE2dxwpPKCCBPB2AVexCuPGpy/fNIF8zSunHOmiA
 hOvWXcXLJp/TeXHMHp6PnY420WHconXpUC9V3iiqwGvKAgjvBSejc21eqsTH6DHjAXxQXZOJf
 J4Gjt+NFMRkZBL0czjJvKXVtxMfEgH/lWOPPsFqoLbpNxLMZ2pLUrEHmR0Y78KkyhSA+bmMrD
 uraOL/ZcXV7uQxl/omAtwx2qF+O48V4yTF1Srpf1CJtiUD7W2IwdTqC11fT5pI6W9dgJlfh1m
 Invd3Jit+3L8SQV0GMiebZgiPFWasWnJG9MUo/ti5bNWoMvzZOBL0er6T7qdgoM6CDXMTbiDI
 6ebLRy+jOof2M5+86lZ5Tvqt3/qWKgzyY6F+qlfhSGFPP+xgWT+70CcsBgrtfBM5CyomXR4Wc
 DgGtmy1y+Hq+0Q7BTAAxxz/UTDJqskC/Rz1jRf66s9+/wmlumrzkxfpDPU7jmGgJXTSHoVTNF
 RJyEyLc6ODYNMorCgNitgw91gkEPYDOEgmdzCa/uSSdsYU9pPx78hz2/ACd6pvr+LBLd4YLYh
 oi+ZexcKimUEet88zEYgY3jxuKgi0rrOqf6k/PNVo2/0rDhAiqRfs+mVCCyvupBPMpFlBCrdQ
 Rql4e1OR42wq+bK8yo1lMEmhtSFtOvFAw/Zv/07Xng4N1DyQiPjcUI9cYDcUjPay91fCS/XK9
 McUHvSahPHrv9u7xZSGN7cDw+NEKyokCYEHJC1FPj6MH22hhp3UpgszCGzU6NkpgoN94e83GG
 3oSFasWdXFEOxa+RY2PyRAzDBnigH/5D1H+1Y05Mo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 15 Dec 2020, Junio C Hamano wrote:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > In a subsequent commit, we will implement the traditional recursivenes=
s
> > that gave merge-recursive its name, namely merging non-unique
> > merge-bases to come up with a single virtual merge base.  Copy a few
> > helper functions from merge-recursive.c that we will use in the
> > implementation.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ...
> > @@ -1462,5 +1492,7 @@ void merge_incore_recursive(struct merge_options=
 *opt,
> >  			    struct commit *side2,
> >  			    struct merge_result *result)
> >  {
> > +	(void)reverse_commit_list;
> > +	(void)make_virtual_commit;
>
> To keep these symbols referenced?  Cute ;-)

I saw this technique used extensively in cURL. Note that we ourselves
introduced the first such thing in 2fb330ca723 (packed_delete_refs():
implement method, 2017-09-08).

However, we seem to have the `MAYBE_UNUSED` macro specifically for such
use cases (and use it in four instances as of time of writing). I wonder
whether we want to settle one one strategy instead of keeping both?

Ciao,
Dscho

>
> >  	die("Not yet implemented");
> >  }
>
