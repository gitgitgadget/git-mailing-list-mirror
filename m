From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found  by the clang static analyzer
Date: Sat, 26 Sep 2009 23:42:33 +0200
Message-ID: <87bpkxcrhy.fsf@master.homenet>
References: <87ab0hepcn.fsf@master.homenet>
	<alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	<871vltefdj.fsf@master.homenet>
	<fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	<87ske9cya9.fsf@master.homenet>
	<20090926204604.GA2960@coredump.intra.peff.net>
	<3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
	<20090926211220.GA3387@coredump.intra.peff.net>
	<3f4fd2640909261420h2588df4cld8dd3e49f9654e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrf2b-0002FE-EV
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbZIZVmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbZIZVmn
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:42:43 -0400
Received: from averell.mail.tiscali.it ([213.205.33.55]:38221 "EHLO
	averell.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbZIZVmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 17:42:42 -0400
Received: from master.homenet (84.223.203.227) by averell.mail.tiscali.it (8.0.022)
        id 4AA780C800768F4B; Sat, 26 Sep 2009 23:42:41 +0200
Received: from gscrivano by master.homenet with local (Exim 4.69)
	(envelope-from <gscrivano@gnu.org>)
	id 1Mrf2H-0005PE-De; Sat, 26 Sep 2009 23:42:33 +0200
In-Reply-To: <3f4fd2640909261420h2588df4cld8dd3e49f9654e9e@mail.gmail.com>
	(Reece Dunn's message of "Sat, 26 Sep 2009 22:20:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129183>

Reece Dunn <msclrhd@googlemail.com> writes:

>> There is exactly one caller, and it doesn't care about the return code
>> for the reasons mentioned above.
>
> Including being called from a script?

I agree, if something goes wrong then it should be reported.  The same
applies to the `run_receive_hook' return code that is not checked in
`cmd_receive_pack'.

Considering you want to keep the current source code invariants, and I
don't have any objection to it, probably the only assignment that can be
removed is the following one:

>From f8dd14bf4c3f3e132f6a8e13bf3e2fc575a804b1 Mon Sep 17 00:00:00 2001
From: Giuseppe Scrivano <gscrivano@gnu.org>
Date: Sat, 26 Sep 2009 23:23:13 +0200
Subject: [PATCH] Remove a dead assignment found by the clang static analyzer

---
 http-fetch.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index e8f44ba..6879904 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,7 +3,6 @@
 
 int main(int argc, const char **argv)
 {
-	const char *prefix;
 	struct walker *walker;
 	int commits_on_stdin = 0;
 	int commits;
@@ -19,7 +18,7 @@ int main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
-	prefix = setup_git_directory();
+	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
-- 
1.6.3.3
