X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Edgar Toernig <froese@gmx.de>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 19:55:59 +0100
Message-ID: <20061114195559.40967ee4.froese@gmx.de>
References: <20061114134958.5326.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 18:56:36 +0000 (UTC)
Cc: git@vger.kernel.org, linux@horizon.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #271361
In-Reply-To: <20061114134958.5326.qmail@science.horizon.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31362>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk3S9-0005LU-6m for gcvg-git@gmane.org; Tue, 14 Nov
 2006 19:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933476AbWKNS4J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933478AbWKNS4J
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 13:56:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:29902 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933476AbWKNS4G (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 13:56:06 -0500
Received: (qmail invoked by alias); 14 Nov 2006 18:56:01 -0000
Received: from p50903B9C.dip0.t-ipconnect.de (EHLO dialup) [80.144.59.156] by
 mail.gmx.net (mp031) with SMTP; 14 Nov 2006 19:56:01 +0100
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:
>
> Personally, I'd prefer if the requirement that HEAD point to
> refs/heads were enforced when checking in rather than checking out.
>   
> Then you could check out an arbitrary version without any of the annoyance
> above; I could "git checkout tags/foo" or even "git checkout deadbeef~3".
> I wouldn't be on a current branch (which would necessitate changing
> "git branch" output), so HEAD would simply contain an object ID directly
> rather than being a symlink/symref.

I wholeheartedly agree.  For the casual user it's IMHO the most
annoying behaviour of git that you can't simply checkout an arbitrary
commit without creating a new (most of the time temporary) branch first.
Often you don't plan to change the checked out tree and giving it a
new branch name ahead is cumbersome, especially as you know that you'll
never commit into it and have to delete the branch before checking out
another tag.  I would prefer this behaviour:

	$ git checkout v2.6.16
	... i.e. check whether it builds
	$ git checkout v2.6.17
	... test this one
	$ git checkout v2.6.18
	... change something
	$ git commit
	error: can't commit.  not on any branch.
	use "git commit -b <new-branch-name>" to commit into a new one.
	$ git commit -b my-v2.6.18

