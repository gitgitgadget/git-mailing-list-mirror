Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD70C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7EE206D7
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 07:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q45reSxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFMHsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 03:48:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:57381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgFMHsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 03:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592034473;
        bh=YoAE6OXZOz2dM5ikhzIKUeEBnZVL+SM7YJzSI0st5nA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q45reSxtd6ho+dN6cyEbRnw1U/T1bKCJ4aXFK4Vfez+ZT+Jtf8hoW3IFwDDzovJt5
         n9kxczGydcnVdEOkKIOmOGhTBR/Gai8R88NVTshhqu9ioz2FY6x0EjoKb/7GrmX+7i
         y9/KlGvT6saT3ihQIrAewIyjA2rwLM9P0KVIq9mE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1jHZxo2Ikz-00gI8B; Sat, 13
 Jun 2020 09:47:53 +0200
Date:   Sat, 13 Jun 2020 07:00:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqpna42tt3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006130658330.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2006121518160.56@tvgsbejvaqbjf.bet> <xmqqtuzg2twq.fsf@gitster.c.googlers.com> <xmqqpna42tt3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PiYOcqusZ7pIZDOQ8xwuosrVDlxr5mPt8Vla1SThr41yTOWiOaM
 dRzSCgb+6+z+dC0Ygou9OTms4rBe1eI6kE92FnNBNceIQzwg/4RZRn+kg9iIoc23YEQrPJm
 J7d7ZrOPwygjfMiMHe3t6+/0j0kGXQXFJhfyW5LNP74gQJgrxN4qdGpSqhUkQxeuLlIHfVL
 l2T5gh3Ss0eCwjT0fJ8dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kOLi7SqFYQQ=:vUjiVhZNt62BBXptZOJzlw
 3uz09VWKusA5A1hjdDZXcwJg5n+X3m8E1lGzmaYg7biwpqtFPJ9KvQFl2ymRXwOWhYzTid5r0
 MiNZH599amF5/Fh+ZJOtGUV9Z/Ms2TYFUfaOcRpKpipZuP9YLfi/EiIf3Skqa7mcbMfzzdW4i
 7DL0Ruwb38rEqxnRYAJz2PuT0htEkLS0fHgSR13W9fvVQlXqFQ96iAJcEJq+kNcNuh7udnm2z
 DYH6dcgvL9yr9d/MT1iU/WWilTvbCF2kMHA7T+WDrbje1bc6cODKkD/DLtYPzNP5uOJvem10Q
 j1CJpnPTJReYQrI2m9+9lJqm2ShcgAF+Sx3kxv6fNAjeM1/dbE7hrUvdwCF8u80euGmTts1cM
 BGd7+++Bjsh6HvES4LyMZKknyeU5a3wpNzipwkSb9LaViJiveNMEuVmtZY7fATHZsRkDhOWAv
 sSdwtkjf628lEbYZplzQN8CInF106tnWJk3JfIKxhW8x6cQCwm5roJIA1pR2/hNu5qb5BfeyX
 TvZP0dlRmUVufMc1FdN0pjd/kX6am6qvK6M74uD/sOTduAlGO+siSuVRfJBBhTPnAWKCzJDOO
 0m9BPujjZKKbKgGkuaflPhWlqJq6f+Zl/YyCpuxlvr3BZS60NQzwFIgKvOdSKLhJ4XdlXgVX/
 I5rHxVwnJy0MQw18obvlJFThBYKM+ejYQCZ4VrlK8U9QjuJT2Jl4KIrmXr56b14XfpU/V++8f
 3lU8OhSsnrQaTCMPtPvpL1RvjSb7IMQ6ISOQIYcVo474+Tjdjt9g4ulp6t+5dYK5++kwt1tfS
 X/tHfIrGomzUFTjiVWOdJD18c4JjNMnlWOHsRTZekhYBqxfVpRGihwYNVwVCudptJqoyl/ONW
 33tt2+TvUrWV9v1aOKUnnzSfFgc3rN4tMGkQ0ELOCRQCpowYmIJEXUjp/ImUaldMJLEQW52yN
 uYMuOClC5GBqqO6H0zEUcrEmFrMWJCZts3igsLaN7KNI1yG7Xxg4ib86i/t2CM26cPBuVUuup
 XBFgAOorpgt3AUtExly3QMQB7O2t4x09aQZLz9TLxGec+IFxN1DeCz+pOFNtiBzQZMYRO6IKe
 Pex3WiIjBzFBV5/Sg0l6b48C1OSa7vMzW6ScTGDSUhXx4hHzVqQZUS8vg/LCydRwBzifGlcEP
 ewfO3t/Vrpqjl2DusL5csjlT/YfBbJXuz1YBQMBHADmlMv8xQAZpFgWTGbz20xkspyYTAd1gx
 pNEWBVzLW7W3+zJaC
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Jun 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > As I said already, I personally do not think that this needs to be a
> > preparatory patch to anonymize 'master' that cannot be configured to
> > something else into 'ref0'.  This will become necessary when we make
> > the primary branch configurable, so I think it is easier to replace
> > the counterpart to your [PATCH 8/9] in the original series with it
> > in the v2 series.
>
> Ah, I forgot to say, if you think it is easier to manage the main
> set of patches for the topic to eject as much preparatory changes as
> possible, I do not at all mind treating this as one of the
> preparatory step and queue it separately, making the main series
> depend on it.  I just wanted to say that it is not necessary, even
> though it does not hurt.

Due to the need to adjust t9351, I think it is clearer if it is a two-part
change: one to introduce the "main branch -> ref0" change, and another one
to respect `core.mainBranch`. Those are separate concerns in my mind.

I moved the first one to the beginning of the patch series so that you're
still at liberty to take it early vs keeping it within the topic branch.

Thanks,
Dscho
