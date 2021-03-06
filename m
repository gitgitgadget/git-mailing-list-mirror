Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CABC433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FC064FCF
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCFQTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:19:39 -0500
Received: from mout.web.de ([212.227.15.14]:34361 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhCFQTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 11:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615047534;
        bh=fKjcBCFGBM2POzBEulTNsHTEgzKFGTupqBUhnHumpsM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ZOSkQBqUAfyKaGIlV7XvSJZ3YfhC572/LEW7+UZK2fT4t98Rt4TfWTfQlNVnMvRqO
         7tqezwf12lKMWhABHb2CaLvvtNAWC4l/EQF8VJAjLYirSvu2i4rilr0IYIknUnCSqB
         bdQw3uTdft9yGObCwUMkPvS8CnbeKkxASliHAru8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MC1RI-1lRL4945wW-008tAY; Sat, 06 Mar 2021 17:18:54 +0100
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eli Schwartz <eschwartz@archlinux.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
 <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
 <b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.de>
 <87blc4kxo3.fsf@evledraar.gmail.com>
 <30f78fce-fe1a-0a50-fa8c-e6fe14a03bf3@web.de>
Message-ID: <a28592c5-4a70-1ea8-fd73-959e28b4278d@web.de>
Date:   Sat, 6 Mar 2021 17:18:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <30f78fce-fe1a-0a50-fa8c-e6fe14a03bf3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XDnioue+GOiXGG3SBpmQwgv3otFPRpVpjGS+tFl5WIHH0eJvQHC
 PTDzWrRFVQqHdO4MPBaMVZNEC38nzCCXpfVpVD5cwCEh/YL9Fu3G1t8h5S3t9n8Ac0Mnzu1
 rAwWihQ6tnpv3LfqX9t1DNYRY423dmbm53V2J8/mv5ZgaceV/GA9z8wG5/+jz03pFaSAqAJ
 J4Nltxjf7l9cgBN+THrfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3XvH+KlqC/o=:sDnkskPEvNfqbTekClMJJ/
 MmTg7z16/jladErueMzPOtP0+7YrWEsJ8kOT4NZqvWxuHlINUyKJ4EW6ZrB87LG23tP1QEKF5
 5psgqSeMt6+3XewBp63rexgg4HVAigCCKwn8nCOTs+5M44Jb3e7EXjumm62M6QZEypmhYJr8Z
 6bnVUBDRXwgG+N0hRN9Xc2GEHgrxS+Y4wcjawpOSTxpYgVez1JofQ4SYLd3WkF222bcPaR41G
 1ERfsHGWQLXwxCtdn4qMkIQLcJugLQ9tJCxk6YYNRImoilkbl0OtvZcojiP35Yq4yvX/OFlht
 wpeKM9zOCbTX+IncMi6nuz4LY++0QQR3nrhpYnJRhK1FJ9EKLup1bKsNRPZ252Tisne6Ryx21
 Kziw4ohD2vgJwYqDXQKQKm4y2zkx5856VtiUj8fFKUoG0qtQJFPTrH4r6PjT05BuZ6b2BPSz4
 kah0BENG3xBIEaUOARywkKv6grFf56Rh4VJ5CXPD9Honv3NsVXBUikcNpiNZX/xwc2OqPi/NU
 I0A3IuyhvBjflakdYjXGEkZyfFZe/J+Mt+oq8qLJs2ZUx8ndOtBsZozEeftXrXgX2NFimpOyX
 1P7EJrNz9yTEl6CvVS/qDwugu93W+qyXH6Er7upDCX0j/UOLxv1VKA8dg0WTBzX+fJtnKawRD
 BdSmHLNpttK8EFU8Q+X5XFcDBRMgt0ApZpbSMHf6hVDjLlyt4Irvy160FOpFYl8ayE98NVY+G
 O0Gq1IaCt4KDlcWrooE0elIB2O8hiohEjinWdtsdcFwzISrohgAADNC6S+KmZWuT7RpKQFpBn
 eR8DI9rFbLJ5cY6ihAMR0TeA28bHopOnuStGaoyYGtmjF65ZNMV+ricdQqXziFqnes3xp4pIS
 Q6LnMGtfCKfRU8dQdpHQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.03.21 um 17:00 schrieb Ren=C3=A9 Scharfe.:
> Am 28.02.21 um 16:41 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Instead of taking the trouble of putting a limit in the
>> pretty_print_context so we don't call it N times for the same commit,
>> why not just put the strbuf with the result in that same struct?
>>
>> Then you can have it millions of times, and it won't be any more
>> expensive than the other existing %(format) specifiers (actually cheape=
r
>> than most).
>
> Each %(describe) placeholder can have a unique set of match or exclude
> arguments.  Caching them all would increase the strength of a DoS
> attack.  Caching a few of them would be OK, but is ineffective in
> reducing the strength of the attack.

The script at the bottom creates archives that illustrate the issue. On
a repo generated with parameter 10 (10 files with 10 $Format:...$ with
10 %(describe) placeholders, so 1000 total), I get the following number
with v2.30.1, which ignores %(describe):

Benchmark #1: git archive HEAD
  Time (mean =C2=B1 =CF=83):       2.2 ms =C2=B1   0.2 ms    [User: 0.9 ms=
, System: 1.0 ms]
  Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   2.8 ms    705 runs

  Warning: Command took less than 5 ms to complete. Results might be inacc=
urate.

The version in next expands all placeholders and takes three orders of
magnitude longer:

Benchmark #1: git archive HEAD
  Time (mean =C2=B1 =CF=83):      2.300 s =C2=B1  0.003 s    [User: 819.0 =
ms, System: 1200.0 ms]
  Range (min =E2=80=A6 max):    2.293 s =E2=80=A6  2.305 s    10 runs

The proposed patch to expand only a single placeholder gets the runtime
back under control:

Benchmark #1: git archive HEAD
  Time (mean =C2=B1 =CF=83):       4.7 ms =C2=B1   0.3 ms    [User: 1.8 ms=
, System: 2.2 ms]
  Range (min =E2=80=A6 max):     4.2 ms =E2=80=A6   7.0 ms    451 runs

  Warning: Command took less than 5 ms to complete. Results might be inacc=
urate.

Using parameter 100 takes about a second to create the repo, but the git
archive version in next already needs longer to tar it up than I'm
willing to wait.


#!/bin/sh
n=3D$1
mkdir $n
cd $n
git init
for i in $(seq $n)
do
	awk -v i=3D$i -v n=3D$n 'END {
		for (j =3D 0; j < n; j++) {
			print "$Format:"
			for (k =3D 0; k < n; k++) {
				print "%(describe:exclude=3Dx-" i "-" j "-" k ")"
			}
			print "$"
		}
	}' </dev/null >"file$i"
done
git add file*
echo "file* export-subst" >.gitattributes
git add .gitattributes
git commit -m initial
for tagno in $(seq $n)
do
	git tag -m "$tagno" "tag$tagno"
done
