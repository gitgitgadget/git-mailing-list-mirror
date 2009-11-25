From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 17:53:19 -0500
Message-ID: <20091125225318.GA10127@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
 <7vtywiqmbs.fsf@alter.siamese.dyndns.org>
 <20091125222625.GB2861@coredump.intra.peff.net>
 <4B0DB29D.5010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQjk-0001do-0a
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbZKYWxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbZKYWxM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:53:12 -0500
Received: from peff.net ([208.65.91.99]:42815 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbZKYWxL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:53:11 -0500
Received: (qmail 17092 invoked by uid 107); 25 Nov 2009 22:57:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 17:57:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 17:53:19 -0500
Content-Disposition: inline
In-Reply-To: <4B0DB29D.5010101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133693>

On Wed, Nov 25, 2009 at 05:41:33PM -0500, A Large Angry SCM wrote:

> >I agree with all of this as far as changing the default goes. But the
> >point of my earlier messages was that I don't think there _is_ one sane
> >default. I really do want it different per-project. And that means a
> >configuration option.
> 
> Since grep is so useful, both interactively and scripted, outside of
> git, this is a pretty convincing argument that git-grep, and all
> other git commands with configurable behavior or defaults that change
> over time, need a both a scripting form and an interactive form.

It is tempting to have scripts simply set a GIT_VANILLA environment
variable to ignore config options. But I think it is not quite so
simple. As a script, if I am calling "git log", do I want it to respect
the user's colorization config or not? It depends on _how_ I am calling
it. Is the output to be shown to the user, or am I going to process it
myself?

Similarly, why is the script calling "git grep"? If it is because the
script is a convenience wrapper (e.g., let's say to colorize the output
in a particular way), then it probably wants to respect my configured
choice of which files to grep. But if the script is just using "git
grep" to get data to perform some other calculation, then it probably
does care deeply about which set of files to grep.

So I think you have situations where scripts do want to invoke the
porcelain version of a command versus the plumbing. But much harder, you
have ones where they want to respect some options but not others.

-Peff
