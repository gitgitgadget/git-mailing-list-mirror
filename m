Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6FC2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiHPKAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiHPJ7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 05:59:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991057544
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660641117;
        bh=olnswu0k82gCbIJveFkDwsUYh8/A+FNx+FDSFqmhWnI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UE3xD8aEeoyQGrq3YZNLpe5cVwaleBwbVK4BN/XkQVOm+ZGgiGxgPrV8yD+0mDtBz
         IkIhapTvStIAM/4XgPrU1A18q0QxkSgnOxsjUCSnIIvw/voUO9Vk0+0EbGAJfYkIT/
         NQA8dZRJpp5dCb5mqVXbrwkzABOo96rALZPb4FZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1newUL1VLY-00lRmu; Tue, 16
 Aug 2022 11:11:57 +0200
Date:   Tue, 16 Aug 2022 11:11:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/5] rebase: store orig_head as a commit
In-Reply-To: <cced4a48360b4e4a8ce791e9404ac6b37bae4eba.1660576283.git.gitgitgadget@gmail.com>
Message-ID: <59p441po-0o06-7660-r571-9nn8nos2r5q5@tzk.qr>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com> <cced4a48360b4e4a8ce791e9404ac6b37bae4eba.1660576283.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qQdRucgRKDv0FYaXNT7mwkdEQIyGIUVquvIr7A/7i9tuEnOg4fZ
 kUTOufeP6WFPQ18TKvI1mHnxL4DrtqTPcZ8Z52HDV49anB+ZCPCF5ZASTK8ed6dGnsrthtD
 cJMUfybk7YdXmRvUrHDdz/rP7kSKiH8KFhb+hJPbQIAPkf/0Ufb1hhXWuzDTtPc8qrRziun
 LGd+SGHMoXoK8HgT01hag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XeJWL5mLZfg=:eRkEbMOo8k8pi22gBRtEIH
 /JrF05jlmbr1O1czOUVMY0K5sk8VZ4R2c2UyQKsLZ0BTauC5VUMehFnn54ospO0ttMDf/iI2k
 RULoYw3g6qHEIgscikcnWaJb8F+THH7XMOLd1ZsfdbmLyrXIZE8OUnqkiqdN0ihQ+0Ubm1hl/
 2QoMN1keME/iURwu2YRREeiCy60n31FGnAaE52STX4k31sUJTz3MrEHRoxEKgX0ieYtos7cVa
 EPOG6wAHsLfPys45ge35gj6KWbczbypVwFDmVAaYNA3C+C4MTlAjAf54dUdLzkX/KLdQqiuPp
 5459KEyVLSu/cVZV3NOX+/F03y50j0nsMP917PDGWj2UbgehFgYj4FHYlF4G9PL3ymYweSDkW
 PcYaUg6Q9SEvRnvzyxj8fxr0/rIH+4tEVK1Sf3/rd1PO0hKJKiBqvgr2kGBLa+tGa2KfTnrvg
 K/Eu0kPj/M/hED+Ge52WLBsJGP1hZZijqdWZ4zA6ZnROgz9hKI88FHLozgYC+CCK/hPWfslg2
 qkj7Y27pFgGRRGAhsJ89mfRpOPFdDq+v10epyBcA0C4+MViKuZ7e5ZL+Nc4bOxhqnzhT57Lz/
 OTAi56D9tHlcYq+0hKmPT/e5udg/Dl8nx7Uom2FRJd3zpVilQLd/zEVdHaC32dgmZEH+i8W4X
 2PDdM/Ox80imATvVTm5At7JAJoEfhT6VclIypY/nFDExI4mcwBRKE0XbTEe9rm5Wl8HQgUWsp
 CnWDZsswnPF7YwrSwkamfF8lk6kU5tFm+RpMXWS0V9Vb0f/oUZTVo15zLy5nfa6ipGegnzxw5
 CvEZ6ESk9pxT0SHvdcMLwPWC70TxZECyYIYP4GfvbxX4tku9LuDPx3IKdqN2tX218FPpVR2uA
 pCmIsx4Z4A5Xin7yPnBn6uZcB6SEBlrsyRm2jbQ43pcqMjoZ3YZawhaxN+Ik5IXRQa7HjQdzI
 2Wse0NYt/FT8BhHB09jEbeYdrOfXROmKaIVWQq92sRXfKEN5ByLOgzpxIeChHpuvZ68oBv5l+
 8Tqe8AUHcJi/XpctcSLbjwDyDSXB8EzetQuiUOX5ErfXy9cBQtq9uXCRXdMDKemUe3bjW1dNd
 VwKw0tEC82KdAlbPhP0Lr5DuZfZzq7/oSMwxTcr0Ozi10XE27Pi8Bl5Qw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 15 Aug 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Using a struct commit rather than a struct oid to hold orig_head means
> that we error out straight away if branch being rebased does not point
> to a commit. It also simplifies the code than handles finding the
> merge base and fork point as it not longer has to convert from an oid
> to a commit.

Very nice!

The diff is necessarily "chatty", therefore it is especially good that you
separated out this concern into its own, easily-reviewable commit.

Thank you,
Dscho
