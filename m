From: Greg Price <price@MIT.EDU>
Subject: [PATCH] add: cut redundant require_pathspec logic
Date: Wed, 6 Mar 2013 02:24:21 -0500
Message-ID: <20130306072414.GA15534@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 08:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD8ia-0002lL-CD
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 08:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab3CFHY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 02:24:26 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:62383 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751369Ab3CFHYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 02:24:25 -0500
X-AuditID: 12074425-b7fec6d000007584-cc-5136ef28132e
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BE.B2.30084.82FE6315; Wed,  6 Mar 2013 02:24:25 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id r267ON7B028697;
	Wed, 6 Mar 2013 02:24:24 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r267OL0m018856;
	Wed, 6 Mar 2013 02:24:22 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixCmqrKv53izQ4MR3JouuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj3J3Qgp1cFS9b77M1MO7k6GLk5JAQMJH4M+8z
	C4QtJnHh3no2EFtIYB+jxKNd+l2MXED2BkaJOds+M0I4nxglzl3fztrFyMHBIqAisei0FUgD
	m4CCxI/565hBbBEBcYm3x2eyg9jMAmoS7ZumsILYwgJWEou3rANbxitgLbFh5jEoW1Di5Mwn
	LBD1WhI3/r1kAhnPLCAtsfwf2J2iQJuu7W9nm8DIPwtJxywkHbMQOhYwMq9ilE3JrdLNTczM
	KU5N1i1OTszLSy3StdDLzSzRS00p3cQICkJ2F9UdjBMOKR1iFOBgVOLhnaFtFijEmlhWXJl7
	iFGSg0lJlPfbK6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV6uM0A53pTEyqrUonyYlDQHi5I4
	742Um/5CAumJJanZqakFqUUwWRkODiUJXuZ3QI2CRanpqRVpmTklCGkmDk6Q4TxAwzVBaniL
	CxJzizPTIfKnGBWlxHllQRICIImM0jy4XliSeMUoDvSKMO/7t0BVPMAEA9f9CmgwE9Bgj1AT
	kMEliQgpqQZGs/MXHfz6jOLYFUXLrVelq7BIpUSc+WdxUjXZoEFy9qSgjSybGGLSfjZNPnA8
	XayqW2LyFJn36QU7dj1T/NM8+a3WYekn1w6+frX5i/q9/XLrHmQzMr9ZavF2K8dx7fa1U9hf
	/3dPMS1ZpNMw61ZqRdBKv7O6B121fQLesS23aj8w6Rznhe9pSizFGYmGWsxFxYkA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217498>

If take_worktree_changes is true, then the logic around
option_with_implicit_dot ensures argc is positive by this point.
So require_pathspec never has an effect.

Signed-off-by: Greg Price <price@mit.edu>
---
 builtin/add.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0dd014e..9feb2ba 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -358,7 +358,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	int flags;
 	int add_new_files;
-	int require_pathspec;
 	char *seen = NULL;
 	const char *option_with_implicit_dot = NULL;
 	const char *short_option_with_implicit_dot = NULL;
@@ -399,7 +398,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	add_new_files = !take_worktree_changes && !refresh_only;
-	require_pathspec = !take_worktree_changes;
 
 	newfd = hold_locked_index(&lock_file, 1);
 
@@ -410,7 +408,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (!(addremove || take_worktree_changes)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
-	if (require_pathspec && argc == 0) {
+	if (argc == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
 		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
-- 
1.7.11.3
