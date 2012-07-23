From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g.
 ImageMagick's
Date: Mon, 23 Jul 2012 15:41:03 -0700
Message-ID: <7vtxwyhzi8.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
 <500DA7F3.3000403@gmail.com> <7v4noykxvm.fsf@alter.siamese.dyndns.org>
 <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
 <7v629ejexo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:41:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StRJR-0004HL-1D
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 00:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab2GWWlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 18:41:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab2GWWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 18:41:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC38465E6;
	Mon, 23 Jul 2012 18:41:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Do5U6ptaOHrFQqQdkoA0EpnUGpQ=; b=iiZY7c
	cyeLccUvrRgiQQDKTseIkkPHCrpzd6YLoeqbg1aajDgPuLRXxsumdoWk0JNsk4rn
	f6f9Tjo5szHldl3uriTBkRqDScBq6qhheS+L2QK+PIHlgjsB/UDWQ+4XputGy7yk
	/sjyEKp6/BCSieJ5RvEsmX/ldusTzsgsHMtsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhE6xT2LMoGrzBuOiSz1/zSS/h3soj9C
	wDlUT62/IUNrDFYTTz+0ODWuIKeqEjvPO1E5L7EmjMceNQ/aGT4d5hO4TtqPp2Gz
	j9aJVvJCLJbPwLKVpZSNRX37jBaVZ+DF7p5WU6qXDHR7AFfL28gjr8YJ19SIPh5A
	pPr6Q9+VY5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A60065E5;
	Mon, 23 Jul 2012 18:41:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F40AF65E4; Mon, 23 Jul 2012
 18:41:04 -0400 (EDT)
In-Reply-To: <7v629ejexo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 23 Jul 2012 15:22:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CA67A1A-D517-11E1-91CD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201999>

Junio C Hamano <gitster@pobox.com> writes:

> If we limit the problem space by special casing Windows installation
> (e.g. check "uname -s" or something), would it make the problem
> easier to solve?  Perhaps it is much more likely that the path the
> program is installed in can be safely identified with a call to
> "type --path compare" (bash is the only shell shipped in msysgit,
> isn't it?).

E.g. something along the lines of your original patch.  I do not
know what other commands are typically installed in the same
directory as "compare", so it is likely you need to fix the name of
the file to let us positively identify "compare" is from the Araxis
suite.

 mergetools/araxis | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5..1180a32 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -16,5 +16,18 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	echo compare
+	case "$BASH_VERSION" in
+	??*)
+		# we can safely use "type --path"
+		if test -f $(dirname "$(type --path compare)")/AraxisMerge
+		then
+			echo compare
+		else
+			echo "$1"
+		fi
+		;;
+	*)
+		echo compare
+		;;
+	esac
 }
