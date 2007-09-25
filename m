From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] unexpected Make output (e.g. from --debug) causes build failure
Date: Tue, 25 Sep 2007 09:59:29 +0200
Message-ID: <86zlzbrx9a.fsf@lola.quinscape.zz>
References: <877imftfef.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 10:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia5Ks-0005IM-An
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 10:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbXIYH74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 03:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXIYH74
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 03:59:56 -0400
Received: from main.gmane.org ([80.91.229.2]:56239 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbXIYH7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 03:59:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ia5KS-0003Ad-5E
	for git@vger.kernel.org; Tue, 25 Sep 2007 07:59:36 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 07:59:36 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 07:59:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:Whr/UmSLejLpco4n/epA8NzStRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59100>

Jim Meyering <jim@meyering.net> writes:

> Without this, the extra output produced e.g., by "make --debug"
> would go into $INSTLIBDIR and then cause the sed command to fail.
>
> Signed-off-by: Jim Meyering <jim@meyering.net>
> ---
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 0055eef..97ce687 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -805,7 +805,7 @@ perl/perl.mak: GIT-CFLAGS
>
>  $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> -	INSTLIBDIR=`$(MAKE) -C perl -s --no-print-directory instlibdir` && \
> +	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>  	sed -e '1{' \
>  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>  	    -e '	h' \
> --
> 1.5.3.2.99.ge4b2-dirty

Does this work with "make -n" ?

-- 
David Kastrup
