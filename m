Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47CC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2022231B
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 12:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e+tttQTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgKBMZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:25:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:51069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgKBMZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 07:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604319927;
        bh=9lD3T7Aw7mVG0hDN5W50OwSScK2miwp8LADOSQKozHI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e+tttQTVoq8okutAHdzyVhXKLmIajQn2ZBNGntY4RPo4Zy2DuAsNe1K7yHMpzD4yl
         dgBI3HbHOPBX2rqJbiFB7BgcsDBK1pWEFGwU74q6jZeqx7TEJrSl3riJGtWWKksuTC
         9SpwcAOKOhyX+lDmzRUvzL5tWJ/1Qlkr9/+n5sf4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1kS6ua2dMx-007UOs; Mon, 02
 Nov 2020 13:25:27 +0100
Date:   Mon, 2 Nov 2020 02:47:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jc/sequencer-stopped-sha-simplify, was Re: What's cooking in git.git
 (Oct 2020, #04; Tue, 27)
In-Reply-To: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011020237070.18437@tvgsbejvaqbjf.bet>
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fCpoiV6n4yxVXdGzYh4RYFS14nnxzy+dqMu8nf9RFDGXyMf2lQ9
 UgJrmsFFt0rWDDp7CUDRGlpzwawwx8fHg09DT3HuQ06wXR81ZYJ4SDD2+Wxa/5vYZgiGnSo
 2pCCiWPwCr7SLUosg+t0AlEl4ptx5cLg4wNaK505CyJ++UvVUtJG8uVNznYWjss0C5HO0I8
 GcJDEvSx92W6xmrC6HgjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B0CwfSgSFok=:+bozCSDYShmGNwXzOG9sQt
 qOAZjJ9ecrc0cSko9Ond5+bfEc1JI20/OHInmbHwhywMJ1neU9y9ZNqonX0eOpXP9daJ06Vxf
 aH/8G8uXVLOhZflB36ffAQ8l+PpiKhqVPIY/1v6Wp8lfyZcOSZ2zFSkacwene3xhlXn5drmwG
 QHFp56dcVci0jZC8S9F8ZRiDgOeXsPUk2S8Q62H2eDAJ6kWPdpLSGJHpt8gQuZbZmpykQRLii
 eh05mV2QZUnTPkf159exQu4bXZDjcw9a7sKYf03E7w4kcvl9y+lvV9E9KF/NEhpmaO7h3eubQ
 gMlvJJHZR64ThS0q7BzjhOyZVpuAQqLX2+n8cVaW+ppxihgEK2qHzGT/nCUiHur3LJrJMswo8
 okMhztrMmhEgFk2ysFsT0ANvoGpqcpNS3Fi4cKBMHMdlqZ0Qt9O1mSFbdC0NSeinipz3rSTFR
 Oy51i8veZA95CYYr4q8ya5IexURfFy3QPq9jpu7A+52Ainz4fNEsB00TAV21NOkG+I5D4flzc
 SX1UX5ElNhLsFtEzbJC9pD3NZ1yPA7EsqhInFoUWG83KqwvyUg4Ru1VstnvHZMjA08+FCCDJb
 ATV4ZYaKIHaeVgQVdPdL/REC1o5H+J1GPAoGnqEOH8Hj6IZyd24scmFokoD+OJ2NXmdgfG8Um
 baKuzEkqfJsn42mD07n2neboF7WeytXa5Ml+JlloTpPWB5Nuo3v6QeHh2uVT2LiVgDjRiAvd5
 iFHZ8aGMnJlZhvcMGwpQGTEKCV9AoDizaDBm9bTBo2OnqePsJIyxy9UyU5D41Ry55yHpMNif+
 UrC4eq4vKhY/6DprX/bcwjCPBxcHRwGKcdJCOmXN+qmSjabf82FURKrrRRVbc4RsLajPiJryE
 RNH7z/LT92O71BBdDuxYfWtFLV65L+wJLHwazKGMo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Oct 2020, Junio C Hamano wrote:

> * jc/sequencer-stopped-sha-simplify (2020-10-21) 1 commit
>  - sequencer: tolerate abbreviated stopped-sha file
>
>  Recently the format of an internal state file "rebase -i" uses has
>  been tightened up for consistency, which would hurt those who start
>  "rebase -i" with old git and then continue with new git.  Loosen
>  the reader side a bit (which we may want to tighten again in a year
>  or so).
>
>  Is this a real issue, or just a theoretical one?
>  cf. <xmqqd01b429a.fsf@gitster.c.googlers.com>

We had a similar situation when we decided to fix the incorrect quoting in
the `author-script` file, and we decided that we have to be careful:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1807271415410.10478@tvgsbejv=
aqbjf.bet/

In light of that, I think we should go with Jonathan's patch for a couple
of versions before tightening the reader side again.

Ciao,
Dscho
