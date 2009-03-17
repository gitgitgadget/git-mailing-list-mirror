From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
	current branch
Date: Tue, 17 Mar 2009 03:46:33 -0400
Message-ID: <20090317074633.GB18475@coredump.intra.peff.net>
References: <20090314205628.GA17445@coredump.intra.peff.net> <1237085349-14824-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 08:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjU20-00069i-BA
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 08:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbZCQHqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 03:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbZCQHqm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 03:46:42 -0400
Received: from peff.net ([208.65.91.99]:44834 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbZCQHql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 03:46:41 -0400
Received: (qmail 2688 invoked by uid 107); 17 Mar 2009 07:46:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 03:46:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 03:46:33 -0400
Content-Disposition: inline
In-Reply-To: <1237085349-14824-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113432>

On Sat, Mar 14, 2009 at 09:49:09PM -0500, Chris Johnsen wrote:

> 1) literals that contain a double quote
> 
> 	$ git grep '`[^`]*"[^`]`' | cat
> 	config.txt:You can have `[section]` if you have `[section "subsection"]`, but you
> 
>    There might be a better regexp to find these, I did not think
>    about it too long. The above "hit" seems like a reasonable
>    literal string. Maybe it is OK to live with this one
>    ("[section "subsection"]").

Hmm, good point. Something with typeface that could not be in the string
contents would probably be a better choice. The linkgit: links appear
bolded. We could do that. We could also try underlining, though that
might be hard to read if any strings contained underscores.

I tried to find examples of other manpages that faced the same problem.
I would guess that bold is the best bet (for example, the 'cat' manpage
on my system looks like (excuse my fake markup):

  -A, --show-all
      equivalent to <b>-vET</b>

> 2) manpage-1.72.xsl 
> 
>    I have been setting DOCBOOK_XSL_172 to avoid the ".ft" problem
>    (<http://article.gmane.org/gmane.comp.version-control.git/112943>;
>    my system is Mac OS X 10.4.11 with MacPorts asciidoc 8.3.1,
>    xmlto version 0.0.21, and docbook-xsl 1.74.0). Since non-null
>    DOCBOOK_XSL_172 replaces callouts.xsl with manpage-1.72.xsl, I
>    added the line to manpage-1.72.xsl.

The "callouts" XSL is obviously becoming more than that (there is
already a "I know, this is not a callout, but where else to put it?"
comment in it). It probably makes sense to rename it to manpage.xsl (or
even manpage-1.8.xsl), factor out common parts to manpage-base.xsl, and
then include the -base version from both manpage and manpage-1.72.xsl.

Want to do a patch?

-Peff
