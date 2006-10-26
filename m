X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 16:52:39 +0800
Message-ID: <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	 <200610251146.06116.jnareb@gmail.com>
	 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	 <87slhcz8zh.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 08:52:55 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ad2Po258vPQyromxIAD39d/hDRwbW1i3eh112jeTNLEbuAm+nnwEDVF3IipibfBHUot9X9tDlNJpK5Ez4yKdfZTklQuLgdi9EObIKSrIDhSMWWLIE2iY9oWac2y/B9MsRkkjyW1qlnXIoqX4SgI1KqOrXKnjTV0YoAO/uGf4QLw=
In-Reply-To: <87slhcz8zh.wl%cworth@cworth.org>
Content-Disposition: inline
X-Google-Sender-Auth: bf39ff181f8e17cb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30157>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0yi-0003lm-Lb for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752032AbWJZIwm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWJZIwm
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:52:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:29045 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1752032AbWJZIwl
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:52:41 -0400
Received: by nf-out-0910.google.com with SMTP id c2so908151nfe for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 01:52:39 -0700 (PDT)
Received: by 10.82.120.15 with SMTP id s15mr384756buc; Thu, 26 Oct 2006
 01:52:39 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Thu, 26 Oct 2006 01:52:39 -0700 (PDT)
To: "Carl Worth" <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On 25/10/06, Carl Worth <cworth@cworth.org> wrote:
> On Wed, 25 Oct 2006 18:08:22 +0800, "James Henstridge" wrote:
> > If there aren't, or you made the merge by mistake, you can make a call
> > to "bzr revert" to clean things up without ever having created a new
> > revision.
>
> One result of this approach is that developers of different trees
> don't necessarily have common revision IDs to compare. Imagine a
> question like:
>
>         When you ran that test did you have the same code I've got?
>
> In git, the answer would be determined by comparing revision IDs.

Can you really just rely on equal revision IDs meaning you have the
same code though?

Lets say that I clone your git repository, and then we both merge the
same diverged branch.  Will our head revision IDs match?  From a quick
look at the logs of cairo, it seems that the commits generated for
such a merge include the date and author, so the two commits would
have different SHA1 sums (and hence different revision IDs).

So I'd have a revision you don't have and vice versa, even though the
trees are identical.


> In bzr, the only answer I'm hearing is attempting a merge to see if it
> introduces any changes. (I'm deliberately avoiding "pull" since we're
> talking about distributed cases here).

Or run "bzr missing".  If the sole missing revision is a merge (and
not the revisions introduced by the merge), you could assume that you
have the same tree state.


> And to comment on something mentioned earlier in the thread, there's
> no need for "wildly complex" distributed scenarios. All of these
> issues are present with developers working together as peers, (and
> each considering their own repository as canonical).
>
> A harder question (for bzr) is:
>
>         Do you have all of the history I've got?
>
> (The problem being that when one developer is missing some history and
> merges it in, she necessarily creates new history, so there's never a
> stable point for both sides to agree on.)

Why does it matter if they create a new revision?  They can still tell
if they've got all the history you had.

