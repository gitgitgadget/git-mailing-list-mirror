Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1C01F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406812AbfBNWk5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:40:57 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:48548
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388757AbfBNWk5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Feb 2019 17:40:57 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2019 17:40:57 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id uPZWgBNHcbtsnuPZZgVWpC; Thu, 14 Feb 2019 15:33:38 -0700
Date:   Fri, 15 Feb 2019 00:33:34 +0200
From:   Max Kirillov <max@max630.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Johannes Schindelin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
        'Max Kirillov' <max@max630.net>
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Message-ID: <20190214223334.GE3064@jessie.local>
References: <pull.126.git.gitgitgadget@gmail.com>
 <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfJ9di/7MfWBpKixf+dumnQXUcJZJq8pqcjkb6tavmdJp87lXE9k1yVKkpklSl4+jar+ZsqUF8uZyTPNUHiCmAh+sE376XxvR35SYBVnUlftYnPgFn9iC
 /1Vhu4g5W8pG83emYMbgDpYRfRLQAb++eYFR43HpIeSHGVRt+/pUq6tdRxxGaxUjId6FYBy5P0927Xhu500ly2+LToi9F2cB5CWa3mBNQ3xNDeTom+du/F4k
 ckqKSAEQTWeXiPVUq9H67sPl1QWXZPIEdwa1pIM8K+QUOOyfkhGloEZ7e8Pa/l2G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 05:17:26PM -0500, Randall S. Becker wrote:
> Unfortunately, subtest 13 still hangs on NonStop, even
> with this patch, so our Pipeline still hangs. I'm glad
> it's better on Azure, but I don't think this actually
> addresses the root cause of the hang. This is now the
> fourth attempt at fixing this. Is it possible this is not
> the test that is failing, but actually the
> git-http-backend? The code is not in a loop, if that
> helps. It is not consuming any significant cycles. I don't
> know that part of the code at all, sadly. The code is
> here:
> 
> * in the operating system from here up *
>   cleanup_children + 0x5D0 (UCr)

... so does the process which the stack was taken from has
any children processes still?

I could imagine if a child somehow manages to end up in
uninterruptible sleep, then probably it would never complete
this way, wouldn't it?
