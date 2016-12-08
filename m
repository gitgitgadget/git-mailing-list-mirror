Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E5F20451
	for <e@80x24.org>; Thu,  8 Dec 2016 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbcLHSlt (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:41:49 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:52547 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753380AbcLHSls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:41:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tZPNB2SsFz5tlK;
        Thu,  8 Dec 2016 19:41:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CA8FB1E71;
        Thu,  8 Dec 2016 19:41:45 +0100 (CET)
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
 <20161207201409.GA19743@tb-raspi>
 <xmqqtwafwkdt.fsf@gitster.mtv.corp.google.com>
 <20161207221335.GA116201@google.com> <20161208075555.GA23595@tb-raspi>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6cae7549-72f2-e591-ad48-28d449a62caf@kdbg.org>
Date:   Thu, 8 Dec 2016 19:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161208075555.GA23595@tb-raspi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.12.2016 um 08:55 schrieb Torsten Bögershausen:
> Some conversion may be done in mingw.c:
> https://github.com/github/git-msysgit/blob/master/compat/mingw.c
> So what I understand, '/' in Git are already converted into '\' if needed ?

Only if needed, and there are not many places where this is the case. 
(Actually, I can't find one place where we do.) In particular, typical 
file accesses does not require the conversion.

> It seams that we may wnat a function get_start_of_path(uncpath),
> which returns:
>
> get_start_of_path_win("//?/D:/very-long-path")         "/very-long-path"

We have offset_1st_component().

-- Hannes

