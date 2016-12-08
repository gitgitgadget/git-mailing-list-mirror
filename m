Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99E61FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 11:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbcLHLde (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 06:33:34 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:51850 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbcLHLdd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 06:33:33 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tZCsC4Kfzz5tlC;
        Thu,  8 Dec 2016 12:32:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EECB51E71;
        Thu,  8 Dec 2016 12:32:46 +0100 (CET)
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <7d968fd8-a92d-efd3-ce67-7de6049b6d56@kdbg.org>
 <20161207222927.GB116201@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1767f01a-4125-d99b-37db-3f4a56aaa28a@kdbg.org>
Date:   Thu, 8 Dec 2016 12:32:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161207222927.GB116201@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.12.2016 um 23:29 schrieb Brandon Williams:
> Instead of assuming root is "/"
> I'll need to extract what root is from an absolute path.  Aside from
> what root looks like, do most other path constructs behave similarly in
> unix and windows? (like ".." and "." as examples)

Yes, .. and . work the same way, except that they cannot appear in the 
\\server\share part. I also think that .. does not cancel these parts.

As long as you use is_absolute_path() and do not simplify path 
components before offset_1st_component(), you should be on the safe side.

> Since I don't really have a windows machine to test things it might be
> slightly difficult to get everything correct quickly but hopefully we can
> get this working :)

I'll lend a hand, of course, as time permits.

-- Hannes

