From: Jason Riedy <jason@acm.org>
Subject: Re: [PATCH] Pass --upload-pack and --receive-pack through submodules.
Date: Thu, 01 Jan 2009 20:44:03 -0500
Message-ID: <878wpua3do.fsf@sparse.dyndns.org>
References: <1230605055-30723-1-git-send-email-jason@acm.org>
	<1230649782-14710-1-git-send-email-jason@acm.org>
	<7vy6xuhhbx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 02:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIZ6h-0004wG-8H
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 02:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbZABBoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 20:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbZABBoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 20:44:25 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:54070 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbZABBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 20:44:24 -0500
Received: from nan.sparse.yi.org (misc-148-78-88-138.pool.starband.net [148.78.88.138])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id n021iAEw018348;
	Thu, 1 Jan 2009 17:44:13 -0800
In-Reply-To: <7vy6xuhhbx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 01 Jan 2009 13:00:50 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104353>

And Junio C. Hamano writes:
> Do we (and can we) assume that the remote repositories submodules fetch
> from all reside on the same host and can share the same values for these
> parameters?  Shouldn't these instead be specified in the configuration
> files for the submodules, if they need to be nonstandard values?

git does not and (for me) should not make the assumption above.
I'm fetching different pieces from different administrative
domains where I also have push access.  While I could clone them
all into one place, that adds another level of repositories I'd
have to keep up-to-date.

Essentially, I'm collecting experimental libraries and drivers
into one build tree.  My intent is to record exactly what is
being built on multiple machines while being able to push local
build configurations back to my central superproject.  Then I can
make a version with pull-only remote URLs[1] for others to
duplicate the setup for my experiments.

I suppose I could clone the submodules by hand and then use git
submodule add.  But then I'll have to build the structure by hand
(with my own wrapper) everywhere I use the supermodule.  At that
point, using git submodule becomes a tad silly.  Or I could set
up the superproject with pull-only URLs and modify the
configurations with a separate wrapper.  Seemed like adding the
two options to git submodule was easier.

Jason

Footnotes: 
[1]  Or ask for separate pull- and push-urls in git remote.  But
I haven't thought that through.
