Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9CC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 06:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E7A611C8
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 06:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhIRGfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:35:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:47039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhIRGfI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 02:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631946819;
        bh=RnpfFmJKZ+V6UBKtrnzi9iy3Rg2pAScBEx5Sxcf24A4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=U/kMCv8gexE+q7UKulPR6gQoxI69cFfYu2X+o6/W3EOpTIZ0LXXNCRPpqU+YcRAhF
         wAAhTROfLPRCf8+t2VLHLgVOH4TKpZcnxj1c4CXusw/vGLvWLwZh69NTkVdBTVkBRY
         BLVFkKKsHBIm0r9+Z9Sx3ZrFyP8jNdAdWb64xK8k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.59]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1mgeLq2ucr-00FlFV; Sat, 18
 Sep 2021 08:33:39 +0200
Message-ID: <9bd95c0ad91bd490adf2b6e57495411a0f72fe50.camel@gmx.de>
Subject: Re: data loss when doing ls-remote and piped to command
From:   Mike Galbraith <efault@gmx.de>
To:     Rolf Eike Beer <eb@emlix.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 18 Sep 2021 08:33:38 +0200
In-Reply-To: <2722184.bRktqFsmb4@devpool47>
References: <6786526.72e2EbofS7@devpool47>
         <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
         <xmqq7dfgtfpt.fsf@gitster.g> <2722184.bRktqFsmb4@devpool47>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D+OqzmU9Yf2Wd93LvHRaZwCa/Q+J42EDYyKg7wE0/8nmmHYR2oS
 1MTQLJIwc1wMDMPZWotJupCDDmmsRq07fjer1FjJ5ORxCrR3ijsouNEW3uGc3/gW+VGoZIr
 xCnwc9KzV2v1xSFhamRGq5TB374IdKiD7uQgy9LylwsfZm4PIlGYKgPm3TBYF8aXp5/VDZ6
 nhjgEsJ6q+flT4M+wUd0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6siFrffE2AA=:CQGYv4WyYAGxTpd1cx6kno
 G8hG0emZRcPeqWQTPC5e5a+k3hAhkste9/P7i11OD7kBt0Od+ksnf5GWNFv82TGmUzBZvmxBP
 dnpy147022QeVSxmbam2r3lcPlrbgzV4AnQXhZLRwNSbjlaQ5dgfGpOUwgcBCopnuXPIYTnh7
 K/BbS+KDnB8wD2pfCLnH7LnSaSIx0oNQpNXonnOnBTjZLCLDVNSOvQle1zhzvduIUyMxqD4NQ
 AdoB4DD0EiaIc498gXk+ot2s7IoK9yU9zNsKB6Bn7inSp0vVSpSvLKlu8gMe7+22aOKMQVhul
 FyjJg9sD+LLsNHrnwm5Olb03m8ZSxnwO+505Y2vx464bwMiUAwlAvgNURMt+2cZs0vGLA2jRn
 4o42FIip6tbVIhmWz3I9lUkJ4Uq+8RV5WLiJBtAk/8uSYG50lOWYs/j7EpHUlNcCSSoVkWCNZ
 D0ou20w4slr9vYE0opOlfhmctXlU5V1FeW592QU2rs9YHq34IpojmPyRdX2HKATlIqk9BYYzT
 53xOvjGpmTdfcSSUkLyMHtb/fFAIOF+CVTiV/IZUHqnXnH4QmdNocyiedixtlyThjsCKCkM6p
 qQPecqBeCy/RiYLrcmb1hnL/E03OAtGW9V1HBJ3Zqozqsn4+ECfXiTHDBdunNFfFprVvm7+I6
 UPqkaH02gDIURyNRD+60Ao9UfUGEqkKO4OC48VhK7DiXOOQKgZM8heakZI+W/tzyoMJZ+oSYs
 0Pp8DHuSEab7E1BnTS/VfePMaU7589bev/E45KDdllPD12MyFwAx/u9XWmz/jW4jAZZ2Kiyl9
 131ad99iEniLwp8KZTZ/DJipsLvj5720OMZIGO2V5W7Op2ePc+oaGgfCUxxQfu/78z2KuGw+y
 hgmEUtnHZXj5JN1k0qsVbKmBuoQ6fzqzNI67/Zr2l6s4GneWJXZhWc9OHvqM4OaXHnb2EXmC5
 PHfRPSHLg3enOQcFByaeIJnRbEV+WWfxAQi7BS61Qh8IP36lE0LYeubKt6rQv26HrlZkqNjBn
 I0yDkEiZwsXIjsIkOWvsiOkv47d8U3VI8Hhc+0XdMmx29JGNkYIywD++TiCe1sIXLbXnf/hMR
 P2H7oAmFHHM3gM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2021-09-17 at 08:59 +0200, Rolf Eike Beer wrote:
>
> What you need is a _fast_ git server. kernel.org or github.com seem to b=
e too
> slow for this if you don't sit somewhere in their datacenter. Use someth=
ing in
> your local network, a Xeon E5 with lot's of RAM and connected with 1GBit=
/s
> Ethernet in my case.

Even faster: what's coming across that wire should be a constant (is?),
variable is only delivery/consumption jitter.  If there's really really
a pipe problem lurking, you should also be able to trigger by saving
the data once, and just catting it, letting interrupts etc provide
jitter.  Which stdout is left of '|' in a script shouldn't matter one
whit to the interpreter/kernel conversation, they're all the same.

That said, if I had a reproducer I was confident pointed to the kernel,
I'd try to bisect.. boring as hell, but highly effective.

	-Mike
