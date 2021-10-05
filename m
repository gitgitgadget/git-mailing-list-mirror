Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC57EC433FE
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6BA611CA
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 18:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhJESro (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 14:47:44 -0400
Received: from mout.web.de ([212.227.17.11]:50381 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhJESrn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 14:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633459540;
        bh=BlsS2B4g8tTvtPxDbWZo2McEJUteqzJKtEEeiuLFdSE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dOmifQRTL/jyrqbR7qx5EXmufiy7+t3cjb+fW6C7wDRt4Tb7vBSCxiBKoLZisqcfo
         0CtaqbxSc2IgeFR5LTNPPgq2pWpgITtYg1wAzcmSFgJiAnJV9F8NxEZdBg40KJb3KO
         SJ2i8tP2tKaXTuqf9+6iJcv05oqMDPXgfAplQuY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LmcjH-1n7iQS3STb-00aBVO; Tue, 05 Oct 2021 20:45:39 +0200
Subject: Re: [PATCH] p3400: stop using tac(1)
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
References: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
 <YVq752xjzYz+LTq6@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f6a1296f-f524-9042-7f88-9591522971af@web.de>
Date:   Tue, 5 Oct 2021 20:45:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVq752xjzYz+LTq6@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4YyBliaWIgRDPyhFg5TjRyGz16iRo1HvuWvoM/D1OpCquekjcnt
 nXKpFftlquFKtsP6xpC7WRFk43zYZ7CR+JOb1KUDvSTMIalR5A+tOTsTF4zWDqJK+HTmWYs
 /12M36ylLBsx1KzAWO3P7z2eBaWpe0o3KmrCdPhssdm8qvUem5yxUlVVfs5NuTsOtKmATtX
 3MCZjnC9Dfc21gIBCuWNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:deg5ke0iMtg=:Dyq7xyebxYhAQQl38UCqxA
 MADwgem0ROvNuXQdkYFTQAuKoV/u5cIotAAYRZ5Ylo/t8AY1cxX2fWxhcBF/LyzQU26HsR5Wq
 1DXIpglkQYzva9rCFGPdTNsjr5P+HNQugqRG8OGd6IPkU4A1VSYaNfc5Y2VXraGsyNH3tIOfR
 NSlWYbhu90iIasGlHuCxrvWB+nBztHs65zaS3RiizbIhHWMdhFtJUe2+rjYEpmIMP0ITRBj8T
 RovJXk5mcaAB3RLHNZRMC9dW2E9Hy/jzPuOFXO4r9UumxlNu06qjjaY7aWVbiule9LdxPSUdc
 Rkqe/A6YfW/paHI62P5tjtUkzTPGGQVRH+Q058wsmjgGB0q+hAt+ceOSIRgzmln5SC8GodG35
 kn6YGBTpA8QG2BZl14aU1SyPHXsn8mYVaMzwsYqiOvr+tkd+LsAV+L6w959Dp4LoXuYrfrnrn
 jV0VIdH4R9Lg9ZMElMwKVSWQp3hBvmj7WMQBLSNasI3J+9n+AQfFixfnEw6WkX2H1+Yn2bDGG
 DaTQpPjXz1CGMfjI4K2ZvglOtRPGVJLzP7b2sDrhJrAwOanKelQFJ3j208UvAI1oJkm0KfgXi
 NEVD0W9my8d2lOeloXUsmhp7qVXs+v/zJpA4mBe1a8RUwAq2gadBDpkr5OcZdeTiKImCFwEeO
 5CjS3nBAwe0/qDtwgTjen9R+3CHWib/VgQy9HMFvoc522hHuJVdc04aArStQx18i3Wzh5FEMF
 m9GIIaZ7KDcYfxKrDJ+0pYaT0seO0CComsqz/OggFZ0dC3l01/5mgg3RSlJL2CkzDflpwcLCW
 G6t1/Ql0yNALLTMKAB0lRGbmr0mqg3h2v2bKpOFBptmFu8vvzUTgrZ+XGUmuDL/aOWvnTGslH
 NOEbOoZ1tbpiVe+nxeaWHGf8lHAwsnVXdR8ORImyLbcIqrT9ddjmIJzESpL3AGb+1q61iZRk5
 NKPRIoU2dMPw7Q9lo0gSZSCvmlZuUVFTrRyNb1QH9VsJp4kUUnIwlgfhm0Mk/J69Yx1m2aX75
 FYEngk9WEEbC7U89k5a5YvdmpSvRyRmh408f8zk5Sz7v9gkAXh/oDS37yhykJz1m/XwFgJoAE
 Lvw6+cRYZJLdGQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.21 um 10:31 schrieb Jeff King:
> On Sat, Oct 02, 2021 at 07:44:14PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> b3dfeebb92 (rebase: avoid computing unnecessary patch IDs, 2016-07-29)
>> added a perf test that calls tac(1) from GNU core utilities.  Support
>> systems without it by reversing the generated list using sort -nr
>> instead.  sort(1) with options -n and -r is already used in other tests=
.
>
> Cute fix. With regular seq(1), this whole thing can become:
>
>   seq 1000 -1 1
>
> without the extra process, but our test_seq doesn't understand non-1
> increments (nor comparisons besides -le). It wouldn't be that hard to
> teach it, but given that this is the first time we've wanted it, it may
> not be worth the effort.

Right.  The original also allows "seq 1000 1", by the way.  Not sure we
need that either.

But when you say "without the extra process", I think:

test_seq () {
	set_step=3D'END {step =3D first < last ? 1 : -1}'
	loop=3D'END {for (; first <=3D last && step > 0 || first >=3D last && ste=
p < 0; first +=3D step) print first}'
	case $# in
	1)      awk -v first=3D1    -v last=3D"$1"    "$set_step $loop" ;;
	2)      awk -v first=3D"$1" -v last=3D"$2"    "$set_step $loop" ;;
	3)      awk -v first=3D"$1" -v last=3D"$3" -v step=3D"$2" "$loop" ;;
	*)      BUG "not 1, 2, or 3 parameters to test_seq" ;;
	esac </dev/null
}

;-)

Ren=C3=A9
