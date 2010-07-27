From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 15:58:33 -0400
Message-ID: <20100727195832.GA11717@coredump.intra.peff.net>
References: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdqIS-0007Fa-Rv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab0G0T6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 15:58:36 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55367 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0G0T6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 15:58:35 -0400
Received: (qmail 17774 invoked by uid 111); 27 Jul 2010 19:58:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 27 Jul 2010 19:58:34 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jul 2010 15:58:33 -0400
Content-Disposition: inline
In-Reply-To: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151980>

On Mon, Jul 26, 2010 at 06:39:51PM +0200, Matthieu Moy wrote:

> The behavior of "git ls-files -t" is very misleading (see
> http://thread.gmane.org/gmane.comp.version-control.git/126516 and
> http://thread.gmane.org/gmane.comp.version-control.git/144394/focus=144397
> for examples of mislead users) and badly documented, hence we point the
> users to superior alternatives.

I agree with the goal, but one nit:

>  -t::
> +	This feature is semi-deprecated. For scripting purpose,
> +	linkgit:git-status[1] `--porcelain` is almost always a
> +	superior alternative, and users should look at
> +	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
> +	`--name-status` for more user-friendly alternatives.

Isn't "git diff-files --name-status" the closest plumbing analogue? Git
status actually does a lot of extra work.

Also, while testing this, I got confused. Does "ls-files -t" even work,
or am I totally misunderstanding it? I tried:

  mkdir repo && cd repo && git init &&
  echo content >file1 &&
  echo content >file2 &&
  git add . &&
  git commit -m one &&
  echo content >>file1 &&
  echo content >>file2 &&
  git add file1 &&
  git ls-files -t

which yields:

  H file1
  H file2

Shouldn't one of them be marked "C"hanged (I think file2, but that was
what I was double-checking)?

-Peff
