From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: Only describe --dry-run once
Date: Sun, 13 Sep 2009 11:53:32 -0700
Message-ID: <7vocper80j.fsf@alter.siamese.dyndns.org>
References: <1252848905-19115-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:53:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmuCo-0005Ja-KC
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbZIMSxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbZIMSxi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:53:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbZIMSxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:53:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A77324F022;
	Sun, 13 Sep 2009 14:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fnp9LNjkJmtwVPUk7vkilkGOKN8=; b=SVjdivoAob0RCT+e3admyOQ
	XbVpFwT58MOadNgk6NJtb5fpHH4wfLuu6hcaaFs6TMJHYarFp1YtPVzP6+s1JCZL
	7SN/cPkXCaZmhbYOeAzjSEqGSAemiLVQnXCOYdCwZdtxsu4NJPmjQa5u1d1H8LWb
	WQsX3xp0dno/1N0M6NrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Nqgar7clmh9TzwNgCX0485SrnkshKKlkRPcd4y+6BfkGu6xkd
	lqpA08cCG4hFgTb5+MH65mCO+5m4rq+k1+6X2OI0rHS2pu6JRKN457joKxRUkxcm
	iu/SXgbCBDm4X9jYaTEn5Bo6IIvG9MnAvUH+uJz2JNH9lUWuZOyXI6rIQI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A0784F021;
	Sun, 13 Sep 2009 14:53:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 625004F020; Sun, 13 Sep 2009
 14:53:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF724E40-A096-11DE-A424-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128404>

Johannes Gilger <heipei@hackvalue.de> writes:

> Junio described the option in 3a5d13a and then again in 60c2993.

Thanks.

I must have been too tired to think straight when I did 60c2993.

I think it is a better option just to revert that commit except for the
second hunk that makes it stop talking about "git status", like this.

I'd apply your typofix as a separate patch.

Thanks.

 Documentation/git-commit.txt |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 64f94cf..0578a40 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--dry-run]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -69,12 +69,6 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
---dry-run::
-	Do not actually make a commit, but show the list of paths
-	with updates in the index, paths with changes in the work tree,
-	and paths that are untracked, similar to the one that is given
-	in the commit log editor.
-
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
