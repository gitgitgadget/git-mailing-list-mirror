From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] push --follow-tags
Date: Tue,  5 Mar 2013 14:47:15 -0800
Message-ID: <1362523639-30566-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 23:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD0eD-0004uP-9y
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab3CEWrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:47:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab3CEWrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 17:47:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4B90AD10
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=HRrALZHbVdXBWRwwhh/o8V+4iSc
	=; b=OxnP4venr7tHoi1tEZX9SOT48AVBHS58ii6FKbwPGERnrhsinOb0NuQu0rM
	SVJw+Sj3McVWXTLPlIZvypYLVaJKq82xNVhO8wv7jtgEjKMf5T3D6Emeb5UphUw7
	bq1Du5dag9NVxIx5vMr2EhsF1nX2JmECbUGRoDP1vIkqz4nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=SOYtTdKzG4Q/O4QnzPvrex3YUcLow
	VQsz+dyBSifD+ub4Y3lu2ikJbTY3yxVbmlySTKXbufcKCGy/o0j/WIvyGE1X1R3a
	q100zuAJseWGeNKaHp4al+2lPBIw5TDqKntWT1jWQguRVc9SF6Ppx3wvFbulNinj
	d4Z8W/+5oyAbFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99356AD0F
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2214AAD0D for
 <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:21 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc2-194-g549a9ef
X-Pobox-Relay-ID: A3CA7EC2-85E6-11E2-90D5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217490>

The primary change since the last round is that it pushes out only
annotated tags that are missing from the other side.

Junio C Hamano (4):
  commit.c: add clear_commit_marks_many()
  commit.c: add in_merge_bases_many()
  commit.c: use clear_commit_marks_many() in in_merge_bases_many()
  push: --follow-tags

 Documentation/git-push.txt |  8 +++-
 builtin/push.c             |  2 +
 commit.c                   | 42 ++++++++++++++------
 commit.h                   |  2 +
 remote.c                   | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 remote.h                   |  3 +-
 t/t5516-fetch-push.sh      | 73 ++++++++++++++++++++++++++++++++++
 transport.c                |  2 +
 transport.h                |  1 +
 9 files changed, 218 insertions(+), 14 deletions(-)

-- 
1.8.2-rc2-194-g549a9ef
