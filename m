Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CAC433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F9820836
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hCAxvOGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390974AbgFXNeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:34:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:45855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbgFXNeU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 09:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593005658;
        bh=Ln2ZtZKg6OFrofXH1QyK12HuVyjysBK3/I4e301VEek=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hCAxvOGtezgLIrS5v8uURfSPWgYkV0m/+KXxwlOXEN1ZK/vR4JzZmCdh1f4bF0R8u
         PepHe+XaO58HLDSC+1DcCK2EphcK+0yssIhfEZg4WC9vQJYghehfNGO5feMdgQ3mx0
         GvdHsaiLaAVSxTOAW+VBNpEnGaOkcKW8yULBQEGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1iwXDV1wah-00roRQ; Wed, 24
 Jun 2020 15:34:18 +0200
Date:   Wed, 24 Jun 2020 15:34:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files
 correctly
In-Reply-To: <20200624071116.GA79097@mail.clickyotomy.dev>
Message-ID: <nycvar.QRO.7.76.6.2006241528290.54@tvgsbejvaqbjf.bet>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com> <pull.654.v2.git.1592916485.gitgitgadget@gmail.com> <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com> <20200624071116.GA79097@mail.clickyotomy.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zvUlgzPHeMOcGnqlazzFW07ZA0ldPZ/6wszejDBR0fv0mgVcwMs
 PlqNxRTfsrpDwcf8uAMgsmn2zi+X2HnWaGcAuY7vPqPseZKem5WvLut03n5mhaNl3YoATNg
 icoH9o4Kz3m+MjBhwOGygyuNNus0ISif1MdfkW+qpvEQHXsq7uZHxFnSOkiiaBgsEqHI5hM
 fQZ8zno1LqGOuJiNkYuTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lnd4RNGsRJg=:utM1fKbWHpn0I61RHQo5QM
 pBJXsaEJwGCR/sIwynVbhvywjSgS4zvQs3VaJShSR2TQxt89jO5ET+A4vc3ZPsSYRCu28eXwi
 bMATfJSqOJgX0r3dRqD/g2r0EUd5mn77sT0I1D7/2puLc07xbS15908w85Fz8DNz7M5d4Ssr9
 UkXgh1axxCuKasH5YGu62rLcj8ys8IUMJTUYN855dQZ8v/s+r0KKrlfeapRpwAKgv3rOGeHKZ
 37UofQs8sNkV77Svf3CarvCrQmXEiDgG8QXZiD8EeBE5iRtQA7H5wZ2UquQRsxiEquOba7hgJ
 547br0VwWpygyJnHGeaMJLPdk/a5BKK2b8nKeCGLZogO96cBLpTJyyywzLwbhrQy0uQ7Sv2ya
 6UsIV6Ly+WJxQC6KHn9gIATh3vuQ0gzmkIGuTANRGaH0fNU7T+xFV5vce1d5yYdFpb5dUe4zn
 KocuJm+GrB1TzC8/iFNuetZAZ61Q11RifctNdl+jGvob5RWTgL5pE2RCSXb9xOIKw9TG/wOtz
 taCI/iegKOnn8lPxsR4Ps7GDTuZ5AIQ2oqHh/qrhRd1SsdWOEjw2aZFPXG5l6agZcDBVD+EXB
 Xk1GMBXVQp4VsHPf5FfdTldutIHhKSbEpvxjloKevaKL1XrI13woqwbg/wET+ob9BYapWlxMu
 NOwd5CWMDwkIxgyNwZa9sKP2I2z6mWBD+evUcCT6l9qxbBxfocGfkLkJuc/ovJHGOqbaeuz5l
 NqE1oB8WXLe59bNnFptWV+cNfaC5As7wcW3UB3oujxzQUynNzFuFRKKRLviYu98EO9QnGI/IF
 qpdsm8ab8zw22y0ywlXsUGerAC1lbD8on1VBGmwaubre/bDrM9qpd2Ot1Y/4ZRP5k2iEMgJJG
 Gaf0QGK8czLK7m15gBZh59uBJhMLo2TRUXVJagl43Go7k4XPxH+hGKdmqhmQv23lJX3hP4B66
 aFjP049X//+6WUC+PlBht8ONyIbicG/3/g3m5I3LKxA/Badht/f4lrs+joLYfZMKxC9J9mc0s
 vpk8QnCxnj9C16sN4lzAwo9TTGggfHggAfs1ONOk/6xq36s/uXsdL9H/R5TjbaJQYLPokpySM
 vhwJADUQF/ssNaOwxqWY0wpKbdo78SFy6gs6SwdXvw0EqcbImZIOp9WJgn20cGGXu7Qn3e84f
 MEvgQATFEgXkwGlQVflcz5rGL4Yfw+JCFGddA6yOajAzR33AwyGOldUmHseWt50nXE+3FDzS0
 wgA4Tu7JFtS7u9mhnsQzcAzA6kbXsRxeUOCM+Gg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Wed, 24 Jun 2020, Srinidhi Kaushik wrote:

> > The underlying problem is that some time ago, the (already incorrect)
> > empty blob constant was replaced by the empty tree constant, by mistak=
e. I
> > contributed a patch series to fix that, and Cc:ed you you in v2 that I
> > sent out earlier today.
>
> Thanks for CC-ing me!

Of course!

> > -  :000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "=
\t")empty
> > -  :000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "=
\t")not-empty
> > +  :000000 100644 0000000 $(git rev-parse --short $hash_e) A$(printf "=
\t")empty
> > +  :000000 100644 0000000 $(git rev-parse --short $hash_n) A$(printf "=
\t")not-empty
>
> Changing the test-case to reflect to the hash of the blob also makes
> sense.

Yes, that's the post-image side. The pre-image side is marked with 0000000
(which is Git's way to say "dunno! no current information in the index").

And it is reflecting the `--patch` case that is unfortunately not visible
in the diff context:

        cat >expect.diff_p <<-EOF &&
        diff --git a/empty b/empty
        new file mode 100644
        index 0000000..$(git rev-parse --short $hash_e)
        diff --git a/not-empty b/not-empty
        new file mode 100644
        index 0000000..$(git rev-parse --short $hash_n)
        --- /dev/null
        +++ b/not-empty
        @@ -0,0 +1 @@
        +$content
        EOF

(This comment is not so much directed at you as it really is a
continuation of my reply to Junio, see
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006241517320.54@tvgsbejvaqb=
jf.bet/)

> [...]
>
> > > +     hash_e=3D$(git hash-object empty) &&
> > > +     hash_n=3D$(git hash-object not-empty) &&
> > > +     hash_t=3D$(git hash-object -t tree /dev/null) &&
> >
> > > So this is the hash of the empty tree object, and...
>
> I guess we can get rid of the `hash_t' assignment here, because it
> won't be used anywhere else in the test.

Right! I _knew_ there was something I wanted to do, still, but then
forgot all about it...

Thanks,
Dscho
