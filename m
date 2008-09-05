From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How can i write a new protocol for git
Date: Fri, 5 Sep 2008 07:52:46 -0700
Message-ID: <20080905145246.GA20537@spearce.org>
References: <976e6d070809050222v1580ae53ye96dee913d44ae4b@mail.gmail.com> <20080905094746.GA26820@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sky Patrick <patricksky852@gmail.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbchA-0004vi-Ob
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbYIEOws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 10:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbYIEOws
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:52:48 -0400
Received: from george.spearce.org ([209.20.77.23]:58091 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbYIEOwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 10:52:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C82C38353; Fri,  5 Sep 2008 14:52:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080905094746.GA26820@glandium.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95020>

Mike Hommey <mh@glandium.org> wrote:
> On Fri, Sep 05, 2008 at 05:22:57PM +0800, Sky Patrick wrote:
> > 
> > If i want to write a new protocol for file transfer and would like to
> > to integrate it with git. Is it possible and easy to integrate it ?
> > Currently, i know that jgit may achieve it, but it is a Java
> > implementation and may not work with git command line program that
> > written in C.

Writing a dumb protocol support isn't difficult in JGit due to the
abstractions in place.  Its a little harder in C Git, unless Mike
(or someone else) can abstract out the cURL library usage and make
it more flexible.  Though these days cURL supports just about any
file transfer protocol known.
 
> First, it would depend if you need this new protocol to be a dumb
> protocol (like rsync and http) or "native" (git or ssh).

Writing a smart protocol is a PITA.  Look at the smart HTTP effort
I am trying to do.  OK, I'm not spending a whole lot of time on
it, but its a damn difficult thing to do well, and to keep simple
enough that it can be described and reimplemented.  Otherwise we
have another that-thing-before-Git on our hands.

> I've been meaning to refactor the dumb protocol "stack" for a while, but
> haven't gone much further than ideas in my mind (i.e. no code). I also
> have some start of http code recfactoring, that is waiting for this dumb
> protocol rework to be completed.

Yea.  One reason why I'm doing the smart HTTP effort prototype in
JGit is because the C code structure makes this harder to implement
without first going through a number of refactorings.  Though for the
smart HTTP stuff I really need to refactor fetch-pack/send-pack and
upload-pack/receive-pack, not the dumb walkers.

-- 
Shawn.
