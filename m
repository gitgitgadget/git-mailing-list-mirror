Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A1C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8F611CE
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFMHri (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:47:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35705 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229777AbhFMHrh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:47:37 -0400
Received: from [192.168.9.205] (157-131-169-219.fiber.dynamic.sonic.net [157.131.169.219])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15D7jYrM005080
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 13 Jun 2021 03:45:35 -0400
Subject: Re: v2.25 regression: cherry-pick alters patch and leaves working
 tree dirty
To:     Elijah Newren <newren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <148044c89c194a82aa15ab0ca016669d@oc11expo7.exchange.mit.edu>
 <CABPp-BGDfucqae=HNES_QmmsjpDbdHrR6CG=H3gtiDygHzquVg@mail.gmail.com>
From:   Anders Kaseorg <andersk@mit.edu>
Message-ID: <9ef09567-d69c-0fba-a09c-70095a21a3a9@mit.edu>
Date:   Sun, 13 Jun 2021 00:45:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGDfucqae=HNES_QmmsjpDbdHrR6CG=H3gtiDygHzquVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/12/21 11:57 PM, Elijah Newren wrote:
> There's two bugs here, and they actually predate v2.25.  If you put
> all your files in a subdirectory (e.g. 'subdir/bar' instead of 'bar'
> and 'subdir/dir/bar' instead of 'dir/bar'), then the same bug
> reproduces going back many more versions.  The changes in v2.25 to
> support directory rename detection of a subdirectory to the root just
> allowed this bug to happen at the toplevel as well.

You’re right.  I’m sure you’ve already done this bisect, but for 
posterity, after that modification to the test case (‘mkdir subdir; cd 
subdir’ after ‘git init’), it reproduces back as far as 
9c0743fe1e45b3a0ffe166ac949a27f95a3e5c34 (v2.18.0-rc0~2^2~20) 
“merge-recursive: apply necessary modifications for directory renames”.

Thanks for the quick investigation!

Anders
