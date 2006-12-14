X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 07:10:48 -0500
Message-ID: <20061214121048.GM1747@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612141123.02346.andyparkins@gmail.com> <Pine.LNX.4.63.0612141224330.3635@wbgn013.biozentrum.uni-wuerzburg.de> <200612141200.42875.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 12:10:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612141200.42875.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34329>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GupQN-0002A2-Kl for gcvg-git@gmane.org; Thu, 14 Dec
 2006 13:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932683AbWLNMKw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 07:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWLNMKw
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 07:10:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37691 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932683AbWLNMKw (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 07:10:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GupQE-00021j-MB; Thu, 14 Dec 2006 07:10:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 02B9020FB65; Thu, 14 Dec 2006 07:10:49 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> I wonder if the number of objects is a reasonable measure of progress.  Let's 
> say we're transferring 100,000 objects.  Let's also say that the average size 
> of objects is 100 bytes.  Let's finally say that the object sizes are evenly 
> distributed throughout the 100,000 objects.  This would mean that the first 
> 1,000 objects are just as representative as the last 1,000 objects; or any 
> other randomly chosen 1,000 objects.  In which case, the size of the first 
> thousand objects would be approximately one hundredth the size of the total 
> transfer.  Volia: an estimate of the total size of the transfer.

Ah, but much like those stock scam emails, "prior performance does
not predict future results"...  The size of objects in the pack
tends to be small up front (commits/trees) and larger in the back
(blobs).  The size distribution probably also gets more erratic
near the back as the blob sizes may not follow a nice distribution.

E.g. I have a repository with a blob that is 23 MiB.  But I also
have some 5 MiB blobs, and then a very large number of relatively
small blobs.  That 23 MiB blob really gums up any estimate.

But as you state, its easy to refine it over time, and the closer we
get to the end the more likely it is to be correct.  Unless its that
23 MiB blob.  As it takes up about 85% of that repository's pack.

-- 
