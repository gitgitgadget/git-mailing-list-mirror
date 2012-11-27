From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] "diff --stat" counting fixes
Date: Tue, 27 Nov 2012 13:21:45 -0800
Message-ID: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSbZ-0001zD-VC
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab2K0VVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:21:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab2K0VVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:21:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B5F593C4;
	Tue, 27 Nov 2012 16:21:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=hsqIKZON/51RniCQp0979VVceiI
	=; b=rK8KrHeCXA0zqlUioQQtAPDDUmgyQJbvDtsKChY0/F2CtVjxsPjbpySxY3I
	ZdzYrOz1TiI8dX5KeNAOGYPYhOiatXENHIZkPHsXizWjlm+AzlEbVOmLgB/SJdHw
	IMkpzJRBfNWgmFKD+vnOA+BArlKoVmQjJnTj1UXZfB1QwqHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=W/88yLjrFiwyVoBDtJ2xF
	ndvv7Sf2x1/Ln5BfBY1Nvyn9idm3Np1kka69xROe9fHRT3IeoEPwIoigUJOB1y/B
	lBl03r3BjUu9OPZAcIarUbta+Lz1htnzxmM3f6OigJnGQr0eEZa2hkZLoPLqgP3Z
	04YTZtGc8FaopK9t/yxlNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69AD893C3;
	Tue, 27 Nov 2012 16:21:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D320093C2; Tue, 27 Nov 2012
 16:21:51 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1.331.g808d2af
X-Pobox-Relay-ID: 7605E81A-38D8-11E2-B3A3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210599>

It turns out that there are at least two bugs in the diffstat
counting code.  This series comes on top of the earlier 74faaa1 (Fix
"git diff --stat" for interesting - but empty - file changes,
2012-10-17) to fix them.

Junio C Hamano (5):
  test: add failing tests for "diff --stat" to t4049
  diff --stat: status of unmodified pair in diff-q is not zero
  diff --stat: use "file" temporary variable to refer to data->files[i]
  diff --stat: move the "total count" logic to the last loop
  diff --stat: do not count "unmerged" entries

 diff.c                     | 49 +++++++++++++++++++++++++---------------------
 t/t4049-diff-stat-count.sh | 46 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 23 deletions(-)

-- 
1.8.0.1.331.g808d2af
