From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Mon, 12 Jan 2009 06:21:09 -0500
Message-ID: <20090112112109.GA3825@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net> <49672244.80200@viscovery.net> <20090109101335.GA4346@coredump.intra.peff.net> <496728B9.7090200@viscovery.net> <20090111112222.GA29656@coredump.intra.peff.net> <496B2278.9050905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMKsN-0005lU-Px
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbZALLVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 06:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbZALLVM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 06:21:12 -0500
Received: from peff.net ([208.65.91.99]:39757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZALLVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 06:21:11 -0500
Received: (qmail 30777 invoked by uid 107); 12 Jan 2009 11:21:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Jan 2009 06:21:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2009 06:21:09 -0500
Content-Disposition: inline
In-Reply-To: <496B2278.9050905@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105326>

On Mon, Jan 12, 2009 at 11:59:04AM +0100, Johannes Sixt wrote:

> But we need to insert the patch below *before* 2/4. The test case needs a
> change, too,(exit code on Windows is 3, not 130) but I'll keep that in my
> repository, like with all other Windows related test suite changes.

Hrm. How do you properly detect "killed by SIGINT" on Windows? That is
the intent of that test.

> -#define SIGKILL 0
> -#define SIGCHLD 0
> -#define SIGPIPE 0
> -#define SIGHUP 0
> -#define SIGQUIT 0
> -#define SIGALRM 100
> +#define SIGHUP 1
> +#define SIGQUIT 3
> +#define SIGKILL 9
> +#define SIGPIPE 13
> +#define SIGALRM 14
> +#define SIGCHLD 17

Don't these get fed to signal()? Does Windows really not care about
getting bogus numbers versus 0 (which is, admittedly, bogus itself)? Or
are we just ignoring the return code everywhere?

-Peff
