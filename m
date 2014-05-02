From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Pull is Evil
Date: Fri, 2 May 2014 09:16:55 +0200
Message-ID: <20140502071655.GA6288@inner.h.apk.li>
References: <536152D3.5050107@xiplink.com> <5361598f8eaf7_4781124b2f02b@nysa.notmuch> <536173F5.7010905@xiplink.com> <53617877b41a9_41a872f308ef@nysa.notmuch> <20140501094610.GB75770@vauxhall.crustytoothpaste.net> <5362664C.8040907@xiplink.com> <20140501175623.GY6227@odin.tremily.us> <53628CB1.8010302@xiplink.com> <20140501183008.GZ6227@odin.tremily.us> <5362ACD6.50505@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 09:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg7iz-0007Al-GU
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 09:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbaEBHRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 03:17:32 -0400
Received: from continuum.iocl.org ([217.140.74.2]:46406 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaEBHRb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 03:17:31 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s427Gt307249;
	Fri, 2 May 2014 09:16:55 +0200
Content-Disposition: inline
In-Reply-To: <5362ACD6.50505@xiplink.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247926>

On Thu, 01 May 2014 16:21:42 +0000, Marc Branchaud wrote:
...
> 
> But these days there's hardly any risk to using a detached HEAD.  Plus
> nowadays I think it's commonly accepted that using topic branches is a git
> best practice.  The notion of doing work on a generically-named branch like
> "maint" seems archaic.
> 
> So what benefit does "git pull" provide?

It provides the moral equivalent of 'cvs update', 'svn update', and
'clearcase <do nothing>'.

Even when I'm on a feature branch, there are cases where I have that branch
as the current one in multiple repos (on different machines because testing),
or multiple people working on that branch. A 'git pull' is the obvious way
to get divergent branches back together.

In cvs&svn a local workspace can't ever be more than half a commit ahead,
and what an 'update' does is most similar to a rebase in git. But I'm
not eager to teach this future userbase rebases, and also a rebase loses
expensive test results that are tied to the commit ids.

My personal beef with 'git pull' is still that sometimes (namely in the
'git pull && git push' sequence) it should reverse the order of the
parents in the merge commit, so that *my* commits look like an
integrated topic branch, instead of the former mainline.

Unfortunately the answers to the question "what to do instead of 'git
pull'" are, in increasing order of teaching needed:

- Ok, just 'git pull' <sigh>.

- Please do a 'git pull --rebase'; I'll show you how.

- <Something involving switching branches and doing the
   merge in the other direction>

(I'm coming from a 'blessed repo where everybody pushes to' setup,
and we're considering a server trigger that refuses pushes where
the previous head is not a *first* parent of the new head, in order
not to accidentally mess up the mainline.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
