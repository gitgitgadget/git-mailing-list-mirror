From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 10/17] Move WebDAV HTTP push under remote-curl
Date: Tue, 27 Oct 2009 18:08:31 -0700
Message-ID: <20091028010831.GP10505@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <1255577814-14745-11-git-send-email-spearce@spearce.org> <20091019105921.d58c2728.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 02:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2x1h-0001LG-4C
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 02:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbZJ1BI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbZJ1BI0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 21:08:26 -0400
Received: from george.spearce.org ([209.20.77.23]:46061 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbZJ1BI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 21:08:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 24BDE381D3; Wed, 28 Oct 2009 01:08:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091019105921.d58c2728.rctay89@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131398>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Thu, Oct 15, 2009 at 11:36 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> > @@ -34,6 +34,10 @@ Commands are given by the caller on the helper's standard input, one per line.
> >        value of the ref. A space-separated list of attributes follows
> >        the name; unrecognized attributes are ignored. After the
> >        complete list, outputs a blank line.
> > ++
> > +If 'push' is supported this may be called as 'list for-push'
> > +to obtain the current refs prior to sending one or more 'push'
> > +commands to the helper.
> 
> The new paragraph should have the same indentation as 'list'.

Isn't the style I have here the standard way of adding a second
paragraph to a list item?
 
> It would have been great if you implemented this as a filter, such that
> 'list <attr>' lists the refs with the specified attribute <attr>,
> rather than hardcoding it.

Ack, will fix.
 
> > @@ -59,6 +63,22 @@ suitably updated.
> > +When the push is complete, outputs one or more 'ok <dst>' or
> > +'error <dst> <why>?' lines to indicate success or failure of
> > +each pushed ref.  The status report output is terminated by
> > +a blank line.  The option field <why> may be quoted in a C
> > +style string if it contains an LF.
> 
> You should mention that this behaviour only occurs when the
> --helper-status option is used.

No.  This manual page is about what a helper program must do, so I
mean what "git-remote-curl" must do.  The fact that git-remote-curl
honors this output format via passing the --helper-status option
into a command it executes is an implementation detail.

> > @@ -106,6 +132,11 @@ OPTIONS
> > +'option dry-run' \{'true'|'false'\}:
> > +       If true, pretend like the operation completed successfully,
> > +       but don't actually change any repository data.  For most
> > +       helpers this only applies to the 'push', if supported.
> > +
> 
> The 'like' after 'pretend' can be, like, removed. :)

Thanks, fixed.
 
> Two more areas in http-push.c that should have status messages
> (generated on top of pu):

I folded your patches into my series, thanks.
 
-- 
Shawn.
