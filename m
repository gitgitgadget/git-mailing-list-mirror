Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B00C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56277613AA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhEENwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:52:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:46027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhEENwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620222676;
        bh=a0NxbAmgQDgjBPM++zbUupWkHrt/QOylcHnqkkJRWmU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZBDpiNa2zLh+NVQTz+YOcx+mgmRCJ7Y+ZpTH00/UFtPXDNAZ4Y3ODhGW4/gSTSNd/
         vLsDroumgYjAPbkaiBuPbmNEqLMgfe5M8mkVrXymF4zuei0k1jznxfF1YEE7PRZu0J
         384AE5ZSXOyF7oLAFwxU+o54OUP1DYpeZIVzxwyY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1lRpYZ2Eqt-0165C2; Wed, 05
 May 2021 15:51:16 +0200
Date:   Wed, 5 May 2021 15:51:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on case-insensitive
 file system
In-Reply-To: <YJEuBqVVa/7x+jrZ@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2105051528030.50@tvgsbejvaqbjf.bet>
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com> <YJCABtAGT7s70jl1@camp.crustytoothpaste.net> <xmqqfsz36u0r.fsf@gitster.g> <YJEuBqVVa/7x+jrZ@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MKpqnVnAE31tQHJSAzQnCoEXHxqZdpMhVlFyveg5uUAyx7/dKTm
 rIMUwm98a5siL6KYKcbrANZjjIXWfWeLPHSHde2IpsHN0fcqZeHPtTpYG/lhBWVUDwgHv02
 xzXtl+cr7RQOn1WLu83/1WxYnWUHuLUCb/xz7wfGNzkafLQPgrmOGJKNXDNwpbQqOe2PPAh
 OKQTVCzgMZ6ef2wNm2wkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T6IsHAmZeOg=:56wbrfQTx82qdBAvUmjgZp
 MQtgH6BmgdGRS5M72dNbj1yWE7mdrLLhT93Bew4gNuKJ+Lthjz63Kc63HUIuWBxyE/Zc/3OLM
 2IKInPNsYwojLjW4Tvgu4+eFBL75QSNmi9pgf1t3DpSAM+FzfIWY4fcOls5GoOb1JwhNIbVi0
 wA5DeQgQEkpaH/A/pLBN2QfXi2dr8sm9HXfwrD8nszersuYHM8r7bGg+8oojBf6JjSH4tBets
 R5SxM+tve0IoQ8hhjVCYUD7hXKSI19ZVveY7bDg0Gof7jtdinwVrx/Id84yQjYtczFg0l40Ck
 OGy+QIfSctJCY4POoUQtNflM/s0Sj9FORdSLnlostoYUxLWVYfoIydzLTFwCM0pr/AeBLPhnJ
 N7ccUH0s7c1HxuVWzBKOtTmoHoD9r9JX93X9ny8TLTRzbvXDSOdNK8BeAhVvE/0e8SFgstn8z
 7CYxw0bFCefzpoAPKLu6+txls2EKM0OlHCxQOojZtoeRxQemgmHYCV9cESFXe733YYbw8PdyM
 yjkXN1+OWdqGpj/eVFsAJYkuLm9E26TkEmsGYtw5Jp7vY2xXpoTLon+wv+derFClYvj9rU/N4
 7u+tvudvZ2x4qFqbK1IuifOafGfNrTucqBnfmw2wsOr+quipUEsE3j2oWUm4zpGeZKU7bMsix
 LAMCLChx88CtI64QnHEPDY0hCUgp2Ml9NvWzc7f1No21lFX52bJZrZAe0tRLIc2DBqVk3tu3R
 21pbCfXcgKZEGcZVJ1H4SbRljFY45z+lzZXEkp4yqFSrMbWsQj8Pt3wvtiww5wLdvsA1kzGnX
 4vAMuxFxQmLGYSfGCO/pEvusMYZpGocp3yMkCpUnUiYcd/DSQbvYUqY7h0bml83kxcsetXQyX
 MM7DKms7kBbpDfMYDZBVMTBO2SHScrlzt37EiGT4p2+ItHbIKLl0np50vu7zqLBynfwWlRK/S
 8W1HS2FI2q7YKFHzZfQ9CsvWPgg3XHg1xBk3coLyWEwYwtOAlLUdQFnUbOmXmjNyWgHX8MVnI
 c5r/NQRzyqS9TgLsnUUY4N6+Vu1CpYWqYoVUiWJPjftCe1GQC9HCfjLmCSk7UUdr9gEFwg0lS
 NNNOqdXQJQF3/VqMzucYw0vQ1QfIjolUSMEram+NPIPpSoswYW2kVRxPRswkLFIoffzfPiy5f
 Rt+Xs8X7KvgeJXd1+WYaE+NFOPhaDjq3M/unvzriM+KWIZu3V39lRnQcg5/Irjg0AfaARLM8J
 gGlILNgNVddPSqL3Q
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 4 May 2021, brian m. carlson wrote:

