From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] solaris test results
Date: Fri, 22 Feb 2008 00:42:29 -0500
Message-ID: <20080222054229.GA32294@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <7vk5kz171q.fsf@gitster.siamese.dyndns.org> <20080221004146.GA6682@coredump.intra.peff.net> <7vr6f5pnmz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 06:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSQgg-00072p-6T
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 06:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYBVFmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 00:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYBVFmd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 00:42:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4276 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbYBVFmc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 00:42:32 -0500
Received: (qmail 19195 invoked by uid 111); 22 Feb 2008 05:42:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Feb 2008 00:42:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2008 00:42:29 -0500
Content-Disposition: inline
In-Reply-To: <7vr6f5pnmz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74692>

On Thu, Feb 21, 2008 at 09:26:44PM -0800, Junio C Hamano wrote:

> Here is a possible solution.
> 
> This is a fairly mechanical substitution (grepping for "git diff -u"
> and "diff -u", and replacing them with test_compare_expect.

I think this approach is reasonable (though as I suggested in my
original message, I probably would have selected something a little
easier to type, like test_cmp).

> Test scripts can be run with --no-diff-u option, to use "git
> diff -u --no-index" for comparison instead.

I thought you were against using "git diff" in the test suite for this
purpose.  Using "diff -u" produces nice output in case of failure, but
even "cmp" can do the job of returning an exit code. Perhaps it makes
sense as a more robust fallback.

Perhaps the command line option should be --compare=cmp, which lets the
caller choose an appropriate fallback for their system (and which means
that you can use --compare="git diff" to make debugging more pleasant,
but confirm with --compare="cmp" before claiming breakage on the list).

But honestly, I do not care that much about this. I don't even usually
use Solaris; I happened to have access to a box, so I followed up on
Whit's bug report. It is probably not worth spending a lot of time
over-engineering a solution. I have no idea how common it is to run the
test suite on boxes without GNU diff.

-Peff
