From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/10] doc: push.default is no longer "matching"
Date: Tue, 08 Jan 2013 14:28:32 -0800
Message-ID: <7v1udvcnsf.fsf@alter.siamese.dyndns.org>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 23:28:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TshfD-00020B-OE
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 23:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141Ab3AHW2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 17:28:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab3AHW2f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 17:28:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6828CA5FE;
	Tue,  8 Jan 2013 17:28:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rt8O+I1zXaf9UdLPsjR5zHxAFrg=; b=x2eGcb
	L/DueqTRJ2Rfdd3RTR24cGddGOcXem2oCHYEQ3F0GigWL6yAwVgx4g5xkD13Kbx0
	izBKTaotg2gPuAB6Z3MtQaB7RhpMWcop1EspTiBR7co9mu3u32VyYuDNMFZhbsZz
	/cV0DZQd+R8PP9canYwjT2OZMps/WFmm+iTU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VBS64VkL1cg+X7IqbTNmBkqh/0YBXghx
	sxnaZLvj2rrJtWcCbxzuOJOn8120d98COcUBT5PnqK29Jfvlxnbu5X8CP9lPley9
	HqefQ2ZyXyjaNmPUGE1UgthvFKpYUhj8ZyP/ehxaPWorey55rZYztfaU8+u/EYVZ
	gnn/zGf8O1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CCBDA5FD;
	Tue,  8 Jan 2013 17:28:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1ADFA5F7; Tue,  8 Jan 2013
 17:28:33 -0500 (EST)
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Fri, 4 Jan 2013 22:52:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCAB2106-59E2-11E2-A072-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213009>

The documentation for the command said that `push.default` is the
default without referring to the releavant manual page.

Now `simple` is the default behaviour. Document it right there where
we say we take the default value from `push.default`, and remove the
description of old default being 'matching'.

Also reword cryptic desription of `--all`.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I skimmed our two tutorials, just to be sure, but they do not
   discuss 'git push', so there was nothing to update there.

   I *think* we are minimally ready to switch the default behaviour
   now, but there may be other places that need similar adjustment.
   An independent audit is highly appreciated.

 Documentation/git-push.txt | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8b637d3..f326afb 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -36,10 +36,14 @@ OPTIONS[[OPTIONS]]
 	The format of a <refspec> parameter is an optional plus
 	`+`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
-	It is used to specify with what <src> object the <dst> ref
-	in the remote repository is to be updated.  If not specified,
+	It is used to specify what <src> object the <dst> ref
+	in the remote repository is to be updated to.  If no
+	<refspec> is specified on the command line, and if no
+	<refspec> is configured for the <repository>,
 	the behavior of the command is controlled by the `push.default`
-	configuration variable.
+	configuration variable, and if it is unset, the `simple`
+	behaviour is used (see lingit:git-config[1] and look
+	for `push.default`).
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
@@ -65,14 +69,11 @@ the remote repository.
 The special refspec `:` (or `+:` to allow non-fast-forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.  This is the default operation mode
-if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below) and
-no `push.default` configuration variable is set.
+already exists on the remote side.
 
 --all::
-	Instead of naming each ref to push, specifies that all
-	refs under `refs/heads/` be pushed.
+	Push all branches (i.e. refs under `refs/heads/`); cannot be
+	used with other <refspec>.
 
 --prune::
 	Remove remote branches that don't have a local counterpart. For example
-- 
1.8.1.317.ga1ba510
