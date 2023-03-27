Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD41C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjC0JTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjC0JTW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 05:19:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC2210D
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679908757; i=johannes.schindelin@gmx.de;
        bh=rExz5XF1EqKjCEXriEZvbcE7ZcUvUyIK4XFnB2dJs+I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GpC9MvTL+g9Y7xSXMeae3SLACJssaJMk4zzLFXFCkE8axw82mL/ap+XUYX9M4GfkI
         /XbDdvycroNWaYDZ9SSeNl33hsXLmBQYXgmd4WATDDLjTSR5xWMQaOcRIXXZ7ckxOB
         Hh+PViTLbRAs3fR3QVr8hymPr8LCJeY0tAj+ymzOg9trVw/OPAGdDcGIjfIyyevrDG
         d6tmBTTm2pLYMr/EicvnQUtSnJlxrJfZ/th3VjtRo8ZHKIaX9tz9ZHAQs3TNFHBXZ6
         zbRsuU8DwkeqiecFBl2Xnu+GkMJ00rXQOh5eYH03sngfpEANf8O3IknhrfrPpZ0bsQ
         kudJo/p17C9GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mFY-1qS70T1gcO-013AEo; Mon, 27
 Mar 2023 11:19:17 +0200
Date:   Mon, 27 Mar 2023 11:19:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Drew Noakes <drnoakes@microsoft.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: --jobs=0 no longer does any work
In-Reply-To: <PSAP153MB03910458707331B64FA7460DCAA19@PSAP153MB0391.APCP153.PROD.OUTLOOK.COM>
Message-ID: <ed63b919-eb3a-1aae-0746-1ff582890a28@gmx.de>
References: <PSAP153MB03910458707331B64FA7460DCAA19@PSAP153MB0391.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HedkWqhJ0CRD/KRIKVg6L+MT81Q1rI+CzczQV2zcHHn5w6ioZ/v
 7MCiVI4mJLLyI4i9DcHBw+NJoKxnFJRE6lAdIYJ8uE+2XVniumuNxlfs+iSaePm1SZm/8qd
 Vxrt6V3W4F9A21A4TIfMvKt6DelBAvGIrUGn2QdU0Y3vyHIV2rVqb4Cya9KkHsuZ3EONHDT
 xNYQMds4W27r4J4VOcz9g==
UI-OutboundReport: notjunk:1;M01:P0:bJ+vq31XgLI=;sgo9MfxVDmpqLbY62wXpIDRopky
 CxnJO/d9cKl3CVCYEidstNnHwkyUkOHXvKyVUB3cJAQqPKTBj2dg5k8uXpAqmSh7Hzy6b9q+Q
 jojHIQqF/aj2BSmaXyIYnrfegh3HL6ceeW/o9QKUMa23rKIcbOhQPvc4gNkCUqJkOxc86/02W
 f4A7JfpXqNY3x27lPjAWWyFlrdCUYw1pTMc/cvApn6EPyCRgg/S8dIuv1cR0rXa9PEkz0YsSN
 COkV0g+VJXkTrRN1YZKi4JNg5dogyS+LcdtJd8p50iTk3fLqDNA6tyAMitQg47Vb4o5VxHGMb
 JORQ+aRtSfHHBT/8sev32OX7IPa0XEdvrDjFYOobLOVPV080Vus+/d47QidRcr2d+LtkQfqxe
 eYxxDrYCPCsbtTVahg9CGLYyX0s/F/FGyaI2eX3AB9saSdUpXRoKmO+HqWhNbqnfV8yDfUN1S
 L50IkWvbJYdZr4R0uYxwvdfHaJHCgjK7yfLaYpY5eYSdxmzbLtABhfCeMJpVpCBFuMLmQfxG3
 X7VWFbuSsqs7uGDmwPgKkpb+45U5F39TyXDPjZdnuqRhyZn1ETGz5eha5IsQhUS0TuQYW0GZ1
 /Y3x3+Zn5AtPJeUXr19mDKG1Ve9e9d74t5WHyP+pQ6lOeD4JQRW/Vd9XA6NFq/qsfOcaftxsl
 17bGyXs9RY/FyUGbi3RU44adYhxWq6RGtKltGFpjEcnES/7J/QyIbaPGbhJ4fKFrh9b3ws9xi
 RFK8Vx3KdhnK8XBF7ryDNVrl2bOrY46AfbIZOBpgvyqi/RRYQrCZxpdrX6OlFW/0TZjICjuCd
 VAMeqkWHrPpfvl3MUA4kxodSROeCFfiBrBTsl7OBbIEHXNkIX34MjAP/ULcafgfY4x/Fu4TDb
 okah/nZNWIaJT1T96qIXeum/ef762rjn/ygqAAbZIgVOHiV5T0L92IptYA9QIVVkY55zfmU87
 miDyvRABErb4exwUZ+p9TNbCixw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Drew,

On Fri, 17 Feb 2023, Drew Noakes wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> - Enter a repo with multiple remotes
> - Run: git fetch --all --prune --jobs=3D0
>
> What did you expect to happen? (Expected behavior)
>
> - Multiple remotes to be fetched in parallel
>
> What happened instead? (Actual behavior)
>
> - Nothing fetched and command exits quickly with no output
>
> What's different between what you expected and what actually happened?
>
> - That command used to work correctly. It now does nothing.

This should be fixed via
https://github.com/git/git/commit/d180cc297922569e530da843bee4df3964167dea
which made it into v2.40.0, unless I am mistaken. Could you verify?

Ciao,
Johannes
