From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] merge-recursive: prepare merge_recursive() to be
	called from builtins
Date: Mon, 11 Aug 2008 22:46:16 +0200
Message-ID: <20080811204616.GA26823@leksak.fem-net>
References: <cover.1218374062.git.vmiklos@frugalware.org> <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <20080811151303.GA11208@leksak.fem-net> <7vzlnjwcog.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:47:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeIf-0002Ms-Oa
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbYHKUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757770AbYHKUqX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:46:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:34905 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757740AbYHKUqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:46:22 -0400
Received: (qmail invoked by alias); 11 Aug 2008 20:46:19 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp056) with SMTP; 11 Aug 2008 22:46:19 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18HoGhJ9rcHGALCSRo9ya7dSK2q1FUih94T5THZCk
	imI8vJWoPyq79m
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSeHQ-0000q9-RS; Mon, 11 Aug 2008 22:46:16 +0200
Content-Disposition: inline
In-Reply-To: <7vzlnjwcog.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91998>

Hi,

Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
> > Hmm, I have the long-run vision that we have a nice libgit some day,
> > with merge_recursive() being part of it.  And I'm a little unsure if
> > libified functions should rely on environment variables.
> 
> I think the environment variable is the least of your worries.  
> 
> I do not think anybody has vetted if it is safe to call merge_recursive()
> more than once in a single run of a process.

I use it in builtin-sequencer.c, without yet spending much effort in
libifying it. For the tests, it works. (Each "pick" calls a
merge_recursive(), each threeway-merge needing "patch" does.)
But I should either spend some effort in improving the libification
or, if this gets too time-consuming before Aug 17, I revert the commits
that make use of merge_recursive() instead of running git-merge-recursive.

> leaking of "virtual commit",

Apropos, I think I have some tiny leak fixes lying around here.
Would such patches go into 1.6.0 or is it too dangerous?
(A free() that fixes a leak in one place could cause a segmentation
fault in another place. Of course I can try to explain in the commit
messages, why those are leaks in every case.)

> But such a clean-up may not be too bad as I initially feared, I suppose.

I suppose, too.

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
