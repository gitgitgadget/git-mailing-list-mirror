X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 12:40:17 +0000
Message-ID: <200611301240.22938.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <456ECBA5.7010409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 12:42:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V5JOrBlkCR9inkO6VPtKWyYEb8HXgDLwxXtuWbf64J3TmMWP2cYF+Tlng2VAgvC/CMiILYY2awiib8SSUfBP9TAArWXB/uyw9oZwByAn246X/YDusgn6RRS4jw+XWJQ9wnr8BKwz0sGB8J9D5COj0vpAc8fRWE6Xb1RRCuihvjo=
User-Agent: KMail/1.9.5
In-Reply-To: <456ECBA5.7010409@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32733>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplEW-0007TW-OF for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936295AbWK3Mkc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936292AbWK3Mkb
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:40:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:26763 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936295AbWK3Mk3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:40:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2097627uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 04:40:28 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr5324743ugh.1164890427593; Thu, 30
 Nov 2006 04:40:27 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 30sm23542272ugf.2006.11.30.04.40.26; Thu, 30 Nov 2006 04:40:26 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 30 12:16, Andreas Ericsson wrote:

> > What is the "right" branch though?  As I said above, if you're tracking
> > one branch in the submodule then you've effectively locked that submodule
> > to that branch for all supermodule uses.  Or you've made yourself a big
> > rod to beat yourself with everytime you want to do some development on an
> > "off" branch on the submodule.
>
> Perhaps I'm just daft, but I fail to see how you can safely track a
> topic-branch that might get rewinded or rebased in the submodule without
> crippling the supermodule. Wasn't the intention that the supermodule has

Who said anything but rebase/rewind?  As it happens though, I don't see why 
you can't (it wouldn't be pleasant though).  A rebase or rewind still leaves 
the original commit in the object database, so provided no one runs 
git-prune, there is no catastrophic failure.

> a new tree object (called "submodule") that points to a commit in the
> submodule from where it gets its tree and stuff? Is the intention that
> the supermodule pulls all of the submodules history into its own ODB? If
> so, what's the difference between just having one large repository. If
> not, how can you make it not break in case the commit it references in
> the submodule is pruned away?

I certainly never suggested anything /but/ storing a submodule type that 
stores the commit.  The current debate is about whether the supermodule 
should track HEAD or some defined branch in the submodule.

> but then you're in trouble because the supermodule will have the same
> files as all the submodules stored in its own tree. I'm confused. Could
> someone shed some light on how this sub-/super-module connection is
> supposed to work in the supermodule's commit objects?

I don't really know, I only joined in to stand up against commit in the 
supermodule triggering commits in the submodule.  That lead to me trying to 
get an understanding of how it would work.

As far as I can see, the only way a submodule is any use is if it is always a 
submodule-commit-hash that is noted in the supermodule tree object.  That 
means that the supermodule will only commit clean submodules.  The rest is 
just UI to show something useful in the difficult cases when the submodule 
tree is dirty.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
