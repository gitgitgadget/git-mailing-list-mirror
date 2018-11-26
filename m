Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4809A1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeK0Gor (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:44:47 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:16873 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0Gor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:44:47 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 433cv251rdz5tlF;
        Mon, 26 Nov 2018 20:49:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A0C2A418F;
        Mon, 26 Nov 2018 20:49:33 +0100 (CET)
From:   Johannes Sixt <j6t@kdbg.org>
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
Message-ID: <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
Date:   Mon, 26 Nov 2018 20:49:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.11.18 um 04:04 schrieb Junio C Hamano:
> It appears to me that what Frank sees is not "^M highlighted for
> whitespace breakage appears only on postimage lines, while ^M is
> shown but not highlighted on preimage lines".  My reading of the
> above is "Not just without highlight, ^M is just *NOT* shown on the
> preimage line".
> 
> That does not sound right.  I would understand it if both lines
> showed ^M at the end, and only the one on the postimage line had it
> highlighted as a trailing-whitespace.

I agree that this is a (small?) weakness. But...

> When we are producing a colored output, we know we are *not* writing
> for machines, so one way to do it would be to turn CR at the end of
> the line into two letter "^" "M" sequence on our end, without relying
> on the terminal and/or the pager.  I dunno.

... this goes too far, IMO. It is the pager's task to decode control 
characters.

-- Hannes
