Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F702C433FE
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0944160174
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhKBO76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:59:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:50723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234617AbhKBO6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635864962;
        bh=DpxDr4EAgDrPeU3rSd8uH6ALfqZh+bo+7L5LqV6owHQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d47HBBgoizrrP4blMgbp9C0wkX9o0OuqaLqrrA68wUqyVyCk9GkxG5t77uAqaFf5n
         aUyHuclRjmTUQSXbWReBAPnfpPhxhqQFz61X3Kehe+lw9LyVeeO4TxTIJldYPedlnd
         6ejzpViiOGNGlLYEGcRJ1ze8nudR6M0jiQ1q3zu8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTRN-1n4f9r26Q1-00NPXy; Tue, 02
 Nov 2021 15:56:02 +0100
Date:   Tue, 2 Nov 2021 15:56:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 4/8] t1051: introduce a smudge filter test for extremely
 large files
In-Reply-To: <xmqqlf2bfmdb.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021542110.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <ce9dfaac9f8693890aa402161b38292b31d3690c.1635515959.git.gitgitgadget@gmail.com> <xmqqo877h1x5.fsf@gitster.g> <xmqqlf2bfmdb.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AT5XYznD9PTj1xufuE4X3wgO2qH91cUfNnCaoaq1YM8BppmkUAx
 guvt+uM8GHftC2p03T6gTYwZV3xaJ2JpldWgLaOR+b+9+ExGRw63gEBSZ76kLWWNXNIE3z8
 zjzgl1CVJrQH//kwqw2yCM/rVOdQzR33TneDNvW/ujtBY0KwRSWp69JdXP9NpS5qQijAs6G
 3zJoVOxtPsAfZg+E3dB+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xwSyHxGAing=:Ga5TuRwBCzyTEQ1KwAPBNM
 Zi1D1mLVv/Hr7zTjhgj2KwUe9eUL7whHwLeZnQb4Dt8d4++eBuJKBqK6zhO8zawmYt/Lw9YY0
 qs2VYZ+vWdsrqYST77GuIknMEicgtxwbMjR3PHi0Gib8tQg5Eut4iDVxMfgMutVRIX3qf/H/B
 vcY36yvMYr+1h9Dg7AOmAjW7zDQTn/jzibxt1dxh24YPn8XBPBuRtLuG2RcTA9VCfUJaVD9v4
 rhhV/iWqIhn03azSGZxCgQrDWUI4SiX1ss5LdKA2AzROUs5geQBdtxtOKv/uOphT2QZkNJbWP
 juWHvL3Rfp4qVwejDi++gU0VQIH+pnNWEv9ZBttrROntwLwRVahT2UHjUdgV4yPc+LCcH1usH
 +25N5obyUEpHy5/k98ClALdvN6+QnOXQgw9QEmlH2bY9aXp6N+LxWeOFIcIbdepm1n1ulVlGy
 jUKa0ciw70Q3DZxN8BKxeTeyAHdZDZFixUFGp/jwKTRfY2zV01hwWevmgNCEtk1hQtNwwylS2
 frdKWgV9D9zvB8FeUZkXyV4To20S72wZqODXskb+Cosli7zzyNj1XLcXuhDqbleaxb0Pg4GKt
 F3FncqNRWDggf+1CVq2g5MSRKscrcpbxPO/TFzmbAO4P/jg2gUeEa0OQufuYPOZX2Q58Te5R5
 Q9akIhDcl8SEc21LJM16cxJetvUNpmqTs2NbPmd0+E/SVkWDa4RquYyx6MEB1jG4AtN8ml7H1
 Pf8TdtwPrNShSvlX6ZEOR4+YO/bOpbHMp9aTeEgV3wh+0R9GSNzO/kQ8Tcbe76AuSzs9R6qwx
 2sucCbOuJwLMDSHdY8oQe1uCSlvEtFMpIuo+kNBwMKQdmNi5d0d3V0HlGnjvYMTMgxnz1VdoT
 /vQOT0zaLS8lolUtShU85Oxv7xZM3v8YH55Rfa2F/rQWEjMG/BTY8ruSzvsvkXfnb366jK49S
 glJfCVWuz+iewaHYWVCMyZSbeUAgm7LWg+rUngqD7NLcgeBTJGMc+JGKR4mzn2JzD6KQE9cj4
 CL1seD71ndx8Yc9kh7PT4vAgCuVGAy57O5mFjk09YoXkMq3VzbMXTcsmWlPA2RWnveQydSikv
 eJWfLkhwZQ3zx8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +# This smudge filter prepends 5GB of zeros to the file it checks out=
. This
> >> +# ensures that smudging doesn't mangle large files on 64-bit Windows=
.
> >> +test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> >> +		'files over 4GB convert on output' '
> >> +	test_commit test small "a small file" &&
> >> +	test_config filter.makelarge.smudge \
> >> +		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
> >> +	echo "small filter=3Dmakelarge" >.gitattributes &&
> >> +	rm small &&
> >> +	git checkout -- small &&
> >> +	size=3D$(test_file_size small) &&
> >> +	test "$size" -ge $((5 * 1024 * 1024 * 1024))
> >> +'
> >
> > Why not exactly 5G, but anything that is at least 5G is OK?
>
> I know it is more than 5G, thanks to the "&& cat".  THe question was
> why aren't we measuring the size of "a small file" so that we can
> check against an exact size to be expected.

The main problem solved by this patch series is the fact that by virtue of
using `unsigned long`, Git truncated the contents to less than 4GB. So,
really, what we care about here is that that does not happen anymore.

I will change it to take the extra time to determine `small`'s file size
and add that to 5GB, to avoid confusing readers, though.

Ciao,
Dscho
