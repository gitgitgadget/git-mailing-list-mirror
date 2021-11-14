Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01358C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41566109E
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhKNThZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 14:37:25 -0500
Received: from avasout-peh-003.plus.net ([212.159.14.19]:33815 "EHLO
        avasout-peh-003.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhKNThM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 14:37:12 -0500
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id mLGYmqeLcI8oDmLGZmUHb8; Sun, 14 Nov 2021 19:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1636918457; bh=axijXkhzC08k0AM3+vncK38+tj0IDVknoLIZ7B8bJbk=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=KXeb8m2NGptVNFnZvUGPOH5yd5fd8dwAkGepipXJSr1wcz9CzUcMopozrLEBmkWPf
         8gx9CdCDnJPRG1xAEkzKDJt9vW8sMrW3uAPBJWqsw/nSe79y/JZRu26akl0V0lh17X
         ZHUa/rYVSlm1KhO0hqPPgRPZ/eMIfFFwgEa2Hrk+TfcaMeWeML3vkRt/f2WDsqiHjs
         MjGyrFqJEHa/zgFCGgASoHoGVOaPuTFe486uqT5+K0pxK25fuEGQCBqMeLoKG3hum+
         4WE2gjQdTS6rWb0nBWr7LdUMcNdCF+6IjbmuIotLJTt38MAovkBonHCihSHDQvWoRB
         1/BPu6B6vjVBA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=bPl1nNyZ c=1 sm=1 tr=0 ts=619164b9
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=u0PU4lIHSP-smmge5k4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
 <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet>
 <xmqqee7ozyx4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
 <02b6cfa8-bd0a-275d-fce0-a3a9f316ded3@ramsayjones.plus.com>
Message-ID: <c3fb4778-9537-f909-f792-5a298dbb3907@ramsayjones.plus.com>
Date:   Sun, 14 Nov 2021 19:34:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <02b6cfa8-bd0a-275d-fce0-a3a9f316ded3@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLHsG8UlDWoD1wtsyheYtjO+5saRgnlq1clgFm/HoUBRpkC24Bx8aYrVBNgpMkVYk0Itv/ENKR4lM2RMX4vDeU2oNWUIyas3QxCiJadeP76vjzT6rHWM
 SYTOcJGuNrX8/+INvUkbElApNZoiXGZ0KRMmTPKKlXwJ/SszQXF7k4csVHPEVtxgaVv7mKnDysFikZyS4OWox9syuqsN/pwE2Co=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/11/2021 19:11, Ramsay Jones wrote:
[snip]
> The only change to my setup, between -rc1 and -rc2, was the cygwin update
> to v3.3.2, so this may point to some more fallout from the new pipe code
> (maybe?).
> 
> Anyway, I haven't even looked at the new failure (see below), which we will
> probably not have time to fix before release, so I am just now building
> current master (v2.34.0-rc2-16-g5a73c6bdc7) to give that a try. (So, I won't
> have anything to report until tomorrow).

So, current 'master' fixes t0052-simple-ipc.sh, which is good, but the
t0301-credential-cache.sh test is still failing. Also, I can confirm
that cygwin v3.3.2 adds an additional hour to a test-suite run. :(

[ie it now takes 6 hours rather than 5 hours to run - I remember a time
when it used to only take 2 hours; those were the days!]

ATB,
Ramsay Jones


