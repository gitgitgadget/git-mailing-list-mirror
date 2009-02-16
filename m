From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch -d: Export GIT_DIR earlier
Date: Mon, 16 Feb 2009 14:42:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161441190.6289@intel-tinevez-2-302>
References: <20090216130951.GA3769@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 14:44:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ3lK-0006d6-Vo
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 14:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbZBPNm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 08:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbZBPNm1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 08:42:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:40774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754795AbZBPNm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 08:42:26 -0500
Received: (qmail invoked by alias); 16 Feb 2009 13:42:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp025) with SMTP; 16 Feb 2009 14:42:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5CNhRH2b5tMu+Gy51268OYRULy6kRii+TShNhO+
	iPQqW5bWYgnFMF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090216130951.GA3769@lars.home.noschinski.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110178>

Hi,

On Mon, 16 Feb 2009, Lars Noschinski wrote:

> The improved error handling catches a bug in filter-branch when using
> -d pointing to a path outside any git repository:
> 
> $ mkdir foo
> $ cd foo
> $ git init
> $ touch bar
> $ git add bar
> $ git commit -m bar
> $ cd ..
> $ git clone --bare foo
> $ cd foo.git
> $ git filter-branch -d /tmp/filter master
> fatal: Not a git repository (or any of the parent directories): .git
> 
> This error message comes from git for-each-ref in line 224. GIT_DIR is
> set correctly by git-sh-setup (to the foo.git repository), but not
> exported (yet).

Thanks.

> ---
> 
> This fix is not yet ready for commit, as it lacks a test case.
> 
> Writing a test case for this bug, I wonder about the preferred way to use a
> directory outside any git repository in a test: Using some directory below
> git/t/ will not work, as (in most cases) git is a git repository.

How about using a filter-branch call with a filter that echoes GIT_DIR 
into a file, then fails, and then checking the exact contents of GIT_DIR?

Ciao,
Dscho
