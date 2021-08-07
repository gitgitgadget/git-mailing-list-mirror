Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F5C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A716113C
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 09:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhHGJor (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 05:44:47 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:47146 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231615AbhHGJoq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 05:44:46 -0400
X-Greylist: delayed 7476 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Aug 2021 05:44:46 EDT
Received: from bsmtp.bon.at (unknown [192.168.181.101])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4GhXy63j5pz5vLr
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 08:49:18 +0200 (CEST)
Received: from [192.168.1.103] (089144221092.atnat0030.highway.webapn.at [89.144.221.92])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4GhXy12Ylrz5tl9;
        Sat,  7 Aug 2021 08:49:13 +0200 (CEST)
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com> <YQtYEftByY8cNMml@google.com>
 <YQyUM2uZdFBX8G0r@google.com> <xmqqh7g2ij5q.fsf@gitster.g>
 <YQ3n9Z2nH35429mC@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
Date:   Sat, 7 Aug 2021 08:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQ3n9Z2nH35429mC@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.08.21 um 03:55 schrieb Jonathan Nieder:
> The motivating example (Rust) shows that there is at least one script
> that _did_ use "-m" in this way.  Rust has mitigation, but the above
> logic leads me to believe that they are not the only project that will
> be affected.  And more generally, when a script author has a
> reasonable reason to believe something will work, they write scripts
> where it _does_ work, and then an update breaks their script, I think
> it's reasonable for them not to be happy.

As you know, we have "plumbing" commands with a stable interface and
"porcelain" commands for which we reserve to change the behavior without
advance notice. By your reasoning we would not need to distinguish
between the two categories and were forced to keep all behavior stable.
This undoing of a behavior change in a "porcelain" command with the
argument that one script depended on the old behavior and that others
might do so as well would set an unwanted precedent.

Perhaps we need to point script authors to "plumbing" commands more clearly?

(BTW, I have no opinion on whether -m should or should not imply -p.)

-- Hannes
