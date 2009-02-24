From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH v2] bash completion: add --format= and --oneline options for "git log"
Date: Tue, 24 Feb 2009 15:33:29 +0200
Message-ID: <87zlgcq7rq.fsf_-_@iki.fi>
References: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	<7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	<7vljrxveqa.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
	<94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
	<7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
	<20090224130626.6117@nanako3.lavabit.com>
	<20090224045041.GA4615@coredump.intra.peff.net>
	<7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
	<20090224054524.GE4615@coredump.intra.peff.net>
	<20090224185913.6117@nanako3.lavabit.com> <871vtonlmv.fsf_-_@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com, "Shawn O. Pearce" <spearce@spearce.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 14:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbxRO-00072L-Ri
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 14:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbZBXNdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 08:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbZBXNdi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 08:33:38 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:49383 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbZBXNdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 08:33:37 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC905770494; Tue, 24 Feb 2009 15:33:33 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LbxPd-0000xm-3w; Tue, 24 Feb 2009 15:33:29 +0200
In-Reply-To: <871vtonlmv.fsf_-_@iki.fi> (Teemu Likonen's message of "Tue\, 24 Feb 2009 13\:02\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111286>

We also add --format= completion for "git show".

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

On 2009-02-24 13:02 (+0200), Teemu Likonen wrote:

> I like this change and would immediately switch to using --format= and
> --oneline instead of --pretty=. I think we should add these bash
> completions too.

And let's add --format= completion for "git show" too. I think --oneline
completion is not needed with "git show" even though it works.

This patch replaces my previous one.



 contrib/completion/git-completion.bash |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a3092f..31608cb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1012,10 +1012,15 @@ _git_log ()
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=}"
 		return
 		;;
+	--format=*)
+		__gitcomp "$__git_log_pretty_formats
+			" "" "${cur##--format=}"
+		return
+		;;
 	--date=*)
 		__gitcomp "
 			relative iso8601 rfc2822 short local default
 		" "" "${cur##--date=}"
 		return
@@ -1027,11 +1032,11 @@ _git_log ()
 			$__git_log_gitk_options
 			--root --topo-order --date-order --reverse
 			--follow
 			--abbrev-commit --abbrev=
 			--relative-date --date=
-			--pretty=
+			--pretty= --format= --oneline
 			--cherry-pick
 			--graph
 			--decorate
 			--walk-reflogs
 			--parents --children
@@ -1539,12 +1544,17 @@ _git_show ()
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=}"
 		return
 		;;
+	--format=*)
+		__gitcomp "$__git_log_pretty_formats
+			" "" "${cur##--format=}"
+		return
+		;;
 	--*)
-		__gitcomp "--pretty=
+		__gitcomp "--pretty= --format=
 			$__git_diff_common_options
 			"
 		return
 		;;
 	esac
-- 
1.6.2.rc1.29.g79ccf
