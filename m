From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over SSH connection
Date: Wed, 25 Jun 2008 01:38:49 -0400
Message-ID: <20080625053848.GJ11793@spearce.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org> <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:40:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNk0-00070Z-U7
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411AbYFYFjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758319AbYFYFjB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:39:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50558 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbYFYFi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:38:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBNiU-0000yC-Nb; Wed, 25 Jun 2008 01:38:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7250B20FBAE; Wed, 25 Jun 2008 01:38:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy74u5bkk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86234>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > If we force --upload-pack workaround to _everybody_ we are already lost.
> >
> > Also I think the previous one still lets you work it around by giving a
> > full path, like "/usr/local/bin/git-upload-pack", because "/usr" does not
> > match "git-" ;-)
> 
> Ok, let's map this out seriously.

This plan makes a lot of sense to me.  I'm behind it.  For whatever
that means.  At least I'll shutup and stop making noise about this
issue if you take this approach.  :-)

 
> * 1.6.0 will install the server-side programs in $(bindir) so that 
>   people coming over ssh will find them on the $PATH
> 
> * In 1.6.0 (and 1.5.6.1), we will change "git daemon" to accept both
>   "git-program" and "git program" forms.  When the spaced form is used, it
>   will behave as if the dashed form is requested.  This is a prerequisite
>   for client side change to start asking for "git program".
> 
> * In the near future, there will no client-side change.  "git-program"
>   will be asked for.
> 
> * 6 months after 1.6.0 ships, hopefully all the deployed server side will
>   be running that version or newer.  Client side will start asking for
>   "git program" by default, but we can still override with --upload-pack
>   and friends.
> 
> * 12 months after client side changes, everybody will be running that
>   version or newer.  We stop installing the server side programs in
>   $(bindir) but people coming over ssh will be asking for "git program"
>   and "git" will be on the $PATH so there is no issue.
> 
> The above 6 and 12 are yanked out of thin air and I am of course open to
> tweaking them, but I think the above order of events would be workable.

Yea, 6 and 12 seem like a good idea.  Its a couple of releases and
gives people time to migrate their server installations.

-- 
Shawn.
