X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Thu, 7 Dec 2006 03:49:57 +0100
Message-ID: <200612070349.58521.Josef.Weidendorfer@gmx.de>
References: <200612061207.23437.andyparkins@gmail.com> <200612061800.17087.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0612070022180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 02:50:31 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612070022180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33543>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs9Kz-0006yX-9J for gcvg-git@gmane.org; Thu, 07 Dec
 2006 03:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967769AbWLGCuE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 21:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967772AbWLGCuE
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 21:50:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:34621 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S967769AbWLGCuB
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 21:50:01 -0500
Received: (qmail invoked by alias); 07 Dec 2006 02:49:59 -0000
Received: from p5496AD20.dip0.t-ipconnect.de (EHLO noname) [84.150.173.32] by
 mail.gmx.net (mp028) with SMTP; 07 Dec 2006 03:49:59 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thursday 07 December 2006 00:23, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 6 Dec 2006, Josef Weidendorfer wrote:
> 
> > On Wednesday 06 December 2006 13:07, Andy Parkins wrote:
> > > The [branch "master"] section is such that there is no change to the
> > > functionality of git-pull, but that functionality is now explicitly
> > > documented.
> > 
> > Nice. However, changing "git-clone" for this is an adhoc solution and 
> > looks wrong.
> 
> Not to me. There is _no_ other place to put this, if you want to help 
> people graps the concept of branch.*.merge.

As far as I understand, git-clone defaults to kind of a mirror operation
while changing remotes ref names slightly as tracking branches, and
afterwards, it sets up a local branch for development, which is
branched off from the branch which tracks remote's master.

IMHO there only should be one place/command which is creating new branches,
and which is called by other porcelain commands [*1*]. This way, if we add
some further action to "branching off" (like adding a default merge branch),
we will not miss any place where a new branch will be created, thus keeping
everything consistent.

Why should we not setup branch.*.merge when a create a new development
branch from a tracking branch via "git branch", or "git checkout -b" ?

Josef

[*1*] I recently made up my mind about this. I suggested a patch (see
"[PATCH/RFC] Convenient support of remote branches in git-checkout"
in the mail archive), which also set up "branch.*.merge" in a similar
way as this patch is doing. And I got - rightly - the same response
