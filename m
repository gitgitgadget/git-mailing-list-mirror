Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA3ECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 08:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiH0Iyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiH0Iyn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 04:54:43 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7168E8983B
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661590480;
        bh=tl42naNH5szh6hPSBeVgbI9xUljUuZqTOzPqBGY8x/M=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=sFplmb84wp+7sKsBOTcRWChrpmIxOGsR1kk+CBjzHCfgJoq7oUTEstxe7bEZL+yPB
         kOAnZ80oBT5f8FePKJg1SMXiHlWwSDLvom+TTr9ETG1etyOGJhieXqX8qZwdmtSKZh
         G3ykk6DG4SeKyPG6psR7N/m/2B3d9x5W9ZMuLsoc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl4z-1pCl8H0irt-00pmJG; Sat, 27
 Aug 2022 10:54:40 +0200
Date:   Sat, 27 Aug 2022 10:54:39 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20220827085439.4qqfdggdhnytxxav@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220827085007.20030-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220827085007.20030-1-tboegi@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:a6ropsZUYO4CQWPzaNXegZuWEh0ELrudHg8ztkee6IJ+RsdApec
 DQfxY7ucfJRApfgvDo2ffv3/hrrUNfhARSuHDXqaNC1DKzxxjRz1HQVggm7KO3QICV/bc5H
 /sJfqeddOsCgowzXkNrr5Gtgk2T6ml3r1Oxl1c9r37ZSXka2hyrwxH3FJOQV8HwT5ZRm03a
 2CMFrU8Tgi/cF5ne3B+/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z53RrOLhy+o=:iW+PmvAlooMnXB3AHTBWM3
 KyYhdm35zkODOOF30O4L4E1pbrTcLtyIOeYdAuQhFQ0E4jbpH0N7PGcNdDKe9/Se8aYlAR+Mm
 LS1tnBVsrZzBksZGGLAdzx4G1rA8Tp4D3ywoNXNW0DDqtGB4eZ9ze3MpOYgFXvR1nwoovXrTD
 yqesvyWjpnTqct+hMqULwYwxMpJ5o8vNJb74L6DIDOGyVmJbk2k5+cvEymS1/ad242ElJ7EVn
 sCGNKKGyL/DbvRD2Gf7lMQBW7m8jYG4E/NBqB46gFm4VCB5/7ycnUlVaGZk+WkJ5bUmQRvRV8
 XTUahrgC+V3XpfLjpDtn5PCI5T0fpdFVuOTs+WzRwPgrokdkl/nnVGj8YzVuD1r+0OQnuFZtJ
 GwreDie0ERp9Bd08DmuCFiW3nM2DC/cw4qj6hMO6LfgzZeODWS5PU2212pAZ+GOiN5XzTHrJ2
 yw6BmA9GfeMsGC/+AEvIUgQAZZOF2zVDcFuHdk7rVObHG1kJ+CY/saDl6sMdZeEZuWB0dkdTg
 sbLOJHt62SX48pGorpL8hbCA++FqpBzWbnml84E0jU8VL4AacqMrJ67YPJDlSE664WXXOJRJb
 KIMH0ADdEI+albki+DEmPuWPmiBs5+kJFd/62MfcUmHne630guLJ6hImDVrui4SpJ6BtfW9PY
 oqiVtlinEV+NxjcOvTUDh3FKC3SITYCbncziu4XkClvjJqMaDs0fRThWgg6A2mb27a2bRV0V7
 vmysFEdkQsL6w+i5Th3uoN0AXWYx4tN6ZmFbhCykjp3BredaelB4LRj1eeEPbrJz81QZH5KEV
 ZHIgybJGOKHx/CES9C8qhpJK+kUGuWA7/JO2iPjmemOoyWk1HO0Agt0O5LzHO+/pjsP1lptua
 dJhtbxs2APgizBx1/XQE0vhpU1zaa4wiFVXdZuQyfXQudxCzlHTHvRR7O8LNhdfjdgt+DyITi
 tWGtfejWn3cYns9F8hZmPWUhZTDkq1ZL02G0Zlz7OM0ppN+xFfwpQ2nqGrFpnKzOy94ZG5kJZ
 caP+U94TnjJiSOqsOJeCAWBR/qjr0IgVCjimJbHIYs6eBgDRMNrUu2rodWPofsY/+c103zhuQ
 cH5CpTF7yGPxhFmq6latCXSIlzZdftjbOx1Jyu1xmQ8xTAfHOMG0jKsUg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 10:50:07AM +0200, tboegi@web.de wrote:
> From: Torsten B=F6gershausen <tboegi@web.de>
>


> b) The same problem exist for all unicode code points (so we

That should be "exists". Let's see if there are more comments,
before sending a new patch.
