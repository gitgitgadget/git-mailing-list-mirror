From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: git branch --set-upstream-to=
Date: Tue, 11 Sep 2012 10:46:11 -0700
Message-ID: <7vliggh2qk.fsf@alter.siamese.dyndns.org>
References: <bd9d638e84e7e142e94b71213bed2126ea1f1951.1347364675.git.git@drmicha.warpmail.net> <7v627kiitq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 19:46:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBUXb-00058P-40
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 19:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab2IKRqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 13:46:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab2IKRqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 13:46:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1578C59;
	Tue, 11 Sep 2012 13:46:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LE1lRJ9ENKCAT/qBVIuN5q+LIXU=; b=Mug8My
	JMinr2XFOXAEFwzSLYbgKpWeJFmnoxzc5kjfQItl3Ss/YWVvdOGLxC+nDq7ufCGP
	OaUOJEfPsAZbuPdNmccPbr8uYuICFieFZ+dELa575FbfapBZnANx3EKXvOXEe1D4
	RG9RcYnynTeG10T/Qz9o9hJrLVXp5qaREKM08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eAtVqCqE8I0009CzoOKoz25sQ7n54dbX
	PFauYos81Veg4oAxqmIpqaZWi3m0Wh3YxHlyjUMBaOjwJZjSxNbrbRfDzsmq535R
	f9QkpeUGK8Yd4wg4HVktMbALaj6kUiXxGZ0o/IrucZc/Ev2cFIJRonf8PwaNEh5n
	PYaWmA3/k6M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF9B48C58;
	Tue, 11 Sep 2012 13:46:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51D058C56; Tue, 11 Sep 2012
 13:46:13 -0400 (EDT)
In-Reply-To: <7v627kiitq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Sep 2012 10:13:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94403376-FC38-11E1-A7B2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205256>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks; I picked up $gmane/204633 but forgot to queue.

... so this has been reduced to:

-- >8 --
From: Michael J Gruber <git@drmicha.warpmail.net>
Date: Tue, 11 Sep 2012 13:58:30 +0200
Subject: [PATCH] completion: complete branch name for "branch --set-upstream-to="

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4a4d30a..e48cf80 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -875,6 +875,9 @@ _git_branch ()
 	done
 
 	case "$cur" in
+	--set-upstream-to=*)
+		__gitcomp "$(__git_refs)" "" "${cur##--set-upstream-to=}"
+		;;
 	--*)
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
-- 
1.7.12
