Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673FC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A51821655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OhkHAMBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgABT6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:58:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:43941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgABT6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 14:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577995110;
        bh=S/ksLQjK0DAMbMr+IlDHdQsIgqshNTx1F305y1v+QIY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OhkHAMBmatv7umMoWA92aXLC1958mX4zfWKYnr9cMNSr+TiVxoysBfIp4m3N5sD2E
         DVS9u1xUnSRgQQvKVfxSNHY15veRnvvv4OQ4mow55EYwWWbEH6Exn11keWQrANBlzv
         Wv10z6k+eyzoMOFU2G9wAn12tIm6CBnbulUcLGs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1j0mNc0IX8-00LSzt; Thu, 02
 Jan 2020 20:58:30 +0100
Date:   Thu, 2 Jan 2020 20:58:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
In-Reply-To: <20191226214245.GA186931@google.com>
Message-ID: <nycvar.QRO.7.76.6.2001022053530.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com> <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com> <20191226200316.GD170890@google.com> <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
 <20191226214245.GA186931@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mjxaTJNBFlVvVQV6Y5h6/gPpL23w0jD/9sHQZbZoB/azeZ5kYnd
 BjjW9+5ont4Hjy2l9xqtxKfRgiNSwOxgdvCrUg3WfgXghrwvLIDn8p7My/IZkgzUKOUT6jA
 C+8wancX5Dx5zz09/xN+Cw/apk1bkN+2S0/lX93FLs4VpBghrj4Xcl0yVeMOTDgZcRmV5qP
 4U2JsDKR7JG0gTdQ8caww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E5PmA3orgbw=:YGEzNlOOhNXBdjtGKJejEh
 zNpGc8gXk0L1JiDyzSpa6ynXrKZ4aujW+YpId6OFz9O5FKMg8tdA+rD6Ys+e6p9lwxplUBRvj
 flSBtwq7nahY3Kgq2eZqRnCbffKRY1e3aBRxVKWJ6fkcuO6ToKVcmnxvfXKV41xYVjDQ5u81h
 VgHZWtwxT/tcJVPRxsUBcO2xC5w1xl+0fTwWxgrI1KK0nNMHTcV8P8+kNG+fhanErv/FBdCgv
 a9P0hB2ZdbrnnZDnqyjq8n7Fl0i51twUKbEOiYkTQNO7PBNaOfCHO0CkR5jgriAxzwM+w/fCZ
 M0IEO63gJf+5QqH6/HiWrrPOr2HYTlVvfxVnOtkKkMtP7/ja8797IbC2AUUFVQ1BRRHKP+Zi1
 HJfUmb8vn9bomm9evQTHi+Ngn+aKkonV7hFRsrUwHhvt7uwOC8bQPKfUX6pWee/EPAvx9HgU1
 nH4QHi2C25cTqkTGLxq/kC6w4M1XDqX7eU7LhiHA8KUrTk1GXjs49pZN9lTEGiE7229tc8yqC
 KCWGgD+c0yi6fqFt1fbOrr4Hy+0S3F7lvOaT+YzCJirezU2rLWBiO1YSdmnow8PeM2AWn+PGs
 DxNDQXa9ngbYSBi+sm13mz/l6Gs8ol4priocidZse7IX3ctBLkDzUD7FAEWKjtVEpFj1uOQwF
 mS/mvq3HPbHPuMt//J+kfjuiEMWW5n12fMuJa188lUTurCMMpMPsDsFJJoaIrhtapj6HWCt/p
 Tq+Z6PRlA7BkheT5FxDO79mv8Wrop9XhWxd5547MP5ZEsyyaFR3W3qgPcHjtkhCMDQgwldIKp
 Ob9s1DuKx5ZUtPy+GLLmVkDhY/AB8etKPs0dx0TanwxPyg/yEF01POH3rPsUoJyc0A0z6Z3Ec
 Xx0JPmj0UH/g6f8A1rcHJrTJF59O10TBryVgVZc/0xtgIQWObf/4bIdiEaY+lx+3dGhl3Ktmm
 XAnMWf/k6U52w00JjOs9sZbtQpsQAmpm4Wee8ncFoeY9k1kYQurkV6mnnlfqZoThEjqWHG1HT
 76270GW/3sGRrx8trv/KiicMQCEo/vvpOsPGv8fK7kJtnCtD/znX4qGwpKj5+e9tvLBuVWpva
 +dACYWNUzpzkvfnS1iBl5D4MNTz7RJ8oxXRMNRDj6/dIbn2hYxhcTHBGrTUCGimxcXddTBr3x
 wxYbCj8ItxBcEy8RejhcTSb5qp5xGZHwvbZJH6EgLIF4PFoIEigpqL7HiufGxvGF+O22w2xzW
 7vcqmBJ4MzBTUw3Y/w+tjPZR1Tc0hw57Yi4nUw+4N2Ms2SMHv4qw+iPNPwW0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 26 Dec 2019, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Thu, 26 Dec 2019, Jonathan Nieder wrote:
> >> Johannes Schindelin wrote:
>
> >>> Arguably, this is the wrong layer for that error, anyway: As long as=
 the
> >>> user never checks out the files whose names contain backslashes, the=
re
> >>> should not be any problem in the first place.
> [...]
> >>          between the lines of this commit messages I sense that there
> >> *are* repositories in the wild using these kinds of filenames.
> >>
> >> Can you say more about that?  What repositories are affected?  Do the=
y
> >> contain such filenames at HEAD or only in their history?  If someone
> >> wants to check out a revision with such filenames, what should happen=
?
> >
> > Yes: https://github.com/zephyrproject-rtos/civetweb contains history w=
here
> > at some stage, by mistake, a directory was called `\`. It has been fix=
ed a
> > long time ago, but users obviously still want to be able to clone it ;=
-)
>
> Thanks.
>
> What should and does happen if someone tries to check out an offending
> revision?

To answer this question, I added this paragraph to the commit message:

    The idea is to prevent Git from even trying to write files with
    backslashes in their file names: while these characters are valid in
    file names on other platforms, on Windows it is interpreted as directo=
ry
    separator (which would obviously lead to ambiguities, e.g. when there =
is
    a file `a\b` and there is also a file `a/b`).

> [...]
> > I added this paragraph to the commit message:
> >
> >     Note: just as before, the check is guarded by `core.protectNTFS` (=
to
> >     allow overriding the check by toggling that config setting), and i=
t
> >     is _only_ performed on Windows, as the backslash is not a director=
y
> >     separator elsewhere, even when writing to NTFS-formatted volumes.
> >
> > Does that clarify the issue enough?
>
> It helps: that tells me why the check is only performed on Windows.
>
> Since this only affects Windows, please only take this review as data
> about how someone read the patch.  The patch doesn't make non Windows
> specific code any *less* maintainable, and as a general presumption I
> assume that the Git for Windows maintainer knows best about what is
> needed for maintainability of Windows-specific code.
>
> But the commit message and docs still don't describe what the desired
> behavior is.  For example, should I be able to check out a revision
> with a backslash in it (e.g. via Git skipping the offending entry), or
> is the intended behavior for it to error out and prevent checking out
> such versions of code?

As mentioned above, the idea is to prevent Git from attempting to create
files with illegal file name characters.

> Is there anything we can or should do to prevent people checking in
> new examples of paths with backslash in them (on all platforms)?

As mentioned in my reply to Junio, I don't think that it would be wise to
even try to warn about backslashes in the file names. There are _so_ many
Git users out there, I am convinced that at least some of them have valid
use cases for file names with backslashes in them.

Ciao,
Dscho
