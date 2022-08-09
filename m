Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F553C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 10:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiHIKhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiHIKhO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 06:37:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31B1C130
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660041422;
        bh=l/iJyt+MFRRol7FrvDi1YiTDbdhLF5cc5ZQAJ6PwnW4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g2ze3HKqpeoFzHFZ/kbPStf1847BLbXIZgJeNTUeVHgCU2O3MPGXe+pQcHOmOJgja
         auqKiXKSimrlOl/59fa/iDfnOEob0rlBgxr5pssxyA5AdFel+3WrqVH7SW2lm7A7Z+
         X+HpIkeOHvX799FkTl+KwoMY1a1j0S4lORKWPveE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1oEAoG2Oio-00BZqU; Tue, 09
 Aug 2022 12:37:02 +0200
Date:   Tue, 9 Aug 2022 12:37:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
In-Reply-To: <xmqqr11zoe6i.fsf@gitster.g>
Message-ID: <663onqs0-465s-023o-9s25-p2193ss5so59@tzk.qr>
References: <cover.1659291025.git.matheus.bernardino@usp.br> <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br> <xmqqr11zoe6i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C63p9JtgRDjtFWIHt+NQmytaT8A0v3DbYMGGT3sNIAKkVi/3+rH
 XTask8EJvEqPBqDzrZqRU/Ty0xWfq3rtqSIHJaBOXMMjyLd1NHsruUehrqo83N2wgbBEFVL
 Uzo4pvZHdNglwxwbDKgkFRLFP1nSlPygIU4VeXNhQje4VgyXKPZjad9Hkn0N1TKr5GX9vkE
 WLvf82QcWWaS/fVkt6S+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VwY81EJ3zz4=:sluzmuP377N3AlDKcfUpCf
 ByYd6uM7HPSilFzhShGlSmJkcGeG3t7nkBeSYMB0Ypv9btyqW3gHYRC9JGco3arYbbgCNxOhP
 cIEsW8CcFwMgkTIiZbr40Z8vzySWUn0Ruc8XhSOlcD/RgdHqvsVksFEFtFkfeh+piq9CMycaQ
 68kpJHnVtUTwB9P8uhKuI1zhxZaxh1f5N3imeI5QPCb0bTaubrfyKK9Yb3SNVtdNjojSRuVT3
 GbmAEIySc/Wc67suKeNM9YKPwpAsAo+MjRirOhoYvRSjhoQWQBtspc14KJyjJgInh8UcZU+BT
 YCdPvtHKrxgebfW6H1IW3ZsKFnavypY2uEGMgU5vsOS4OarAm7gWMcoaBXNkHdu5QiW+BfU6n
 +KEsEqfwfK9yq5Db9wwsZWvpwBz2r2lxKwkdkQsW68YKRYA2Iau2uP1EpTpeLCwIuFxTdJW+c
 a+WMWA7sryHz0uRv9yxnOhXvpIZ8czaMKi75ChD2KLWfr2eYI/dvhKkk7b3ggMAsxOM83WaQM
 T72Si1jBdyM4rVT7Bob2hFSk69lOAGqkbB185JLbBQKvzWX+X51QbiXhx6o1sc0bCPIeqZMHw
 K9d6bKAcHvLpsgC7VAmk2UWRmauqVCQTLFStZNYnaHgysp4WL01wAcqwQxo8B4spKbwai9v2+
 nvv03EwRy23/ZoJii2W6rrxphPnxpVtaMG6RSoczAuFsXQQ+dVztKEWz8/aesY4NyCixIJuLS
 veGHAq5ASVagvP0f/BWu32/1IPur/F0R8dXiCBCwHnnINdBQia9Ac1yk8rftRT6brFiQcaQeh
 hPUfHRULFItf3CnI4q6SYvD35YvzvpMlQRP3HtScTGRtY/WBru8wHiVJ402yvy7iQWwkH1Dub
 PusmUDeAXLCQ5jwISQM0EqD8TtedvvOcic0QszUvmlLw60M/Vmo3uITEFnr1uptLycwut3w6d
 I6cYFsEmtba0gPFCpnr4qhn/JUNB/N0QjkfeBG6iMiDtR30ro0OrJKmnIsqCGhTeKhhwI6j5L
 0rYhxEHb0ZQhKw1ZmdrOEae1xaIaE9XqbzXPx/EWoNX0Dohk+oMBaAFAvEr89IOldjuhrRbuv
 +pdsEj1d0k8H7OVLpLlwg1/2j5VyJd4OZAV82oa7nCMO4kXvjVCUiLBBg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2022, Junio C Hamano wrote:

>  * read_capabilities() feeds the buffer taken from
>    packet_read_line(), so buf[size] should be NUL terminated
>    already.

Could you help me agree?

In `packet_read_line()`, we call `packet_read()` with the
`PACKET_READ_CHOMP_NEWLINE` option, but we do not NUL-terminate the
buffer.

See https://github.com/git/git/blob/v2.37.1/pkt-line.c#L488-L494

In `packet_read()`, we call `packet_read_with_status()`, but do not
NUL-terminate the buffer.

See https://github.com/git/git/blob/v2.37.1/pkt-line.c#L478-L486

In `packet_read_with_status()`, I see that we call `get_packet_data()`
which does not NUL-terminate the buffer. Then we parse the length via
`packet_length()` which does not NUL-terminate the buffer.

Then, crucially, if the packet length is smaller than 3, we set the length
that is returned to 0 and return early indicating the conditions
`PACKET_READ_FLUSH`, `PACKET_READ_DELIM`, or `PACKET_READ_RESPONSE_END`,
which are ignored by `packet_read()`.

In this instance, the buffer is not NUL-terminated, I think. But if you
see that I missed something, I would like to know.

See https://github.com/git/git/blob/v2.37.1/pkt-line.c#L399-L476

And yes, in the case that there is a regular payload,
https://github.com/git/git/blob/v2.37.1/pkt-line.c#L456 NUL-terminates the
buffer.

And the proposed `get_value()` function would avoid returning a not
NUL-terminated buffer by virtue of using the `skip_prefix_mem()` function
with a non-empty prefix but a zero length buffer.

Therefore it is _still_ safe to skip the `buf[size] = '\0';` assignment
despite what I wrote above, even if it adds yet another piece of code to
Git's source code which is harder than necessary to reason about.

After all, it took me half an hour to research and write up this mail,
when reading `buf[size] = '\0';` would have taken all of two seconds to
verify that the code is safe.

Ciao,
Dscho
