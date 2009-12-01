From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-merge: a deprecation notice of the ancient command line
 syntax
Date: Mon, 30 Nov 2009 16:23:50 -0800
Message-ID: <7vaay3bkyx.fsf_-_@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org>
 <20091201071234.6117@nanako3.lavabit.com>
 <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGXn-0005CT-Jk
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZLAAXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbZLAAXz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:23:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbZLAAXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:23:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7719A2BCD;
	Mon, 30 Nov 2009 19:23:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9lVd3R6G0rXs/jhLGjZ5fte4UEg=; b=fAmHoO
	SRUo642XnhVoBNo3UBnNdVrBGeuiYuIlG1PapjOUXRa/2GpWaQf2Y4X9iD2wBoiE
	4JLMLgoCpI3un3fqdq7bjjWaCQIliNbBBFtlGmbBaf86VYu7VfiYloTwblPXlF0B
	jM/6oxpUJNE6Pb2Izk48X7DdlVvQtNbEXyfJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZyuuFD0RtcsWMTL72YYeZNSa8tV1YpK
	Nmdx2LO3CqRToNsIIoC8H0mJ26e1SfluMRFhO+faL2/eQmDLY6LekUjYSO9Gi9km
	ekZcSoEtyJkHWYt+sc5AS83IjF4Ko5vSPkindKlM1scFhaIk1dwozU0Emlq4RLEB
	YB19nzgT+aY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7794AA2BCC;
	Mon, 30 Nov 2009 19:23:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EDE01A2BC9; Mon, 30 Nov 2009
 19:23:51 -0500 (EST)
In-Reply-To: <7vmy23bl4o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 30 Nov 2009 16\:20\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0116C02-DE0F-11DE-B085-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134156>

The ancient form of git merge command used in the original sample script
has been copied from Linus and are still found everywhere, I think, and
people may still have it in their scripts, but on the other hand, it is so
unintuitive that even people reasonably familiar with git is surprised by
accidentally triggering the support to parse this ancient form.

Gently nudge people to upgrade their script to more recent and readable
style for eventual removal of the original syntax.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    And this is the first step of such a deprecation.  Perhaps we start
    warning in 1.7.0 and remove it in 1.8.0, or something like that.

 builtin-merge.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e5cf795..4cb695e 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -789,6 +789,11 @@ static int suggest_conflicts(void)
 	return 1;
 }
 
+static const char deprecation_warning[] =
+	"'git merge <msg> HEAD <commit>' is deprecated. Please update\n"
+	"your script to use 'git merge -m <msg> <commit>' instead.\n"
+	"In future versions of git, this syntax will be removed.";
+
 static struct commit *is_old_style_invocation(int argc, const char **argv)
 {
 	struct commit *second_token = NULL;
@@ -802,6 +806,7 @@ static struct commit *is_old_style_invocation(int argc, const char **argv)
 			die("'%s' is not a commit", argv[1]);
 		if (hashcmp(second_token->object.sha1, head))
 			return NULL;
+		warning(deprecation_warning);
 	}
 	return second_token;
 }
