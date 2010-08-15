From: David Fries <david@fries.net>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
	<paths>
Date: Sun, 15 Aug 2010 08:02:45 -0500
Message-ID: <20100815130245.GB15631@spacedout.fries.net>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com> <20100814210505.GA2372@burratino> <7vvd7chcj4.fsf@alter.siamese.dyndns.org> <87tymwzjbk.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	??var Arnfj??r?? Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Ralf Ebert <info@ralfebert.de>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 15 17:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkfI0-0005sA-Uj
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab0HOPiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 11:38:18 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:40982 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab0HOPiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 11:38:17 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7FD2lhN032586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 Aug 2010 08:02:47 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id o7FD2jWQ032585;
	Sun, 15 Aug 2010 08:02:45 -0500
Content-Disposition: inline
In-Reply-To: <87tymwzjbk.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (SpacedOut.fries.net [127.0.0.1]); Sun, 15 Aug 2010 08:02:47 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153604>

On Sun, Aug 15, 2010 at 11:43:59AM +0900, Miles Bader wrote:
> On a similar note, how about a more helpful error message for
> "git reset --hard PATH"?  It took me _ages_ to figure out that I
> needed to do "git checkout PATH" to get that effect...

There's also the mixed reset in a bare repository message that could
use an update.

-- 
David Fries <david@fries.net>
http://fries.net/~david/ (PGP encryption key available)

>From fe5837d9222a621c081e22685db65adab32207f6 Mon Sep 17 00:00:00 2001
From: David Fries <david@fries.net>
Date: Fri, 2 Jul 2010 09:12:47 -0500
Subject: [PATCH] reset --mixed message update, tell the user what will work

Instead of,
fatal: mixed reset is not allowed in a bare repository
print,
fatal: mixed reset is not allowed in a bare repository, use --soft
To tell the user what they can do, instead of just what they can't.
---
 builtin/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..ebbefe0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
-		die("%s reset is not allowed in a bare repository",
+		die("%s reset is not allowed in a bare repository, use --soft",
 		    reset_type_names[reset_type]);
 
 	/* Soft reset does not touch the index file nor the working tree
-- 
1.7.1
