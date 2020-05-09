Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A827C54E49
	for <git@archiver.kernel.org>; Sat,  9 May 2020 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DB621473
	for <git@archiver.kernel.org>; Sat,  9 May 2020 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K2zUVPD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgEIL1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 07:27:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:43145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgEIL1j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 07:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589023645;
        bh=nwdiwXpoRoeTXObtKsAKFrCFlwDaMh41PyruX3IIqh4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K2zUVPD3AWOXCM8c8q49JcDLNxpB1TQTCx4smV326r150Hlsziw38FevQnTzVSh+6
         RWOSyzI6lxQxfq7his58oeUSLcWhptCZNRXoqTM7hWUfAP0JN403hy7qMBdRKDhMRD
         /ctSbdZtD1qmtJ1/rUq2712sF9wyFm7Oii+Kyjog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.212.13]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1jACRk3xOm-00wUUm; Sat, 09
 May 2020 13:27:25 +0200
Date:   Sat, 9 May 2020 09:07:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: Preparing for a Git 2.26.3 release
In-Reply-To: <xmqqk11mvzb4.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005090903560.56@tvgsbejvaqbjf.bet>
References: <20200428055514.GB201501@google.com> <xmqqk11mvzb4.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/0T7rSvCTyCu1Ytlp0sQqHnnOddT3EU8cgBKqA9G97KpNyMATkg
 ciU3lpYz+vnh6iiyIepTySLXEAfWjHdpfZKUFY+j2Z2TDqNtb+yj66GarSjh7zqhw0NF28L
 F07SaFT6lknRikSQ47wCO86HiJWz+vcaYsQ4LvEkRg+T/F8W5xroN19yErAOomQ3NKh0niH
 hBQrVGhWGQiPS0pDBAw/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S0Zro0WY0lU=:8pREyCSJI2Ni8JwVhlJNHB
 Koop9z/ljdRhoOgeN5TEL9pKoMBe/ynC9hQD+5mstBXL0hcEHXIM/+ps7Lscrq8MmuTzJ0l6p
 urNvyD59o/fc21/nbWC1AxwOO3GVJVaEhRxsmD1h6KA6FAU4tqN0DJrPriHioO93d321RHrC/
 ekP9LZX3Ktf7TdQ8WiidUz3CmzNm0GhYkGoQdER6HOyUtZ2A463x1gFmodBEXvaEsMQchWRJ/
 D760xWaRFRuybmjUzD5fzKRi2utcygiDSDi/2g3L7QRmD8kJig+N8kKRvB0dlp7ELenSFnLuf
 tExohCwf0MmpeG73jyExYi0FtPNJD8VdQOjWA0gDKnqoYjGMpHcRLkgzHcNAtFGVkYSPeHsAi
 Z8EYi7p6vzW66eEKRJH1aMqre2eJaC9BoT55UkULFnCxrgfDM0ZwPIeMIsHLEFc1wd4gwteqt
 H0c7KShr+QAUQXu9EbZVPI0UqeXJ3UN5HbYOjWZWLt29LD4+golYk/eu5dOy7rs8J/MKshJrP
 5NOt9/30z3zHwiME6hZLMjhgRTRxezal0tUX9HENhqWvKsUnX14EGKRWugpab7FMqJlWIegHr
 7D/FD8/9sw93TSMbNZqsr3bXEaJHbO4RvhqDs1nNAZWqq4S1RzWUeTzWJLBz6+jMH0eUDa5e/
 Tot9rIo8l2gMXM8cEQcp3JI2pru56RDmFipzIkUYjpIr07g6jTFcjaXLvtQOBcX4+AX9kSfLt
 sSLdCgDwhib+NkgnNjNdD+bHbzEJDyoD3JVTyb0c8DrtXfVchiRdVgFt0h2QCKBpu0CscX5ry
 vlGv7sJf94oRgW/f+ctdMQ/uOYOOB87dtPdEKYt3Qfw/huwPBHSxoES0YTpIPY+yhcDcRvvDA
 J2UdYe3bG7pLp/4HedUH3lPwoIwtyqlCRgtYKwilNUvawGBZnzi1Gw/Hr3AtvZfI04jVmiezC
 J4VOk6hKph+AmfQXx8bdmb9vpaWiNoIZYWdi4gpQV7VcHR4jRJdUn1QP/wXMg6/d+d8PiOR6C
 UPL64ln/IpF3v19EM5UOoIvVSmRMrVl7MWWFW5IHmPUn7qkntu3QCjr/LhmvJlFE/roMvuTFu
 6zCw6b8PMyb2PR10mtBN4r5nsQoeIaf5s85/CLohH09OT2O0SKNz/F6zW8/gus0zxXhSaYs9w
 OeacIqDpdsLrVoDWHXsFzUDCTs4y5tlNCcRMRe95bi9ZSK7i8OIsbKI4+MySQWnO0waaMN47+
 LEE83fJvtjBijs1Kk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 May 2020, Junio C Hamano wrote:

>  * Recent updates broke parsing of "credential.<url>.<key>" where
>    <url> is not a full URL (e.g. [credential "https://"] helper = ...)
>    stopped working, which has been corrected.
>    (merge 9a121b0d22 js/partial-urlmatch-2.17 later to maint).
>    (merge cd93e6c029 js/partial-urlmatch later to maint).

Are you planning on also releasing, say, v2.23.4, with this fix? I ask
because GitHub Desktop currently bundles Git v2.23.x, and while we fixed
the breakages on Windows, they are still present on macOS and Linux (for
details, see https://github.com/desktop/desktop/issues/9597).

Thanks,
Dscho
