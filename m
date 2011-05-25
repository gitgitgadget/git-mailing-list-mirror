From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 12:30:53 -0700
Message-ID: <7vvcwy37de.fsf@alter.siamese.dyndns.org>
References: <loom.20110525T192418-887@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Ligocki <sligocki@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJnR-0003Ch-2y
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 21:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab1EYTbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 15:31:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab1EYTbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 15:31:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F36D5AFB;
	Wed, 25 May 2011 15:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JdpkRwhBomf9I+Gr2Xy1bkQ7L8k=; b=K/+ANE
	MtNgnKzSR0k5QZUiV31F0B458zuWQzlBNJU0fAQr3XqIo+JWaHC1lTNalA67gjLi
	Pd8/ivzAQexO75GkNiKYU+fC/xTyDRLV4mwwaXtyB83FyluuWEGwu+rBZUw/1ElU
	b0cnw48pQnlM4bdPov37IkTmTBabuDSpBJBOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJqQt1cXrZoFFSICHXJoWsl9/wS/L2YE
	cVF1CZ/7sMSHHHLDkZsYrGQBkFsY7wVwFCA+RpAYUApdp/rul51gCOtg/VODIo5b
	Lf5o6g+GNe4oPmk99E3y0Iz0+ReWb1lqXU8RuqXB7vOxKuS4g2Jj3b8JlCS/rSr3
	bqRt/WXIW7U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3CA5E5AFA;
	Wed, 25 May 2011 15:33:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4621B5AF9; Wed, 25 May 2011
 15:33:03 -0400 (EDT)
In-Reply-To: <loom.20110525T192418-887@post.gmane.org> (Shawn Ligocki's
 message of "Wed, 25 May 2011 17:28:07 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0603DD2-8705-11E0-B5F7-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174450>

Shawn Ligocki <sligocki@gmail.com> writes:

> Is this intentionally bad grammar? Every time I see it, I cringe a little.

I think so.  An earlier version of "git merge" used to say something like:

    Committed merge ..., made by resolve.

back in Sept 2005, so it is not so recent development. If we change it
now, scripts in thousands of existing users hands might cringe instead,
though.

 builtin/merge.c               |    2 +-
 t/t7602-merge-octopus-many.sh |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5a2a1eb..8bc453d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -902,7 +902,7 @@ static int finish_automerge(struct commit_list *common,
 	strbuf_addch(&merge_msg, '\n');
 	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
-	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
+	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
 	drop_save();
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 0a46795..61f36ba 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -53,7 +53,7 @@ cat >expected <<\EOF
 Trying simple merge with c2
 Trying simple merge with c3
 Trying simple merge with c4
-Merge made by octopus.
+Merge made by the 'octopus' strategy.
  c2.c |    1 +
  c3.c |    1 +
  c4.c |    1 +
@@ -72,7 +72,7 @@ test_expect_success 'merge output uses pretty names' '
 cat >expected <<\EOF
 Already up-to-date with c4
 Trying simple merge with c5
-Merge made by octopus.
+Merge made by the 'octopus' strategy.
  c5.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 c5.c
@@ -86,7 +86,7 @@ test_expect_success 'merge up-to-date output uses pretty names' '
 cat >expected <<\EOF
 Fast-forwarding to: c1
 Trying simple merge with c2
-Merge made by octopus.
+Merge made by the 'octopus' strategy.
  c1.c |    1 +
  c2.c |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
