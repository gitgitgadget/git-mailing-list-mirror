X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 5/5] git-svn: re-map repository URLs and UUIDs on SVK
 mirror paths
Date: Thu, 07 Dec 2006 11:20:34 +1100
Message-ID: <45775E52.90102@vilain.net>
References: <20061205051738.16552.8987.stgit@localhost> <20061205051738.16552.22494.stgit@localhost> <20061205085804.GB27236@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 04:27:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20061205085804.GB27236@soma>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33550>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsAqk-0006qt-1P for gcvg-git@gmane.org; Thu, 07 Dec
 2006 05:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968736AbWLGE1H (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 23:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968737AbWLGE1H
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 23:27:07 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:42253 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968736AbWLGE1D (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 23:27:03 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 394E7139B0D;
 Thu,  7 Dec 2006 17:27:02 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 8CF13139AEC; Thu,  7 Dec 2006 17:26:57 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong wrote:
> Upon further review, this would make 'git svn rebuild' behave
> unexpectedly (it would make the git-svn metadata, including .rev_db
> entries point to the original repo and not the SVK one).  This may not
> necessarily be a big deal, however.

Yes, that's the idea; a 'rebuild' should set it up to pull from the
original SVN repository directly.  That probably needs some documentation...

> Also, incremental fetches (or fetching more than 1k sequential
> revisions) would probably fail.  To fix this, read the offset of last
> entry in .rev_db instead of git-svn-id: from the last commit to get the
> last revision.  But since rebuild won't work as expected; losing the
> .rev_db file means you wouldn't be able to fetch from the SVK repo
> anymore (but the original upstream one will be fine).
> 
> One last thing: feature should be made optional.  I actually work
> day-to-day on a repository that was created with svm/SVN::Mirror,
> the original repository no longer exists; but the mirrored one
> still has these properties (I suppose I could remove the props
> server-side, but some people may not have the permissions).

ok, I'll work on that and the other issues you highlighted... possibly
the overhead of fetching the revprops during mirroring might hurt a
little for people not doing this, too.  Thanks for reviewing the patch!

Sam.


