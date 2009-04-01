From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-clone.c: fix memory leak in cmd_clone()
Date: Wed, 1 Apr 2009 17:56:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904011754250.13502@intel-tinevez-2-302>
References: <20090401144056.GC2237@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ali Gholami Rudi <ali@rudi.ir>
X-From: git-owner@vger.kernel.org Wed Apr 01 17:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp2pQ-0007lh-Dj
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 17:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbZDAP4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754945AbZDAP4j
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 11:56:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:36052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751878AbZDAP4j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 11:56:39 -0400
Received: (qmail invoked by alias); 01 Apr 2009 15:56:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 01 Apr 2009 17:56:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/K/wpgboDKY1AswXPaCtvtmtSjNET4TAE0tSkaWq
	GbRFeU81+BllKQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090401144056.GC2237@lilem.mirepesht>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115395>

Hi,

On Wed, 1 Apr 2009, Ali Gholami Rudi wrote:

> With this patch, cmd_clone() safely frees its xstrdup()-allocated
> memory.  Also junk_work_tree and junk_git_dir (used in remove_junk()
> which is called asynchronously) were changed to use static arrays rather
> than sharing the memory allocated in cmd_clone().

If you want to go down that route, you will have a long way to go: the 
assumption is pretty much in every cmd_() and main() function that 
singletons will be free()d automatically when the process ends.

Ciao,
Dscho
