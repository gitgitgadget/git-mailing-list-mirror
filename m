X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:39:01 -0800
Message-ID: <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	 <200611151858.51833.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 19:39:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sFIkL3KL6Xofl2WRK9taIJEXHaG2/CdqjN8BoN6taMFG3scBpj+R7vZds81aY1dhDatrCKrBfsOUfUOSJYyz+NpMG3RURg7rMX5xd9JjjmLRc8EChhX5hl4F1FmmnJAo10U3kTQd9RcuSKMEXcZd4P3EYuy6fM3/1tg0CVPfWyk=
In-Reply-To: <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31477>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQbK-0005Ol-Bh for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161098AbWKOTjK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWKOTjJ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:39:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:62136 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1161130AbWKOTjH
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:39:07 -0500
Received: by wr-out-0506.google.com with SMTP id i22so150468wra for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:39:06 -0800 (PST)
Received: by 10.90.51.17 with SMTP id y17mr2760428agy.1163619546553; Wed, 15
 Nov 2006 11:39:06 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Wed, 15 Nov 2006 11:39:01 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/15/06, Linus Torvalds <torvalds@osdl.org> wrote:
> But once you understand branches, and understand "fetch" (and it really
> isn't _that_ complicated: fetch really does exactly what the name says, so
> if you understand local branches, you will understand "fetch"), then it's
> a much smaller step to explain "pull = fetch + merge".
>
> But I bet people don't teach it that way. They _start_ by teaching "pull".
> Right?

"git fetch" is certainly the right thing for the platform integration
role, in which one is trying to maintain a series of integration
branches which track the bleeding edge of some subsystems while
keeping the core stable on each branch.  This is not as impossible as
people make it out to be, but there certainly isn't much place for
automatic merges to _persistent_ branches.

It's fundamentally a backporting and cherry-picking effort, and the
git workflow puts it where it belongs: in the local repository, where
_transient_ branches can and should be created and destroyed casually
to track exploratory efforts.  These may include automatic merges and
even cruder techniques (git diff, hack on patch, apply patch).  Once
you figure out which bits you actually want to backport, you go back
to a fresh branch and cherry-pick the same bits with the tool instead
of manually, so that there is less noise in future merges.  When
you've tested a little, you merge this branch to the persistent branch
that other repositories track.

Cheers,
