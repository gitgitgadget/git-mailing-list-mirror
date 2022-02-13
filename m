Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC2C433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 09:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiBMJCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 04:02:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiBMJCV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 04:02:21 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA3DD
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 01:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644742928;
        bh=bCRw5DWp9bmKzz/BUan0thEjG0xx0nSa0ua/VcuMrGA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ju/k+VHeTuAoijOq4xygjYWLyVGlWPjEsDqhLLS4U2+K5edgu7XHdSaAj6g6RTF2e
         S8B+gaiHu0cOO1f46MNIS738lPJPQmUF/C2DFvHG4WQqPiy0ys7CS7j0G0g0kEsn/W
         gC6veo5l2PpCwOZEjCiRhdHJiU37vNlYd7Rq/TDc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n4G-1oOffd3vsM-015tNZ; Sun, 13
 Feb 2022 10:02:08 +0100
Message-ID: <2d4358db-fc6e-dc89-e647-b1b810817873@web.de>
Date:   Sun, 13 Feb 2022 10:02:07 +0100
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
 <xmqqk0e2frux.fsf@gitster.g> <f83ed995-6dff-bc41-8782-48ac9f1a2651@web.de>
 <xmqqk0e19jrp.fsf@gitster.g> <b05f916c-4b04-4db6-d203-10be0a8eb615@web.de>
 <xmqqfson706p.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfson706p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:219HQ4Nvpji1EzUl/49O95MncCnFlVWvBbjZrS1XbyHApEdGPSM
 KD6MMuezbmju6n28lvhNwhddUp8TG+BCu5SgxSg3LBF7nuZYhlc/LtxRgsGPlThAdhIQLkd
 MaJeYQNGtmv/MYpfJ48pfsnRin87ecb6KxAg0I3ncqtEac75lBhQtcil+zTXmDR5DwnAcmp
 mBJVIoiUgBZG5xnDrjM8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:StIMQ6XtYfY=:Rcm32Y5Uf+sW269MODzNST
 mYSEH99WAYAAMHSbsAenotthW0Wy09syVc9VaedsjSY0C3YHPXncguRqAfiXSnOvCWQTgkCMu
 2nHVk89d5hZa+ptLfygKDx/l64MCBkcA6G3nlU5Ct4af439SpLW2dCtbUR4Y0nVaSm943ZDof
 6abEqfcVP4hCPYhkOeXsJsmb5XvVs3K3ucRnLPrTV3zjmj+l8V+QYkZuuVAWMyHK/q8HO/8MM
 LIjeX4Fj4bEq+gbL9kCWMcEnm9kkblbVOqoK1CYr74JaiBCJbY9kBAEwAa/pW2AvGDzrAGeO+
 Q5zVG9qt6bAkKM4IbUjXbWatkS0vKCL3Q4HV4xL6lObr7prehedPTETArUdMSo8xW+mQ0ZK5a
 QAEO/MtmTpGC0elnXfBZZq/50SnwujhTTtZwsmff8+Ebpdojm/3pglK8a8KozpbKPq++77YkA
 gU5hleiVJuSMpUCJJ03MKTN+GnH+YKNGtlRPqIpsUqFg65b/F26ywIf04Y9ll6R8LBxwQhFpZ
 exffqH49gWuSVEs+lAqwIRbq36aeaj/bdWbgXgDsIXMYuikTGvt/AozdqdsNeCXuYmy0wHkmJ
 +zfWQvAId3uvSoz6PcftKaToCGH29FX7Cqe/n00rFx/+CPypMq0zoMDf+Bdhe5NrKm6guIj+8
 8uVMtSOetX22Eu4LdTG75a39tVehwrhgFVcJiEnmSoIs6pu6g1f+hea6AtIuYUJO/3TlsXJqs
 PgUp56H+Ce90J2oRb+ZZGMbFzioLpQjZpSE6Ir8jbCDK4omoEstD7JvNtuR96dVmPm2BmLULa
 hqBaug3NTWOKN5IY0LFLJ6TegiGnU+bYDY8HsxxYlZkQnBeDkCmFQBSDtVWrQhf1/WtbGgadr
 DMCEq9Yd4LcKAa2ihfZcQLXy9rJQ/yr28RN4FwxfchNT+bu7Pfqt9on6W3Xbfj4u1eR8ojOo+
 ZZsjH6E+9YLmuo8UpouR00ynfldU4Oxht82oFrcXaXFw9TLehjxZy8DOPepr1zGt4F9rQ+iWR
 h6ZyQHbYPu3IL6wf6W9eLXiBtuwwNxcfOiDUipuSmlLuj2yLxDLNkgIPa5VLoKETww==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.02.22 um 07:25 schrieb Junio C Hamano:
>
> So we do need some extra "manifest" to declare what's untracked etc.,
> if we allow --add-file etc. to munge the tree when creating a tarball
> out of it.

Right, or get that information from the order of files in the archive,
by having tracked files come first, then the signature file with a
certain name and then untracked files.

Ren=C3=A9
