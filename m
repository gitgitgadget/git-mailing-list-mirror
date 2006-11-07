X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote
 branches?
Date: Tue, 07 Nov 2006 21:08:47 +0300
Message-ID: <eiqi3f$ouq$1@sea.gmane.org>
References: <20061107172450.GA26591@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 18:09:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <20061107172450.GA26591@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31082>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhVNs-0004Rv-So for gcvg-git@gmane.org; Tue, 07 Nov
 2006 19:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965668AbWKGSJN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965687AbWKGSJM
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 13:09:12 -0500
Received: from main.gmane.org ([80.91.229.2]:10169 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965668AbWKGSJL (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 13:09:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhVNW-0004NO-89 for git@vger.kernel.org; Tue, 07 Nov 2006 19:08:54 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 19:08:54 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 19:08:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Clearly there is a gap in communicating these ideas in a way that
> they can be understood by users.  Of course in at least one case
> the users just isn't reading any Git documentation and plows ahead
> as though it were CVS ('cause everything's "just like CVS") *sigh*.

I've went through persuading my colleagues (~30 engineers) to use Git and tutoring on it
through the three summer months, and my experience is very similar to Shawn's.
(i.e. confusing local and remote branches, not reading documentation,
and "just like CVS" attitude)

Below is the one git feature that I think was stumbled upon most often:

* people were often anaware of *multiple* branches created by git-clone,
  as the operation they wanted was analog of "cvs checkout". 

* git-fetch / git-pull tries to download all of the branches that were
  preset at git-clone time, and subsequently gives errors if some topic
  branches were rewound or dropped, while most of the time my colleagues
  were interested in just one "mainline" branch.

I think that the particular issue with the workflow in my organization
could have been solved by the git-checkout and git-clone hybrid

    git-checkout ssh://path.to/repo.git#branch [work_dir]

which would clone repository with just one branch and setup the remotes
file accordingly (The syntax is completely made up, of course)

P.S. a few words on the workflow we use:
- there is a "mainline" branch of development, kept as ssh-shared git repository
- mainline commits require some pre-commit testing, which takes ~1.5 hours,
  so people tend not to commit to mainline too often. On average, a given
  person commits to mainline once or twice a week.
- mainlines commits also require a fellow developer review, that's where
  topic branches come in handy. Topic branches are also useful for testing,
  as pre-commit testing should be run on several different platforms, thus
  on a different machines. Topic branches are kept on the same shared server.
