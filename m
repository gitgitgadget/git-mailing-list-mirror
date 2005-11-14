From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] archimport improvements
Date: Tue, 15 Nov 2005 11:38:20 +1300
Message-ID: <46a038f90511141438q1d85d429vedcf2a3b54d761e1@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle>
	 <46a038f90511120354n4584aedfhb1f2928ac41478ab@mail.gmail.com>
	 <20051112202150.GA2037@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:41:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebmy1-0006YY-1a
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVKNWiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVKNWiW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 17:38:22 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:61069 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932209AbVKNWiV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 17:38:21 -0500
Received: by xproxy.gmail.com with SMTP id s6so1632970wxc
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 14:38:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=swvV+hOVyshenH1h0vbkE1wklipqH9hOp8sA4Fg9ehUgLpjPVqMuU7+B9PWFN5Yu1KFpcCAnFwhhPRftvcml+/FpYz4aLyZwcbSyIAb+78RJXP5+nCkeNJQ3JCxUxovZ/Es6E1ZTlpWJJkoC2XTYnxwuopaDhHaVMr+3o0eHCKk=
Received: by 10.64.208.4 with SMTP id f4mr5908376qbg;
        Mon, 14 Nov 2005 14:38:20 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Mon, 14 Nov 2005 14:38:20 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051112202150.GA2037@Muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11858>

Eric,

thanks for resending those so quickly. I think I'm going to sit on the
'overhaul of changeset application' patch a bit -- I'll test & ack
your other patches for merge soonish but I want to review and test
this one carefully.

My main concern is that it seems to be calling tla get for each
revision that it imports. For large trees, this is slow. I would be
much happier with a fast Perl-based approach. Have you got a public
repo with directory renames?

Additional comments follow...

On 11/13/05, Eric Wong <normalperson@yhbt.net> wrote:
> > > * Identify git branches as an Arch "archive,category<--branch>--version"
> > >   Anything less than that is ambiguous as far as history and patch
> > >   relationships go.
> >
> > These bug/sanity fixes are _good_. As you mention, I wasn't aware that
> > patchnames could show up not having a --branch part. Tricky...
>
> Thanks.  I got lazy one day and started ignoring --branch on some of my
> personal projects to save my fingers :)

Yup, makes sense. My concern now is that existing imports will change
the name of branches and tags going forward. Can I ask you to resend
that patch with the new branchname mangling as default, and the old
one as optional?

I know it'll force us to go back to using shellquote, but I am not too
worried by that dependency at the moment.

> > > Current weaknesses:
> > >
> > > * (Present in the original code as well).
> > >   The code still assumes that dates in commit logs can be trusted, which is
> > >   fine in most cases, but a wayward branch can screw up git-archimport and
> > >   cause parents to be missed.
> >
> > Fair enough. You mention an alternative strategy (tla ancestry) --
> > have you tried it at all?
>
> No, not yet.

Also interested in this if you get around to it.

cheers,


martin
