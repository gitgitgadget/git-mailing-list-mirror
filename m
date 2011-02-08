From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Tue, 8 Feb 2011 04:20:18 +0300
Message-ID: <20110208012018.GB3132@dpotapov.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102061711.45460.johan@herland.net>
 <AANLkTi=gd5iu0i=ggqJC++N_rL+nU6RO9PNw=jMpT0NH@mail.gmail.com>
 <201102062312.51655.johan@herland.net>
 <AANLkTi=A-rh+wfg7O4KryydxVuorM8nkuGYmpbgVfVJp@mail.gmail.com>
 <20110207190551.GA25413@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>
To: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Feb 08 02:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmcFq-00044v-Gi
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 02:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab1BHBUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 20:20:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60784 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab1BHBUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 20:20:24 -0500
Received: by bwz15 with SMTP id 15so5532478bwz.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 17:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H63pJFqgprSiAABuaz0e2HJk6u8GvUujcZKAok6EJLM=;
        b=E/ohf/SLjJT8qgMxmKQjQ08bZTDi22fSP/f5CXftZKRBTcGcJEQMfoveC19sin+lVY
         qYE9U954jE5M6MJ5uMUFJoznvFeW4KbSDFmmzkvmKqkbOWqfGiKC74JPtRxlthXZ3odh
         UIqJACSc6V46bH+XbgEgMHiBIiRKHfLtmRAYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UyBu16T6UP8CvlLqowPo+Q6juyRyaLAvL37U04VcLp+gJL64BwXMRYAriEt1rD5O1D
         IUP3njRg4WQyDZ2RSDs9P932OthKR9u0UhhuUUnUU9mmz+Uw/D4KyFy0fMOLPGgwKWLH
         6hH0NMCzK+1/jdNP5iNdOYVshjIH/ye5lZvB0=
Received: by 10.204.152.22 with SMTP id e22mr1935776bkw.103.1297128023089;
        Mon, 07 Feb 2011 17:20:23 -0800 (PST)
Received: from localhost (ppp91-77-227-18.pppoe.mtu-net.ru [91.77.227.18])
        by mx.google.com with ESMTPS id j11sm2415471bka.12.2011.02.07.17.20.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 17:20:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110207190551.GA25413@pcpool00.mathematik.uni-freiburg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166324>

On Mon, Feb 07, 2011 at 08:05:51PM +0100, Bernhard R. Link wrote:
> 
> So there are those "local tags", which are not to be shared with others.
> Does that mean an user should always have two repositories, one with
> those tags for themselves and one without those tags for each other?

Well, I believe that the best practice is that each developer has
his/her own private repo and there is also a "bare" repo to which
is used to share results with others. In this way, local tags are
stay only inside one's private repo.

If you need to fetch directly from someone working repository, you can
use "git fetch --no-tags", but obviously it is not an optimal solution
if you also need to fetch global tags from it, because you will have
to specify them explicitly.

> > > Granted, if we leave all tags in a single namespace, I can still work around
> > > this by manually futzing with the configured refspecs to create ad hoc
> > > namespaces. But I _really_ hate it when I'm forced to hack around the tool,
> > > because the tool thinks it "knows better".
> >
> > I believe that the right interface when the common case is simple, but
> > an uncommon case is still possible to handle. I don't think that
> > currently git meets this criterion, but making tag namespaces based on
> > the remote name strikes me as a really bad idea. Tags are attributes of
> > a project and not particular remote.
> 
> Global tags are. Local tags are not.

Sure. I probably should have said that I'd consider only global tags in
the rest of my email, because local tags should not be normally visible
outside of one's repo.

> And even for global tags it can be interesting to see which remote has
> them, without having to manually look at all those remotes.

I am not sure why it should be interesting. I mean as long as you do
not have tag clashes, you should not need to know that. And if you
really need to know that, you can use "git ls-remote" to check actual
references.

> 
> > IMHO, it is very confusing, especially for people whose script was
> > suddenly broken by those namespaces.
> 
> Like it was when remotes where introduced?

How many people used git back then and how many people are using now?
Have you forgotten what happened when the dash was removed from git
commands?  There was endless cry about breaking git, though all what
those people need to do is to add one directory to their PATH to have
git dash commands back.

So, what may be okay for a young and immature project (used by a small
group of enthusiasts) may be not okay for a tool on which many people
rely. Most people who use git now do not read ReleaseNotes. They just
install a ready package for their favorite distro and expect everything
to work as before.

So, I think any changes should be introduced as gradual as possible.


Dmitry
