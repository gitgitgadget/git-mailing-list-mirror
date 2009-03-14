From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Sat, 14 Mar 2009 12:53:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de> <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302> <20090313172002.GA16232@neumann>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1248069994-1237031587=:10279"
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <alturin@gmail.com>
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Mar 14 12:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiSQB-0002EB-Jd
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 12:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbZCNLvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 07:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756341AbZCNLvX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 07:51:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:51718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756569AbZCNLvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 07:51:22 -0400
Received: (qmail invoked by alias); 14 Mar 2009 11:51:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 14 Mar 2009 12:51:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DhnU2wpTDWjxsPvsN6q8JNPb8Be9Enn6vH6hr/J
	EkE3yRg4zGqyHw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090313172002.GA16232@neumann>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113245>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1248069994-1237031587=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 13 Mar 2009, SZEDER Gábor wrote:

> diff --git a/t/Makefile b/t/Makefile
> index 0d65ced..2e6e205 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -14,14 +14,11 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
>  TSVN = $(wildcard t91[0-9][0-9]-*.sh)
>  
> -all: pre-clean $(T) aggregate-results clean
> +all: $(T) aggregate-results clean
>  
>  $(T):
>  	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
>  
> -pre-clean:
> -	$(RM) -r test-results
> -
>  clean:
>  	$(RM) -r 'trash directory' test-results
>  
> @@ -33,5 +30,5 @@ full-svn-test:
>  	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
>  	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
>  
> -.PHONY: pre-clean $(T) aggregate-results clean
> +.PHONY: $(T) aggregate-results clean
>  .NOTPARALLEL:

This is wrong.  If you have failing tests, or if you interrupt the tests, 
it will never clean the test results, and after Hannes' patch you _will_ 
have stale files lying around all the time.

I'd rather not have this change.

Ciao,
Dscho

--8323328-1248069994-1237031587=:10279--
