Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5520AC61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBXN6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 08:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBXN6J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 08:58:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB51A64F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 05:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677247080; i=johannes.schindelin@gmx.de;
        bh=4Z+QNF2h6enR6mDxyFkKSLtGJE7S6FPvpt8jNoBUJoM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jo0VBaRIi9JTYDokhRxgVUfNo+xoh4ckC+G8InDW7R8IZEJLa3yiW2vOEA2Qdn10U
         kaRDxmU6fUS/8C74R/txRP5DcI4FGTMebgISgNp1dEItBr/T9uG6JJGSEtfd5dY24h
         9why6T1lSSA2Im08KYPr+unV1RK875D6JJRAINJt1eK+ZsmGnL42giq3BOqCX4jY8M
         kO8me23Nmht9kx6bFzKVg3Xgs3sS1BTv1TA/RM96oseMdHz0CMTJb7s1/E248VQBdV
         0UdCa0H5UdjZlqRkFJsYLp/sHQVfuVNmw7hDdQC1Tl5j5/rRZnFE+vW4IaMMpmHjex
         f3lFhm/r+7sVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.113.48] ([213.196.212.111]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1pIgXp2Q7d-00DYFL; Fri, 24
 Feb 2023 14:58:00 +0100
Date:   Fri, 24 Feb 2023 14:57:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        sorganov@gmail.com
Subject: Re: [PATCH v4 1/3] rebase: add documentation and test for
 --no-rebase-merges
In-Reply-To: <xmqqh6vc9tqy.fsf@gitster.g>
Message-ID: <f1e8b718-c54e-b228-860c-54d7defd9e7d@gmx.de>
References: <20230223053410.644503-1-alexhenrie24@gmail.com> <xmqqh6vc9tqy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:58zQZIE+pA0fkjPzn1BHcdOagZaYjWGcOOIolH5HXdg52uZqK1C
 0b27F6qUHQwt4x624U2zGi4xqPlNEIXR0SP2IXxcPFw/BlEy5+ofMVMEvMmkOuutuf/V+Ml
 hpPcKHSHgsOYCLBj0oDlMrJe2zIhDLd8OQ5I8xEijtpHQmt5nK7zL+0FeVAsROvbXibkxLK
 P8Xg0i1yrsc0qCKzn5VEQ==
UI-OutboundReport: notjunk:1;M01:P0:Y3uFL2YZtWA=;2XxntqgRFMTh9hSjnJOuDeQrHXX
 l5hfzTO/KiF08X/6G6w9v4bbhipunSlARe6VO+3mqw+iyiOzBwCx3xpsAXns+JMgAMG3wh7f5
 MllZ03erfz+lzsaODAxvEn579lFfwy+ZZkDruCCazUIWHVUC0jDcK9hKHvBM+JDAnuUs8lwq2
 oUM9cBjRlcTBQ41IG72Ohj8kf+EaHbHnrRlRRzlJIvNCyev+FGEBkoLL+b7+ugWxxwXWkGmb/
 HAbh8kTPmMyMi5ypp3WZjVygDjCiu9uscdGcE+Ed24jrWhYohc9+Y1//PaYjogCd2njnVEla/
 iCaXiGjxgUGyVs+Hou9BOBApRztYVnAn315G017wSoh2/xehw0vi0oagZfE5/BDpP0ThzlzHx
 fn0YnW2atswo+/CDyiOQCynYKG28bZr2hS43Mw45p4+e0+qZDyhHOdJfr9kQOcwPuxllcG1xy
 qm/0cbNDHXb4kBWeaP2SUc5zw37KkHDpJYyqk6DcieR2oMmCNXWbMhRDuNiJAhrVsdDuNqYg+
 cvkcPCYq9i01kEbZzStTX2l6BtFPmBdJ6S60tigv9HYliC6ExXh7QyGM+/uD3TNK7ilx7i62I
 zq9tli6Fu4QAIaBpNOEvvZP5FcwvEeLxXL/VigMhBblCfcLBrGRcnIiaUXVr1HGrUG9WrS4b1
 /oZSQVCcYOdTxeZLVVvsNYdo7wIix+QBBMA6JBCqxVsuTs09G5MV6k1l9aXCoQ5jitaDaPJhB
 KIBzoOuHJIn4qoo7wMtRSpfOt1CE/zEu2R65JmcDP5DEtRaAaCMUdg7PU5TM1VPt7ell/9ll0
 umwPRutcUh6rC5mocKB6eS6sUk8kAcfwwnHV2e8bCSeSzbgvHBjue1KCWhUUneyNpQepmuX4c
 FyqkVWM2SZ4ugwkkvQ6+tB7Np97UIWpxWuIsKoTzj1owmljQfgyyxLJg3LRndWMFlXL8tD9yh
 oqVMR+N8pCGDG9lYa9946HiJQ9I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 23 Feb 2023, Junio C Hamano wrote:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > ---
>
> No cover letter to summarize the changes?

A range-diff would have been nice, too, as well as replying-to the
previous iteration so that they're all within the same email thread.

And if you want cover letters and range-diffs and correct In-Reply-To
headers, I can think of a splendid way to encourage that: promote tools
that do that. That's much better than to require contributors to know all
the customs and conventions of the project and send mails in the exact
desired format...

Ciao,
Johannes

