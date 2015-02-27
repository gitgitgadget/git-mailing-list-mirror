From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Fri, 27 Feb 2015 05:04:41 -0500
Message-ID: <20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
References: <54EDBEC2.8090107@peralex.com>
 <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
 <20150225143116.GA13567@peff.net>
 <xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
 <20150225185128.GA16569@peff.net>
 <xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
 <20150225191108.GA17467@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 11:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRHtb-0007Rx-Tj
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 11:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbbB0KLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 05:11:43 -0500
Received: from tbsaunde.org ([66.228.47.254]:52884 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbB0KLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 05:11:41 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Feb 2015 05:11:41 EST
Received: from tsaunders-iceball.corp.tor1.mozilla.com (174.141.12.210.nw.nuvox.net [174.141.12.210])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id D6CD9C0B1;
	Fri, 27 Feb 2015 10:04:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20150225191108.GA17467@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264491>

On Wed, Feb 25, 2015 at 02:11:08PM -0500, Jeff King wrote:
> On Wed, Feb 25, 2015 at 11:01:22AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > So I think _if_ using "diff" attributes is enough for this purpose, then
> > > there is no code to be written.  But if somebody wants to draw a
> > > distinction between the uses (I want to diff "foo" files, but never see
> > > them in grep) then we could introduce a "grep" attribute (with the
> > > fallback being the value of the "diff" attribute for that path).
> > 
> > That is all true.
> > 
> > If we were to have a new 'grep' attribute that can be used to
> > express 'It is OK to diff two versions of this path, but hits by
> > grep in this path is useless' (and verse versa), the built-in macro
> > attribute 'binary' should also be updated with it.  A path being
> > 'binary' currently means '-diff -merge -text' but it should also
> > mean '-grep' in the new world, if we were to go in that direction.
> 
> I think it would do so automatically. There is no "grep" attribute
> given, so we fall back to the "-diff" attribute. But I do not mind
> modifying the macro to be more explicit.
> 
> Note also that I am not volunteering to work on this, nor am I convinced
> it's actually worth pursuing. I've yet to see a useful case where you
> would want text diffs but not greps (or vice versa), and if we can avoid
> cluttering the attribute space, we should. I was mostly pointing it out
> that it is not logically inconsistent to want such a thing. :)

 There have been cases where I wanted grep to always ignore certain
 files, but to still get text diffs for those files.  One case is people
 insist on using ChangeLog files, and another is people who commit
 generated files of one sort or another.

 Trev

> 
> If somebody does look into it, I suspect the place to start is modifying
> userdiff_find_by_path to optionally prefer "grep" to "diff".
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
