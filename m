From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] clone: allow --no-local to turn off local
 optimizations
Date: Wed, 30 May 2012 17:59:12 -0400
Message-ID: <20120530215912.GC3237@sigill.intra.peff.net>
References: <20120530110305.GA13445@sigill.intra.peff.net>
 <20120530111016.GB15550@sigill.intra.peff.net>
 <7vzk8pziuk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 23:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqvI-0000Xk-HR
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757350Ab2E3V7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 17:59:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36583
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757318Ab2E3V7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:59:15 -0400
Received: (qmail 10602 invoked by uid 107); 30 May 2012 21:59:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 17:59:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 17:59:12 -0400
Content-Disposition: inline
In-Reply-To: <7vzk8pziuk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198843>

On Wed, May 30, 2012 at 10:20:19AM -0700, Junio C Hamano wrote:

> By the way, a somewhat funny exercise I found last night is this:
> 
> 	$ cd /var/tmp
>         $ mkdir -p foo.xz:pub/git.git
>         $ cd foo.xz:pub/git.git
>         $ git init
>         $ git commit --allow-empty -m initial
>         $ cd /var/tmp
>         $ git clone foo.xz:pub/git.git x
> 
> This does not work as the transfer phase wants to run ssh on it.

Yeah, you would have to do file://$PWD/foo.xz:pub/git.git, I think. Of
course, there would be no way to specify "--local" while doing so... :)

Similarly, I find it a little odd that "git clone file:///foo.git" will
actually find a file named "file:/foo.git" before checking the URL (IOW,
the argument is a path first, and then fallback to URL). I suspect
nobody actually cares about either, as they are very unlikely corner
cases.

-Peff
