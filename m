From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/12] commit.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 14:05:34 -0700
Message-ID: <20160516210545.6591-2-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Pi7-0001Af-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbcEPVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:05:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750963AbcEPVFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:05:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9862D1C43E;
	Mon, 16 May 2016 17:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iOmb
	PervI4oKi2CDKG+ftdnWdIg=; b=bl3NRemAqa/FCh0h5KqAj7/6i2IJHHTtGinS
	CU6I3VDK8lhpOb0m/WpKAVyQD3i6MmgyP67SD1GJkWy8HKdzi/404mzicctjlUbm
	602gvbVwz80+mf5L2sZMO0qqICdJf2escKegzbbV947rwzofDVkypJNEOxKbq0Na
	7IqQ/Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qV17MP
	oqt0+AKSmlQvZa7urtET86fqJoqlunh5RUQBDKxsrRWFwmRyMByN+YV8DuoA8sux
	9UYBk26dWNwJNLhaBVOp2MA4ptv3bd2g1Occ2NkLm9lrirEJ35gBXJPgImG9tzbP
	pYqrQb4zo+wQu+Qixv91KSUx8+BLHoRt9bo2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FD771C43D;
	Mon, 16 May 2016 17:05:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18FFE1C43C;
	Mon, 16 May 2016 17:05:50 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: F7BC9B58-1BA9-11E6-BB1E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294785>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 3f4f371..1f9ee8a 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p += 2;
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.8.2-748-gfb85f76
