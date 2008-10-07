From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Tue, 7 Oct 2008 02:00:14 -0400
Message-ID: <20081007060014.GA7965@coredump.intra.peff.net>
References: <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr> <20081007012044.GA4217@coredump.intra.peff.net> <48EAF902.3040402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 08:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5dP-0005Vk-SP
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 08:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbYJGGAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 02:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbYJGGAR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 02:00:17 -0400
Received: from peff.net ([208.65.91.99]:2950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbYJGGAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 02:00:16 -0400
Received: (qmail 27797 invoked by uid 111); 7 Oct 2008 06:00:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 07 Oct 2008 02:00:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2008 02:00:14 -0400
Content-Disposition: inline
In-Reply-To: <48EAF902.3040402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97667>

On Tue, Oct 07, 2008 at 07:52:02AM +0200, Johannes Sixt wrote:

> How about this: If I run 'git show -- foo.doc' (foo.doc resolves to a
> single path, obviously), I want MS Word, but for other uses of 'git show'
> I don't. I think that heuristics could be very effective: With a plain
> 'git show' I get the overview of the change, and with 'git show --
> foo.doc' I drill down into a single document.

Hrm. I am not opposed to heuristics, but in this case, I don't like the
one you have proposed. ;P

My specific case that prompted this work is a repository full of
pictures and videos, where I rarely (if ever) change the media content,
but frequently change exif tags. So my "usual" case is to want to see
"git log -p" with the textconv'd version. The commit diffs are otherwise
totally meaningless.

But I think for many others, they are primarily working with text data,
but have some (for example) binary word processor documents. Triggering
such conversions for a single file might make more sense there.

So I'm not sure there is a heuristic that serves both desires. Which is
why I would lean towards a command-line argument, backed by a config
option for those repositories which really want it all the time (and let
me reiterate that such a config option would still have _no_ impact on
plumbing; applying text conversion there is just plain wrong).

> Or this: 'git show -p' uses the textconv'd version, 'git show' does not
> ("Binary files differ").

At that point, is there really an advantage over "git show --textconv"?

> BTW, also with 'git diff' I sometimes don't want MS Word to pop up...

Yes. It is annoying that git can't simply read our minds. :)

-Peff
