From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH] mergetools: Enhance tortoisemerge to work with
Date: Fri, 25 Jan 2013 14:07:08 +0100
Message-ID: <5102837C.9000608@tu-clausthal.de>
References: <50FBD4AD.2060208@tu-clausthal.de> <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de> <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de> <51024B02.9020400@tu-clausthal.de> <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 14:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyj10-0003xp-VM
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 14:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab3AYNHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 08:07:09 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:60339 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932101Ab3AYNHH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 08:07:07 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 4B00742E299;
	Fri, 25 Jan 2013 14:07:05 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 24700422063;
	Fri, 25 Jan 2013 14:07:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=l1UZHSK8ggyj/CcAjmAfWu9JA1E=; b=i22K69qQ9IVDrcu1eh3XUAftkvL8
	e3gmWshH9BzuzPou5qNVni4qg3GTpsXbjPUygw2m7wMS5eOVgZmlO6P2gSveOH1j
	yi4Kb1v3jAsR+/t0ESiwgyR7ssddC2u3I4P1uwBHKkwqXg9yloGft28mT25s2LWj
	Dg38hj8GKCVjD/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=OF8qvKhvGL8BTxNnUK1kbitQck4xNW/1rGBbDnyqzGA979MW340SSCc
	W4IRZ5DzMqFPwpdgNiSVbKXAiSncylv259UnmlRmRSYsiyEhr4ahNjPENPzdorfb
	SHlddkh7ZuEqvMhQOU+3i8/bH8NjrSg2Vn8R9MW+Bm0CPtnQJJzI=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id BFFF0422061;
	Fri, 25 Jan 2013 14:07:04 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 43363805; Fri, 25 Jan 2013 14:07:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (10%, '
 __FRAUD_WEBMAIL! 0, MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214550>

 TortoiseGitMerge and filenames with spaces

- The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
  (starting with 1.8.0) in order to make clear that this one has special
  support for git, (uses spaces as cli parameter key-value separators)
  and prevent confusion with the TortoiseSVN TortoiseMerge version.
- The tortoisemerge mergetool does not work with filenames which have
  a space in it. Fixing this required changes in git and also in
  TortoiseGitMerge; see https://github.com/msysgit/msysgit/issues/57.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 mergetools/tortoisemerge | 51 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index ed7db49..8ee99a5 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -1,17 +1,34 @@
-can_diff () {
-	return 1
-}
-
-merge_cmd () {
-	if $base_present
-	then
-		touch "$BACKUP"
-		"$merge_tool_path" \
-			-base:"$BASE" -mine:"$LOCAL" \
-			-theirs:"$REMOTE" -merged:"$MERGED"
-		check_unchanged
-	else
-		echo "TortoiseMerge cannot be used without a base" 1>&2
-		return 1
-	fi
-}
+can_diff () {
+	return 1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		touch "$BACKUP"
+		basename="$(basename "$merge_tool_path" .exe)"
+		if test "$basename" = "tortoisegitmerge"
+		then
+			"$merge_tool_path" \
+				-base "$BASE" -mine "$LOCAL" \
+				-theirs "$REMOTE" -merged "$MERGED"
+		else 
+			"$merge_tool_path" \
+				-base:"$BASE" -mine:"$LOCAL" \
+				-theirs:"$REMOTE" -merged:"$MERGED"
+		fi
+		check_unchanged
+	else
+		echo "$merge_tool_path cannot be used without a base" 1>&2
+		return 1
+	fi
+}
+
+translate_merge_tool_path() {
+	if type tortoisegitmerge >/dev/null 2>/dev/null
+	then
+		echo tortoisegitmerge
+	else
+		echo tortoisemerge
+	fi
+}
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
