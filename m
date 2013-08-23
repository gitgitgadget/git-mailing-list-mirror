From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [PATCHv2] git-diff: Clarify operation when not inside a repository.
Date: Fri, 23 Aug 2013 14:11:40 -0400
Message-ID: <201308231811.r7NIBeH9027848@freeze.ariadne.com>
References: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com>
	<xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
	<201308222031.r7MKVL6O028293@freeze.ariadne.com> <xmqqioyxqwdr.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCvpr-0000BF-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab3HWSLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:11:44 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:51516
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755538Ab3HWSLm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Aug 2013 14:11:42 -0400
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id GCvG1m0050vyq2s5BJBiCQ; Fri, 23 Aug 2013 18:11:42 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta05.westchester.pa.mail.comcast.net with comcast
	id GJBh1m00T1KKtkw3RJBhAF; Fri, 23 Aug 2013 18:11:41 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r7NIBee1027849;
	Fri, 23 Aug 2013 14:11:40 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r7NIBeH9027848;
	Fri, 23 Aug 2013 14:11:40 -0400
In-reply-to: <xmqqioyxqwdr.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377281502;
	bh=zgEwOlHkwXQep1J6niLMsLzYNX8d50RKJgWk03KVU7E=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=tVQhGvdIF18/m4y3iBY6H7TTLVGMsP0U/7aA0pE4/QVrD5I8HsUoCLQYIinMfnDVU
	 w3/2h0XupOAOkgXhBzhJu4uxvcJQHFss7u0RgKcr9GGNKrt08Dffje2ulLWmfJHCgY
	 HVkGq0H0A0jUjn8CaCGIp1WeR2AdSgv5Kl3JH0iRr4NAuLibJgKin5L1zoRnMgUySz
	 opf3FaYhEFgRCPUDOyYIA5WWiIWZ6KHovARNx/4KgOddnoO39GfyVbsRyTZarzAh1i
	 L+kVQCsN3CAFLMKrY1LD4MgKsg0MjEgb+dhu53OPGGGq02UrWthQ6u0pALNu+gSBOu
	 9K0CMIGxgKawg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232818>

> From: Junio C Hamano <gitster@pobox.com>

> I suspect that it may be a good idea to split the section altogether
> to reduce confusion like what triggered this thread, e.g.
> 
>     'git diff' [--options] [--] [<path>...]::
> 
>             This form is to view the changes you made relative to
>             the index (staging area for the next commit).  In other
>             words, the differences are what you _could_ tell Git to
>             further add to the index but you still haven't.  You can
>             stage these changes by using linkgit:git-add[1].
> 
>     'git diff' --no-index [--options] [--] <path> <path>::
> 
> 	    This form is to compare the given two paths on the
> 	    filesystem.  When run in a working tree controlled by
> 	    Git, if at least one of the paths points outside the
> 	    working tree, or when run outside a working tree
> 	    controlled by Git, you can omit the `--no-index` option.
> 
> For now, I'll queue your version as-is modulo style fixes, while
> waiting for others to help polishing the documentation better.

It'd difficult to figure out how to describe it well.  In my opinion,
the problem here is the DWIM nature of the command, which means that
there is a lot of interaction between the options that are specified,
the number of path arguments, and the circumstances.  My preference is
for "do what I say", that the options restrict the command to operate
in exactly one way, which determines the way the paths are used (and
thus their number) and the context in which it can be used.  But
that's not how git-diff works.

Dale
