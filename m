From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Loosening "two project merge" safety
Date: Thu, 21 Apr 2016 12:24:56 -0700
Message-ID: <20160421192500.23563-1-gitster@pobox.com>
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joey Hess <id@joeyh.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:31:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKJp-0008Ly-1p
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbcDUTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:31:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751571AbcDUTbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:31:10 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Apr 2016 15:31:10 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C46213191;
	Thu, 21 Apr 2016 15:25:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=YkdydZFgcx+QI79VG8DDpLFMzBg
	=; b=Bu5IMzH2gzPk0YTg8DkOZduktLXwSRNMPqAuuAPEY7HSLd/6QMc2ztYuzGS
	EnPXViyU+dQKt9Xt4KR5vcI7tZPzCuF9mVId/UuO8hIdQ3XmDtRfuc9YCXIGsCVU
	Je2pF9rUzAiqlJ8AJiVMQHIWfNN0Z3vBog4p9aKv2o11+pM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=fS7IICvmNoDV9hYobbXVO
	vE9ntH4ENUvI1aFmS+u1uzHSPQilBpD4CkIdLHkQVyVWoPq4XwCmsYgY48T8sgAw
	SXcS9GgcZrvb/3+0httlhJC6tAo0VcWTf8AxoJDdpBZP12pTMf88Nq9juGiwqWqv
	zblr/hO9yOIx+aTLfr5dFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 33C271318E;
	Thu, 21 Apr 2016 15:25:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 556F41318B;
	Thu, 21 Apr 2016 15:25:01 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-422-g6d9b748
X-Pobox-Relay-ID: BE132FAA-07F6-11E6-9457-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292145>

Yaroslav Halchenko gave a vague "forcing 'git merge' users to always
give --allow-unrelated-histories option when they create crap/insane
merges are not nice", which I couldn't guess the validity due to
lack of concrete use case.  Just in case it is substantiated, here
is a series to selectively and safely loosen the safety for specific
use cases and users.

Junio C Hamano (4):
  t3033: avoid 'ambiguous refs' warning
  pull: pass --allow-unrelated-histories to "git merge"
  merge: GIT_MERGE_ALLOW_UNRELATED_HISTORIES environment
  merge: introduce merge.allowUnrelatedhistories configuration option

 Documentation/git-merge.txt     | 14 +-------------
 Documentation/git.txt           |  7 +++++++
 Documentation/merge-config.txt  |  7 +++++++
 Documentation/merge-options.txt |  8 ++++++++
 builtin/merge.c                 |  6 ++++++
 builtin/pull.c                  | 11 +++++++++++
 t/t3033-merge-toplevel.sh       | 31 ++++++++++++++++++++++++++++++-
 t/t5521-pull-options.sh         | 28 ++++++++++++++++++++++++++++
 8 files changed, 98 insertions(+), 14 deletions(-)

-- 
2.8.1-422-g6d9b748
