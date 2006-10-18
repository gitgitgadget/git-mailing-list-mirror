From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] be more vim-ish, and also syntax hilight Signed-off-by lines.
Date: Wed, 18 Oct 2006 02:59:40 -0400
Message-ID: <20061018065940.GC3507@coredump.intra.peff.net>
References: <7vodsbmlkr.fsf@assigned-by-dhcp.cox.net> <1161131976193-git-send-email-madcoder@debian.org> <11611319762395-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 08:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga5P0-0004kB-BZ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 08:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWJRG7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 02:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWJRG7n
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 02:59:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:39610 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750716AbWJRG7m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 02:59:42 -0400
Received: (qmail 31941 invoked from network); 18 Oct 2006 02:59:40 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Oct 2006 02:59:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2006 02:59:40 -0400
To: Pierre Habouzit <madcoder@debian.org>
Content-Disposition: inline
In-Reply-To: <11611319762395-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29197>

On Wed, Oct 18, 2006 at 02:39:35AM +0200, Pierre Habouzit wrote:

> +if exists("b:current_syntax")
> +  finish
> +endif

I think this is a good change (along with commenting), but please write
a more descriptive commit message than "be more vim-ish" (I wouldn't
mind seeing this and the highlighting change broken into two patches,
since they are functionally completely unrelated).

> +syn region gitSignedOff start=/^Signed-off-by:/ end=/$/ contains=gitAuthor,gitEmail
> +syn region gitAuthor contained start=/\s/ end=/$/

You mention gitEmail but never define it. Are people using other things
besides Signed-off-by? I think we might do better to simply write:
  syn region gitCommentHeader start=/^[^ ]\+:/ end=/$/ contains=gitCommentValue
  syn region gitCommentValue contained start=/\s/ end=/$/

Highlighting only the header is inconsistent with other highlighting
(e.g., all of "new file: foo" is highlighted), but it looks so ugly to
highlight the whole line, so I think this is fine.

-Peff
