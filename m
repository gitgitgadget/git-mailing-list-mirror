From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Tue, 9 May 2006 21:45:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605092142050.3718@g5.osdl.org>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net> <864pzyh4x0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 10 06:46:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdgaH-0000rq-EO
	for gcvg-git@gmane.org; Wed, 10 May 2006 06:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWEJEp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 00:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEJEp6
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 00:45:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964813AbWEJEp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 00:45:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A4jOtH009092
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 21:45:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A4jNKO002134;
	Tue, 9 May 2006 21:45:23 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <864pzyh4x0.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19874>



On Tue, 9 May 2006, Randal L. Schwartz wrote:

> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio> This week's "What's in" is a day early, since I do not expect to
> Junio> be able to do much gitting for the rest of the week.
> 
> I just got this with the latest, on the git archive, using git-repack -a:
> 
> Generating pack...
> Done counting 19151 objects.
> Deltifying 19151 objects.
> Segmentation fault (core dumped)
> 
> This is on OpenBSD.  Is there a secret sabotage afoot?  This is repeatable.
> Is there anything I can try differently?

Can you see what the traceback is with gdb?

I'd suspect the deltifier changes, the rabin hash in particular. The core 
file traceback would probably point right at the culprit if so.

I don't see the problem myself, but if it's an access just past the end of 
an array or something, it would depend on exactly what the delta pattern 
is (which, without the "-f" flag, in turn depends on what your previous 
packs looked like) and also on the allocation strategy (which migth 
explain why it shows on OpenBSD but Linux people hadn't seen it).

			Linus
