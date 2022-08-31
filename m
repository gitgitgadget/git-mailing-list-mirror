Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED3ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiHaUoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaUo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:44:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3DEA14E
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661978658;
        bh=XhkQ764JbTEL9jiZLwCLi90WgXpYLpKwDWbgHBFwhCI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e6lni3EP1k6KrHEdeLNiXVJeFFA8i+B6iT3kXdieWjKkTengiW/xHQ3bemucocpro
         dM4PfPobeqASAdGbk21fTYteQshme7E/66+CCpNHhGD79F9u+wQV7n7Ac1I4TdqXb1
         k6Fx3RO4TDULqjADDQY8c2i6HNj+hemy/89Z41W4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1oreDi1aWW-00Sf92; Wed, 31
 Aug 2022 22:44:18 +0200
Date:   Wed, 31 Aug 2022 22:44:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] built-in add -p: support diff-so-fancy better
In-Reply-To: <1d4bf456-6fc0-b675-f0ee-f8ce99bd38b2@gmail.com>
Message-ID: <31rnq09n-5nor-22n0-r68n-5o46p313p5p3@tzk.qr>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com> <1d4bf456-6fc0-b675-f0ee-f8ce99bd38b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FPJDEl4v7svBifZSTs2qaaOCaX376CS0bOXmV0yAfpq9ISudEO8
 1i8TB1o5sqap6IRH2ompGlnkmLJBKohRDi5Vpju9e7RdpneWw3eZ+RGQw4QHKNiZijzSBDD
 C7zp1mQXb0lY2Mq9PSYTydgedQfI0yuqVtUmpcqtzi9POrz+v+RNgyFmnr0JG3Mn9IccNkA
 FqT+hGNGSeXpXSUaP+ZAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VbxMw7SgP6I=:oRuEQ/GNz2iFkuB4dfFp0x
 hQJrq9Abzgd4383UstUQGCRC3HSB6sASkVvxZNx+wvMebQvtKDwlY+yF20K6GVUqoUqIuXGMX
 roJxAxDanN7bESrTR/KHO1A2HEm3az6ktxcf52by0ttFpgigisdvKjlpw1rtUDCisWkjh2a3b
 AMcPEwzIUW9NrOWUzESBofUAFI9DIrtSG6clVKK+WpcqqCT7vdiWckCjODbBy9qNNEJuz6Klq
 171TWS8wlU+OCi4jthqC+6xpHbUONnFvj5iiDyzZG2KYLxWYGDtb+WuhJlx2VKx2bjqBg4YuG
 N1Zo7sPNJzF/u5XS9sJ8GeBh6cTIDULgDzY1O1Q4a2kzgICwuAUfj2R6aZf6IScLxEZGv/zL3
 XOBrmvdxM2kxrCLSXA9U4Y2sHAB+E/kztkAS17bVxTOFHh/app0wI/HFG2y7+s8uNTMKbKvit
 ysa6aCYT347cPQGAICmvV+SAO6OyG7ydtG2Ww4UZ1YZ2bQF2DW7juVfZXv7mMVbLAoAi0FxmA
 ThsWCU7NApUlEH46jgYoNvKjPB5eZ9a2OKXcKf5rbhGyGdWpZnPQVge91EJPn7IO795/0j0GF
 7ZBXks6GBj51vfReVOkogVa1knMO+wPxPlfT3uPrQ0JRVYAzScpRXmra0PA/cYQsHnCH4tnI6
 nMdcaB9z2Zoi2ahEAP4YxHiFNslyVPCb0aI10s5oLUraZx4IKMNAzgY8SImnMTPfmFOExCbKs
 6b0ikVSHdk1SWK+DaP9FHSh2dTylpCaMqIU+fPAWUGLUQauaSSDwc9eFhGYXfBkgAjdaDRzWz
 JajmRL/MyzYMg0GukiTOPh2sqVmWqvL5Py1liKqgKt8LUwfE5XCugqCevVanmVhMEeURhh+iZ
 IcVWOvgkLEcBglWRQtWYr1L+Gc4Cw7mME+CRuw5QZVCJYv1ieouLWT7s45b5gPxCKj5nhfqY/
 6rjMkHjFWLSMN1SAtcbWG0HSwfPKn40TLLoPrnEwZl34L6S5joac3sZNnqQUVFBcuLfN9elnO
 CWLQ8XRN7Xqdw+IgVikPauYCK3+0ghbjT/rozJGV+0urs1pjSeN2/c7ptxUpKKdqMb+QNgVv/
 Gv8cAes/qR0Hbf8e140EyWjKLeyR7xLvYTxhLHLSskozHu2Gl/6oN/JgO39oaofZn8j1tN5/y
 /QYomxmZVMB3CbF7Op1AN7Glyz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 30 Aug 2022, Phillip Wood wrote:

> I'm not convinced about patch 1 or about showing the hunk offsets with
> interactive.diffFilter in patch 4 but the series looks basically sound.

The fourth iteration of this patch series that I just sent out should
address both concerns.

Thank you!
Dscho
