Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9024FC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FAA233FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 15:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbhAGPe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:34:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:48951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGPe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 10:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610033573;
        bh=+x4fArIo7gUexRHKGM2qZI0hoiVhziB3YemWL2gCHp8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=glQ4jt5P0cREG6PkHrrnYpplCdPmZ5NJ+KSEjDyau5tf+VRsI/IKkvFQrmmKVaID5
         zW7MTp5pd3W757FCP9T9IZirDAzSec/isuWd3A0JdBeFn5KxqkHf3rJls0OVUOvMi+
         b/ioi0kOkiynmW5v/0liX5GnL/nhzYi8tCNAZ4/E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1kBo3n1dLK-00qSMO; Thu, 07
 Jan 2021 16:32:53 +0100
Date:   Thu, 7 Jan 2021 16:32:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Rosenbush, David M        Collins" <david.rosenbush@collins.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug report: git add --dry-run does not honor core.ignorecase
In-Reply-To: <b082a81ee8bc4d7da325c3b0a6d2611c@UUSALE0i.utcmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101071629140.2213@tvgsbejvaqbjf.bet>
References: <b082a81ee8bc4d7da325c3b0a6d2611c@UUSALE0i.utcmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l9vIVEP+0BV0U7rAv/dnrNFPISy4EXUc/X0BXg7E7e4J+cIzdWu
 ZimOlDVfnrkqMheyJcv3L+H5BZfrHsamAdKjxfIXT3OhugyMWbh338vtL8yTKRB1wXEerm4
 5a7msyLyGBhx0Evdru27HNhj0g7oyx4KyaqVXI4NO3CGYBEZOMHA92PtsBQT0Pf1R17qvE6
 DA5j51QeKOfhI4wkJG0Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oMgKnburkno=:3CwlMVT3+jF7wNB3BQo4NQ
 8l4fI/34+CfhuNWFNEYIBT/9mGK0RI6HeWgctlFy5sc+7d5yldI6MFtFMH58kCNf/rBi1MZgw
 Y7oGhNgemnD+JzzPCUeoa2ggPypGY0DhnkFgx5Wj6JbG90okGozGO55cSOowI96JCPK8MVzDn
 llgNs4Pnr9jOB8txLZdGAXh2jEvYty5WfXGAXuYijsSZRFKXv7ZHf8fgddVJYgxfmQAxGdLEq
 trw8XSe+zyzkikXsUsl4SezQwy+nRffIXTCCn8DIr+UYzOmV6VuP2xd0GTf4Q8/nA0hgUoIva
 xPlUb5xcOQEqLOfX7u4AnYLUPqv3jy1ZlvGVO3Or+KXUuHRCfwPjAyI4Ua1tpvk/9ogE3WEL0
 Qfjut8iZxjeMxOK3Lc8ZtiCu8EGt65xyM3lyww6/EhwiT6Dq+x0+ROWel26/8cpFCKbKCTBa6
 1V/ZB4T8b8Wt9k80hzolyujzdJN7rQt1aqUK+puliXDZRq1i+PL1XYAz55DcerZuK8sJCPLcB
 UK/ARmdNNAc2O/IveYE7xAXLSJQgWcEA89SNPO3ngcG2j2WHNi/ZoUcawBbi3o3LxZCaqmwkb
 dFmXrreG+Jr7jer3Tu79aR3rVMI7/mNsQfMTpmPZEBhhngDpRCN/zlMT3kS+8IhlbFkd/82WR
 SUldiBFfuS1QTwj6lNtqyj7NxyPCLS/8in1ohDZPh+SGG6kgH1XvWgP0XJ2jOmXgnZg7PCWuL
 INqKg01Nx+FOsazlycsImi+Holb1L4sk3aSPsCf4ptPe7fb2GLVPAzUzEiLzNf3zwjy5VB301
 xDijjHxMqDRD1wVLcxMxVvFg8uleOytJwVGaq0mpszYCTAP/4THFQ0mVATJKFuQs3YokO+3Ym
 x4ezSZMWM7+X48Q5iyr0lQVhj0xKs1/DXO1pX5mms=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Mon, 26 Oct 2020, Rosenbush, David M        Collins wrote:

> SUMMARY: the git add --dry-run seems to ignore the core.ignorecase confi=
guration setting.

I don't think that is _technically_ true: `git add` takes pathspecs, and
they ignore core.ignoreCase on purpose; Instead, whether pathspecs ignore
case is controlled by `--icase-pathspecs` (see
https://git-scm.com/docs/git#Documentation/git.txt---icase-pathspecs) or
`GIT_ICASE_PATHSPECS`
(https://git-scm.com/docs/git#Documentation/git.txt-codeGITICASEPATHSPECSc=
ode).

Ciao,
Johannes

P.S.: A more minimal reproducer is to not even use `--pathspec-from-file`,
but to provide the file name as a command-line argument directly.

>
> What did you do before the bug happened? (Steps to reproduce your issue)
> I started with an empty archive.
> The configuration was set: git config core.ignorecase true
> The file git_ext.txt, used in the command below, includes multiple speci=
fications including *.ico
> I issued the command: git add --dry-run --verbose --pathspec-from-file=
=3Dgit_ext.txt
> git reported that no file matched *.ico even though there were files nam=
ed xxx.ICO
> git proceeded no further after the report.
> running the git add command without the --dry-run added the xxx.ICO file=
s to the archive
>
> What did you expect to happen? (Expected behavior)
> git add --dry-run should have reported that the xxx.ICO files would be a=
dded to the archive.
>
> What happened instead? (Actual behavior)
> Executing git add with the --dry-run switch should mirror execution with=
out the --dry-run switch.
> Both forms should honor the core.ignorecase true configuration, but --dr=
y-run does not.
>
>
> [System Info]
> git version:
> git version 2.29.0.windows.1
> cpu: x86_64
> built from commit: add3cebdf89e93784955b34e1c1ffcba308b89cc
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Windows 10.0 17763
> compiler info: gnuc: 10.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
> David Rosenbush | Staff Engineer, Software
> COLLINS AEROSPACE | ISR & Space
> One Hamilton Road
> Windsor Locks, CT 06096
> Tel: (860) 654-5697     cell: (860) 798-9944   Home: (860) 658-7993
> David.Rosenbush@collins.com
>
> CONFIDENTIALITY WARNING: This message may contain proprietary and/or pri=
vileged information of Collins Aerospace and its affiliated companies. If =
you are not the intended recipient, please 1) Do not disclose, copy, distr=
ibute or use this message or its contents. 2) Advise the sender by return =
email. 3) Delete all copies (including all attachments) from your computer=
. Your cooperation is greatly appreciated.
>
>
>
