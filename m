X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Thu, 7 Dec 2006 15:44:03 +0100
Message-ID: <200612071544.03306.Josef.Weidendorfer@gmx.de>
References: <200612061207.23437.andyparkins@gmail.com> <200612070349.58521.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.63.0612071511440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 14:44:17 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612071511440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33583>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKTt-0000Ng-F1 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937961AbWLGOoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032238AbWLGOoJ
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:44:09 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:54352 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S937961AbWLGOoG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:44:06 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id A011C2852; Thu,  7
 Dec 2006 15:44:04 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thursday 07 December 2006 15:13, Johannes Schindelin wrote:
> > > > Nice. However, changing "git-clone" for this is an adhoc solution and 
> > > > looks wrong.
> > > 
> > > Not to me. There is _no_ other place to put this, if you want to help 
> > > people graps the concept of branch.*.merge.
> > 
> > As far as I understand, git-clone defaults to kind of a mirror operation
> > while changing remotes ref names slightly as tracking branches, and
> > afterwards, it sets up a local branch for development, which is
> > branched off from the branch which tracks remote's master.
> 
> Yes. And I should back off from my strong language: I think this git-clone 
> the most obvious program to set branch.master.merge. It should make life 
> easier for new Git users.

Oh, no problem ;-) I myself used quite strong words. And I fully agree that
it makes life easier for users. And it is way easier to do it in git-clone
because
(1) in git-clone we _know_ that we branch of a tracking branch; in git-branch,
we first have to check if we want the configuration set.
(2) git-branch is more difficult to change because it's written in C :-)

However, as discussed in another thread, branch.*.merge currently has quite
a strange semantic [*1*], and without changing, users have no way to grasp this
configuration option.

And that branch renaming feature cooking in pu really has to move branch
attributes too, when we even officially set them now in git-clone.

Josef

[*1*] Currently, in branch.*.merge you have to specify the remote branch name
of a refspec which updates a local tracking branch in the fetch phase of git pull.
