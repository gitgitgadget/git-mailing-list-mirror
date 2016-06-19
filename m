Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B99D1FEAA
	for <e@80x24.org>; Sun, 19 Jun 2016 08:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbcFSIuX (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 04:50:23 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:58987 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbcFSIuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 04:50:22 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rXSP338rjz5tlM;
	Sun, 19 Jun 2016 10:50:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 5015852C0;
	Sun, 19 Jun 2016 10:50:14 +0200 (CEST)
Subject: Re: [PATCH v2 0/8] object_id part 4
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <57665CC6.6070208@kdbg.org>
Date:	Sun, 19 Jun 2016 10:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 19.06.2016 um 00:13 schrieb brian m. carlson:
> * Adjust the Coccinelle patches to transform plain structs before
>    pointers to structs to avoid misconversions.  This addresses the issue
>    that Peff caught originally.

To avoid future mistakes, can you write down how "transform plain 
structs before pointers to structs" looks like? Is it a particular order 
of Coccinelle rules? Which part of the interdiff between the previous 
round and this round makes the difference?

On a tangent, I wondered recently, why we need oidcpy() and oidclr(). 
After all, in place of, e.g.,

	oidcpy(&pair->two->oid, &p->oid);
	oidclr(&one->oid);

we can write

	pair->two->oid = p->oid;
	one->oid = null_oid;

Is there a particular reason *not* to make this transition? I find the 
latter less cluttered with equal clarity.

-- Hannes

