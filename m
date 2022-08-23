Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56375C32774
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbiHWQlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245579AbiHWQkq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:40:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F56E2CF
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 06:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661260119;
        bh=OlBhHKHUbv5KSoVn0Msf6Ntw2NhwrT5OHp1fmK6sibg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e/Eggg0c2BbQ9S7+pihcbbE6D2sO/5ne5wKUwzlizIRsrJhEv0awYqki3laVExh7F
         oliYBxgoBX/9uglJgJq6WAoXMoLUXd83/n/ULkcPcK14LsqTnYIjjLh+CTT/TFiqXQ
         YMX2DW8G0fqUkJuC1FNjEuZsYi5GzJg6UPQyQLA8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1pDrpL1gCq-00pqX5; Tue, 23
 Aug 2022 15:08:39 +0200
Date:   Tue, 23 Aug 2022 15:08:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: Regression in 'git add -p' with 'interactive.diffFilter' since
 builtin version is default
In-Reply-To: <ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com>
Message-ID: <s40ss309-3311-o08s-38r2-9144r33pq549@tzk.qr>
References: <ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L4kynZ/oERhjuqy6CIkWLP0HanY4XHcid7n6BKs6wUEh8wp4YgJ
 h/ruoepZ/slutdhCI0lOo8Yz4uT+lrbM4drP/QEj2BdrbOfaQ44jUyHTZr1TfFmPOPgyTx6
 7s+nyOv1zmLUn0veKfmh1F7NniYjLXhutn0yYMtGqu6bOZnYGBevxLXWq+JEeSdRgFp4Alz
 Yz1jGWgjnHRSGpTNn29/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:67PwP3u9ptk=:8qpPkPL1PG39WRcZZttUAd
 gSTXcR9oUtZvv4gxy8CkDnjgGu+GjFmXjpeKRDnsM9p9rIYIMICXiDyfqCg4//nP/VjVY6AOw
 dkECiNdGLaKQ17nPcMgRAsj39rBPKRR9SCo7wfG5VoDJe1wkwtNzTFB2jWHIAQQlz8uquZjWr
 VqWkXMcxYnr+ZDeKoOtGop/5ydFVktg89gHbcdss7bgqE+QV5cf38P9wN6I19KFX+18MxPbHZ
 4pL4koDB0j1J7QuKFxlNuS/5zRjAHsAjn17TBmFUXW8g+wnwDxTSg7nOqQGFf4eZEYbtfryU4
 0eQlpa42HYG9O45mUG8f3zSWmuQFq56Yw83wR/ZeHu8VMr6ZUpQmnJ3CbVNCIXK4xWmEQOZx1
 R+enfa09ohlbr7oTRULkEx1+E7pspDkysqh1T3WThJlGKVVYbuhVti9VTPNiGUGHD7t4koInH
 6vjEQ/jGFiCXrGq62NYrZaGY20SeyIymdzZ3Nm/oIEX5MS7hS0Q2St+tg44fg1C7fOgomQ9Zc
 lOh7o8Uu8tVhdcqdDJTwJ3+mndkFIzenENzjpxvIos0yYUTi+Bp1+WSAwC886qQlhy0WXkl9E
 tJaxoRGcNlpZry1pgFzkOHpa9QA9/JEiwAywinwOZTBb1e4Bf22v8pLNOE7Tra6/hsLI8qNmI
 +s9tVyySYLka8z8WMVIYImMn/CjPGpXKKecf1WeyLJgm+/jKW035MrT/T6Wh2CYZ/CP7kLEVa
 Z9QOGtup+HQegabL/KTebKfRDc96Y2BDe9eLDpCT56b4s88hV0q2jm7Xpf3tKs8/l0pnPV9Ri
 68tiWXsXxg9HqjbPSkkF7Hx7HnccviJUIzWlM/TH64qm89w+4A+zlkex3/xq/vGYPxjKZtv72
 EIuD1KLkyGQr3pqbJzNe2PkvOopzpMJEjtJ7iwbGhyMDQH50R89ENx83b9il0VUgJCPrwUgfF
 m8djYt5ufHS99FtzeC9an9imMYhIm+RgnwWh5D93OL1H/LwclEwILcI9nPXddJ8embZXtmIye
 tRaKj2qxwL3S7ssnY63hkCiGQT8sVOjH+bZiKWA57JUC4oaBcmJkNZjwRZjQr/V5PJChskZyC
 AsCmLNnxel7vNDzk/drZjP7jRLvk3pmc3nulLRydEbiqq/PRR6YoFZE+g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, 22 Aug 2022, Philippe Blain wrote:

> I found a regression in the builtin 'add -i'. I use diff-so-fancy [1]
> as a pager and also use it via 'interactive.diffFilter'. With the
> builtin implementation, this errors with:
>
>     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ fil=
e:1 @?[1m?[0m'
>
> With the Perl version, it works fine.

Hmm. This looks different than what Peff reported in
https://lore.kernel.org/git/20201112184026.GB701197@coredump.intra.peff.ne=
t/,
where the command errored out with:

	  $ git -c interactive.difffilter=3D'diff-so-fancy' add -p
	  fatal: mismatched output from interactive.diffFilter
	  hint: Your filter must maintain a one-to-one correspondence
	  hint: between its input and output lines.

I _think_ I have an idea how to address this. Stay tuned.

Ciao,
Dscho
