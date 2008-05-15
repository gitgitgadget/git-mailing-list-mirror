From: Jeff King <peff@peff.net>
Subject: Re: git clone broken in next
Date: Thu, 15 May 2008 00:50:26 -0400
Message-ID: <20080515045026.GA26161@sigill.intra.peff.net>
References: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org> <20080515044402.GA3517@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 15 06:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVRL-000575-2I
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 06:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYEOEu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 00:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYEOEu3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 00:50:29 -0400
Received: from peff.net ([208.65.91.99]:3238 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbYEOEu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 00:50:28 -0400
Received: (qmail 32068 invoked by uid 111); 15 May 2008 04:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 May 2008 00:50:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2008 00:50:26 -0400
Content-Disposition: inline
In-Reply-To: <20080515044402.GA3517@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82179>

On Thu, May 15, 2008 at 12:44:02AM -0400, Jeff King wrote:

> Hmm, builtin-clone does seem to be completely broken. It looks like
> unpack_trees is not doing its job for some reason, but I haven't looked
> further. But it surprised me that we aren't testing anything as simple
> as "clone works". The test below currently fails (though I am getting
> other test failures which are presumably related).
> 
> ---
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index dc9d63d..593d1a3 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -23,4 +23,11 @@ test_expect_success 'clone with excess parameters' '
>  
>  '
>  
> +test_expect_success 'clone checks out files' '
> +
> +	git clone src dst &&
> +	test -f dst/file
> +
> +'
> +
>  test_done

Just to be sure, I bisected this test, and sure enough, the problem
commit is 8434c2f1 (build in clone). Daniel?

-Peff
