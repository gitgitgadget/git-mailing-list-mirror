From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v2] Add a basic idea section for git-blame.
Date: Sat, 10 Apr 2010 12:53:55 -0700
Message-ID: <7veiinw0bw.fsf@alter.siamese.dyndns.org>
References: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
 <1270894530-6486-2-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 21:54:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0gkw-0006GS-Qw
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab0DJTyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:54:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0DJTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:54:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABDDA928A;
	Sat, 10 Apr 2010 15:54:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fRyca1RUwC2IpGf66i5cLrD1Qtc=; b=qlyC6v
	TOEQkdfXpIlbydpAePZkOCrZ0EOmSE2ae8LhE2U3t1zubv7j/s7Zv3q4eVq+iqxS
	5S/u5vvu6kv64yEAOavi4hcVltT/j72ysSea9xGh1EwM+eQVWZzVyOtNZrxTQE9x
	6KdlCaai3uNNm2dlErljgw1KpAtU6d55kP3p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xuWFaxSHtjTvaVVl+LHoZmBA2KIavVdt
	r3Xg2E0S6KJDmxNGD+Dx0IiygwlOgjGPV/j7hZ1Cy61h9jV1lkE277iLcIrYe812
	GpomS+Zjv9sc6wbDPRCrGVM/HNvcCNcEDmhwfJ5UHBkQh+uHsit7szqldJP9Wlti
	pU/L1Yh6rUQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BEC5A9286;
	Sat, 10 Apr 2010 15:54:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88C49A9283; Sat, 10 Apr
 2010 15:53:57 -0400 (EDT)
In-Reply-To: <1270894530-6486-2-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Sat\, 10 Apr 2010 18\:15\:29 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF72EFDC-44DA-11DF-BCD0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144586>

Bo Yang <struggleyb.nku@gmail.com> writes:

> +With `-M`, this command detects same lines of the current blaming code
> +inside the current file. And it will shift the blame to the author of
> +the original lines instead of author of current blaming code. It does
> +the same for `-C` except that it will search across file boundary and
> +multiple commits.

I grant you that the understanding what M/C options do by the end users
(the target audience of the document) would improve if they understood the
above paragraph.  And I know you thought the text leading to the above
paragraph (omitted) would help them understand what this paragraph tells
them.

But I think we should try to do better.  We can always say "With a
technical description of how it works internally, you can understand why
these options give you the behaviour you want", but that should be the
last resort when we cannot give meaningful description without going into
the implementation details.

It may also help git hacker wannabes (not end users) to have more detailed
and precise description of how the algorithm works in a separate document
in the Documentation/technical/ area, but that is a separate issue.

If the goal is to help the end users use M/C options and understand the
output better, can't we take a more direct approach?

It doesn't really matter to them _why_ only B is blamed to the parent in
"A B" -> "B A" movement without -M (and your "BASIC IDEA" section is too
sketchy for readers to guess why, even if they wanted to learn the
implementation detail, which they typically don't).

Things like:

    - they can use -M to annotate across block-of-lines swappage within a file;
    - use of -M adds cost --- it spends extra cycles;
    - similarly -C annotates across block-of-lines swappage between files;
    - use -f -C adds larger cost; ...

are the only important things they want to know about, no?

 Documentation/blame-options.txt |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 4833cac..5d5ed37 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -79,14 +79,15 @@ of lines before or after the line given by <start>.
 	of the --date option at linkgit:git-log[1].
 
 -M|<num>|::
-	Detect moving lines in the file as well.  When a commit
-	moves a block of lines in a file (e.g. the original file
-	has A and then B, and the commit changes it to B and
-	then A), the traditional 'blame' algorithm typically blames
-	the lines that were moved up (i.e. B) to the parent and
-	assigns blame to the lines that were moved down (i.e. A)
-	to the child commit.  With this option, both groups of lines
-	are blamed on the parent.
+	Detect moved or copied lines within a file. When a commit
+	moves or copies a block of lines (e.g. the original file
+	has A and then B, and the commit changes it to B and then
+	A), the traditional 'blame' algorithm notices only the
+	half of the movement and typically blames the lines that were
+	moved up (i.e. B) to the parent and assigns blame to the lines
+	that were moved down (i.e. A) to the child commit.  With this
+	option, both groups of lines are blamed on the parent by
+	running extra passes of inspection.
 +
 <num> is optional but it is the lower bound on the number of
 alphanumeric characters that git must detect as moving
@@ -94,7 +95,7 @@ within a file for it to associate those lines with the parent
 commit.
 
 -C|<num>|::
-	In addition to `-M`, detect lines copied from other
+	In addition to `-M`, detect lines moved or copied from other
 	files that were modified in the same commit.  This is
 	useful when you reorganize your program and move code
 	around across files.  When this option is given twice,
