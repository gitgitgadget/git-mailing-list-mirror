From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Update advice in commit/status output
Date: Sat, 12 Dec 2009 01:02:00 -0800
Message-ID: <1260608523-15579-1-git-send-email-gitster@pobox.com>
References: <7vk4wtysyu.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 10:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJNsU-0001Ra-8A
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992AbZLLJCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbZLLJCc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:02:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873AbZLLJCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:02:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A84A2878AE
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to; s=sasl; bh=HW4O/t5JJRkRY0/
	cjf5XsdL6ufY=; b=FJqadcD9rPZIPdiyrBEvkBjDnyuJ+5TBNsJXPfb/iGG/8Cb
	rgf0IKGauK6bUJAg9VlzD2UrS2NWS29rbTIz0BZVGy8batVrks/83aIxIFgG5IAF
	taNe5QUpJpuMR+JeJpa1S77cQdfIHzbW4nhFAbe2A1eBi0ecYld9tuiHW9/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to; q=dns; s=sasl; b=G5oDpmgLpHtfBEowr
	G8mozie2dPwTbHuW4BAlSpo+gDBeVCcDTDoi01sTraBkWXeqQVdkS0arHw/N/2/x
	la31kGQLX14K2YK1tfdOYqqPzn4ho5UuaqF9XECk+WDyfYTfsB1SeQ5fcosPN1eh
	uPit62iLhBI/KQSF+C5RfIFB0E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1820878AC
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35179878A9 for
 <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:05 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc2.5.g49666
In-Reply-To: <7vk4wtysyu.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 07BFCD4C-E6FD-11DE-8934-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135128>

Jay Soffian noticed that we give "git reset HEAD <path>" as an instruction
to get rid of the local change that has already been added to the index
even when <path> is unmerged, or it is merged and we are about to commit a
merge.

In neither case, "git reset HEAD <path>" is absolutely a wrong thing to do
while merging.

This miniseries updates the advices given in status/commit.  It applies on
top of the jk/1.7.0-status topic, and has trivial conflicts in wt-status.c
with the jk/unwanted-advices topic that has already graduated to 'maint'.

Junio C Hamano (3):
  commit/status: check $GIT_DIR/MERGE_HEAD only once
  commit/status: "git add <path>" is not necessarily how to resolve
  status/commit: do not suggest "reset HEAD <path>" while merging

 builtin-commit.c    |   12 ++++++------
 t/t7060-wtstatus.sh |    3 +--
 wt-status.c         |   16 +++++++++++-----
 wt-status.h         |    1 +
 4 files changed, 19 insertions(+), 13 deletions(-)
