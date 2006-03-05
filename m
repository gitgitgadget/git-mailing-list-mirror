From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/emacs/Makefile: Provide tool for byte-compiling files.
Date: Sun, 05 Mar 2006 11:28:53 -0800
Message-ID: <7v1wxgheru.fsf@assigned-by-dhcp.cox.net>
References: <20060305161431.23622.20032.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 20:29:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFyuY-0007im-Lf
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 20:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWCET2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 14:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWCET2z
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 14:28:55 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60134 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750936AbWCET2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 14:28:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305192504.NXKH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 14:25:04 -0500
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <20060305161431.23622.20032.stgit@metalzone.distorted.org.uk>
	(Mark Wooding's message of "Sun, 05 Mar 2006 16:14:31 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17239>

Alexandre, this looks good to me, so I'll be applying it.

-jc

Mark Wooding <mdw@distorted.org.uk> writes:

> From: Mark Wooding <mdw@distorted.org.uk>
>
> Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
> ---
>
>  contrib/emacs/.gitignore |    1 +
>  contrib/emacs/Makefile   |   20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
> new file mode 100644
> index 0000000..c531d98
> --- /dev/null
> +++ b/contrib/emacs/.gitignore
> @@ -0,0 +1 @@
> +*.elc
> diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
> new file mode 100644
> index 0000000..d3619db
> --- /dev/null
> +++ b/contrib/emacs/Makefile
> @@ -0,0 +1,20 @@
> +## Build and install stuff
> +
> +EMACS = emacs
> +
> +ELC = git.elc vc-git.elc
> +INSTALL = install
> +INSTALL_ELC = $(INSTALL) -m 644
> +prefix = $(HOME)
> +emacsdir = $(prefix)/share/emacs/site-lisp
> +
> +all: $(ELC)
> +
> +install: all
> +	$(INSTALL) -d $(emacsdir)
> +	$(INSTALL_ELC) $(ELC) $(emacsdir)
> +
> +%.elc: %.el
> +	$(EMACS) --batch --eval '(byte-compile-file "$<")'
> +
> +clean:; rm -f $(ELC)
