Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028CC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 23:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376649AbiDCXS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 19:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376646AbiDCXSY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 19:18:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3F36179
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 16:16:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 233NGN7I013898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Apr 2022 19:16:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 30AB815C003E; Sun,  3 Apr 2022 19:16:23 -0400 (EDT)
Date:   Sun, 3 Apr 2022 19:16:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Markus Vervier <markus.vervier@x41-dsec.de>, git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
Message-ID: <Ykoqxx40Fk0DiF9i@mit.edu>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
 <xmqqbkxhvoh5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbkxhvoh5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 03, 2022 at 02:36:22PM -0700, Junio C Hamano wrote:
> I have old e-mails from the scan-admin@coverity.com but the last one
> seems to be from late June 2018, which is ages ago in Git timescale.
> I do not recall us paying for such a service so I am guessing that
> they had some program that open source projects can enroll, get our
> public sources scanned and get the result sent back?

Yep, that's the way it works.  Someone has to use tools provided by
them to build the open source project and upload the results for them
to analyze.  Coverity predates github, so it's not new-fangled enough
to automatically pull sources from repositories; besides, their paying
customers tend to be using their tool for their proprietary software,
so they haven't had any incentive to create an auto-analyze tool that
pulls from an open source repository.

Some folks at Red Hat do have scripts run out of crontab, that will
monitor git branches on projects that they are interested in and when
they notice that the branch has been updated, they will build and
upload the raw material used by Coverity to their dashboard.  Eric
Sandeen has been doing this for e2fsprogs, and a few other file system
related repo's, and I suspect if someone asked, he would probably be
willing to provide the scripts that he uses.

You do need to be the project admin, or someone authorized by the
project admin, to upload new data for Coverity, or to look at the
analysis of the Coverity results.  I have no idea who the project
admin is for git, but I'm sure if you, as the Git maintainer showed up
and requested to be added as one of the project admin, the open source
ombudsperson (I don't remember the exact title, but they do have
someone who interfaces with OSS projects), would be happy to oblige.

> https://scan.coverity.com/projects/git/ (visible without signing in)
> seems to match my recollection. They haven't been scanning since
> late June 2018.  I wasn't the primary developer who registered us or
> who has been reading these reports but if I recall correctly, we
> weren't doing anything custom, and fell somewhere between just "we
> are curious to see how well Coverity works" and "Yay, a free
> offering. We have nothing to lose, other than our time, to sign
> ourselves up and if it comes up with useful scan result that would
> be good".

My experience with e2fsprogs is that it does have a fair amount of
false positives, but I've been willing to wade through the false
positives, and mark them as such in their web dashboard, because the
early warnings it gives when we've pushed new code that has a
potential security problem is worth it.  But make no mistake, it
definitely requires a certain amount of maintainer time work with the
tool.

Cheers,

						- Ted
