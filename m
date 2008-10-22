From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 1/5] add valgrind support in test scripts
Date: Thu, 23 Oct 2008 00:13:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810230008430.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081022202810.GA4439@coredump.intra.peff.net> <20081022202915.GA4547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 00:08:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksls3-0002iH-68
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 00:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbYJVWGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 18:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820AbYJVWGv
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 18:06:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:42136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759101AbYJVWGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 18:06:50 -0400
Received: (qmail invoked by alias); 22 Oct 2008 22:06:48 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 23 Oct 2008 00:06:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FJOEpNzZFEEdUiiCK9FBBVrtWQpzs9b6Ny105GJ
	Air9QZL+qJ5PVf
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081022202915.GA4547@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98919>

Hi,

On Wed, 22 Oct 2008, Jeff King wrote:

> diff --git a/Makefile b/Makefile
> index d6f3695..68f0172 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1343,7 +1345,12 @@ all:: $(TEST_PROGRAMS)
>  
>  export NO_SVN_TESTS
>  
> -test: all
> +valgrind-setup: $(patsubst %.sh,%,$(VALGRIND_SH))
> +	rm -rf t/valgrind/bin
> +	mkdir t/valgrind/bin
> +	for i in git $(PROGRAMS); do cp test-valgrind t/valgrind/bin/$$i; done

I wonder if it would not be better to scrap the t/valgrind/ directory and 
regenerate it everytime you run a test manually; I'd use "ln" instead of 
"cp", and also parse command-list.txt to catch really all of them (even if 
a dashed form is used for a builtin by mistake).

Otherwise: good work, I like it!

Ciao,
Dscho
