Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92EC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 04:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBCECn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 23:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjBCECi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 23:02:38 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8A14EBD
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 20:02:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31342WdW025336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 23:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675396954; bh=qqKOvwfHWvGTB2R6+jlE/otM2kd7vgL2B4XGhhibRdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ixKpE/PsIkLL3MvAAvzN82glpx+PFpLaoMxN/SE252XO1eQXzp/l/ay+WXTTID4Zm
         PEVTvy07uMTkvSl5q3UscRtrn0ltcYHvr/bGX7mfiJNnZpkSOvzB8kJFpr/l+8upqn
         xHLOcgs3qvVbKGwEuOZFUTX2jmhQ8nQJ9t2XFlXElmZ9Vatc2DI5ejnhsncrz0AuJ2
         0SraoMFb2oVtVdL2CjN6thYqM/6Eb8ODwuHWvSOzJA/djCDjI0o6y+1fiRD9PhVOlx
         Ispo5VSAKk2yccDuPnhx1zNjAShsnh1BwTiUKL1sILUBg/SUyfkeQZKZcRrX04jVl/
         BAMoIyXmHDNlw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 93C5D15C340F; Thu,  2 Feb 2023 23:02:32 -0500 (EST)
Date:   Thu, 2 Feb 2023 23:02:32 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Joey Hess <id@joeyh.name>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9yHWFh0ijwrqhOX@mit.edu>
References: <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
 <20230201122152.GJ19419@kitsune.suse.cz>
 <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
 <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
 <CANgJU+VNY-VziRijSwyb1WF9s31hKroK+2VJ0qEGiYweiA59Ug@mail.gmail.com>
 <Y9q129WbseimgeBS@mit.edu>
 <Y9wo4iH2crlt26+d@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9wo4iH2crlt26+d@kitenet.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 05:19:30PM -0400, Joey Hess wrote:
> In my opinion as the original developer of pristine-tar, it's too
> complicated to be usefully used by git. The problem it solves is of a
> larger scope than the problem git has here. (I hope.)

Well, the problem which I believe folks on this thread are trying to
deal with is a way to reconstruct a bit-for-bit compressed tarball of
a particular release in a way that minimizes the cost of storage in
the git tree.  One way of doing that would be to guarantee that git
archive would return something which is always bit-for-bit identical.
Another way is to use something like pristine tar.

I'll grant that pristine tar does solve a bit more of the problem than
what has been stated, since it allows the creator of the tarball to
remove some files, or add some auto-generated files (e.g., after
running autoreconf), and so in that way, pristine tar does solve a
somewhat larger problem than what was expressed in this thread.

That being said, however, pristine-tar is **extremely** useful, and
I'm very happy, and very thankful, that you wrote it.  It has been
super, super useful.

Cheers,

						- Ted
