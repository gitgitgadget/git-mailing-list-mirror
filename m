From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 05:52:03 -0500
Message-ID: <20100222105203.GB16531@coredump.intra.peff.net>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 13:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVtd-0003k0-5W
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab0BVKwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:52:07 -0500
Received: from peff.net ([208.65.91.99]:51990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab0BVKwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:52:06 -0500
Received: (qmail 24876 invoked by uid 107); 22 Feb 2010 10:52:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 05:52:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 05:52:03 -0500
Content-Disposition: inline
In-Reply-To: <7vtytacebd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140673>

On Sun, Feb 21, 2010 at 04:19:18PM -0800, Junio C Hamano wrote:

> * cp/add-u-pathspec (2010-02-09) 2 commits
>  - test for add with non-existent pathspec
>  - git add -u: die on unmatched pathspec
> 
> I am a bit torn on this one.  Traditionally we never complained on
> unmatched pathspec when talking about tracked files.  If we were to go

True, though most of those pathspecs for tracked files are when viewing
diffs. It seems more inconsistent here because "git add foo" complains
but "git add -u foo" does not. So I think this one is definitely worth
fixing.

> this route, I think we should probably enhance the "run_diff_files" and
> friends in such a way that they mark matched pathspecs, in a way similar
> to match_pathspec() in dir.c does, and report unmatched ones based on
> that result, instead of adding an extra pass to scan the index.  The same
> goes for pathspec_matches() in builtin-grep.c

Are you proposing to check pathspecs of tracked files for typos in other
places, or simply indicating an alternative implementation to fix this
problem?

Either way, I think we need _something_ here. If you are volunteering to
work on the alternative, fine, but otherwise (and even if it is just for
a while until the other materializes), I would just as soon have the
existing fix.

-Peff

PS Somewhat related, have you had a chance to read my:

  http://article.gmane.org/gmane.comp.version-control.git/140434
