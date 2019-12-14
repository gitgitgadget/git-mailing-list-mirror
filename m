Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC8C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F78024125
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0PpRXPIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLNO1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 09:27:37 -0500
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183]:40520 "EHLO
        mr85p00im-zteg06021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfLNO1h (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Dec 2019 09:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576333656;
        bh=y4HOnYORcsksDPiEJH+o8PzV1sZujcJaObKsAHU32u0=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=0PpRXPIUL1iv1DQzoyyN+TBakm5RS7TzKAJ6fUPREH+FlwX77jcgMVpFuYoEmxGq0
         jUdTCCbRyIt5Lo0LhN1qch1nDaMITDEXMmh6ryVtlZ4Mv+ZZcGcgaCqEP3XGTOBOl/
         4xbQEyY/nFsnGM1BKPjVWvy04L7UnWUVXIpE7joiyutt25WFcTAVrp+ctgeoOVKgpK
         jpIAZFHtpIzmfCtGXnFFf2dsc3qfNM22YXWtxSiaFklj1yC/5Yj0sMEUQ3fj3LELBE
         xqlaUsdcCixS128dsSqsw5qqFzSq/yTLGF8zLm9oj38efq5xMgoshrMnCwPlklN1Cg
         rFOG/9enekSrA==
Received: from [192.168.0.8] (106-69-210-73.dyn.iinet.net.au [106.69.210.73])
        by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 2EBC5380EBC;
        Sat, 14 Dec 2019 14:27:35 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <BAB4CF6D-6904-4698-ACE1-EBEEC745E569@msys.ch>
Date:   Sun, 15 Dec 2019 01:27:32 +1100
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10B64ECE-6635-4735-A8AA-44E66BF0E5DA@icloud.com>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
 <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
 <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com>
 <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
 <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
 <nycvar.QRO.7.76.6.1912131440400.46@tvgsbejvaqbjf.bet>
 <2BB5D7E6-D565-4DCF-8E4D-D410AC1F91F3@msys.ch>
 <BAB4CF6D-6904-4698-ACE1-EBEEC745E569@msys.ch>
To:     Marc Balmer <marc@msys.ch>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=368 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912140104
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> FWIW, changing the stack limit using ulimit does not change anything =
on my (Fedora) system.  At some point, with exactly the same two leading =
numbers (those separated with a /)it seems to enter an endless =
(recursive) loop, eventually eating up all memory.  And then, after some =
time, it segfaults.
>>=20
>=20
> So today I tried a subtree push again.  It took hours.... Then it =
pushed every single commit that was ever done to repository.

So not actually an infinite loop, but close enough to make no =
difference?  I think we have about three bugs interacting in interesting =
ways here - Is your repo one where the subtree was originally extracted =
from mainline?

When you say it pushed every commit, does that mean that a bunch of =
mainline commits erroneously ended up in the subtree repo?

