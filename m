From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Send XHTML as 'application/xhtml+xml' where possible
Date: Sun, 09 Jul 2006 03:36:28 -0700
Message-ID: <7vwtanm5eb.fsf@assigned-by-dhcp.cox.net>
References: <11524381182709-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 12:36:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzWel-0008WD-7P
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 12:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWGIKgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 06:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWGIKgv
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 06:36:51 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7300 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030447AbWGIKgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 06:36:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709103648.HUCS985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 06:36:48 -0400
To: Alp Toker <alp@atoker.com>
In-Reply-To: <11524381182709-git-send-email-alp@atoker.com> (Alp Toker's
	message of "Sun, 09 Jul 2006 10:41:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23544>

Alp Toker <alp@atoker.com> writes:

> "The 'text/html' media type [RFC2854] is primarily for HTML, not for
> XHTML. In general, this media type is NOT suitable for XHTML."
>
> This patch makes gitweb use content negotiation to conservatively send
> pages as Content-Type 'application/xhtml+xml' when the user agent
> explicitly claims to support it.

Ok.

> It falls back to 'text/html' even if the user agent claims to support
> 'application/xhtml+xml' by means of a glob in order to work around an
> insidious Internet Explorer bug.

I do not care much about IE, but...

> +	my $content_type = ($cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') ne 0) ? 'application/xhtml+xml' : 'text/html';

1. I would prefer something like this to be written with if-else,
   not with a conditional expression;

2. The "by means of a glob" hack needs to be left as a comment
   in the code to say why;

3. Did you really mean to say "ne 0"?
