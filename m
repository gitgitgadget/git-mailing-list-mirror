From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/10] fetch: allow "git fetch $there v1.0" to fetch a tag
Date: Fri,  4 Nov 2011 23:01:34 -0700
Message-ID: <1320472900-6601-5-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKO-0005a3-D6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab1KEGB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:01:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab1KEGBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:01:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0005A3C1F
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=chzW
	atXPNuKTJ1zKyOH4p3UDCkE=; b=IRbq1EK4d/jRSf/h++j35rTtpJjJcc8xD0hi
	TBQgf5+vzJn1vSfokvx5xtTOfEbeS5TBh507lv3qq6W+FBWbXTys9pNYqb/xOv9y
	Ig6QQYb5zpdJHUT7O5Q8E3EWRBQQ9qJnuh2+Q4KmHpi3iYWSGvvde7TwLsjOtKok
	NVFKNiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MUJiZD
	iZi0wQzlAB+7UckfNQh/dsFHu6ELG1nTtF9GO/AyT5nk6ZRPzHywgJrUwPYIXPZI
	UgPxnosBRGzZbc5MqxT6+quu+2dyt5q75wMnYwZJVnTcDs70qjGELT8FzuXiVDWr
	CLsL7C4YBeKLWbahCMrAzWQEP80NLFisnAMSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED3A03C1E
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83DE73C1D for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A7315CCC-0773-11E1-A364-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184825>

You can already do so with "git fetch $there tags/v1.0" but if it is not
ambiguous there is no reason to force users to type more.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index cab4394..ff20eeb 100644
--- a/refs.c
+++ b/refs.c
@@ -998,6 +998,7 @@ const char *ref_rev_parse_rules[] = {
 const char *ref_fetch_rules[] = {
 	"%.*s",
 	"refs/%.*s",
+	"refs/tags/%.*s",
 	"refs/heads/%.*s",
 	NULL
 };
-- 
1.7.8.rc0.108.g71b5ec
