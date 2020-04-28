Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C2C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E524206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZT2K6JyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgD1K6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:58:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:49415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgD1K6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 06:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588071488;
        bh=HElB45qscATb91bmcmC8leAlaHtr8ZHJ2sa+3oqQhu8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=ZT2K6JyHsH98AMpuhi0E2dyxKq08ChMVA75h4gXgArtbf3mXlxVELtH7y7vsBH/Tv
         V0XaGQpDwiGYlf3cSFAoTem2T6VH+ZJDzOWTpZTeTVqvvgu7TZ0S9ahtUHO0a/kRMP
         r0H8+ivygymAhZJDIbOXcxaRwpg2p+t1jIQMAM54=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from legacy ([80.109.83.31]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1jfKAW1tdr-00Xwxy; Tue, 28
 Apr 2020 12:58:07 +0200
Date:   Tue, 28 Apr 2020 12:58:05 +0200
From:   Stefan Tauner <stefan.tauner@gmx.at>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?UTF-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
In-Reply-To: <20200428052510.GA201501@google.com>
References: <20200427084235.60798-1-carenas@gmail.com>
        <20200427125915.88667-1-carenas@gmail.com>
        <xmqqftco94wx.fsf@gitster.c.googlers.com>
        <20200427191858.GB1728884@coredump.intra.peff.net>
        <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
        <20200428052510.GA201501@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1M9Wuk-1jYti72AjM-005WZt@mail.gmx.com>
X-Provags-ID: V03:K1:PEFv+uKvxCRVNE4ORbdsMJfEmgZKkWvapo0jbciaUuUxUd9ts22
 KHSM47FeYpo1zXH/AdkzjvOIH96mYcOTCEFKryONGV/CKH7gnhu5CVpSSf1BY6a5gtBxp/j
 FAjrQsCn8s11rJT+3b7avLjW4CgHVrXzBHD4yDr9R06/sGpyQJ607XPT8HWHB6AuqNI48CJ
 tSiE5bBRelOgLZDxRnHVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gxGgziSmQE8=:kASuA7N5OzTW37va7CUdEy
 1xypRs8hq2rRDzn6oSDe2tuWYDNlvXpGRvSRYt/xDTcVfsL3RJn3KIFjabeO+pCpevQjDuQd5
 5Ou6LPJal7JjJEVxpBN6+dHfx2MWHTry8amqSQ1fjf0eZ4kdir2I39ymuBRcIZnzPadlO/7Ap
 lArcm0VnswbMgz25Ns7m7zjN/gAD2RcFNyBiJ0Wo3J8Fdnt2AvI+ojbp7m7foV3CfT+mMu66O
 FMsfBzCTGMTpyryxZl7DsBglYKBGWSN3DdsquZqFJRoaX27bzMzdewuDoVY4gAPbtWuQLuxia
 0h4n6wflm3+QE8D0tkqPGkT7Tl0G7FknPtKnyGsOPimPWU7gYrvC03K076wYY2UxGW9n4NsTW
 NFV8j6Iuj5evkIxt+zGujyGwpsxtIW2n2loHe1EFxsI4n9S5+RsH8eGA1oH4ktz0KH5YBEh6e
 2nx6cdIrAQgNdF9m/5G1x9wZFz+IwEkte/tJAwSBma1YqBzOZmj2aNxCyRhMMhKSVMcE6R+cO
 xD5dbVG9UMcFzS0fX7He0s6lokiwpMp33mY5UkTpJKFH2Rt0EUj9Hjb6/rpUDo1S/81mPrYaD
 Z7VzSW1mbRgRaaZv9R+Bxmib1Bgh/ZG6MbOkXj+WgkkSlqc2I7KPzz+WfbK2ov3ItZsmlAEmp
 Q7sDO+RYo9I3mMjpXeuwJke9qgIOxLpcQObPlzih13gP1zPTPrx9Og8oK5bktgUuGmYW/klc5
 3wTbxOWYXcpC5hM3o7oA9tJqpsM3Uy9tNtkB9WmSI5iPAMHhYu0zT0+wOTVpx2uBcDeQvOBGI
 IiS6bjDNFOa3hcuNEUKWMjeq2582d4KZe+6q3+6MjgJLWvTr6sLPMBoeU01IF0ebyzsTSuVaV
 v0kvSGbMIWbZy5RHo3mQrquK4k1pq/nxPW6V/8vpT1G9HhO/OV15WJDkkhu7rZIhUKdjOy7ml
 mmJw+m7n1ajHWpDeKgTAIOn6r82xrl/TfRY2eSjsrMVRe/mxQIppCMWhpvlFFrnNSnQ3clbH9
 QUccbernvBi6pHv2ecLsy4pPPONkGghE7JHjA0kv5LQBGLdIFcExNKHZ7JnnCLsJ5sgdYADmY
 Zx0kU4hmcm90xcXrxp1R0LMkffCb9eoh2oMURIAtw52y3MGBn57lqXgqME92HKtQPjnBaSAlL
 7O+DE1z+uITcV3Z0oN6HqXhdOVFYJx7ARdf6jQoHNQcdXBK1S3qGWBwRIVzwSLBnYKcC7DAXZ
 hhqOtgGLfqrv1nQYP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Apr 2020 22:25:10 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Independently, in Debian's bug tracking system, Stefan (cc-ed)
> reports[2]:
>=20
> | the vulnerability in CVE-2020-11008 is related to the handling
> | of credential helpers in git. In Buster this has been fixed in
> | 1:2.20.1-2+deb10u3. This broke my existing configuration where
> | repositories have credential.helper=3Dstore set. This is
> | documented in /usr/share/man/man1/git-credential-store.1.gz
> | and other files from git, git-doc etc.
> | I am unsure how to proceed... is this helper now unsupported?
>=20
> (Stefan, do you have more details?  Did you manually populate your
> credential store?  What error message do you get?)

I can't remember for sure - it's literally years ago - but I am pretty
sure I did not *populate* it manually initially. However, I might have
edited it to separate entries (https vs. smtp) and I might have added
additional entries by c&p & editing.

I have replaced the one instance of \n\n used for separation with a
normal single line break between entries and how it works fine. Before
that I got the following output (that's obviously not very helpful if
you don't know the whole story :)

> git pull
> warning: url has no scheme:=20
> fatal: credential url cannot be parsed:=20
> Already up to date.
> Current branch master is up to date.

--=20
Kind regards/Mit freundlichen Gr=C3=BC=C3=9Fen, Stefan Tauner
