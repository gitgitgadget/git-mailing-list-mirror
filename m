From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 14:59:56 -0500
Message-ID: <20071216195956.GA14676@fieldses.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com> <20071216162637.GA3934@fieldses.org> <200712161916.44715.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 21:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3zfX-0003f2-7n
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 21:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbXLPUAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 15:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbXLPUAA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 15:00:00 -0500
Received: from mail.fieldses.org ([66.93.2.214]:57419 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037AbXLPT77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:59:59 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3zeW-0005NU-D8; Sun, 16 Dec 2007 14:59:56 -0500
Content-Disposition: inline
In-Reply-To: <200712161916.44715.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68483>

On Sun, Dec 16, 2007 at 07:16:44PM +0100, Jakub Narebski wrote:
> J. Bruce Fields wrote:
> > No, the previous version didn't work for the align-with-spaces case
> > either.  Consider, for example,
> > 
> > struct widget *find_widget_by_color(struct color *color,
> >                                     int nth_match, unsigned long flags)
> > 
> > If following a "indent-with-tabs, align-with-spaces" policy, then the
> > initial whitespaace on the second line should be purely spaces
> > (otherwise adjusting the tab stops would ruin the alignment).  But
> > indent-with-non-tab would flag this as incorrect even before my fix.
> 
> Yes, this is (if we want "indent with tab, align with spaces") false
> positive even with current version of indent-with-non-tab policy, but
> it is _rare_ false positive.

You can find examples like the above all over the git source, even in C
where the top-level code is indented in main().

> It is useful because it catches quite common "indent with spaces only",
> for example if MTA or editor replaces tabs with spaces, or if editor
> preserves whitespace but it uses spaces for indent.
> 
> So for me this version is a good compromise between false positives
> and catching real indent whitespace errors. The version proposed has
> IMHO too many false positive, while I guess not catching much more
> errors in practice.

Unfortunately, this compromise wouldn't solve my problem.

Which is: I do get the occasional kernel patch with whitespace problems
uncaught by git's existing checks.  It's annoying to have to fix them up
manually (but wastes Andrew Morton's time if I don't).  This shouldn't
be necessary, because the kernel has a simple policy for initial
whitespace that is completely automatable.

If we've got to define a fourth whitespace policy for this, well, OK,
I'll live--tell me what I need to do.  I haven't seen a convincing
argument for that yet, though.

--b.
