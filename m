From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "git-clone.txt: remove the restriction on pushing from a shallow clone"
Date: Mon, 15 Jul 2013 08:35:50 -0700
Message-ID: <7vk3krdeeh.fsf_-_@alter.siamese.dyndns.org>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
	<20130713212541.GA10951@google.com>
	<CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
	<7vfvvhgeif.fsf@alter.siamese.dyndns.org>
	<CACsJy8Bx_o+9S1N_uieQaV8NBbc3T_MR_VCvF+fM==Dy-vt7tw@mail.gmail.com>
	<CACsJy8DELmhBwBCk9hmg4EpQxGeCRDPaSEr5rYp=CiMjq8j54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 17:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uykoh-0004RY-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 17:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703Ab3GOPfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 11:35:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab3GOPfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 11:35:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6565430225;
	Mon, 15 Jul 2013 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+pJxeYZmhzMgrM+lSAaVQQkcDU=; b=e3T/la
	BFu2nH1nR/3CAAAOWZbZTgbmBzcJJ2x/I8mBGieab1vj3d6/vpFDkVyqL1pFrivB
	vks29XUab+3SpG+DFnHPF+TX8S8bp39lJLPUd657EWgw6zem6eqiH4gVQTMABW/T
	u1HGV3bH/TxdqcD4wTEuHsY/Y+VEPKl0yyr/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LM1PO5Ej0YhN3DfEgh7KMyr6WEKVOlN3
	/rFwS6FeGvF3STXWMVTeahfCdKQ0Iws5HXixwkdCDz8GSsBtzZA9X0zf5v0mw9p1
	hSGlJ4Lxk2crmOhsQBeWpAIY1YHcIWqrICZsaNOpYZ9PX1X40G+hCh+R4+qMdfQl
	JdC+Xuepk/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58E5C30224;
	Mon, 15 Jul 2013 15:35:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A58630221;
	Mon, 15 Jul 2013 15:35:51 +0000 (UTC)
In-Reply-To: <CACsJy8DELmhBwBCk9hmg4EpQxGeCRDPaSEr5rYp=CiMjq8j54Q@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 15 Jul 2013 13:33:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AF82058-ED64-11E2-8D47-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230481>

This reverts commit dacd2bcc414e0b7aac36aaa400da0a743c4741cc.

"It fails reliably without corrupting the receiving repository when
it should fail" may be better than the situation before the receiving
end was hardened recently, but the fact that sometimes the push does
not go through still remains.  It is better to advice the users that
they cannot push from a shallow repository as a limitation before
they decide to use (or not to use) a shallow clone.
---

 * Unfortunately I thought the documentation update was a
   no-brainer and already applied it, so here is a revert.

 Documentation/git-clone.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 85769b8..450f158 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -182,13 +182,11 @@ objects from the source repository into a pack in the cloned repository.
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from it, nor
-	push into it), but is adequate if you are only interested in
-	the recent history of a large project with a long history.
-+
-Pushing from a shallow clone should be avoided if the git version on
-the receiver end is older than v1.7.10, or any other git
-implementation that does not perform connectivity check.
+	number of limitations (you cannot clone or fetch from
+	it, nor push from nor into it), but is adequate if you
+	are only interested in the recent history of a large project
+	with a long history, and would want to send in fixes
+	as patches.
 
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
-- 
1.8.3.2-941-gda9c3c8
