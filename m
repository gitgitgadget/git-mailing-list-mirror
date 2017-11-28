Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A810620C11
	for <e@80x24.org>; Tue, 28 Nov 2017 00:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdK1Adi (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 19:33:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:61187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdK1Adh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 19:33:37 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtlG5-1fI90v3xnp-011AMi; Tue, 28
 Nov 2017 01:33:29 +0100
Date:   Tue, 28 Nov 2017 01:33:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Takuto Ikuta <tikuta@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
In-Reply-To: <xmqqbmjn9t48.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711280132480.6482@virtualbox>
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com> <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com> <20171127043740.GA5994@sigill> <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
 <CALNjmMo3KH4QXY00ViVaiHdy=pSZ5j0BWRueO1T=sC_r0=3c3g@mail.gmail.com> <alpine.DEB.2.21.1.1711272222100.6482@virtualbox> <xmqqbmjn9t48.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v8fRTmIR8i5b1oAMYD1g50e+sRMkY5LtoXyNQeSdpy0hfyK6t8Q
 WeyAnYTqK1+vrELhA10SrcwJPrY92h/TAF95a/+9HGxrdQ3t7eEGDTSXQy101+26scX8bFP
 Hn5QcJhHpB5K+eZ6Qwbu+TxSco8p5D8f+qtHjNNkgo1C73JVFUlhN4eMr0t5f0BExLyUonp
 4rpVGtEzBY0snji+t89jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e5bfXvbQwsU=:/YiKUJQ9BnpqjVekPB9d16
 9e3kVjEwWQkTdJXYKGl1r+IxbB6u2lVt0cTVybQhbZ6Q8YdI9ng91tZ0qT9IVootMsDPkrQYV
 4oGHBNJpo/Sh87ncGxw5U+O67wG5KwzXptrky4Mm9f9fjHueGSKZQ1RQQDN6EY2z6mTtn39nd
 DpGKQQUQ5wX/1WtP/kHoqnwhqnX/WyWsjxivLuVMhKtvf1xmvF+X5vATn9xf8ISv3+ELMbQB+
 Z5zrjq18bQH9RX/x1VDdaYdX1aWnjUwjz3Ktr5PHAljzazMfP50VibSH4vmKeg/IH12i4XDFd
 BdESsvJxUxS7nIR5phZL6Bd+24ij/sFdOjyp1WWOrCbYD//OV77iY5cd188BUIhp/7FxFgm3u
 V/2ddZxZJF3/rP6y8doZ4lexXQKH043grAp4XPJfIBcwocaecqCWcLfgDA9OXoFq+Ff2xQOGg
 MzXu8/8N+KKhN0+SvuWlQaAHYyfYzURvmLBxNgY/Cs6sCaqhJhA00W7FVoIpS/WyarOdOXxmQ
 2EF815DzBt6PM89/Is7j09SJoRn5T7TIj2/OKQGDxqQPZvnue8/tsTzKX5QV7WBO1toGdBiLm
 bKGZqwFrqoZNeQB435H1XxBSy5Jk8YnnVMjY5A7zgoob5dJxYrWhuS1ehIcEPIxKOiiTCqdfl
 ZnHRl+k9ExBOQFVT9N6kDVK2NEqngwDrQpSUCaNZUzYy/p3vopjszWD24UKupwCINsk+dYno8
 6fVmO4siCB1TwEQIW+n82SmVi3ay06Y+M5vnR0qHOqKTP2j6J0VT6C7wv8cWlNqhxsPsB7Z1q
 tyJTztaP+cKc6/JwknUXUcGM4Y7fQfS01SNoXiFPqy3Vxy1msU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 28 Nov 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > My current plan is to release a new Git for Windows version on Wednesday,
> > to allow for a new cURL version to be bundled.
> 
> Is this an updated 2.15.0 or are you planning to package 2.15.1?

If there is a 2.15.1 to pick up for me, I'll take it. Otherwise it'll be
Git for Windows v2.15.0(2).

Ciao,
Dscho
