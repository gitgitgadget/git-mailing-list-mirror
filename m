From: Johan Herland <johan@herland.net>
Subject: Re: New Proposal (simple) for Metadata in Git Commits: git-meta
Date: Thu, 17 Dec 2009 01:26:40 +0100
Message-ID: <200912170126.40566.johan@herland.net>
References: <93857A5A-744E-4A7C-B42D-23A56A48AAF7@lenary.co.uk>
 <7349A827-41D5-434F-85FE-D49980A7D501@lenary.co.uk>
 <20091216163036.GE18319@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Sam Elliott <sam@lenary.co.uk>
X-From: git-owner@vger.kernel.org Thu Dec 17 01:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL4Ck-0001EK-3C
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 01:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762916AbZLQA0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 19:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762873AbZLQA0q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 19:26:46 -0500
Received: from smtp.getmail.no ([84.208.15.66]:53794 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758247AbZLQA0o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 19:26:44 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUR00G8BT8H0PB0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Dec 2009 01:26:41 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUR00GYKT8G5Q20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Dec 2009 01:26:41 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.17.1221
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20091216163036.GE18319@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135349>

On Wednesday 16 December 2009, Shawn O. Pearce wrote:
> Sam Elliott <sam@lenary.co.uk> wrote:
> > On 15 Dec 2009, at 23:05, Shawn O. Pearce wrote:
> >> If you dropped the --git-meta-- tags above, JGit would happily
> >> recognize the awesome: and Github: tags, but it might need a bit
> >> more work to recognize the nested user: tag.  Also, you'd be able
> >> to use git-meta on the git and Linux kernel repositories to pull
> >> out and work with Signed-off-by, Acked-by, etc.
> >
> > I'm not entirely sure about this approach. The current implementation
> > also works with PGP-signed tags, where the information is not
> > necessarily going to be at the bottom of the message when i use `git-
> > cat-file -p`. I think it shouldn't be too hard to also have git-meta
> > read any YAML-like data just before the signing message.
> 
> Ah, good point.  But as you point out, it should be simple enough
> to detect a PGP signature on the bottom and just clip that off the
> end, and then perform the YAML-like data parsing on the footer.

I agree with Shawn's point that it should be possible to do this without 
embedding it in custom ---tags---.

I would even try to parse the _entire_ commit message, and then discard 
everything that didn't match the "<word>: <free-form value>" format (with 
possible continuation lines). Even though this will generate some false 
positives (probably non-sensical "key: value" pairs), I don't see this as a 
major problem , since most users of this functionality are looking for a 
small set of specific keywords (which are even more unlikely to turn up as 
false positives)

In future versions of Git, you might also want to check for YAML-like data 
in the notes object corresponding to the commit in question (see git-notes 
in v1.6.6 for more details on the new notes feature). This would allow users 
to add/edit such metadata after the commit was made, without having to 
rewrite the commit itself.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
