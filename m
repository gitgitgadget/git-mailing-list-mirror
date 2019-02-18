Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF171F453
	for <e@80x24.org>; Mon, 18 Feb 2019 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfBRPJK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 10:09:10 -0500
Received: from forward105p.mail.yandex.net ([77.88.28.108]:33661 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730522AbfBRPJK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 10:09:10 -0500
Received: from mxback13j.mail.yandex.net (mxback13j.mail.yandex.net [IPv6:2a02:6b8:0:1619::88])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id D98704D42478;
        Mon, 18 Feb 2019 18:09:07 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback13j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id h9LOdJB31U-97maoRsJ;
        Mon, 18 Feb 2019 18:09:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550502547;
        bh=mFWoef4ns3c0UrenuH5ufzb+dsbD/qeG8SKGxQu+WbU=;
        h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References;
        b=nHptYO1NKozoVv8gI5JRqf0spJhhVHlUPMIJ5v5CbKHJn0lQrVz0/aw2vaujrLdw3
         8Y1DosiF57NkFymer3vg7Sw4WMVJxEDuGR+bqKxIM/Bm3ra67b0pnjZNNr7A16JL9B
         L9Zm3YR/XRXA27jnuudjtjO6S+xLPhQ8tRW7Z/bc=
Authentication-Results: mxback13j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id rHz1NV7Blt-97OKqgY3;
        Mon, 18 Feb 2019 18:09:07 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Mon, 18 Feb 2019 18:09:06 +0300
From:   hi-angel@yandex.ru
Subject: Re: git gc fails with "unable to resolve reference" for worktree
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-Id: <1550502546.2865.1@yandex.ru>
In-Reply-To: <CACsJy8Bjryv5Of0kN-wwiQs5S3Km=z=WRDTPcBD_Sgsm6Mvjag@mail.gmail.com>
References: <1550500586.2865.0@yandex.ru>
        <CACsJy8Bjryv5Of0kN-wwiQs5S3Km=z=WRDTPcBD_Sgsm6Mvjag@mail.gmail.com>
X-Mailer: geary/master~g2c4fe9b7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On =BF=DD, Feb 18, 2019 at 6:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 18, 2019 at 9:44 PM <hi-angel@yandex.ru> wrote:
>>=20
>>  # Steps to reproduce (in terms of terminal commands)
>>=20
>>      $ mkdir foo
>>      $ cd foo
>>      $ git init
>>      Initialized empty Git repository in /tmp/foo/.git/
>>      $ echo hello > testfile
>>      $ git add testfile && git commit -m "my commit1"
>>      [master (root-commit) d5f0b47] my commit1
>>      1 file changed, 1 insertion(+)
>>      create mode 100644 testfile
>>      $ git checkout -b bar
>>      Switched to a new branch 'bar'
>>      $ git worktree add ../bar\ \(worktree\) master
>>      Preparing worktree (checking out 'master')
>>      HEAD is now at d5f0b47 my commit1
>>      $ git gc
>>      error: cannot lock ref 'worktrees/bar (worktree)/HEAD': unable=20
>> to
>>  resolve reference 'worktrees/bar (worktree)/HEAD': Invalid argument
>=20
> Thanks for reporting. This is not a valid reference and causes the
> problem. The worktree's name has to sanitized. I'll fix it tomorrow.
>>=20

You mean, you want to prohibit such directory names as a worktree? But=20
it's a proper directory naming, can perhaps git do the sanitizing=20
transparently for end-user?

=

