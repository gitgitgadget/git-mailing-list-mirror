From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Notes in format-patch
Date: Tue, 13 Nov 2012 10:09:07 -0800
Message-ID: <7vfw4de5oc.fsf@alter.siamese.dyndns.org>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <50A2213B.4060505@drmicha.warpmail.net> <7vhaotfou6.fsf@alter.siamese.dyndns.org> <7vzk2le918.fsf@alter.siamese.dyndns.org> <7vr4nxe7nf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKvP-0003LY-9D
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab2KMSJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 13:09:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005Ab2KMSJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:09:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07F7A9F83;
	Tue, 13 Nov 2012 13:09:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8/Ai3+sAfmzykhmTsU0JxwEUQw=; b=UdFjBX
	CUpbKOqXzabj9kuLL4pe5/x2dGNpybLTIIPJ8ZPkObYM3foEBSZFWmhusIuetqds
	Nb+2mhrGZ6GwnN5HDUwQu/XmwQlBasC3KJ/z4Ogwjc85CNTyRaJbH0AT8CtfbahL
	Xe/aywkssy2tSZoK/LBTJHzJHAqHLfRL+XK2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RzHwKHW0hmlSnTmsWIiLUQvSeXJtGmak
	QU5zHp+meJ9h/I/o1YABBNHhC0ZJR7QxTWmHj6fPokdJLoMoxzCR1poRS42sf3N/
	DQGrf9Hn5Xnax2Se7T3CoD/fSUGN5HfO9pli95r8xBHp1E89L+cQsWEPGbXPCHh2
	HsK0x8kt2fc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76049F82;
	Tue, 13 Nov 2012 13:09:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 302099F80; Tue, 13 Nov 2012
 13:09:09 -0500 (EST)
In-Reply-To: <7vr4nxe7nf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 13 Nov 2012 09:26:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 385A766E-2DBD-11E2-84F3-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209651>

Junio C Hamano <gitster@pobox.com> writes:

> ... and it is broken X-<.
>
> The blank line should be added before the diffstat, not after the
> notes message (t3307 shows a case where we give notes without
> diffstat, and we shouldn't be adding an extra blank line in that
> case.

Second try.

-- >8 --
Subject: format-patch: add a blank line between notes and diffstat

The last line of the note text comes immediately before the diffstat
block, making the latter unnecessarily harder to view.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 log-tree.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git c/log-tree.c w/log-tree.c
index 712a22b..4f86def 100644
--- c/log-tree.c
+++ w/log-tree.c
@@ -727,15 +727,16 @@ int log_tree_diff_flush(struct rev_info *opt)
 	}
 
 	if (opt->loginfo && !opt->no_commit_id) {
-		/* When showing a verbose header (i.e. log message),
-		 * and not in --pretty=oneline format, we would want
-		 * an extra newline between the end of log and the
-		 * output for readability.
-		 */
 		show_log(opt);
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
+			/*
+			 * When showing a verbose header (i.e. log message),
+			 * and not in --pretty=oneline format, we would want
+			 * an extra newline between the end of log and the
+			 * diff/diffstat output for readability.
+			 */
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if (opt->diffopt.output_prefix) {
 				struct strbuf *msg = NULL;
@@ -743,11 +744,21 @@ int log_tree_diff_flush(struct rev_info *opt)
 					opt->diffopt.output_prefix_data);
 				fwrite(msg->buf, msg->len, 1, stdout);
 			}
-			if (!opt->shown_dashes) {
-				if ((pch & opt->diffopt.output_format) == pch)
-					printf("---");
-				putchar('\n');
-			}
+
+			/*
+			 * We may have shown three-dashes line early
+			 * between notes and the log message, in which
+			 * case we only want a blank line after the
+			 * notes without (an extra) three-dashes line.
+			 * Otherwise, we show the three-dashes line if
+			 * we are showing the patch with diffstat, but
+			 * in that case, there is no extra blank line
+			 * after the three-dashes line.
+			 */
+			if (!opt->shown_dashes &&
+			    (pch & opt->diffopt.output_format) == pch)
+				printf("---");
+			putchar('\n');
 		}
 	}
 	diff_flush(&opt->diffopt);
