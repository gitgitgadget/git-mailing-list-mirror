Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340AC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiBKTWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:22:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347561AbiBKTV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 14:21:58 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 11:21:56 PST
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451DCEC
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644607315;
        bh=OkMZWC9sMLwG0VId7e1RySpjndROXAqJfl91R4Ovfq0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZsSbyVrXGi6Vv+daNpRYcvz0vqdXtoUkpRrZCPSutwAQEcirQTfWq9IJaGcgmFg2Z
         eD2kaRL4utzv5okV4tMTzOVZn2ZQ8y8Nm+nlw6M9zrewGCKHUPOeaVskEk+LzDsOaU
         GAzm618zAJzAD3uT8MbCMSageq5i3wW7ZQycxfP4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1nZiaU2J4E-00Ibuc; Fri, 11
 Feb 2022 20:16:44 +0100
Message-ID: <f83ed995-6dff-bc41-8782-48ac9f1a2651@web.de>
Date:   Fri, 11 Feb 2022 20:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
 <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de> <xmqqbkzigspr.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
 <xmqqbkzhdzib.fsf@gitster.g> <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
 <xmqqk0e364h7.fsf@gitster.g> <6f3d288a-8c2f-0d63-ea17-f6c038a9fa3e@web.de>
 <xmqqk0e2frux.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqk0e2frux.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SzFygK6++/iFk1AUAyFLybmNSaUmUze7V/o09WSkvc/y4rblx/j
 xGzxaeXneryM+dfau1WsUflSH2bYaK8RkLVBdkLExQeXbqcij9FFbGkux0M20l4eU3nUVTI
 BuTKf/7zq9FGzHGLhxFolG0zplES/EOe47L60buMLGEGHuMPnckbxsy55OFG51RRAALhDdd
 QBcphrYE/u31Zvoz9V33A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4VMS8K5Upeo=:W+RiwDDyZM8qrkyE1l7dE6
 0ghcWmbDLycm8wGBTi/1QgNirzxZzbkCSovcLp73AoCLCPGGcV3OIvfYX3TamwlRiy/PfiVwG
 Xm4D/SPsxHDPtNxV67hF82aacBFCTW15/hhaPYLb+atcw94B9zgatmZ3l5rhWYCvMBFmDHIdp
 +Q0CMYGMtWDCUp9WIXc+Zg79+YP3XCN63DjVYgFgQ2ykgI4nC4SZ70VemPbuBAufHsxKiX/iv
 Ivoef/67OBeVrTPBC4MsyBPjEeznJYQkhmLbD08TPwH3BIyunvuXPUcwQUb8yrzNabqOFPUvJ
 Z+nkQDRY6Zpbxvge8ucKxZV18QqazsTJbjGKKFXveZPKdTYY7+/ulTXKs+6CEerwyJVuqBw8d
 Eoa5mHDc0+fivSI3YWqX2nyGNRSp26nIBvcU8Dp//8eaVOo9rTuSSA5WD5Gywp2i/gEi1sXdO
 rTWg05KwZULulYgJ4pHRv6eizFIiNYmYt3BPW/Dh548+2C6UBgjIZsw2u164jtmyygaJNc39P
 dxJa4L/+6r/VGG19yAbF6JAwQhtTpOUS7FzD4lbCeGe6kFjWEWceitrbtcZFH8Sm7Byfpp4Cx
 RpPLAsevh6ibiy0DS+8UrPxuFA+8Lb1WqaFwqO+0VGATai1pFIDZ1s8gm33nXHe5SdWUWqqUr
 Q3Zz3iSog7wqFc3HpOQlWBYo5/5VxByHnQtyHKwJatavJc5Vy37RxekDdh/ncdSwN1NB1kNYm
 FWbpFxngjfjd2Ir0GLCCJmBpu8w42OXDuXkA+abOQce42nhCBY7h/ZZU15DNOu6nvB+K6Cwsj
 lJkXdtxjMIL5DA1U06XtM8/yKX8UduQf1Cn2hIjft4PBCoOPvkrHzSKygeq0QS0lgngVeumsQ
 YcwpY7NW99xaleNqIc8EwKISe2NBPC1ISI01aPWwWjB3zJagvCHARqGFNrVmp6P5Qj4MjwfoK
 aYGLIijxAl0Kd0vI5WiOY0vhTNiF5O+e8Bydhy1O6VQR4LfdtNFyHpxNanlOFjltHOOtuYNx5
 kePLtxi9NBbmr1Nd64P9f95NwKShPv6rSay12xvSLrMpp8MKBU9M/fuu3aDx//B2Cw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.22 um 20:23 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> Yes, which is exactly how this (and existing --add-file) makes
>>> Konstantin's plan much less useful.

A harder obstacle to verification would be end-of-line conversion.
Retrying a failed signature check after applying convert_to_git() might
work, but not for files that have mixed line endings in the repository
and end up being homogenized during checkout (and thus archiving).

>> People added untracked files to archives before --add-file existed.
>>
>> --add-file-with-content could be used to add the .GIT_ARCHIVE_SIG file.
>>
>> Additional untracked files would need a manifest to specify which files
>> are (not) covered by the signed commit/tag.  Or the .GIT_ARCHIVE_SIG
>> files could be added just after the signed files as a rule, before any
>> other untracked files, as some kind of a separator.
>
> Or if people do not _exclude_ tracked files from the archive, then
> the verifier who has a tarball and a Git tree object can consult the
> tree object to see which ones are added untracked cruft.

True, but if you have the tree objects then you probably also have the
blobs and don't need the archive?  Or is this some kind of sparse
checkout scenario?

>> Some equivalent to the .GIT_ARCHIVE_SIG file containing a signature of
>> the untracked files could optionally be added at the end to allow full
>> verification -- but would require signing at archive creation time.
>
> Yeah, and at that point, it is not much more convenient than just
> signing the whole archive (sans the SIG part, obviously), which is
> what people have always done ;-)

Indeed.

Ren=C3=A9
