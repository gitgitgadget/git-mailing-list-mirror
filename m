From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Fri, 29 Feb 2008 23:41:55 -0500
Message-ID: <20080301044155.GA9010@coredump.intra.peff.net>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com> <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com> <20080225184648.GC15131@sigill.intra.peff.net> <20080228084328.GA18350@coredump.intra.peff.net> <7v3arcfh54.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 05:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJYr-0005ad-26
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 05:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbYCAEl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 23:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYCAEl6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 23:41:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3054 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbYCAEl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 23:41:57 -0500
Received: (qmail 31072 invoked by uid 111); 1 Mar 2008 04:41:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 29 Feb 2008 23:41:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 23:41:55 -0500
Content-Disposition: inline
In-Reply-To: <7v3arcfh54.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75609>

On Thu, Feb 28, 2008 at 09:47:35PM -0800, Junio C Hamano wrote:

> While I like the fact that somebody is trying to tackle the
> consistency issue, I do not like the approach itself.  Fudging
> the issue at the merge-tool UI level may make things appear more
> consistent when viewing the merge from within merge-tool, but it
> makes the views merge-tool gives and vi/less gives inconsistent.
> 
> It would be a lot more sensible to make sure that we always show
> the side that the end-user modified first and then the side the
> other party changed.

I hadn't considered that, because I never pay attention to the order of
changes between the conflict markers; I look at the nice "HEAD" and
"abcdef... commit subject" messages.

But then I don't do a lot of conflict resolution. Usually I either work
with tiny teams on a central-ish repository, or work on projects where I
am just a contributor.

So I agree that a consistent view makes sense, and I can see that
ordering of hunks is a sensible context clue. However, should this not
extend further, to the index numbering? Or do we not care, because
mortals rarely touch the index? What about "git-rebase --strategy=ours",
which really means "theirs"?

Unfortunately just swapping the arguments to git-merge-* in
git-rebase.sh doesn't quite work ("merge-ours" doesn't actually load the
index and say "pick the 'ours' stage"; it just says "whatever is in the
working tree is fine.").

-Peff