> On 2021-05-04 at 03:46:12, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > Yeah, this is because your operating system returns EINVAL in this c=
ase.
> > > POSIX specifies EINVAL when you're trying to make a directory a
> > > subdirectory of itself.  Which, I mean, I guess is a valid
> > > interpretation here, but it of course makes renaming the path needle=
ssly
> > > difficult.
> > > ...
> > > I suspect part of the problem here is two fold: on macOS we can't
> > > distinguish an attempt to rename the path due to it folding or
> > > canonicalizing to the same thing from a real attempt to move an actu=
al
> > > directory into itself.  The latter would be a problem we'd want to
> > > report, and the former is not.  Unfortunately, detecting this is
> > > difficult because that means we'd have to implement the macOS
> > > canonicalization algorithm in Git and we don't want to do that.
> >
> > I agree we'd probably need to resort to macOS specific hack (like we
> > have NFS or Coda specific hacks), but it may not be too bad.
> >
> > After seeing EINVAL, we can lstat src 'foo' and dst 'FOO', and
> > realize that both are directories and have the same st_dev/st_ino,
> > which should be fairly straightforward, no?
> >
> > For that, we do not exactly have to depend on any part of macOS-ism;
> > we do depend on the traditional "within the same device, inum is a
> > good way to tell if two filesystem entities are the same".
>
> Yes, although that won't work on Windows, which I don't believe has the
> concept of inodes and almost certainly has the same problem.  CCing
> Dscho in case he has some ideas on how we can make this more resilient
> there.

Windows does not really have inodes. But it has what it calls "file IDs".
This concept is pretty much what you expect on inodes, except on that
still-used file system called FAT (for full details, see
https://docs.microsoft.com/en-us/windows/win32/api/fileapi/ns-fileapi-by_h=
andle_file_information):

	In the FAT file system, the file ID is generated from the first
	cluster of the containing directory and the byte offset within the
	directory of the entry for the file. Some defragmentation products
	change this byte offset. (Windows in-box defragmentation does
	not.) Thus, a FAT file ID can change over time. Renaming a file in
	the FAT file system can also change the file ID, but only if the
	new file name is longer than the old one.

In this instance, because we're not actually renaming (yet), the file ID
would probably be okay. But in general, we should assume that we do not
have inodes on Windows.

There is another complication: it is not actually cheap to get to that
file ID. For performance reasons, we introduced that (optional) FSCache
feature in Git for Windows where cache the `lstat()` results because the
assumption that `lstat()` is fast really only holds true on Linux.

In fact, what we do is to use `FindFirstFile()`/`FindNextFile()` to
enumerate an entire directory's worth of `lstat()` data, because funnily
enough, it is a lot faster when we need an entire directory's worth of
`lstat()` data anyway (calling `GetFileAttributes()` for individual files
is of course faster, but not for a dozen files or so).

But even `GetFileAttributes()` won't get you that "file ID". You have to
create a file handle (via `CreateFile()`, which is *expensive*) and then
call `GetFileInformationByHandle()`.

Now, way too much of Git's source code still pretends that `lstat()` is
just this fast operation and we can do it left and right and not say what
we _actually_ want to know. That function is called when we need only
parts of the `lstat()` data. Sometimes it is even used to determine
whether a file or directory is present. But since Git does not have proper
abstraction, `mingw_lstat()` _still_ has to fill in all the information.

So _if_ we need that file ID information, I would be very much in favor of
introducing a proper abstraction, where differentiate between the
intention (think `get_inode(const char *path)`) from the
platform-dependent implementation detail (think `lstat()`, `CreateFile()`
and `GetFileInformationByHandle()`).

Ciao,
Dscho

> In any event, I'm not planning on writing a patch for this since I have
> no way to test it, but I'm sure someone who uses macOS could probably
> write one reasonably easily.
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US
>
