Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F8B20193
	for <e@80x24.org>; Tue,  1 Nov 2016 09:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168258AbcKAJgv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 05:36:51 -0400
Received: from mout.web.de ([212.227.15.14]:54301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168197AbcKAJgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 05:36:50 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MGUHw-1c5tD10D44-00DGnA; Tue, 01 Nov 2016 10:36:43
 +0100
Date:   Tue, 1 Nov 2016 09:36:41 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] convert.c: stream and fast search for binary
Message-ID: <20161101093641.GA1313@tb-raspi>
References: <20161009095649.1886-1-tboegi@web.de>
 <20161012134727.28365-1-tboegi@web.de>
 <xmqqd1il5w4e.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1il5w4e.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:1YGTZ0wsyV2GWmfeyyqUMsAcNScTkACxUcYi3/vEoU7IdmfhzPl
 5SWP3LJf/QZHOa8b4zrcaWd8RnQjnH/BTukGDcZfAEptJaV0yhoslS9dEvBPvZQe32STIET
 6RNYn5io0+0sq4BL2uuXPeP6b2qciNUJazOSZ5TNFLSK8zaiTeSNO2r9TbPR9+AffySAmt2
 dInNnoSiTIhGuFZ8auD9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IuySf2T9yrk=:HnAXjHuCTrFS8U2oxarD/v
 Jl2wh1BtXdu7bvR9bXuYhpogi9fnmxgiRKBmXQC63Ec0NAnnBYuZBkWj6QW9bhSMzGga3n/bx
 EpJtcXxuQDZO50/OrZwktn4dYJfCCyi7TEOana//KmYgFh/M5v2WZRr8C1ZRmH4p4VeaY7IGG
 EjaA6xEOSTYCn4A+/Dk33ycr4aOkYSmtSTOa1Oz1YbUlLY0jl+7sfSaGFgbwb2UfUOMqzZlkq
 g2fCKX+xNlgCPn3h+qUTkaw0GD1QLlm10XV7UeJKYSFqg9Qa4lkWEPpl3ys+ChyJ/l3oLc3EB
 RYpn8pGKFJ4WoXhfdj7XQEO6Ii/IMNLS6iEijEzIzVQ4AKyE6F+vDLEEK/xOO6rGj3QqH4IIP
 ysGKCivZP6EBNGq3g7hXb4krKiY0chWvU9HVpxy+Rfv1Yd2SS8H137uyTusj00U5+C88hXk1p
 xYdIhU53UuAxQisEV3fQ8Sa+ni1LkNPEufVZPoq0ZTx3xm/vp4FdgR2TU13xb/MBbWb7TbsGz
 oJfL3m8gzeuaGKVLfGBglVOWFARFgVbgYadCTFB92QmSCdEWhOjTHo1QW0ubK+fvN6oXRAeiy
 tCGzrxiYsAD7Seh6SX2qZBAJNmc2eBA+MORft+f7nGVKBYn6a4/dbH40LsCLA/9c1ZE6FJxwr
 eBp1EDjXQ60PccMuHDCPDnq8TQQvCZlei9/2GRGhp3rXnz7HTNmaDsARDGDfCqIjVKLlqoo39
 vDnJG0ZrEE8oF0zugdtXr11ffUzP+twO5KU/eF5EjRrr5eANhUo1NG9I4SY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
> This probably should be done as four more patches to become
> reviewable.
> 
>  - One to use the CONVERT_STAT_BITS a lot more for the conversion
>    decision than before, 
> 
>  - another to allow the caller to tell gather_stats() to give up
>    early with the "search_only" bits, 
> 
>  - another to update the get_*_convert_stats() functions to use
>    get_convert_stats_sha1(), and then finally 
> 
>  - use the streaming interface when reading from blob and file.
> 
> or something line that.

Many thanks for the detailed review. Let's see if I can come up
with a better series the next weeks or so.

