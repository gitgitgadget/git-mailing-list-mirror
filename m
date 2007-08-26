From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sun, 26 Aug 2007 00:28:42 -0700
Message-ID: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
	<7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
	<52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>
	<7vsl66svv4.fsf@gitster.siamese.dyndns.org>
	<C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 09:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPCYd-0006LN-9M
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 09:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbXHZH2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 03:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbXHZH2q
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 03:28:46 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbXHZH2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 03:28:45 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 93766126F1A;
	Sun, 26 Aug 2007 03:29:05 -0400 (EDT)
In-Reply-To: <C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com>
	(Dmitry Kakurin's message of "Sat, 25 Aug 2007 23:36:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56677>

Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:

> I thought I did: I've observed that these problem are caused by
> storing metadata in regular files (that exist both in repo/index and
> in workplace).

And that observation solves the initial checkout issue how?

> My knowledge of Git internals is quite limited, but if *I* were to do
> it right now, I'd introduce a META entry in every TREE object that
> would point to a BLOB that contains combined content of
> .gitattributes, .gitignore etc.

A tree that has .gitattributes (and I am assuming in the longer
term you can use "ignore" and "precious" in .gitattributes
instead of using .gitignore) POINTS TO A BLOB already, so what
you are saying does not add anything to what we already have,
other than that you are renaming .gitattributes to "META ENTRY".

When you do "git checkout -- this-path", you are checking things
out from the index and at that point you may not have _any_ tree
yet (think "before initial commit").  A "META ENTRY" that exists
only in a tree does not work -- it has to come to index somehow
for it to work with how git works.
