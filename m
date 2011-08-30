From: David Aguilar <davvid@gmail.com>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Mon, 29 Aug 2011 20:10:24 -0700
Message-ID: <20110830031022.GA64106@gmail.com>
References: <1313163498.14274.505.camel@rex>
 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
 <7vmxfemnc4.fsf@alter.siamese.dyndns.org>
 <1313181853.14274.535.camel@rex>
 <20110828130555.GA56765@gmail.com>
 <1314620166.5939.282.camel@rex>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nguy?? n =?utf-8?B?VGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 05:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyEjJ-0006Eh-Tp
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 05:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab1H3DKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 23:10:25 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:63342 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1H3DKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 23:10:24 -0400
Received: by pzk37 with SMTP id 37so9535829pzk.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xB4rzapU1Kfct+ThpvcQKAGlzIKD82tm2fHaY34y85g=;
        b=IjNY8lXBQz5V6w1zwSNdX0+GLZ9zlTPb+J9UGvH3IIPNekZ3UobmboRXpQhUHgsJbw
         FhhhrqAOkUe3lyObvYQo3b3I1mxfwqdn8r6iHOwRPCfAv51R4obxS2l29d5ogNgMJuMN
         EJNtKBmf4K3+EDTk4wbqI5e3ieqvC9MdQ9w9I=
Received: by 10.142.242.21 with SMTP id p21mr2586797wfh.60.1314673824244;
        Mon, 29 Aug 2011 20:10:24 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id a6sm5605371wfg.3.2011.08.29.20.10.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 20:10:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314620166.5939.282.camel@rex>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180388>

On Mon, Aug 29, 2011 at 01:16:06PM +0100, Richard Purdie wrote:
> On Sun, 2011-08-28 at 06:05 -0700, David Aguilar wrote:
> > On Fri, Aug 12, 2011 at 09:44:13PM +0100, Richard Purdie wrote:
> > > My problem isn't that I want to specify a specific .gitconfig file, I
> > > just need it to ignore the one in $HOME. I'm happy for the .git/config
> > > file to be used, in fact I need it to be.
> > 
> > If you're writing a tool then it should restrict itself to
> > git's plumbing commands.  You should be able to do just about
> > anything without needing to worry about differences in
> > configuraiton.  Git commands almost always provide a way to
> > override configuration through the use of flags.
> > 
> > The plumbing commands are listed in the main git manpage.
> > See "Low-level commands (plumbing)" here:
> > http://www.kernel.org/pub/software/scm/git/docs/
> > 
> > What is the specific problem solved by overriding the
> > configuration?  It may be possible to solve it without needing
> > to get too complicated.
> 
> I'm not sure writing my own porcelain makes sense in this case.

True...  luckily we don't have to go that far.

> The tool in question is a build system which is primarily interested in
> building software. Sometimes the software we want to build is "bleeding
> edge" and hence rather than download tarballs, we want to interact
> directly with SCMs like git to obtain it.
> 
> The commands I'm using are the likes of "git clone" and "git fetch"
> although we do use commands listed under the plumbing section too such
> as ls-remote and read-tree. We do "cache" checkouts and support
> automatically noticing changes and updating/building.
> 
> What I do want to be able to say is "ignore whatever the user might have
> put in their ~/.gitconfig file" since I've open bug reports about people
> putting things in there that break builds.
> 
> The fetch/clone commands do what I need, apart from being influenced by
> userconfig so reimplementing them myself doesn't seem like a good
> approach.

This is what we're interested in.

Do you have the specifics of exactly what in the user
~/.gitconfig file broke the build?

What I'm suggesting is that there's probably a way to avoid
the user-dependent behavior by being explicit on
the command-line.

Specifically regarding fetch -- if you're doing "git fetch"
and relying on the configuration then we can probably come
up with a more explicit fetch command that has an explicit
and predictable behavior independent of the user's
configuraiton.

Using the explicit form of the command can make the build system
more robust.

Let us know what you're cooking, it sounds interesting.

cheers,
-- 
					David
