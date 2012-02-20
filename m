From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] diff --ignore-case
Date: Sun, 19 Feb 2012 18:16:23 -0800
Message-ID: <1329704188-9955-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 03:16:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzInt-0007il-MI
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 03:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab2BTCQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 21:16:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2BTCQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 21:16:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FEA077D3
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=dCFnYbfzMt7I6ha1vpzMzVLXlIA
	=; b=kMQioi65ZzVDrgCsYQr0keysknQbUzpoz9Ai6iVaG+P2cv0l3dTJGRUL/h6
	OHKW3WzPzU4hsB0ri3RCvOCdRguqFhhcD+9Celg29Yl+AEyY62dRFdU1teZJS0GS
	x86ZOqhddmzpb0MRjYFu0u/c5n2zG14oD/oAX3brKVKuU3c0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=Gk/TaCn6Bwe6u5m/TWffSfDffbJXo
	6FJyJnbOKk0K2Mxb4tUam2pSa/oKthBuX8tP+GjXjFaHt21emW2zFGwH+EfTvk3L
	g5QfoJX5sZb35pRHMXKu6hL/f82enM+9ekPa4YfFCnGDedkhiibcQA73wtihHb+h
	bUyWgboI+2lwaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3747077D2
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF73477D1 for
 <git@vger.kernel.org>; Sun, 19 Feb 2012 21:16:29 -0500 (EST)
X-Mailer: git-send-email 1.7.9.1.265.g25f75
X-Pobox-Relay-ID: E665119C-5B68-11E1-B324-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191036>

This teaches our "diff" machinery to optionally consider lines that are
different only in upper/lower-cases to be equivalent.

Junio C Hamano (5):
  xdiff: remove XDL_PATCH_* macros
  xdiff: PATIENCE/HISTOGRAM are not independent option bits
  xdiff: introduce XDF_INEXACT_MATCH
  xdiff: introduce XDF_IGNORE_CASE
  diff: --ignore-case

 Documentation/diff-options.txt |    4 +++
 diff.c                         |    8 +++---
 diff.h                         |    2 ++
 merge-recursive.c              |    4 +--
 t/lib-diff-alternative.sh      |   45 +++++++++++++++++++++++++++++++--
 t/t4033-diff-patience.sh       |    6 +++++
 t/t4050-diff-histogram.sh      |    2 ++
 xdiff/xdiff.h                  |   19 ++++++++------
 xdiff/xdiffi.c                 |    4 +--
 xdiff/xhistogram.c             |    2 +-
 xdiff/xpatience.c              |    2 +-
 xdiff/xprepare.c               |   21 ++++++++--------
 xdiff/xutils.c                 |   54 ++++++++++++++++++++++++++++++++--------
 13 files changed, 133 insertions(+), 40 deletions(-)

-- 
1.7.9.1.265.g25f75
