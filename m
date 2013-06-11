From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] log --author-date-order
Date: Tue, 11 Jun 2013 15:19:05 -0700
Message-ID: <1370989149-28538-1-git-send-email-gitster@pobox.com>
References: <20130611063648.GB23650@sigill.intra.peff.net>
Cc: Elliott Cable <me@ell.io>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 00:19:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWuu-0007jn-77
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 00:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363Ab3FKWTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 18:19:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756928Ab3FKWTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 18:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA33927943;
	Tue, 11 Jun 2013 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6Ii/
	XSV1jWVmuj60ByfskDqg8Qw=; b=EN9YH177aKN4PaJKSpJlbv2Vd2eZi8RXfmDI
	r4IsWXRGrvjlWUJhK0dy7oSVGT1D9f+XZb+aNNe20IVCy8O+9E5+3hayzUfcl5iJ
	SGDYKNMuwI8WD4MTUp7rG7Ab7JiaoIuevIUu908ncPxXPsRs10d09ODf84KgvrCf
	0rgYS6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	UcMpEyqPMeIxjj2Tyl+6YnCz0a96Nx2X8n9pjEQ5uBBu0yb9hS+NN9lUHcVdHGGR
	KXCrDc7cBsykTSSoOad3b2x82dH9GFvOsutDOIAoz+gQCQnJvmFN1wfaW+KSOX2A
	Yfkj7gAV5CE6RWZ/T8OZJZYW55Y0sZoCjRcL+2hPz5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D03F527942;
	Tue, 11 Jun 2013 22:19:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5159B27940;
	Tue, 11 Jun 2013 22:19:10 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.1-494-g51b8af5
In-Reply-To: <20130611063648.GB23650@sigill.intra.peff.net>
X-Pobox-Relay-ID: F079CA20-D2E4-11E2-892C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227552>

The first one is unchanged.  The second one was redone with Peff's
help, and the other two patches have been adjusted for it.

Adding tests to t4202 and/or t6012 is left as an exercise to readers.

Junio C Hamano (4):
  toposort: rename "lifo" field
  prio-queue: priority queue of pointers to structs
  sort-in-topological-order: use prio-queue
  log: --author-date-order

 .gitignore                         |   1 +
 Documentation/rev-list-options.txt |   4 +
 Makefile                           |   3 +
 builtin/log.c                      |   2 +-
 builtin/show-branch.c              |  14 ++--
 commit.c                           | 145 ++++++++++++++++++++++++++++++-------
 commit.h                           |  15 +++-
 prio-queue.c                       |  84 +++++++++++++++++++++
 prio-queue.h                       |  48 ++++++++++++
 revision.c                         |  13 ++--
 revision.h                         |   6 +-
 t/t0009-prio-queue.sh              |  50 +++++++++++++
 test-prio-queue.c                  |  39 ++++++++++
 13 files changed, 381 insertions(+), 43 deletions(-)
 create mode 100644 prio-queue.c
 create mode 100644 prio-queue.h
 create mode 100755 t/t0009-prio-queue.sh
 create mode 100644 test-prio-queue.c

-- 
1.8.3.1-494-g51b8af5
