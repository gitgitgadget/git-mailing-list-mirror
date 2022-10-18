Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2EC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 15:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJRPPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJRPPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 11:15:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505A915F2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666106123;
        bh=NLIUo68NxUYh3c5iJUP147gxnzllK3HGC0fhq6uGUlc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AvN5fjVvqGTZGtd137Xrq/8UEP1IEGfSvgTIht8CejyB8gRsMpRJuUaWQ9B+n/X6A
         QePyfoyxgZSjmav4N5qgJvy40cicai++ErpTjIH5iAfWPALgP2kuwLFFUUkIJ1oQxX
         /xVuKgA+yzelbl6uGUEvHnEbVMDboOaqQ23PfW8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1pJ38Q3LPx-00amfh; Tue, 18
 Oct 2022 17:15:23 +0200
Date:   Tue, 18 Oct 2022 16:30:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Hans Meiser <brille1@hotmail.com>
cc:     Erik Cervin Edin <erik@cervined.in>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Dead-end Situation created by amending a merge commit in a topic
 branch
In-Reply-To: <AS4P195MB1527956C72FD0407FF4C488EE2279@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
Message-ID: <n7599nnr-qps4-oo46-93o9-8310q0r44714@tzk.qr>
References: <AS4P195MB1527E825B28B3C17F39D0AB7E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM> <AS4P195MB1527C07F4E985018B6BD12C3E2259@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM> <CA+JQ7M8Bcr9czyBNg-+sFpqGSy=3QJfps8vGPa=82QGAvqpUSw@mail.gmail.com>
 <AS4P195MB1527956C72FD0407FF4C488EE2279@AS4P195MB1527.EURP195.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3j9YOBhhYUWCoPjaK29/TpwIyhu5a+OsjX/3Q6LFXYYGB/XmFpT
 n3uGbRkqAjG+vMfRufvFxTUHsovYck7OxKhFnPrD1N0vrU7PtZ4cTuBD2g07oJqIAh0mYSk
 o67SjNpx4MDjqUrDC6SuG+MhEdUfxUlI5NIT+ev8w9QcjqDRZJWmpXlDFpJAdoc1awnwgyE
 ErXPORzpnaT4A/n50DXnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4H9hKDyyBXM=:8bKsMPkFSti1u66+QJx0Km
 hYD7nO1K/2ihJt7LL3N85FtM6WvqzORpQTfT5NM7Yqen98joUBVk9gnNElq3YmiTTHEh/j2c/
 anmSnLDchppfeRzNop0fvW2Ac66sp6zUvbPo5JnY+xWLcdpM1dqWvK6r0PURUIr9tO/Tzm3ww
 XTrxG9KLXSNsGtAEnJrfehR1jryxGXVGcwl5HCvSTd1g1pv6wPAS2z9+gqkizygYqARVuPQEz
 nC1brMkb0aNQpSVF41p6KhkuWaYBM3YPEDHyM4dF8Ex4aLM3q3iOtXtTiDtg+EUf3BsBqMn5V
 9MIFh4961aNaHq3ZsCHO5YzSPHjFVWAx/TyTXn7dIZ73caZIe9Q5kmdoPcsHDyxQhMJts1fOe
 M+fzBtArKMJR3WKM1/JC9iYutkk5QCqErmCGD8CV7Ckck6oSsrCVEKbK+XoHbPzPJXpPP3Imz
 TqjI/C4NZ4X/W2YwDqC2LmiaRU9Ej0qDOAzhBizr2jIuxBUwdAtGfedHtTch5+t8c2OeP5wW1
 FgILs/vy6zcDuvqM2Ee/OmOy30qnSaOFTMrkCdPV7DP6VevxgI9psD1tqB6njox7yTxryRLyV
 POOIQvnC2Sd8XqCtLF7hTUhtMxhXayG8qYC7VRnd4hb4VFsf1o5Lu3zWeJam9AXu2p/Jy7lIW
 cXmUT0qvu3Hn86GQKz8gN7ddJK5i6SUWZe9Kf2L9MnKhkXV+FYJplkBZMsihuuhyoAtWPLzFh
 Hg/BuC16mMrmZga+6gaL7uhEhHE6hGDAnZKCijUrCWlIQYmVWfQNR2m64MVR7IvLGoa+6dF8r
 Dkejn+DcSFCvuLu2xCHbxr/O9NssjDNoZA4XTbuxv3IqWwQKM42WWFd9fhmkWhFN3jd9B1nJQ
 juQs9YtIBggatOSyMwmXIjMJEmrXplWxLHP3vnKNv4ltuaxNH0InQHpc1PooyyENrejMPcKn2
 SSezUcLV9388CcRekKzELXGydkFbUfVkBIKsmPicnS9oZFx++UJsNxzjxr7omph0oBRreHD7H
 itQxCxrfLrT4zW67dCiUpiV+E3uyiozcJSGo+TA0FG3E9wUXZuetHC1PsqCnTEsA5Q0iI0xkk
 sDMFfCDqUNgg1+VsfgVBihhtHreDvpNueLtl9Rq9BODP2SQRHJrWu/1SivfNvs7hqksqz/u6l
 2l1MCRZqCcc66je7bg8ftUyHYGg/1++Q3BANPJawubWBoLY7BTqvmgnOsIqVLfllRrkLAKjqR
 dbxZd4CdaAi99GTndG1ntAu59u+N7Ncg5Du7BOAfjM02Ra/4Bq/1NnMCJm71lB6UT3AwV+UYC
 6Q6qOl7jKup8MsG7M+2BSfaARAK7WFO+zP94/fFBjs4EFfkvkIjL0NNZyzansgt5vCJsNSnub
 USa2qEjq8aWtlcKRWdgk0wJiVbTZ6Hfp//7R5X/Kbaf9i6kjlodHVFSw58DGRHquJGptcY9lR
 4UT1pvg93foyJeXLA29S9ymwqAUKarpQOqDqgM4UWH8WMInvmt1mc+ycpA8sggXN8ZQEALous
 rioLJ+Q2kag9K1drsV9EB0i9TKuOgcGb5yUODFKNXTBej20AZmgUVD9qXlJqiPzWDFw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hans,

On Sat, 15 Oct 2022, Hans Meiser wrote:

> It looks like it's possible to reach an unresolvable dead-end situation =
by amending a merge commit.
>
> For a use-case see this issue at Stack Overflow:
> https://stackoverflow.com/questions/74032523/how-can-i-rebase-this-git-b=
ranch-on-master/74064773

Please note that readers such as myself make a habit of not following
links thrown into a mail on the Git mailing list.

If you can summarize the problem succinctly and comprehensively, please do
so, without sending readers to read through threads elsewhere and weeding
out the relevant information for themselves. It's a better use of
everybody's time if _one_ person distills the information into a
well-written bug report, instead of forcing every reader to do that.

Ciao,
Johannes

>
> Is this situation desired?
>
> Shouldn't git rather emit an error message when trying to amend a merge =
commit?
