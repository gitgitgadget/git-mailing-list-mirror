From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] combine-diff.c remove unused return variable
Date: Sun, 13 Aug 2006 18:01:33 -0700
Message-ID: <7voduogmfm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608131730470.24283@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 03:01:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCQpp-0002le-Bw
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 03:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWHNBBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 21:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWHNBBf
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 21:01:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:16631 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751235AbWHNBBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 21:01:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814010134.TXBE12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 21:01:34 -0400
To: dave rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608131730470.24283@chino.corp.google.com> (dave
	rientjes's message of "Sun, 13 Aug 2006 17:31:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25305>

dave rientjes <rientjes@google.com> writes:

> Removes unused return variable.

True.  Then making the function void would make more sense, like
this?


diff --git a/combine-diff.c b/combine-diff.c
index ba8baca..f2f3806 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -609,15 +609,15 @@ static void dump_quoted_path(const char 
 	printf("%s\n", c_reset);
 }
 
-static int show_patch_diff(struct combine_diff_path *elem, int num_parent,
-			   int dense, struct rev_info *rev)
+static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
+			    int dense, struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
 	unsigned long result_size, cnt, lno;
 	char *result, *cp;
 	struct sline *sline; /* survived lines */
 	int mode_differs = 0;
-	int i, show_hunks, shown_header = 0;
+	int i, show_hunks;
 	int working_tree_file = !memcmp(elem->sha1, null_sha1, 20);
 	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
@@ -769,7 +769,6 @@ static int show_patch_diff(struct combin
 	}
 	free(sline[0].p_lno);
 	free(sline);
-	return shown_header;
 }
 
 #define COLONS "::::::::::::::::::::::::::::::::"
