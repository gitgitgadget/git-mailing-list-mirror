From: Junio C Hamano <gitster@pobox.com>
Subject: mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 10:21:25 -0700
Message-ID: <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 19:21:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StMK6-0003mx-NI
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 19:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2GWRV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 13:21:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab2GWRV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 13:21:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B48427045;
	Mon, 23 Jul 2012 13:21:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KTJh9DLeCMD7pbX1r1A0ObZDmJo=; b=k10Q7v
	cuNPmCPg+E61Yrk/wD3T4Ihp0F3zZTRTMVDo6G81SUrNocxLtq6zQy3+F3qSAonF
	hUiYZXGji0kb9UjcwVXUO4WBOj/BreVdYwnYAhnTG8sTcXDrl68pFcLhikD0fwRc
	QVZ1iDllIJUTbmII+rsnvTCKpoxMDPjZXh5lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ILLpF+BeLyQvlynfJkCJbIxrpIjHy4E3
	zA1H8sNQb9HpgWGcp3BBs+E/SEah+4t8snU2H8kH9w7BNSNIuPvvWkliDoGus2i9
	R2NfPo8+h77SkBREPoJSuezMIul4jfML+yueLuB9yHSBBQUIFMOnIkleK4Nq7YRs
	07mfwNdthso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A212F7044;
	Mon, 23 Jul 2012 13:21:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC2117043; Mon, 23 Jul 2012
 13:21:26 -0400 (EDT)
In-Reply-To: <7vr4s2mnir.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jul 2012 09:48:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D59D04AE-D4EA-11E1-84D8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201942>

This way we do not have to risk the list of tools go out of sync
between the implementation and the documentation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano <gitster@pobox.com> writes:

>> +--tool-help::
>> +	List the supported and available diff tools.
>
> This part is a good addition (but it already is mentioned in the
> description of --tool above, so it is more or less a "Meh").

I noticed that the main while loop has style violations in its
case/esac, but I left it as-is.  Reindenting it would be a low
hanging fruit janitor patch that would be a separate topic.

 git-mergetool--lib.sh |  6 +++++-
 git-mergetool.sh      | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b2..f730253 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -111,7 +111,7 @@ run_merge_tool () {
 	return $status
 }
 
-guess_merge_tool () {
+list_merge_tool_candidates () {
 	if merge_mode
 	then
 		tools="tortoisemerge"
@@ -136,6 +136,10 @@ guess_merge_tool () {
 		tools="$tools emerge vimdiff"
 		;;
 	esac
+}
+
+guess_merge_tool () {
+	list_merge_tool_candidates
 	echo >&2 "merge tool candidates: $tools"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index a9f23f7..0db0c44 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
+USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
@@ -284,11 +284,51 @@ merge_file () {
     return 0
 }
 
+show_tool_help () {
+	TOOL_MODE=merge
+	list_merge_tool_candidates
+	unavailable= available= LF='
+'
+	for i in $tools
+	do
+		merge_tool_path=$(translate_merge_tool_path "$i")
+		if type "$merge_tool_path" >/dev/null 2>&1
+		then
+			available="$available$i$LF"
+		else
+			unavailable="$unavailable$i$LF"
+		fi
+	done
+	if test -n "$available"
+	then
+		echo "'git mergetool --tool=<tool>' may be set to one of the following:"
+		echo "$available" | sort | sed -e 's/^/	/'
+	else
+		echo "No suitable tool for 'git mergetool --tool=<tool>' found."
+	fi
+	if test -n "$unavailable"
+	then
+		echo
+		echo 'The following tools are valid, but not currently available:'
+		echo "$unavailable" | sort | sed -e 's/^/	/'
+	fi
+	if test -n "$unavailable$available"
+	then
+		echo
+		echo "Some of the tools listed above only work in a windowed"
+		echo "environment. If run in a terminal-only session, they will fail."
+	fi
+	exit 0
+}
+
 prompt=$(git config --bool mergetool.prompt || echo true)
 
 while test $# != 0
 do
     case "$1" in
+	--tool-help)
+		show_tool_help
+		;;
 	-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
