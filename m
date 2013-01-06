From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/pathspec-literal] t6130-pathspec-noglob: Windows does
 not allow a file named "f*"
Date: Sun, 6 Jan 2013 09:33:20 -0500
Message-ID: <20130106143319.GA10690@sigill.intra.peff.net>
References: <50E9852F.2060005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 15:33:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrrIL-0007JS-Th
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 15:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab3AFOdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 09:33:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45240 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011Ab3AFOda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 09:33:30 -0500
Received: (qmail 2921 invoked by uid 107); 6 Jan 2013 14:34:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 Jan 2013 09:34:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2013 09:33:20 -0500
Content-Disposition: inline
In-Reply-To: <50E9852F.2060005@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212806>

On Sun, Jan 06, 2013 at 03:07:43PM +0100, Johannes Sixt wrote:

> Windows disallows file names that contain a star. Arrange the test setup
> to insert the file name "f*" in the repository without the corresponding
> file in the worktree.
> [...]
> -	test_commit star "f*" &&
> +	# insert file "f*" in the commit, but in a way that avoids
> +	# the name "f*" in the worktree, because it is not allowed
> +	# on Windows (the tests below do not depend on the presence
> +	# of the file in the worktree)
> +	git update-index --add --cacheinfo 100644 "$(git rev-parse HEAD:foo)" "f*" &&
> +	test_tick &&
> +	git commit -m star &&

Thanks, looks obviously correct to me.

Sorry to break Windows again. It seems I learn about a new gotcha with
every patch series. :)

-Peff
