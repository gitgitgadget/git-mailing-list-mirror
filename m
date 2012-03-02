From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH] build: avoid possible confusion between GNU/XPG4 make on Solaris
Date: Fri, 2 Mar 2012 10:34:31 +0100
Message-ID: <87obsfcpnc.fsf@thomas.inf.ethz.ch>
References: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:34:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Oss-00040x-4J
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 10:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab2CBJeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 04:34:37 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:52364 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910Ab2CBJee (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 04:34:34 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 10:34:30 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 10:34:31 +0100
In-Reply-To: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com>
	(Stefano Lattarini's message of "Fri, 2 Mar 2012 10:13:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192018>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> +# FIXME: this is ugly, and which(1) is quite unportable.  Find a better
> +# 	 way to obtain the same effect.
> +MAKE := $(shell set $(MAKE); m1=$$1; shift; \
> +                m2=`which $$m1 2>/dev/null` && test -n "$$m2" || m2=$$m1; \
> +                echo "$$m2 $$*")

There's 'command -v make'.  'man 1p command' on my system (opensuse
installs a bunch of POSIX reference material) says

       -v     (On  systems  supporting  the  User  Portability Utilities
              option.) Write a string to standard output that  indicates
              the pathname or command that will be used by the shell, in
              the current shell execution environment (see Shell  Execu-
              tion  Environment  ),  to  invoke command_name, but do not
              invoke command_name.

               * Utilities, regular  built-in  utilities,  command_names
                 including  a  slash  character, and any implementation-
                 defined functions that are found using the  PATH  vari-
                 able  (as  described in Command Search and Execution ),
                 shall be written as absolute pathnames.

So perhaps enough systems including Solaris "support the User
Portability Utilities option", and you can use this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
