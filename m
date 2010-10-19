From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: Add option to show author email instead of name
Date: Tue, 19 Oct 2010 12:02:22 -0700
Message-ID: <7vsk02ypj5.fsf@alter.siamese.dyndns.org>
References: <1287212271-23545-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8HSK-0001LG-JL
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0JSTCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 15:02:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab0JSTCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:02:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E753E08F2;
	Tue, 19 Oct 2010 15:02:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xu5d8QE0QqOfzladcK0fAAevUx0=; b=TRwzho
	qn615s6aWKw43v4uyL+yuH2Z/Ev7RKbdsXvdtwAh+e0uAd0qATS4FQkp7+jTDi8z
	intFWR9UbWQSAzLEVR32LFSTiIoq2TDxWNIXKf0n8LGFVXdn0jkgQ1MprFY8LiXC
	ECuiNqhqwPf63pEJL4f7hjBqUnS8Ip5dle2VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1lwOg/q7dBS5M8ZdEqMe2+p8xDKt9NP
	ZOMvGHTP9xyYPZRsB/G+TAkh/ucVQ6blRG5v0qnTCeCJex85sTrKnpVYuO+S3wfv
	RGJ36Rd5m3K0hw0D42Iwq1HUzPQnyAJTuQ6N41vk1cyV2ww3mN1+t7gnenev1VPH
	cDXdySzl28s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB4BE08F1;
	Tue, 19 Oct 2010 15:02:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D167E08F0; Tue, 19 Oct
 2010 15:02:24 -0400 (EDT)
In-Reply-To: <1287212271-23545-1-git-send-email-kevin@sb.org> (Kevin
 Ballard's message of "Fri\, 15 Oct 2010 23\:57\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A4C52AE-DBB3-11DF-B6C1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159354>

Kevin Ballard <kevin@sb.org> writes:

> Add a new option -e (or --show-email) to git-blame that will display
> the author's email instead of name on each line. This option works
> for both git-blame and git-annotate.

Some nits.

    CC builtin/blame.o
cc1: warnings being treated as errors
builtin/blame.c: In function 'emit_other':
builtin/blame.c:1678: error: assignment discards qualifiers from pointer target type
builtin/blame.c:1680: error: assignment discards qualifiers from pointer target type
builtin/blame.c:1700: error: assignment discards qualifiers from pointer target type
builtin/blame.c:1702: error: assignment discards qualifiers from pointer target type
builtin/blame.c:1703: error: ISO C90 forbids mixed declarations and code
make: *** [builtin/blame.o] Error 1

 builtin/blame.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0f0317c..df45e5c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1673,7 +1673,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
-			char *name;
+			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
 				name = ci.author_mail;
 			else
@@ -1695,12 +1695,13 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				       ent->s_lno + 1 + cnt);
 
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
-				char *name;
+				const char *name;
+				int pad;
 				if (opt & OUTPUT_SHOW_EMAIL)
 					name = ci.author_mail;
 				else
 					name = ci.author;
-				int pad = longest_author - utf8_strwidth(name);
+				pad = longest_author - utf8_strwidth(name);
 				printf(" (%s%*s %10s",
 				       name, pad, "",
 				       format_time(ci.author_time,
