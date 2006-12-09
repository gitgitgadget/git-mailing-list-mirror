X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sat, 09 Dec 2006 13:59:14 -0800
Message-ID: <7vpsas91e5.fsf@assigned-by-dhcp.cox.net>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612082141260.2630@xanadu.home>
	<7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612091517010.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 21:59:48 +0000 (UTC)
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612091517010.2630@xanadu.home> (Nicolas Pitre's
	message of "Sat, 09 Dec 2006 16:15:42 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33840>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtAEL-0007nk-Lc for gcvg-git@gmane.org; Sat, 09 Dec
 2006 22:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758519AbWLIV71 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 16:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758682AbWLIV71
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 16:59:27 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59923 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758519AbWLIV7P (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 16:59:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209215914.BYFZ22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 16:59:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id wlzR1V0081kojtg0000000; Sat, 09 Dec 2006
 16:59:25 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

>> +Note that the contents of the paths that resolved cleanly by a
>> +conflicted merge are automatically staged for the next commit;
>> +you still need to explicitly identify what you want in the
>> +resulting commit using one of the above methods before
>> +recording the merge commit.
>
> Like I said in another mail,...IMHO the merge 
> example included further down should be sufficient information wrt 
> committing a merge.

You are right --- removed.

>>  -o|--only::
>> -	Commit only the files specified on the command line.
>> -	This format cannot be used during a merge, nor when the
>> -	index and the latest commit does not match on the
>> -	specified paths to avoid confusion.
>> +	Commit only the files specified on the command line;
>> +	this is the default when pathnames are given on the
>> +	command line, so you usually do not have to give this
>> +	option.  This format cannot be used during a merge.
>
> Is there some value in keeping this option documented?  What about 
> removing it (the documentation not the option)?

True, although the description of <files>... need to be
clarified if we do this.

>> +When recording your own work, the contents of modified files in
>> +your working tree are temporarily stored to a staging area
>> +called the "index" with gitlink:git-add[1].  Removal
>
> I like the way the index is introduced at this point.

Credit owed to JBF.

> I'd add (with links):
>
> SEE ALSO
> --------
> git-add, git-rm, git-mv, git-merge, git-commit-tree

Done.

Attached is an incremental patch on top of what you commented
on.

-- >8 --

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8fe42cb..20a2cb3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -34,12 +34,6 @@ methods:
    changes from all known files i.e. files that have already been committed
    before, and perform the actual commit.
 
-Note that the contents of the paths that resolved cleanly by a
-conflicted merge are automatically staged for the next commit;
-you still need to explicitly identify what you want in the
-resulting commit using one of the above methods before
-recording the merge commit.
-
 The gitlink:git-status[1] command can be used to obtain a
 summary of what is included by any of the above for the next
 commit by giving the same set of parameters you would give to
@@ -119,19 +113,15 @@ but can be used to amend a merge commit.
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
--o|--only::
-	Commit only the files specified on the command line;
-	this is the default when pathnames are given on the
-	command line, so you usually do not have to give this
-	option.  This format cannot be used during a merge.
-
 \--::
 	Do not interpret any more arguments as options.
 
 <file>...::
-	Files to be committed.  The meaning of these is
-	different between `--include` and `--only`.  Without
-	either, it defaults `--only` semantics.
+	When files are given on the command line, the command
+	commits the contents of the named files, without
+	recording the changes already staged.  The contents of
+	these files are also staged for the next commit on top
+	of what have been staged before.
 
 
 EXAMPLES
@@ -240,6 +230,15 @@ This command can run `commit-msg`, `pre-commit`, and
 `post-commit` hooks.  See link:hooks.html[hooks] for more
 information.
 
+
+SEE ALSO
+--------
+gitlink:git-add[1],
+gitlink:git-rm[1],
+gitlink:git-mv[1],
+gitlink:git-merge[1],
+gitlink:git-commit-tree[1]
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and
