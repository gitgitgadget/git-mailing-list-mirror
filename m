Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B29C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AFC6101E
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhJGUoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:44:16 -0400
Received: from mout.web.de ([212.227.15.14]:41489 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232894AbhJGUoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633639329;
        bh=xIJce2ToWs3B+lROISY2EeC4KOWsFPnZPli9/cw7/7g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yf64cxb/oGKPFLaLawb5O/nm2tAeynrPENvKrN85DxT54AMmb/VfVkbhcT+sNtEs9
         6QUbAeYfc5AR3iK9QhcNESoCFEVXkc893D+WXcjbh5YpnSoUzhCdQP+RWAUsiH/vbV
         pDFYuDK2X0a3nM3xRzzTVG/32bTudbEbJOEId78k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Lcxw8-1nGkef1xJY-00iBPS; Thu, 07 Oct 2021 22:42:09 +0200
Subject: Re: [PATCH] p3400: stop using tac(1)
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
References: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
 <YVq752xjzYz+LTq6@coredump.intra.peff.net>
 <f6a1296f-f524-9042-7f88-9591522971af@web.de>
 <YVyppmEGkNCxZ+5L@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a3377973-4f4a-376a-f02e-94a3b20dd9ad@web.de>
Date:   Thu, 7 Oct 2021 22:42:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVyppmEGkNCxZ+5L@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AZorpM+HBnr9SE8edso9dI50/jadKOX6o56Sodc8F6a4aXcRlt4
 hZugpxteX248t6LVph+EM1tx63xPaf0mTbefKqG4j3Qh4CYJUtmVJHF9NC/guowXOlMR8OA
 ypuidivMKHU6r5wjKF2f7aqX2SMt3Tpnmu11hIK6yhVMvI9xxjDVTKr6hC85aNKbe2yxinZ
 EW/z0mc5opHBhWjKkWPBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6d+aYoh1Ew4=:oz6LNbKmECGFvfhgCWuzWs
 fO+w1ENQlxBTT5B+mup3+DphIw0VlQtq4fSRieWho4fYG6zlsFE3dPR3zVHh0U0KNRgJWk6JR
 xzVEjQw0muijO1Emi1yPwrQsQxb3Kwl/r58LhCp7sTpLjhyPPcL8vWHoKn5nF8JO3NLUYHPii
 IjqJO5RfRSqaHY4+EJH3VmdLFJLutoX0dZ3hxDI626HR6Kg8rxPGefisokdMEbEYk0xMgfCVP
 XtcNECY8eSWA1h1RDnO/iw6hr4kksNft1IDkrBQ9M/I9aqJ2BzLTPygdQ4afyXkRk2J9WG1ab
 gxMaiUt25N80FsaojzpfnrXybArUOitAXBgX4P1ajQ1Vg9iDHvtLCBx2Tub6xcomfccvUJM3c
 YDUl8BBbAWcrkZL8dKHwqTv2XAzKngS+5bg4pFQXHC/ttkEwrRFZPlkDwY+IKrBq2tSbtnNa8
 CpwnY3h/dDG8vRlls1Y3DUqWtt18/cIKbiTWDH7ceXn/YCJAiXM5IWMey2UQ4uZspBNi/MQoF
 9iK9sC7ZYXGW1c8QccLFxsxphlfQUzCPtha6kW5+EkSKpyZwNYzErPBvoF0u9y3lf1EyjbWKh
 cQ4Y/BD8Nu+BQOpZdTg3l/tPRcB3ztXBe8JYlNPMSxZZbwMiwq4Bn2W3Z94aba7LamL5yA3CC
 WFBaLP+nIyXqC/JOIY4UKZhRQZu+wNM1mgfIRdVtF5FVHA9r6KjNa00woSiVYWV1NXkn+FJpm
 DQIvOC87VDfGOZXKyiPAxL7iHL/yOzRAyJaCiPwU7WTkg9BduSxE2mCuXXEiJzL0vRxeuoMVT
 8Tec3MAb92/uStdgh6qI+rIIh6HOiGB/Bt+8v4jOdHcbLxzEtLuSE1v0aKKp1iJsPlA1oQYDD
 9CfEb9V+ZNnd6WFSyy/Wf01ZbexXBZ2q6mhN8Q1vPo0OwWSJDGpkJEtB+i2FV7RWItYwi5Tvu
 9flH9MPHwRcQl2xphjqIjxIo0wF96Hrs40SvWurxUNZ6itqv+sKEYxDKQOHeK+fUblBtL3632
 zypLYQTuTZ205trM3rjFHx6AA/1K7M/qXeUmo0N6TrcyoeYosESn8o+cxB+CyPk12/rchyMUd
 3ygmMchYRaJAqs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.21 um 21:38 schrieb Jeff King:
> Right, that works. It does introduce an extra awk process per
> invocation, though I doubt that really matters all that much. The diff I
> showed in my earlier response works totally in shell, like the current
> test_seq().

In my mind, test is an external command.  Wikipedia [1] says it has been
a builtin since the early 80ies, and I couldn't find a shell without it.
I wonder where I picked up that outdated assumption -- I'm not actually
_that_ old.  Time for an update..

Ren=C3=A9


[1] https://en.wikipedia.org/wiki/Test_(Unix)
