From: Jeff King <peff@peff.net>
Subject: Re: [Patch 3/5] Create html documents for all files in
 Documentation/RelNotes
Date: Sat, 6 Oct 2012 15:21:05 -0400
Message-ID: <20121006192105.GA17895@sigill.intra.peff.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker66@arcor.de>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZwF-0006PX-Bo
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab2JFTVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 15:21:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43176 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab2JFTVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:21:09 -0400
Received: (qmail 10134 invoked by uid 107); 6 Oct 2012 19:21:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 15:21:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 15:21:05 -0400
Content-Disposition: inline
In-Reply-To: <343092834.269729.1349538958985.JavaMail.ngmail@webmail08.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207170>

On Sat, Oct 06, 2012 at 05:55:58PM +0200, Thomas Ackermann wrote:

> - create html for all release note files
> [...]
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 86594f6..80eb06d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -24,6 +24,7 @@ SP_ARTICLES = user-manual
>  SP_ARTICLES += howto/revert-branch-rebase
>  SP_ARTICLES += howto/using-merge-subtree
>  SP_ARTICLES += howto/using-signed-tag-in-pull-request
> +RELNOTES = $(patsubst %.txt,%,$(wildcard RelNotes/*.txt))
>  API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
>  API_DOCS += technical/index-format
>  API_DOCS += technical/pack-format
> @@ -35,6 +36,7 @@ API_DOCS += technical/racy-git
>  API_DOCS += technical/send-pack-pipeline
>  API_DOCS += technical/shallow
>  API_DOCS += technical/trivial-merge
> +API_DOCS += $(RELNOTES)

Yuck. This means that anyone generating the html documentation will have
to format all of the release notes, too, even though they are much less
likely to be useful[1]. If this is only useful for the fullpdf target,
can we omit it from the regular html target (and maybe add a "relnotes"
target or something for people who really want them formatted)?

-Peff

[1] I would not be surprised if they do not actually format all that
    well. Though they are written in an asciidoc-ish style, they have
    not traditionally been formatted, and I suspect there are many small
    errors (like improper quoting of metacharacters) in them.
