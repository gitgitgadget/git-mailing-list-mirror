Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB93FC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiIHUyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIHUyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:54:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415892AE19
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662670476;
        bh=3yYZJe0JZbdp2Z3JFCp4JgByww5G2J3yfcER3L+cy6U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E/M6G0VRSafiVNpGxBoXY/GiTJ0f4ps9lpVhXO5trN//nRLWiKxCbbouENocxw2ij
         vwOfuL9drukCFeprJKcLEzawJuLuHARLjUqgSaTiER5p4LxKgOchE0EV1PuticGO1m
         BwQ6BDsZFZDeGl4IGJxSD3MsFPmchsOp7plH6Bt8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1p0UdN2NDh-00hMej; Thu, 08
 Sep 2022 22:54:36 +0200
Date:   Thu, 8 Sep 2022 22:54:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
In-Reply-To: <xmqq7d2fywvr.fsf@gitster.g>
Message-ID: <q044qs1r-n8p3-1617-so32-02s1r88186sp@tzk.qr>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>        <xmqqwnbv7trp.fsf@gitster.g>        <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>        <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de> <xmqq7d2fywvr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1741476505-1662670481=:189"
X-Provags-ID: V03:K1:noNS/+Sgml0+vAD+6FfDs0AT0YspzIAPDoavAiuhS55Oyx0XCfR
 HBV2tiV7aHbR6a+nBzhVqUHsKUwArExr4KckdHXaZV6ciVPecpfHHL1BZ5S6HVk4/U4KPz7
 g3LVrAjVPEo2yiAGU1DuH5cRrQKZROopsTBpnCMODafsajkXZgcM2ulf/cHcPj4VxKDSggr
 siHnyn4OvJd8ZyFPxoAdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xS85s+jAFmY=:HDAigw6qrrATMGNO7vnwr5
 CiY9Qwio6V+Sh1hlY1sOjHpf6p1Vv6Kiy/7QWfCqZ+yu9fyX1TsWnR04zK8qAJFRUQBYaJCnR
 eel6Jsfk2DdTXbyYOB2XV8kkVQPKb6N2qnIv+iKLI5/wHDQbk4RS82mLJxDV7SBpSYv4p+s/U
 hl1yeAaR8E25mCrDjJfqcFoTmZhVzn7IAbjOij+7zAFATxbplbV7y7vhygkl+ymlCRJ94yPmV
 Du3Y2cPFqSqpbA6v4L7HcWpZTBUEvrceivusZ/4r4/wLsSRfw+lVNWJ3BsGreFWhYrMAU9H2l
 KGzN89rq4ze/DlZp9J96z7zgjlbFZshFC+lsTIfnTJ5n6KTjsX3rByp7rks8AH4T53kOyRxaQ
 eeSWR2rsEVL+pFMHVWJ4+6D6U8scZk1egbLR9BmsXMuE7YmyjYbxPKo+wTpnC5nC2AlqTmkOB
 P5oDqxkqZHz23xHwxsm4yJ9DGqy+rXZCqwIDMLCGGvYHhGbr3DhijDXFrmGC8ZZCUyJA5OzCN
 oQmknmf6n/Dlp2DjVnXfFkDIF2HY69iZNGfoj7bB0LzhaA08GBi9gXlvHgxpG3yJeKxO60Q7N
 6IftrZnNV9wNHUtFIDhDn7vb4NfIz4box9KAdjS9SYTBdNRPyg4CrPyGOoFJmaoHgJChF+uvP
 80MStj2uUjkubxDJzdDqGiAHyfhRxsS0wkPsDiwtG70QZScIh9vbhhMgklGlYEz945TG//Tcg
 r/+Ei/+DpZH2a1p+5s7CEyPTFVjfZAX/376EhzAu/nDzcfovn+WCOQ9R2zXQ3pO7QpSG1jMz9
 md/CnvfBe+bGAVtN/5boGz/WjiAvV7Q0UJjHgZr0MNMt//2B9R8UWk2iOQyjjghN3civfHulz
 zU7g93iPaIonXyzXIgNm2uDXpVEEBrrpk1lJESdj7DpXhA3sV1EiZpEO0IesIL1hPIA5ryWkF
 4alnTZqXAEKu9T7CYUc2kcTOkj8Mh72uEX8mc0ppJxBsXESNfwPH9x1cdSahjNwVWvDf0SjCW
 r2VaDY746OryWk7CMw1+cWvqpptkhTnFEZC0ay9LD8Rne5zfdiKuzBEe8v83B0OPUqW6cpr6O
 Eo05Lm6uLD40qxSu3nGTttXGmELkFN21SUw/HByTmhwJsMzQt6xelHEncfdLn8FkwYrmbGSFw
 RrOcJP903ZPYPQL82XwUT1uvPX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1741476505-1662670481=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 7 Sep 2022, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > "git diff --no-index - -" also doesn't complain, by the way.
>
> True, but in this case hopefully it is worth to call it out, as both
> this code that uses "diff --no-index" and "diff --no-index" itself
> came from the same author ;-)
>
> I think "git diff --no-index - -" should just exit 0 after slurping
> all its input (i.e. allow it to be placed downstream of a pipe
> without blocking the upstream), but it is also fine to exit with 0
> without reading a single byte from the standard input.  Of course
> the latter is easier to implement ;-)
>
> >>> But otherwise the idea is sound.  We compare them line by line,
> >>> using strbuf_getline() to ignore differences in CRLF and LF that
> >>> originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
> >>> random LF <> CRLF conversions, 2013-10-26).  Only when we find the
> >>> input different, we use "git diff --no-index" to make the difference
> >>> (and unfortunately more, as it does not ignore CRLF <> LF
> >>> differences) visible.
> >
> > Why not use "git diff --no-index --ignore-cr-at-eol"?  Do you even nee=
d
> > to wrap it?
>
> Hmph.  That surely sounds sensible if it works, and I offhand do not
> see why it shouldn't work.

Is this a reversal of the stance you took in your reply in
https://lore.kernel.org/git/7vps7xrfxa.fsf@assigned-by-dhcp.cox.net/ to my
suggestion to replace `cmp` by `diff --no-index` (in that mail referred to
as patch [7/8])?

If I recall correctly, you clarified outside of that thread that "I do not
think it is a good enough reason to make the tests slower" was you being
concerned about employing the entire diff machinery instead of doing a
simple byte-for-byte comparison.

And while it is no longer _that_ simple a comparison (it now
special-handles Carriage Returns), the speed and simplicity concern is
still valid: `test-tool text-cmp` is vastly simpler (and provably faster)
than `diff --no-index`.

Just because it is easier to review a one-liner to switch from essentially
`cmp` to `git diff --no-index --ignore-cr-at-eol` does not mean that it is
reasonable: it would cause us to blast out that much more CO2, just for
our one-time convenience.

Or for that matter, it would willfully slow down the `windows-test` jobs
that already is mired by sloooow performance (mostly due to running a
shell script-based test suite).

Can you please let me make the Windows situation better rather than worse?

Thank you,
Dscho

--8323328-1741476505-1662670481=:189--
