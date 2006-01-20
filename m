From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Fri, 20 Jan 2006 01:23:44 -0500
Message-ID: <1137738224.27911.26.camel@dv>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
	 <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth>
	 <1137631749.13853.22.camel@dv>  <20060119213838.GA27397@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Fri Jan 20 07:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezpgw-0000RD-2Y
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 07:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWATGXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 01:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWATGXv
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 01:23:51 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:2453 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030400AbWATGXv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 01:23:51 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EzpdX-0001Jn-9v
	for git@vger.kernel.org; Fri, 20 Jan 2006 01:20:39 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1EzpgW-0007MO-Mr; Fri, 20 Jan 2006 01:23:44 -0500
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060119213838.GA27397@nowhere.earth>
X-Mailer: Evolution 2.5.4 (2.5.4-9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14953>

On Thu, 2006-01-19 at 22:38 +0100, Yann Dirson wrote:
> > I believe StGIT should be primarily designed to be used interactively.
> 
> I tend to disagree.  3rd-party apps like qgit should be able to let
> the user do the selection, and tell the command-line tool what they
> want to act upon.  It may be useful as well if stg gains
> interactivity, but should not become the only way to work with it
> (unix way of life).

In this particular case, the GUI frontend should be able to supply much
more data than the hunk numbers.  It would be much safer.

I didn't mean to say that StGIT shouldn't have any options for
non-interactive processing.  I meant that whenever adding a feature, we
should try to make it immediately useful without any frontends or
additional software.

> Maybe we could have a "fold" or "refresh" variant that takes its
> output from the output of "stg diff" (or any arbitrary diff on stdin,
> to be friendly with GUI wrappers) filtered by an arbitrary command.

That would be "fold".  "refresh" like is saying - this patch should
produce this file.  I actually tend to think now that deep refresh would
be confusing and dangerous if there is another patch closer in the stack
working with the same file, even in a separate part of it.  stg would
either report conflict with the higher patches use the file with the
higher patches reverted, and neither sounds good to me.

Deep fold of the local changes would be much easier, since no other
patch should have them.

> That command could be "cat" to get the current "refresh" behaviour, or
> an editor wrapper acting on stdin/out, or a wrapper to filterdiff, or
> whatever clever filter one would want to use.
> 
> Does it sound better ?

Yes.  The first step would be to fix "stg refresh --edit --showpatch" to
actually respect edits made to the patch.

-- 
Regards,
Pavel Roskin
