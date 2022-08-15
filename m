Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299AC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 13:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiHONCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiHONB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 09:01:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D37E11827
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660568510;
        bh=G9wSgURRLwT58o0Aob6dxFdFVLhi4s6sjMQ2Of7UNz0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k1NB9xyAUzn8LGwGUqMvfAUc64gHG95fW9cihguJc0Dco9uKs0WGcku92t76jzT9L
         6WF5kVON3CU7FirKIoAw4R8pdJmPGvBfR4sJsgn8kdCqkRE6Dz88W8++YpA0AY64MC
         IJvgd/Iqdv7wu1OemaU7JZyfhVoBxdAhYWTFlfCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1o3AG42NX0-00KSK0; Mon, 15
 Aug 2022 15:01:50 +0200
Date:   Mon, 15 Aug 2022 15:01:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v4 0/3] t0021: convert perl script to C test-tool
 helper
In-Reply-To: <cover.1660522524.git.matheus.bernardino@usp.br>
Message-ID: <oop2rosn-011s-9rpn-04s5-ss12n45q615p@tzk.qr>
References: <cover.1659291025.git.matheus.bernardino@usp.br> <cover.1660522524.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qefcCMaw8O4s5J5kr/pfqM8evhMCoWMXUnFnqbq/Tb2t87tv1hv
 cmpehmEF8CC6m1K3kMtraEM0Sgonp3A7q6aT8gGkH3ePpynp/T2QlM15Jn0z965HesNLORP
 DaeJIzZQryI92LmXqj4QfWjYQf+a0r0JLgVXb3RRJ7Y+Z1hJVZjAJ607/pE3bd2YmaxEjcL
 tNnKIu1jtY0Q+QWaK8OwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2N28mrGO10=:FjWiQJ367bfgwsAeOrwed+
 FEU4u3CKMr+ygg82xlyYYhQTNhTta3D2t2q2Dt2+GNjUDHK9fz8RZXksXLQp6pvXgWJoZsYM9
 L6UlLChWYD3lkLpWDRweZslqasKO8yGqI17TN2IAhGIdtrjJPCMbAsOoyTOz/9OmEXIax2Dy7
 wTHVMh8ATNwa8+sFXW5uV9rEZ441l/+cQK+FQH3kebe85o09KPO6aYK/uAvD3SbKSn8r6WBWt
 7F0mq2QCL496dJSWn3qms/Gw2LbwT2no99QRkSVnz//gJ/e1si0JpX3pazmrwHO9oC/aIkvpq
 ozjBnTugvAbsIYhm+l/cQQVUhUblhq0w+kN4r/Omng+I0Fks+msYju2bKX49ca1olawuTAKyF
 8ryjh83Z5VZIsfzs10tVQgSinouZtiutk5e1bSSY2qNwkytKqxM0wNiQKEVn+x+Ez0TNGsCRC
 BDNmHqItjlj6A6cw8IUBUESBfPyqlphyaY3MJGXZd/SDdHN6IqvYG7Vp7+TsMm3BHIa9idsU1
 WvB/XT46rdslNk7EV61MvhmoqlgikNsOF3zLzmhWaIK1hmIX4F9wtZgVAUffknB1sQiTXT5SU
 WdgbJCkY6NaYkoxuhAIWS8HLAJWXdt1U0FQ9Jiv91k71xUhOgTV14acC/11yauQc7I5mvTJbz
 oTVKbRD4gaKmQWtGmPdvrHUEbEzJpF9TExrwGYE3gQ3BObEd127W4ZmD5h9iXqh+Qu33Fwd9b
 gyd+60zkb8lfMJPwKeN5bhFQeb0xhtU/dYsIItQnHeUOCgO5r7hB4LUSiP+8UqEtVENvV8OdV
 kNXcEcw3bzcH0ARH3yUZ/Ooib792oE7D2usGEUlssBoZtrncl+wqgGNb/4knhcshu/NL2zFwE
 0UybOk2g7hf8T62KFmT8/OJ1GaX1Zt7PXF7C0kzL2628u5SNHSAvcQxGRjjFusfEU3qIVMR0R
 aABOlJrjtWfseY/lLb8vPqnQIpiNtsSnrWXfHgX/O06bdqyUXM8pfLmUT32MDh3p74I4pJ2TK
 rMKnKeQaXEii9Mg8t6OyiBmE6VrqR4npELENVtVRGqAhwnHQsTlk+gPpx3qNgAls/xPoSmqDM
 INypkvPGMsN7vkHl7106MPg3u6uwCqaG0Rb5Nic2kSUEN7dlRucItFpKg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sun, 14 Aug 2022, Matheus Tavares wrote:

> Main changes since v3:
> Patch 2:
> - Mentioned in commit message why we removed the flush() calls for the
>   log file handler.
> - Removed 'buf[size] = \0' and relied on the fact that packet_read()
>   already 0-terminates the buffer. This also allows us to use NULL
>   instead of &size in many places, dropping down the unneeded variable.
> - Used parse-options instead of manual argv fiddling. I'm not strongly
>   about one way or another, but I found the parse-options slightly
>   easier for new options that may be added in the future.
> - Style: removed unnecessary {} and newline.

While I think that the `parse-options` were unnecessary churn, I won't
object because I find that I cannot motivate myself to care all that much
(other reviewers seem to find this type of aspects super exciting, a
sentiment I do not share). I care much more about the essence, about the
actual improvement brought about by your patch series, which is to reduce
Git's test suite's reliance on scripting.

The range-diff looks good to me, and I think this iteration is good to go.

Thanks,
Dscho
