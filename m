From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Aug 2013, #01; Thu, 1)
Date: Sat, 3 Aug 2013 12:55:15 +0200
Message-ID: <87a9kz3uy4.fsf@hexa.v.cablecom.net>
References: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ZUY-0004SV-GE
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3HCKzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 06:55:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57198 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab3HCKzS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:55:18 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:55:06 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 12:55:16 +0200
In-Reply-To: <7vbo5hqe6r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 01 Aug 2013 14:44:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231580>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/log-full-diff-keep-true-parents (2013-08-01) 1 commit
>  - log: use true parents for diff even when rewriting
>
>  Output from "git log --full-diff -- <pathspec>" looked strange,
>  because comparison was done with the previous ancestor that touched
>  the specified <pathspec>, causing the patches for paths outside the
>  pathspec to show more than the single commit has changed.
>
>  I am not sure if that is necessarily a problem, though.  Output
>  from "git log --full-diff -2 -- <pathspec>" without this change
>  will be applicable to some codebase, but after this change that
>  will no longer be true (you will get only tiny parts of the change
>  that were made by the two commits in question, while missing all
>  the other changes).

Hmm.  Uwe's original complaint was that --stat -- as in "what other
things are touched when we modify foo" -- is nonsensical.

In addition, applying what you describe above would be a very strange
form of rebase: one that squashes everything into the commits that
affect the given files.  When would it ever make sense to do such
squashing?  After all, you'd lose all the commit splits&messages in
between.

If you care about it, I can introduce a new flag that lets the user
pick; it's pretty trivial.  But it seems very strange to me.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
