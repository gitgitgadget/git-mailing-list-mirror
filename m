From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Fri, 2 Oct 2009 10:42:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910021042110.18640@intel-tinevez-2-302>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091002061159.GA24892@coredump.intra.peff.net> <20091002073628.GA9444@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtdix-0006Is-W3
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295AbZJBImi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbZJBImi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:42:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:32966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757284AbZJBImh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:42:37 -0400
Received: (qmail invoked by alias); 02 Oct 2009 08:42:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 02 Oct 2009 10:42:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eoHI838ieBA6XTdm9T81YA0OWyzgfmpMbKvvcXZ
	K2O5kgFQvLNeoC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091002073628.GA9444@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129434>

Hi,

On Fri, 2 Oct 2009, Clemens Buchacher wrote:

> On Fri, Oct 02, 2009 at 02:11:59AM -0400, Jeff King wrote:
> 
> > So I don't feel _too_ strongly. I am just concerned that we are 
> > introducing some DWYM magic that is not really going to help many 
> > people out, and is just going to make understanding the rules for 
> > option parsing more complex, and introduce the possibility (albeit 
> > slim) of breaking people's scripts and trained fingers.
> 
> But it makes the rules simpler, because it removes ambiguities such as 
> the one above.
> 
> Yes, we deliberately allow users to shoot themselves in the foot. But 
> they should have to use at least a long option to do it.

Something like this?

-- snipsnap --
[PATCH] Deliberately allow users to shoot themselves in the foot

But they should have to use at least a long option to do it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 9883009..e7cb946 100644
--- a/git.c
+++ b/git.c
@@ -122,6 +122,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--shoot-me-in-the-foot")) {
+			warning ("Bang, bang!");
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- 
1.6.4.297.gcb4cc
