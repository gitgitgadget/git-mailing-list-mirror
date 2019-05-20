Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0094E1F461
	for <e@80x24.org>; Mon, 20 May 2019 10:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfETKNq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 06:13:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:50111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfETKNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 06:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558347219;
        bh=ZcnPbtEr4JPccY03yXNdvPRSmiStgvY8drnEi9fwjD8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lfr0tUaapmnFEGIWgqFlCZp8Z/pyqMekFHCtvnSbGPc0l1wdH1DIqs2TG2+wK8zfT
         iE28QXIXvJ7R71ruNRZLYXAeWjrTz1n4Fx7tjgS6w265xVTA4klsbruCavSRZiv8ry
         NawHFVMPCwns5YfRxJ6uzJ+j9rKNibGROXTJGaKY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOjMY-1hXayb398Q-006892; Mon, 20
 May 2019 12:13:39 +0200
Date:   Mon, 20 May 2019 12:13:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 0/3] Close commit-graph before calling 'gc'
In-Reply-To: <xmqqk1en19pp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905201204390.46@tvgsbejvaqbjf.bet>
References: <pull.208.git.gitgitgadget@gmail.com> <xmqqk1en19pp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/mdmG/1WFqVoiXYQnM/EmTg3IG7CzEOhYwj1/FgpJ292QcwPBxk
 3zxgIItRplxTzZ8HENn74xW9rSUcM0zCv0zr1jA8rDe518A/gj94CuOvxgKyBGZAtIMppNC
 9p+rBxOM4ERV1LM/Hl8rf/gsiVdL5EeMCWIPqQsy3SZGxhGI2E0mIadwNp1I1yVdj5tdzWL
 rS9znDrac/FdjRrwwdIzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gd3xRh2hkh0=:F4ovKRTSbpnLqw2v6TYQmM
 g25LMEiA55Ia2wM1axObK/toYG9f4gfbM6rNBE9Nz9Qq9NMyQaFzgttRx52tft+0ksPXY7LO4
 KNIKJeAkcsSIMnYHDS1n5JgwUqXHThfV/UPV4rb3qLzW/8kEiR+jqYe1yaIQJwDZ3MtLIeeNF
 tBk1byF75OeTIVnLxXbHRsE91J8fBjRZe80NnlbqGDB55yjQwxAF4pO+wfa1zOaZjx2yAnUdF
 zLrlMy4/JJbFn6r+mLr9pS7iE/eTVTMKof0k1AmOGDCXv5+Fzt+7/8oQ8H+O9TNiZbPMf1HkN
 6fDCgk4i2rbzvJWmxtx0L+FADSl3y41GrwQK2QFo6r1qEzq/YJg/eHGSvoY4t7NT2RYYbc5H8
 7yMIPF6SR3w/5wcLsKHgzwRgvWSAwoAWuWEa8386EVnf0FF8BalAPSNqKDQbWdQES9aZ0wI+H
 fNzLYYrQsXLzT/K2sf0keoQC8f+ZKEWGYeJ6q9CZaI9cw5wT00CPIgCjYnKp7qerfVPvimr7c
 oxtWrkFuG7kmDWj7uxBKRCPaBAis+23LeYqRxMpVArwm9n7MJ0r3z/1zNB5oxRbKjpj/+K1qL
 XmkFuXTkcK9EcfS87H+/zzA92kEXz4qERO2d9mwTRk7vi4+7oSoE0Pf87bahR/u73+0jQxmU9
 i0F9WUtXEBrr96oxxb1/SKT1uQDtcZJ4ML4ix1OHNP1GS6ZdIRJGFaKFjCa7KGTSFNYdLqugu
 xh+z78sKxOFNIPEfKaFNPIe6VqmsyKFUzA+lC4qZaoSof9hs6RF6Zdtp6mhjgASCVlLeXXRCh
 Tj/Vq0jq3Xk2/tCvSZSyMQNjBaYiGHZodgjO4eTyCABZrxpbrvHQFNaDwruFPyh51/v1XLf1g
 K64MnZE4kDrKhJJNUXYya6cOET61iO2d+7WTovtwPW9gTPd7n4RIvQ6H9ZR8lywBGmqCEfmZE
 S+XCQShih6ZkQWbonitxKx2g3PaRyCN5DadahdoQbF09qhpAH3Mya
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 19 May 2019, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series adds close_commit_graph() to close_all_packs() and then re=
names
> > close_all_packs() to close_object_store(). This name is more descripti=
ve of
> > its larger purpose.
>
> OK.  Somebody needs to go though all the existing callers of
> close_all_packs() to see if the above claim is true (unless you
> haven't done so, that is), but I really like the general direction.

I tried to provide that in my review of 3/3.

Please note that these patches are most relevant for Windows, where
renames and deletes fail when any process has an open handle to the
file(s) in question.

Ciao,
Dscho

P.S.: Now that I think of it, if we close the object store, that's
probably also a time when we want to release the loose object cache.
