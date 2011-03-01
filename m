From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Tue, 1 Mar 2011 15:00:25 -0500
Message-ID: <20110301200025.GF10082@sigill.intra.peff.net>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
 <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org>
 <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 <7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
 <vpqipw2rixy.fsf@bauges.imag.fr>
 <7vd3maelbh.fsf@alter.siamese.dyndns.org>
 <vpq4o7mfzd1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:00:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVk8-0004gU-M6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446Ab1CAUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:00:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35402 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1CAUAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:00:17 -0500
Received: (qmail 9764 invoked by uid 111); 1 Mar 2011 20:00:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 20:00:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 15:00:25 -0500
Content-Disposition: inline
In-Reply-To: <vpq4o7mfzd1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168249>

On Tue, Mar 01, 2011 at 07:51:38PM +0100, Matthieu Moy wrote:

> > Once your users (you as a script writer) have an option to set the
> > configuration to participate in the tree-wide party early, you would need
> > to update your scripts immediately so that they don't break on them;
> 
> But "update" should mean "replace git add -u with git add -u .", which
> is the portable way to do the same.
> 
> > so the introduction of the configuration becomes a flag-day event.
> > Hmph...
> 
> The introduction of the config variable is a non-event if you already
> use the portable . notation.

Right. Once this happens, you can never say "git add -u" again portably.
You can't rely on the old behavior, because it's changing. You can't
rely on the new behavior, because you might be using an old version. So
as a script you _must_ say "git add -u .", and if you want top-level
behavior and are not at the top-level, you must cd to the toplevel and
"add .". Which sounds onerous, but it is what scripts have to do
already with the current behavior.

> > Yeah, I think you convinced me that an elaborate configuration wouldn't
> > help us at all.  We just keep warning in 1.7.x series when "add -u" didn't
> > see any pathspec, and flip the default at 1.8.0
> >
> > Simpler and cleaner ;-)
> 
> I think is still makes sense to have a config variable, so that people
> who want the new behavior can get it ASAP. Right after 1.8 is out, I'll
> still have machines where I'm too lazy to install a brand new Git, and
> I'll want to get the 1.8 goodness for free ;-).

Agreed. I also think there should be a setting to keep the current
behavior. I don't want to use it, but given that configuration does not
introduce any existing portability issues, we can help people who really
liked the old behavior. We are inconveniencing them by changing the
default, but it seems doubly mean to leave them with no way of restoring
it short of typing extra characters on every invocation.

-Peff
