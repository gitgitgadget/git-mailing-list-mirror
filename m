Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB61C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B23020733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLQKCc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 17 Dec 2019 05:02:32 -0500
Received: from mail.computer-surgery.co.uk ([82.69.253.61]:58190 "EHLO
        nicole.computer-surgery.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbfLQKCc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Dec 2019 05:02:32 -0500
Received: from [192.168.131.253] (helo=bath.backslashat.org)
        by nicole.computer-surgery.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1ih9gS-0007ta-VI; Tue, 17 Dec 2019 10:02:29 +0000
Received: from roger by bath.backslashat.org with local (Exim 4.92)
        (envelope-from <rgammans@gammascience.co.uk>)
        id 1ih9gN-00088U-16; Tue, 17 Dec 2019 10:02:23 +0000
Message-ID: <fd4bd9c49d7d4daf4275b19a9b5f7478f2e4e145.camel@gammascience.co.uk>
Subject: Re: Merging two Git-Repositories
From:   Roger Gammans <rgammans@gammascience.co.uk>
To:     Steve Keller <keller.steve@gmx.de>, git@vger.kernel.org
Date:   Tue, 17 Dec 2019 10:02:22 +0000
In-Reply-To: <trinity-c6dbf360-5abe-43df-8428-85514195a7a6-1576574916643@3c-app-gmx-bs62>
References: <trinity-c6dbf360-5abe-43df-8428-85514195a7a6-1576574916643@3c-app-gmx-bs62>
Organization: Gamma Science Ltd. (GB Nr. 07356014 )
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2019-12-17 at 10:28 +0100, Steve Keller wrote:
> Is it possible to merge one Git-Repository into another?  I have
> developed two independent repositories A and B, and now I find that
> B should be part of A in new sub-directory, e.g. A/B.  I want to
> move B into A while keeping the whole development history of B.
> 
> How can I do that?

It is possible bit isn't straightforward, at least not if you want to
interleave the commits.

If you don't want to interleave the commits, just rename everything (*)
in B to B/*' and merge the repo with A's repo. Then you will have a the
structure you want going forward, all the history together; but if you
check out a historic commit you will have to decide to check out on the
'A' or 'B' branches.

If you do want to interleave the comits the best  found was  ( 
https://metacpan.org/pod/distribution/Git-FastExport/script/git-stitch-repo
to merge the repos. (from https://github.com/book/Git-FastExport/ )

I've got some updates (
https://github.com/rgammans/Git-FastExport/tree/hintfiles ) to it when
I did some work on this a couple of years ago but the it looks like the
upstream has improved a little since then. My changes allow you to try
to give it hints in case in make mistakes, on choosing the correct
parent for a commit. The whole system worked pretty well except where
there were a lot a diverging/remerging branches.

My process was to write a shell script to actually drive the process,
and tweak the script to improve the results iteratively.

Hope this helps a little.

-- 
Roger Gammans <rgammans@gammascience.co.uk>

