From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 18:02:52 +0200
Message-ID: <20080808160252.GA8541@leksak.fem-net>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080808153624.GA28716@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRURa-0004dE-TR
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYHHQC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYHHQC4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:02:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:43826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbYHHQC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:02:56 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:02:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp065) with SMTP; 08 Aug 2008 18:02:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/9oh0cZdb9qsPZaVU5yL2ju1fCQVEy63YvOTv/QQ
	Vd0QXtkz35mg6A
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KRUQW-0002Jf-St; Fri, 08 Aug 2008 18:02:52 +0200
Content-Disposition: inline
In-Reply-To: <20080808153624.GA28716@neumann>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91685>

Hi,

> There are a few tests involving http transfers, namely:
>   t5540-http-push.sh
>   t9115-git-svn-dcommit-funky-renames.sh 
>   t9118-git-svn-funky-branch-names.sh
>   t9120-git-svn-clone-with-percent-escapes.sh
> 
> These start an apache web server at the beginning of the test and shut
> it down after the test finished.  Obviously, if you run tests in
> parallel then these tests can also run concurrently.  The problem is
> with the svn tests, as all those tests use the same directory and port
> for the web server, resulting in failed tests with -jN.
> 
> t5540 is not an issue at the moment, as it uses lib-httpd.sh, hence a
> different directory and a (possibly) different port than the svn
> tests.  However, who knows, in the future we might have other tests
> using lib-httpd.sh.
> 
> The simplest solution would be to disable parallel testing altogether
> if http tests are enabled (GIT_TEST_HTTPD and SVN_HTTPD_PORT).

Hm, another simple(?) solution could be to make the tests that try to
access the same port/directory/whatever depend on each other.
Well, this could bloat the Makefile, but seems to be clean (at least to
me).

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
