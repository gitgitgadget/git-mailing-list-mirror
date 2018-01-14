Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0152C1FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeANSkq (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 13:40:46 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:42350 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeANSkp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 13:40:45 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zKQKR4qJ7z5tlF;
        Sun, 14 Jan 2018 19:40:43 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2C0AF274;
        Sun, 14 Jan 2018 19:40:43 +0100 (CET)
Subject: Re: [BUG] test_must_fail: does not correctly detect failures - Was
 Git 2.16.0-rc2 Test Summary on NonStop
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Joachim Schmitz' <jojo@schmitz-digital.de>
References: <004a01d38cab$705262a0$50f727e0$@nexbridge.com>
 <001a01d38d57$d36c7d10$7a457730$@nexbridge.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <59d3adab-4a95-4ef5-2d8f-ef4c7b797156@kdbg.org>
Date:   Sun, 14 Jan 2018 19:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <001a01d38d57$d36c7d10$7a457730$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.01.2018 um 17:50 schrieb Randall S. Becker:
> Follow-up: This looks like the completion code from perl on NonStop is not
> the same as expected by git in the case of failures. I need to debug this to
> get more details to the team. We have had completion issues before relating
> to interpretation problems between perl, bash, and git in this platform, so
> I'm assuming this to be likely again but need to track down the specifics.
> Can anyone point me to where the detection is within git or the execv?

Perhaps you are looking for wait_or_whine() in run-command.c? But this 
function cannot do anything if perl alread exits with an exotic code (> 
128 even though no signal was received).

-- Hannes
