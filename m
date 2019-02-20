Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD27D1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 14:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfBTOek (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 09:34:40 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:54433 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbfBTOek (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 09:34:40 -0500
Received: from mxback8j.mail.yandex.net (mxback8j.mail.yandex.net [IPv6:2a02:6b8:0:1619::111])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 34D0042008A8;
        Wed, 20 Feb 2019 17:34:36 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback8j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Ba0ToElAeY-YadWXHfL;
        Wed, 20 Feb 2019 17:34:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550673276;
        bh=YTsPIFVgVg6Wh64wO8ruhWdbWEUdISbWbN+Ke86pjXM=;
        h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References;
        b=C2q8HJ4I76MWYnzEvxljpuzabl4ZBje2hfdpP+dNJcc6C6YWPVE3eC00RkDAJVqey
         m48TrdFctO0EWAVWAh1XFC34y3Pbx23HUFWvJzDX7w/DH7cKXX6qMJZJQDJC23I8JS
         anECBztEkzq74g1kWo+FvOnepM5xIvNrlD9zvVSw=
Authentication-Results: mxback8j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id vlhEyF7Iee-YZ98o6vF;
        Wed, 20 Feb 2019 17:34:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 20 Feb 2019 17:34:34 +0300
From:   hi-angel@yandex.ru
Subject: Re: git gc fails with "unable to resolve reference" for worktree
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-Id: <1550673274.30738.0@yandex.ru>
In-Reply-To: <CACsJy8BLERwq_oSnox7f0f_VPZy9NMjpM=nym_sJ-i8k-0DTKg@mail.gmail.com>
References: <1550500586.2865.0@yandex.ru>
        <CACsJy8Bjryv5Of0kN-wwiQs5S3Km=z=WRDTPcBD_Sgsm6Mvjag@mail.gmail.com>
        <1550502546.2865.1@yandex.ru>
        <CACsJy8BLERwq_oSnox7f0f_VPZy9NMjpM=nym_sJ-i8k-0DTKg@mail.gmail.com>
X-Mailer: geary/master~gb7739634
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see, thanks!

On =BF=DD, Feb 18, 2019 at 6:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 18, 2019 at 10:09 PM <hi-angel@yandex.ru> wrote:
>>=20
>>=20
>>=20
>>  On =BF=DD, Feb 18, 2019 at 6:02 PM, Duy Nguyen <pclouds@gmail.com>=20
>> wrote:
>>  > On Mon, Feb 18, 2019 at 9:44 PM <hi-angel@yandex.ru> wrote:
>>  >>
>>  >>  # Steps to reproduce (in terms of terminal commands)
>>  >>
>>  >>      $ mkdir foo
>>  >>      $ cd foo
>>  >>      $ git init
>>  >>      Initialized empty Git repository in /tmp/foo/.git/
>>  >>      $ echo hello > testfile
>>  >>      $ git add testfile && git commit -m "my commit1"
>>  >>      [master (root-commit) d5f0b47] my commit1
>>  >>      1 file changed, 1 insertion(+)
>>  >>      create mode 100644 testfile
>>  >>      $ git checkout -b bar
>>  >>      Switched to a new branch 'bar'
>>  >>      $ git worktree add ../bar\ \(worktree\) master
>>  >>      Preparing worktree (checking out 'master')
>>  >>      HEAD is now at d5f0b47 my commit1
>>  >>      $ git gc
>>  >>      error: cannot lock ref 'worktrees/bar (worktree)/HEAD':=20
>> unable
>>  >> to
>>  >>  resolve reference 'worktrees/bar (worktree)/HEAD': Invalid=20
>> argument
>>  >
>>  > Thanks for reporting. This is not a valid reference and causes the
>>  > problem. The worktree's name has to sanitized. I'll fix it=20
>> tomorrow.
>>  >>
>>=20
>>  You mean, you want to prohibit such directory names as a worktree?=20
>> But
>>  it's a proper directory naming, can perhaps git do the sanitizing
>>  transparently for end-user?
>=20
> No, not inhibiting. When you do "git add ../(abc)" then the internal
> name could be simply "abc" or something like that instead of "(abc)"
> which is invalid to reflog and other commands. The worktree's location
> is still '(abc)'. There's also a work-in-progress option to let the
> user control this worktree name directly.
> --
> Duy

=

