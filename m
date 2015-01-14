From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/10] shallow.c: make check_shallow_file_for_update() static
Date: Wed, 14 Jan 2015 15:40:52 -0800
Message-ID: <1421278855-8126-8-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXZ8-0002o2-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbANXl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751904AbbANXlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7F792DBB5;
	Wed, 14 Jan 2015 18:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UJad
	PgWc1CC0e2LP3MyQ9wJOoVQ=; b=GcitmrBau9+TTl6NaWmzoFwMtOGMPRmmjSYn
	QMAu8bQ8RX/agQKt1qHArH9VikxA0Z6/TGnKGnLXtvYIZHOY6x85ZnZbW3zRCo2v
	W0jsK8dfAOddvon7baIrtCVwgTd6eeC3cEU6giqqldKKQSeuGKk6et8vI46Es5Cl
	TK/3l70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CBPq5j
	VLDvYFVs8X3hdWkAYR8tujt7wFWetuxfqhkGH6ZT0Rw6A0Ug1uCHM/+Rd6oOgm3c
	jkPHl4A6JqfklWkeUwNecmhzC5aqdRNrXS88DJyljgwh576omy5h82xHNqHdgoki
	TXePOzxzq+9WaYJb0OGwoLnCFrs5ntoMvGZH4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEAB72DBB3;
	Wed, 14 Jan 2015 18:41:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC0E82DB95;
	Wed, 14 Jan 2015 18:41:09 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D1387CF6-9C46-11E4-9FDE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262446>

No external callers exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h  | 1 -
 shallow.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.h b/commit.h
index 5cc1e7e..9f189cb 100644
--- a/commit.h
+++ b/commit.h
@@ -254,7 +254,6 @@ extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
-extern void check_shallow_file_for_update(void);
 extern void set_alternate_shallow_file(const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct sha1_array *extra);
diff --git a/shallow.c b/shallow.c
index cdd0775..04ea816 100644
--- a/shallow.c
+++ b/shallow.c
@@ -137,7 +137,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	return result;
 }
 
-void check_shallow_file_for_update(void)
+static void check_shallow_file_for_update(void)
 {
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
-- 
2.3.0-rc0-134-g109a908
