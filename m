From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Fix probing for already installed Error.pm
Date: Fri, 30 Jun 2006 00:28:08 -0700
Message-ID: <7vfyhnksqf.fsf@assigned-by-dhcp.cox.net>
References: <20060630050923.701.37665.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 09:28:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDQF-00040r-0k
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWF3H2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWF3H2L
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:28:11 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:32728 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750852AbWF3H2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:28:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630072809.QMY16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 03:28:09 -0400
To: Pavel Roskin <proski@gnu.org>, Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060630050923.701.37665.stgit@dv.roinet.com> (Pavel Roskin's
	message of "Fri, 30 Jun 2006 01:09:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22963>

Pavel Roskin <proski@gnu.org> writes:

> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index d401a66..b3fbb73 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -12,7 +12,7 @@ my %pm = ('Git.pm' => '$(INST_LIBDIR)/Gi
>  
>  # We come with our own bundled Error.pm. It's not in the set of default
>  # Perl modules so install it if it's not available on the system yet.
> -eval { require 'Error' };
> +eval { require Error };
>  if ($@) {
>  	$pm{'Error.pm'} = '$(INST_LIBDIR)/Error.pm';
>  }

The syntax updates is correct, but this is still wrong, I am
afraid.

It is trying to see if we need to install the Error.pm we ship
just in case the system does not have Error.pm available.  But
this script is run in perl/ directory where we have that private
copy of Error.pm, so "require Error" always succeeds, eh, at
least after you fixed the above syntax error X-<.
