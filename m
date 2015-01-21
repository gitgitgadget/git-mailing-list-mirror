From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/18] Introduce an internal API to interact with the  fsck machinery
Date: Wed, 21 Jan 2015 01:17:04 -0800
Message-ID: <xmqq4mrkxzlb.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrPa-0004kj-MB
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbbAUJRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:17:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbbAUJRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:17:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01D3D26E0B;
	Wed, 21 Jan 2015 04:17:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ui1BX5lLb41A2y7VsZnV+mmfLw4=; b=NPA8lY
	xGwWa7iJbd2/DZN/4quX11NBMc9JVRGl8gh99Fm6ccbuNSb9qgywxJvXqgM5knqX
	79jRekwCZYDQrkw2JMqUC6TvF4Q8/yWunCW9gEt9i4UvX/+hM5shMF92FTj+EADo
	qAxzCLJj3OUskh7LDofwHwwTC46tAdljEUpbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O55docMT+aRR3RaJfEpGAlq45Nh0Xhrh
	ETYBHRKpToWWWLoemNuotzMboln8c019iu2hvAJ1yTE7zSwkdZ8eH5AL+gXEq4bV
	xKaZXJ+GDgYUlvjEgWrlfA/KOlOEOXnPOfZuu8om475hGAOK5twKM69FyKequ/YY
	4Y+tKu1xvs4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2ABE26E0A;
	Wed, 21 Jan 2015 04:17:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5CA026E06;
	Wed, 21 Jan 2015 04:17:05 -0500 (EST)
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Mon, 19 Jan 2015 16:49:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44A08E84-A14E-11E4-9513-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262725>

The documentation did not format well.  Tentatively I added the
attached fix-up on top of the series before merging to 'pu'.

 * The wildcard in "fsck.*" and "receive.fsck.*" may have made sense
   back in v1 when the variables are unbounded set, but v2 fixes it
   and we now have a known fixed set of variables, so lets list them
   explicitly (this is not a "fix to unbreak formatting").

 * The "--" that is not closed was giving me this:

    asciidoc: ERROR: git-config.txt: line 413: section title not permitted in delimited block
    asciidoc: ERROR: config.txt: line 2414: [blockdef-open] missing closing delimiter
    make: *** [git-config.xml] Error 1

   (this is "workaround to unbreak formatting"; I didn't check the
   actual output closely).

 * the line that begins with "- missing email" after indent was
   taken as an bulletted item or something, so I rewrapped the
   paragraph somewhat to avoid having the dash at the beginning.


 Documentation/config.txt | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6718578..aae66bb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1208,7 +1208,9 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
 
-fsck.*::
+fsck.error::
+fsck.warn::
+fsck.ignore::
 	The `fsck.error`, `fsck.warn` and `fsck.ignore` settings specify
 	comma-separated lists of fsck message IDs which should trigger
 	fsck to error out, to print the message and continue, or to ignore
@@ -2138,25 +2140,26 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
-receive.fsck.*::
+receive.fsck.error::
+receive.fsck.warn::
+receive.fsck.ignore::
 	When `receive.fsckObjects` is set to true, errors can be switched
 	to warnings and vice versa by configuring the `receive.fsck.*`
 	settings. These settings contain comma-separated lists of fsck
 	message IDs. For convenience, fsck prefixes the error/warning with
-	the message ID, e.g. "missing-email: invalid author/committer line
-	- missing email" means that setting `receive.fsck.ignore =
-	missing-email` will hide that issue.
-+
---
-	error::
-		a comma-separated list of fsck message IDs that should be
-		trigger fsck to error out.
-	warn::
-		a comma-separated list of fsck message IDs that should be
-		displayed, but fsck should continue to error out.
-	ignore::
-		a comma-separated list of fsck message IDs that should be
-		ignored completely.
+	the message ID, e.g. "missing-email: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.ignore = missing-email` will hide that issue.
++
+error;;
+	a comma-separated list of fsck message IDs that should be
+	trigger fsck to error out.
+warn;;
+	a comma-separated list of fsck message IDs that should be
+	displayed, but fsck should continue to error out.
+ignore;;
+	a comma-separated list of fsck message IDs that should be
+	ignored completely.
 +
 This feature is intended to support working with legacy repositories
 which would not pass pushing when `receive.fsckObjects = true`, allowing
