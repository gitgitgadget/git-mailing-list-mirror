X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how to ignore merge conflicts?
Date: Mon, 30 Oct 2006 14:53:25 -0500
Message-ID: <20061030195325.GB5504@spearce.org>
References: <200610301448.38222.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 20:05:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200610301448.38222.len.brown@intel.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30516>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GedCp-0001B1-0I for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965429AbWJ3Txa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965399AbWJ3Txa
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:53:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:28890 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965429AbWJ3Tx3
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:53:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GedCB-0005FM-NW; Mon, 30 Oct 2006 14:53:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A3D9B20FB0C; Mon, 30 Oct 2006 14:53:25 -0500 (EST)
To: Len Brown <lenb@kernel.org>
Sender: git-owner@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
> Sometimes when a multiple-file merge give conflicts, I don't want to edit
> one of the resulting <<<<<=====>>>>> files.
> Instead, I just want to choose the version of that particular file that
> existed in one of the two merged branches and commit that along with
> the rest of the merge.
> 
> How to do this?

Your branch is in stage 2 and the branch you are pulling is in
stage 3.  So if I ran:

	git pull . other

then my HEAD before the pull is stage 2 and other is stage 3.

You can use checkout-index to get your version (stage 2) or the
other version (stage 3):

	git checkout-index -f --stage=2 .../path;   # mine
	git checkout-index -f --stage=3 .../path;   # other

then just make sure you update-index before you commit (git commit
-a would do the trick too).

-- 
