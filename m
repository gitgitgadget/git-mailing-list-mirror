From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Tue, 26 Jun 2012 14:33:40 +0100
Message-ID: <20120626133339.GT9682@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com>
 <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 15:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjVtx-0006DO-6G
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 15:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914Ab2FZNdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 09:33:47 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:41506 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab2FZNdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 09:33:47 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjVtm-0003No-HT; Tue, 26 Jun 2012 14:33:42 +0100
Content-Disposition: inline
In-Reply-To: <20120620194824.GA32228@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200641>

Jeff King <peff@peff.net> writes:

> I think the only thing you can do is make a fake sentinel commit (with
> an empty tree) to put in HEAD, and then remove the sentinel immediately
> after the first commit is put in place (making sure not to include it in
> the first commit's parent list). Yuck.

I thought this would turn out far more horrible than it actually did in
practice.

The follow-up patch adds this empty sentinel and then automatically squashes
it into the root commit(s) as they're picked. The resulting rebase -i --root
can handle re-ordering of commits (picking a new root), editing of the root
commit, dropping the root commit, and so on.

In the second patch, I've written some simple tests to demonstrate this and
to cover cases that seem particularly likely to break, as well as removing a
test_must_fail for --root without --onto, because it no longer does!

Cheers,

Chris.
