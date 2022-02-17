Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB717C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 15:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiBQPpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:45:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242510AbiBQPpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 10:45:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68442B1025
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645112697;
        bh=5lLNw3y6SeEnM9C08KjthoYTXC8cIJnpBDeaWLNmSpc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VZz/8PyljAoFdEj0tXOHM0eYFZAyUPxI3rSI2ON+gnFv/+wur27bPuSZTM665ByPr
         8JdTAbyLi7e062iT0sA+Qo3mxW1H9c9dfKbB3v0NrLOeg4880OpDlVIiyJH1MIDE5x
         iKfcDk09npivWSZsphMiZGE3ciQR2u6UQ8tKZnpM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1nj5IP4Bgn-00Swvp; Thu, 17
 Feb 2022 16:44:57 +0100
Date:   Thu, 17 Feb 2022 16:44:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Edward Thomson <ethomson@edwardthomson.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] xdiff: share xdiff between git and libgit2
In-Reply-To: <20220209012951.GA7@abe733c6e288>
Message-ID: <nycvar.QRO.7.76.6.2202171644090.348@tvgsbejvaqbjf.bet>
References: <20220209012951.GA7@abe733c6e288>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8vv6cyLrxTa0matiJZ/UqIvEPzKaBS9rsaEqFtbg5LEB1pesrLZ
 8zNfHaW96+PWCZFny5fMJs+ktN/PEv1xabpmfliWC5Qq2wNEzn6YZssQeysaS+x3l8bCl+z
 sT0vwy3dVl4XKirXTMg0o9ik4Rwm7WjFlyzai8jLaZTkpbQGpTtxkFA2zZ54U4vAfcSWmIt
 C/vrU5MAjJ2wly263bRNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FtdmAuZTmZw=:tONGt/Pb+OZtgJEmfeZIlV
 aY8AlqgCRhT2f5QJYRInIpLwXeiMwNSghRPcQNeNZ0jZk/58Be73AImiazzvuylWvr5LbwfUk
 gxOgg6nFq966u7SnYIkRUhPlmWAoiMztTnpn/dkhKojgwoKNuapuvWyH2909tCVCPfvUW50YB
 9LjPeVJcooOT/cv/HC33ujwD6mhkkWeGsIBQKYjG07JppuAwYMiKOnlD5MnbhBlJl2Y+K8bWI
 gXkKpcwLGo89PxnUmX2Y8NbEaescmBgapjnPql66bcpPFSDcYnM2/3Y9XzFJ4CRupQHS05Kva
 B55F3B2eikS/L0kVPnnr/iMyDbw50HSLyVCEKEjAFcn/xMSVrFYxdYvoteEFEXRo8XrWY4D2o
 LjpR2fWGvzfM/sz1BOPS9gxvnT0ebz/UlFCNJEv09ZIu5MC6EqT/i6isxlJkqEmxglU86j52i
 PAjvo0ENa+uLA8gKrQr4jl3eqoqmijCqNAMNXzqIPbBV4mcVWIrKjcRGx3xZLYNOvgg25ED+J
 8HKbgywGHLRVsgJlYN60FCClDYtCo3IWdaBeJ201iTC/uRwBQvc8Q4ai/D5GzoJOxVPfi+Oje
 qLbkzHCVP72gbVUKnD5Dfi1eFmTHi1VhT8G277JS5rnvSEMW5rTAC+Rcsn7qVPMMwq3w0v9/O
 AEu8GPOieVT6eaOv0XmjiWQC9BZchBI7FoTH/8uk+73iu8tgLmf8yDPjGPZfzIg3y2Rbf54j8
 /8BR7pTrsibIGpzKxXYxSEEopJnm/iYNVzL/tSzkr/TwrBZE6Z13jvM5CpyB0UBs2bEIwGPrT
 PhMWj8bSl1Ca05vF2M7Bp+sdo92131MussdIp1CGAxPOKm4V85YKpsravrVUer+7MmZtTsEgK
 l0yUYGNDL12tlkWIFiCeoF+PpyHQ4mFQ+LiWzGndjVa2ZEkb/KlcjYFL3vUfLP7LTZwFU8PG3
 wr+YOHUl/BCYFRC+bOJXkZfYt0WlB+FgYo2wE7DNx+lwtBqUvW0gUoNZbte45I4Y/2HOw0IEU
 uDScXKr5kn+bNst+wDlL5I0EbDewYIZYHZIWc+0wAleQ5iBtXlSx0RxNzWUiUu4SsN/vS1klW
 oKlhLTjEjWxFgM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Wed, 9 Feb 2022, Edward Thomson wrote:

> Hello from libgit2, where we borrowed your xdiff a few years ago and
> have watched as we both hacked on it independently.  (For us, mostly it
> was around tightening some things up around warnings and signed/unsigned
> mismatches.)  However, we'd love to share a common xdiff implementation,
> and we're happy if git is the home for that.

Great!

> The next patch adds an indirection point, `git-xdiff.h`, that contains
> the git-specific functionality in xdiff.  This keeps the core of xdiff
> to standard functions.  Other xdiff users, like libgit2, can specify
> their own compatibility functions in this header file.

I like this direction and looked over the patch: ACK!

> I hope that this allows us to make progress on a common xdiff; we'd love
> to go back to building it without warnings, but we'd like to not do that
> in isolation.

Yes, let's combine efforts.

Thank you for kicking this off,
Dscho
