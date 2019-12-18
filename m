Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D1CC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 00:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BF20717
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 00:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hwwrkLHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLRAPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:15:17 -0500
Received: from mr85p00im-ztdg06021701.me.com ([17.58.23.196]:48549 "EHLO
        mr85p00im-ztdg06021701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbfLRAPR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Dec 2019 19:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576628115;
        bh=U1lt4QlFoGRTHWlVP43leURjfcdFaRT4la4q3utcFZ8=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=hwwrkLHfxWlxcrKhaVDCahCiVDU2vLTGQIn3BXbu3qfcElCe48HgSF3BKOrlW5XTR
         6oYY6Qd/CQjefXQ+5sLFAjylTHftvWOC3rUQz23NPQt1hHfXTKnH6SyTvaDcFJRd4l
         b2QENOIZ3tO9bUX7/HqEXXNWiwIio7iAEmumnYOIYpeKuCaKWalZl/XoPOmgixZrkV
         FEev9TvX7vztO6T6mbd+l3T1G1plfocUl6bHK9UQofwaETrOhk1G2jQvBl2gyoP6n3
         LuGR+Xs5Cz/64d55iyd9uvary7wFJI46Q2wFHLfvJa5sNH9Yg5nwZewy33s2oLVDCP
         +JYOKXQ2ksJSA==
Received: from [10.100.5.107] (unknown [49.255.65.138])
        by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id DF05EA018CE;
        Wed, 18 Dec 2019 00:15:13 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CAPyFy2ANiDQ+Ed+3vG-MAxeAV=CRhJow56F7tBooBpJ-Q9B-bA@mail.gmail.com>
Date:   Wed, 18 Dec 2019 11:15:10 +1100
Cc:     Marc Balmer <marc@msys.ch>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4578D90-519D-4C24-9E62-C7E949D2FE0E@icloud.com>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
 <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
 <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com>
 <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
 <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
 <nycvar.QRO.7.76.6.1912131440400.46@tvgsbejvaqbjf.bet>
 <2BB5D7E6-D565-4DCF-8E4D-D410AC1F91F3@msys.ch>
 <BAB4CF6D-6904-4698-ACE1-EBEEC745E569@msys.ch>
 <10B64ECE-6635-4735-A8AA-44E66BF0E5DA@icloud.com>
 <CAPyFy2ANiDQ+Ed+3vG-MAxeAV=CRhJow56F7tBooBpJ-Q9B-bA@mail.gmail.com>
To:     Ed Maste <emaste@freebsd.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912170193
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 16 Dec 2019, at 10:30 pm, Ed Maste <emaste@freebsd.org> wrote:
>=20
> On Sat, 14 Dec 2019 at 09:27, Tom Clarkson <tqclarkson@icloud.com> =
wrote:
>>=20
>> When you say it pushed every commit, does that mean that a bunch of =
mainline commits erroneously ended up in the subtree repo?
>=20
> We encounter this case when trying to use subtree on the FreeBSD
> repository. In our case it's caused by commit that should not be
> classified as a commit to the subtree, but has no files in the
> subtree. In our case it looks like an artifact of svn-git conversion
> of an odd working branch, but the same issue is reproducible in other
> ways. For example, it will appear if the subtree is deleted at some
> point and later re-added.

Deleting and re-adding a subtree is an interesting case. My patch =
won=E2=80=99t avoid the recursion there, because it can only be certain =
about the irrelevance of commits from before the first add.

However, I think that may be ok to leave in as something of an edge case =
- you may get more recursion than your system can handle, but assuming =
process_split_commit is correct, you can work around it by increasing =
ulimit, and can avoid any subsequent performance issues with a rejoin =
commit. Maybe we could display some sort of =E2=80=9Cyour repo is doing =
something weird=E2=80=9D warning to make it clearer where there are =
problems to be worked around.

Although the recursion would no doubt fall over on pretty much any =
machine when depth gets to 200k, it looks like the FreeBSD repo isn=E2=80=99=
t getting to that point, so let=E2=80=99s  cover the details of more =
reliable mainline detection on its own thread.

