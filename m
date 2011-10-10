From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Mon, 10 Oct 2011 11:53:14 -0700
Message-ID: <7vwrcck1jm.fsf@alter.siamese.dyndns.org>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
 <1318098723-12813-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:57:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDMuf-0002jS-S9
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 22:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1JJU5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 16:57:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59196 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab1JJU5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 16:57:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA0E47BD;
	Mon, 10 Oct 2011 16:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Kgu7IvcXvTHk4wpV6AskX0SxsnA=; b=MMW28ZKsadxd/wHzsg9a
	G1ElymPCnCG6gIYO+ZsvgFO0vmCcr6eRsEs2LfugDhz2jFJf5rxVOmYL1wyI/ULH
	iw1nnzw3yffRwWilYJTKVYHuX9vzF8HRb9MTN+NzgDrStnVH1469mdS+nWG/59qM
	n1Sg9XEQwfkMX2LWX5hpNBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mnXJU2X2OpRAVKePMs0UheP0QHpUZVPOPSwHX6rfjR5EeE
	llQVf6JYtPlKt2ibjhPQ/i2Oec+d30Yt5Wd59ewLvzYBG8GA9/5FMgblMl/woyrw
	59ISvf0zMTKw4fGgQz2TypCSu7eoVkCu2cvABS8fDPDvxd58BzN9UjGqMub+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 047AD47B2;
	Mon, 10 Oct 2011 16:57:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37D1A47B1; Mon, 10 Oct 2011
 16:57:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 713F644C-F382-11E0-9BA9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183257>

Jakub Narebski <jnareb@gmail.com> writes:

> This patch adds infrastructure for easy generation of only
> gitweb-related manpages.  It adds a currently empty 'gitweb-doc'
> target to Documentation/Makefile, and a 'doc' proxy target to
> gitweb/Makefile.

I tend to agree with your after-three-dash comment that this separation is
not necessary, it may be expedient while working on the series, but wants
to be removed once the series is complete.

> This way to build only gitweb documentation in both 'man' and 'html'
> formats one can use
>
>   make -C gitweb doc
>
> or
>
>   cd gitweb; make doc
>
> This somewhat follows the idea of 'full-svn-test' and 'gitweb-test' in
> t/Makefile.

It seems that this follows the idea backward in that the existing practice
fo full-svn-test (and valgrind test) is to allow _excluding_ stuff that
the user may not care about or the user cannot afford to run; in that
sense 'gitweb-test' target is also backwards.

> gitweb manpages would reside in the gitweb/ directory, "make doc"
> would invoke "make -C gitweb doc" to generate formatted docs.
>
> The gitweb.conf(5) and gitweb(1) manpages will be added in subsequent
> commits.
>
> [Commit message improved with help of Jonathan Nieder]
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This commit is not strictly necessary: it only adds "doc" target to
> gitweb/Makefile, and "gitweb-doc" target to Documentation/Makefile;
> neither is run when e.g. generating RPM.
>
> They are here because they would be here if documentation source was
> kept along with gitweb script in the 'gitweb/' subdirectory, and to
> make it easier and faster to test the changes.
>
>  Documentation/Makefile |    3 +++
>  gitweb/Makefile        |    7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6346a75..44be67b 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -170,6 +170,9 @@ info: git.info gitman.info
>  
>  pdf: user-manual.pdf
>  
> +GITWEB_DOC = $(filter gitweb.%,$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7))
> +gitweb-doc: $(GITWEB_DOC)
> +
>  install: install-man
>  
>  install-man: man
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 1c85b5f..3014d80 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -174,6 +174,11 @@ test-installed:
>  	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
>  		$(MAKE) -C ../t gitweb-test
>  
> +### Documentation
> +
> +doc:
> +	$(MAKE) -C ../Documentation gitweb-doc
> +
>  ### Installation rules
>  
>  install: all
> @@ -187,5 +192,5 @@ install: all
>  clean:
>  	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
>  
> -.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
> +.PHONY: all clean install test test-installed doc .FORCE-GIT-VERSION-FILE FORCE
