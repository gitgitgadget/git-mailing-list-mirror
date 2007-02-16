From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 17:10:57 +0100
Message-ID: <8aa486160702160810i3d92ba6fy390674dfcc9c584@mail.gmail.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	 <Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	 <17876.52962.662946.582507@lisa.zopyra.com>
	 <17876.53654.426022.454712@lisa.zopyra.com>
	 <er333i$787$1@sea.gmane.org>
	 <17877.51730.418633.750922@lisa.zopyra.com>
	 <20070216152130.GA7086@coredump.intra.peff.net>
	 <17877.52593.509791.685008@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Jakub Narebski" <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 17:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI5fv-0004E1-U2
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 17:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbXBPQLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 11:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbXBPQLE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 11:11:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:10264 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932427AbXBPQLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 11:11:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so190808uga
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 08:11:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FhXAPYLWtdTJjq/qWR6to0jfH++VKcHdaBR6MNkGrhJKZXGqsQITXZzlU4OfKLBBp0GlcsAhJTpEVfyTe6jgu+ZATyInuvDPC+uVvLiLxN4MfaDiwhBRoo4mG8R5LuAzhI8VAuNUDrYopkU4m7mugk/dHWtvWh1xSYzuMMV+LVU=
Received: by 10.78.149.13 with SMTP id w13mr86459hud.1171642258204;
        Fri, 16 Feb 2007 08:10:58 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Fri, 16 Feb 2007 08:10:57 -0800 (PST)
In-Reply-To: <17877.52593.509791.685008@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39924>

On 2/16/07, Bill Lear <rael@zopyra.com> wrote:
> On Friday, February 16, 2007 at 10:21:30 (-0500) Jeff King writes:
> >On Fri, Feb 16, 2007 at 09:13:22AM -0600, Bill Lear wrote:
> >
> >> % git pull ../peer_repo topic:topic
> >> [...]
> >> * refs/heads/topic: not updating to non-fast forward branch 'topic' of ../peer_repo
> >> [...]
> >> So, why does it say "not updating to non-fast forward branch", yet
> >> it does the merge and gets the changes anyway?
> >
> >Because your pull command really means "merge in the topic branch from
> >peer_repo, and while you're at it, store it in my local tracking branch
> >topic". Remember that pull is really a fetch+merge. But the fetch is
> >actually doing _two_ things: putting the fetched branch into FETCH_HEAD,
> >and putting it in into refs/heads/topic. The latter fails (because of a
> >non-fastforward), but pull actually uses the FETCH_HEAD results to
> >do the merge.
> >
> >Yes, this seems overly complex for what you're doing, but the reason for
> >FETCH_HEAD is to support pulls when you _don't_ have a tracking branch
> >at all (i.e., 'git pull ../peer_repo topic').
>
> Ok, fair enough, but then I guess I'm back to my original question:
> how can I give a concrete demonstration to our developers that this is
> a bad thing?
>

It no longer works with recent git, as of v1.4.4.1-37-gd25c26e. Now
git-fetch exit with a non-zero status when fast-forward check fails,
so the merge does not happen.

Santi
