From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/6] rev-list/log: document logic with several limiting
 options
Date: Thu, 13 Sep 2012 19:04:17 -0700
Message-ID: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
 <cover.1347544259.git.git@drmicha.warpmail.net>
 <49f89f65cd39306655a9b382a1244e34fb90fff1.1347544259.git.git@drmicha.warpmail.net> <7v7grx5zfq.fsf@alter.siamese.dyndns.org> <7vsjal4d14.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 04:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCLGf-00036c-Gr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 04:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab2INCEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 22:04:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab2INCEU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 22:04:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D5F8F66;
	Thu, 13 Sep 2012 22:04:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U2AZOi78TYEomot7cn/rW3oHzAk=; b=o2SIDA
	sPkLwIEOAznI+olUW/Zsl2Q7NN4L58F/dNqCMzrY6zLi9xQTwj6DGzuNOrKNR+tG
	qOgmdg9QwBgkoCIRNkzHAV1ilzzypajOtEuncsuS9LfEcRwVckrmNMOFWE4pN7Ty
	mQK6KBkXFx+E+dUB5O5xyq+mGZ8bMxXAmpRjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXOiiWQISqJVGj54lgvR6HdASv5VsmY0
	qs6CWEA8kIBkqhnoLYpLUZSCJRS3xYN+2xAoIKDubnxzqBWCpS8rrPbVuVWAa61p
	gKMvUthCXEkGWTpxHfTjk7J1Hiuw90BP730OWHA/ws8GJ4PSpMx7AnveL6kxq+z8
	Vf509iPmpQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED768F65;
	Thu, 13 Sep 2012 22:04:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 955D18F64; Thu, 13 Sep 2012
 22:04:18 -0400 (EDT)
In-Reply-To: <7vsjal4d14.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 18:19:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E16F90C-FE10-11E1-8536-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205444>

Junio C Hamano <gitster@pobox.com> writes:

> Assuming that the patch I posted earlier actually works, I think the
> description can become vastly simpler, if you stop explaining author
> and committer in terms of "grep".

And here is a replacement in a patch form.  

-- >8 --
Subject: [PATCH] log: document use of multiple commit limiting options

Generally speaking, using more options will further narrow the
selection, but there are a few exceptions.  Document them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1ae3c89..57d6c90 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -3,7 +3,14 @@ Commit Limiting
 
 Besides specifying a range of commits that should be listed using the
 special notations explained in the description, additional commit
-limiting may be applied. Note that they are applied before commit
+limiting may be applied.
+
+Using more options generally further limits the output (e.g.
+"--since=<date1>" limits to commits newer than <date1>, and using it
+with "--grep=<pattern>" further limits to commits whose log message
+has a line that match <pattern>), unless otherwise noted.
+
+Note that these are applied before commit
 ordering and formatting options, such as '--reverse'.
 
 --
@@ -38,16 +45,22 @@ endif::git-rev-list[]
 --committer=<pattern>::
 
 	Limit the commits output to ones with author/committer
-	header lines that match the specified pattern (regular expression).
+	header lines that match the specified pattern (regular
+	expression).  With more than one `--author=<pattern>`,
+	commits whose author match any of the given patterns are
+	chosen (similarly for multiple `--committer=<pattern>`).
 
 --grep=<pattern>::
 
 	Limit the commits output to ones with log message that
-	matches the specified pattern (regular expression).
+	matches the specified pattern (regular expression).  With
+	more than one `--grep=<pattern>`, commits whose message
+	match any of the given patterns are chosen (but see
+	`--all-match`).
 
 --all-match::
 	Limit the commits output to ones that match all given --grep,
-	--author and --committer instead of ones that match at least one.
+	instead of ones that match at least one.
 
 -i::
 --regexp-ignore-case::
-- 
1.7.12.469.g5235eb6
