Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8EFC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17782082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 10:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cdPQ6c7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgAQKBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:01:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:43671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgAQKBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 05:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579255262;
        bh=YZX6L3KRs1cEUEbTREhnPDwyO2aX67iihrk17T5qq6o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cdPQ6c7iFf7h4eQ0vbYU+jH2yF9uRhwfavp/8gtVqTpaL2CWWRN1e1VDRcKml3ORy
         ZssnUCUtlsJEsJ7s3AVBOZydqR4lWfexyv5UIX9Qaj++CVk1NmTJUi/ikvpzJdHxrO
         ArCdnsFptC/iY+A8sa6jVcDs4sXOEr+g0GGLbTGY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1jGgZq2HCy-00OCyK; Fri, 17
 Jan 2020 11:01:02 +0100
Date:   Fri, 17 Jan 2020 11:01:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] built-in add -i: accept open-ended ranges again
In-Reply-To: <xmqqv9pbf3mu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001171100030.46@tvgsbejvaqbjf.bet>
References: <pull.528.git.1579163587.gitgitgadget@gmail.com> <7e4bf4bbbcd8c81a19d690aee379042e47246947.1579163587.git.gitgitgadget@gmail.com> <xmqqv9pbf3mu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wp1Z+xGaPW5j7wqaoeQewqekfcZ6sdS+4sZERScrY5qXIl4URjO
 aaAlKU0rcKaByNw0Cfa3BtEu2rE2EqFvDeOWspCNTWvZsolaa2MN70isJkbeYrsrhfoC9Bb
 P++ueKO3JbuHVq83CpTFlW/Ymuuyblkd5NJYqC62L85HtjEo49hxzqTfsJypvBN47/OC/sQ
 QrCSj4nk20khAuxQdvSFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:imB0yfTQs4k=:A1WuMPBnZdaNin53iRkFRt
 Hdx1p/ERamT3CubNAlbGYajvv62QDIQ+GTOaz+o/peUZkdcOO0bJ3ZSrmAl2miiEY5yGSxmaU
 PjXwXnhdOvDfisBtT8s9FODWuaZRJxnLu92nYyfsBePxIfU19w79U4mMQFTmtmk5Rr32DX/r7
 mk37hOAie24ISQpkTZJ/XtwpOVwsr18r5RsdoxYdERcBpW1cqpTQUmuUTwDNTTDfo5fHGtNEK
 20T3rsZ+Ju6XwNNWMMoASmsMzDFHyQGQuZMrxhc5w89EyYA3CsekJ3ZFK2T22Dm1Tz/B767c5
 En/+IxeidihzO9udWldeNxKypwF3txu8/9fi6cAeTvvhDhddUl7T6AoXFOJpbktqgMHUj7Fdt
 Sm2PxWso9pGnljgnyHJgX3OYq+1u1p0nXQhJ+18oYjSHbrG194Bi8H+D6VPNcaHPXHhJAwHpn
 lZr4c28ES6YI/mcYnMdqqKo09f1smoskw6XCzztMSh0FhKNeF+S0nwDxpvbIdQGLKRj4I90ta
 RP2xu7+eR09DfedHrEqFcU2okN2YflecprJXPQxx9VBXXac2g8leDTODRBxj8VzYbaInYlDkE
 NbAiVA6Drc+1LzU08bNrhMGXXarxGc63DgPjNRMymt2rznjC6aupvezmDLg3ukAXzfPtlJv6u
 b3J1J/ou0W3vKH3S4sDL/cVCDoKEZIQR+/9F0ki59SfPYXKje+MGpP6os5twCF/niXx/SvHg7
 fpykuAMaLehAuDl0UFfrk6pe/NG4MDAv3xyhr6EwiPOjVhYfeeALR0W97bMmHVTGYiAYqsDTt
 MKsBWXYkDTB7l3/kOBThN1fFBohWENF4t07+7287XVUjjw+0Jm89oNyiRzVHzXhhkRW0bBADX
 5bGl/DsfVnS9QuCXrSRDoR3BYcFl0q6vAVM6u0KXeubOfGvHTxPlX+m66qsh8IzcP8wU8SpXs
 m80nMPULrEKMlyJh8mGgyQ54D9TsSIXps2CAIKYNdiNelLawaf8O8f2Dd+Dzzq8+bPb+xsidy
 YFK9BF/1pjDLMe/8L4WD1pGJft0QyMNnHkcfsXDYGrQ3Tfa34Hjl1DkLcc9J7QA3y+nFbjSlq
 m2gu7Cy5D62BMY1AXslWycZpvinKp1vRewBTaVz8W8Jxq0wyjLq47+Z5DtZtjonUe7eJII/lG
 9I8nq/5Uwa14I2mb/wdiggPs5je0BzEbgxOfgDhLsdnfR87337F4tSvAfOLm/40gTtUYjovar
 VY+61/muPJS+FMJV4x0+bAMciC36DFmgreJHb6KHy0fID9ZXDcuBCerdCV1E=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 16 Jan 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The interactive `add` command allows selecting multiple files for some
> > of its sub-commands, via unique prefixes, indices or index ranges.
> >
> > When re-implementing `git add -i` in C, we even added a code comment
> > talking about ranges with a missing end index, such as `2-`, but the
> > code did not actually accept those, as pointed out in
> > https://github.com/git-for-windows/git/issues/2466#issuecomment-574142=
760.
> >
> > Let's fix this, and add a test case to verify that this stays fixed
> > forever.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  add-interactive.c          | 5 ++++-
> >  t/t3701-add-interactive.sh | 9 +++++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/add-interactive.c b/add-interactive.c
> > index 14d4688c26..396066e724 100644
> > --- a/add-interactive.c
> > +++ b/add-interactive.c
> > @@ -328,7 +328,10 @@ static ssize_t list_and_choose(struct add_i_state=
 *s,
> >  				if (endp =3D=3D p + sep)
> >  					to =3D from + 1;
> >  				else if (*endp =3D=3D '-') {
> > -					to =3D strtoul(++endp, &endp, 10);
> > +					if (isdigit(*(++endp)))
> > +						to =3D strtoul(endp, &endp, 10);
> > +					else
> > +						to =3D items->items.nr;
>
> Good.  We do not allow "everything up to N" with "-N", so covering
> "N and everything after" with "N-" is sufficient.

Even worse, `-N` means "toggle N off". But that can't be fixed easily as
it has been part of the UI for ages.

Thanks,
Dscho

>
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index d4f9386621..b02fe73631 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -57,6 +57,15 @@ test_expect_success 'revert works (initial)' '
> >  	! grep . output
> >  '
> >
> > +test_expect_success 'add untracked (multiple)' '
> > +	test_when_finished "git reset && rm [1-9]" &&
> > +	touch $(test_seq 9) &&
> > +	test_write_lines a "2-5 8-" | git add -i -- [1-9] &&
> > +	test_write_lines 2 3 4 5 8 9 >expected &&
> > +	git ls-files [1-9] >output &&
> > +	test_cmp expected output
> > +'
> > +
> >  test_expect_success 'setup (commit)' '
> >  	echo baseline >file &&
> >  	git add file &&
>
