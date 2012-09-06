From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: initial_to and initial_reply_to are both
 optional
Date: Thu, 06 Sep 2012 14:21:00 -0700
Message-ID: <7vr4qe26gz.fsf_-_@alter.siamese.dyndns.org>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com>
 <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
 <7vsjav6d85.fsf@alter.siamese.dyndns.org>
 <CALaEz9W_RR70KEzxk7GxjOu1_yv4UudckcsKAP2C_39Nc2yLbw@mail.gmail.com>
 <7vipbq3omb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jVg-0007ry-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933160Ab2IFVVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:21:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759866Ab2IFVVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 17:21:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79952972C;
	Thu,  6 Sep 2012 17:21:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJDsNUHiiVpUqt8DGkB2EY+Rrec=; b=wFLQdO
	lH/STS+QA1IeOgCbpGGkzDz2C2OWKhwofkH4i2ybn7+onTb0gCZoY97HtUDMlF5v
	TSvGrqj4uAGR0+0L/sOq1nb6lXHXrFJy3qoD44vcY6dhmwBAk9wm8SSKbRIFmkZr
	xKi1P6fYIXzpQVQkJROEsz8uARF5dVIoE1Qtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xx1UTxsRzThdGYtXe9EFz7rCMVDnXrpR
	1qd9r/Uy42nmjJHJk4+xqJoBO4OAE6dVf3eDK/PD728+Y0dhBggd6L2tnWHd2FeM
	bnQZTaDZSx5IhNaT0CV4PV/LqnYfl65FPGZ3hVaCbS8T7xTcITT1seA3Gxo0QZsY
	BdO+bDPRpws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66643972A;
	Thu,  6 Sep 2012 17:21:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF0A19729; Thu,  6 Sep 2012
 17:21:01 -0400 (EDT)
In-Reply-To: <7vipbq3omb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 06 Sep 2012 13:03:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C24CF4D0-F868-11E1-8754-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204926>

We may pick up additional recipients from the format-patch output
files we are sending, in which case it is perfectly valid to leave
the @initial_to empty when the prompt asks.  We may want to start
a new discussion thread without replying to anything, and it is
valid to leave $initial_reply_to empty.

An earlier update to avoid y@example.com stuffed in address fields
did not take these two cases into account.

Noticed and fix suggested by Stephen Boyd.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am tempted to queue this, after asking you to eyeball it, and
   then update the author to pass the blame to you before merging it
   to 'next'.

 git-send-email.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e89729b..b1fb7e6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -759,7 +759,8 @@ sub file_declares_8bit_cte {
 }
 
 if (!@initial_to && !defined $to_cmd) {
-	my $to = ask("Who should the emails be sent to? ",
+	my $to = ask("Who should the emails be sent to (if any)? ",
+		     default => "",
 		     valid_re => qr/\@.*\./, confirm_only => 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
 	$prompting++;
@@ -786,7 +787,8 @@ sub expand_one_alias {
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
-		"Message-ID to be used as In-Reply-To for the first email? ",
+		"Message-ID to be used as In-Reply-To for the first email (if any)? ",
+		default => "",
 		valid_re => qr/\@.*\./, confirm_only => 1);
 }
 if (defined $initial_reply_to) {
-- 
1.7.12.321.g60f00e5
