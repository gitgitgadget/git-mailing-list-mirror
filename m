Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EFA923
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883089; cv=none; b=PkVuq7+1cjl/onGUhWYPWVo+tqokfKP4eSvy5PTtIwWctNckvku6yVUpJ98L/S2xpgtoVBYatoAS/ZY+ZYJJ9KkxwoP0Fmy7VfyJLWkc/0OjPMAEnytOtjPYEk7ypthU6uvQ7tIXwBSv9ey6LVnGIpOF2hvwLB/T6G+ZK0lb0zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883089; c=relaxed/simple;
	bh=sgQ2xY+5aErXdd7QXU9Wc+t0wrHBrGhZqNSXjesW9U4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=db+/HOePtbLQ88MCxsbpeMJhX+cF49oqyEDM5vswon5tB+1QVZrMmlulh7sne7tW2Be8MK8PRTYcShPNLfmhw3ckB8sUV20SW9AtGHKxK3BWY/7kCDFBqWdzfs3pNvIV75L8Ja9uRXHVy8GR9lTYg3QF0gSUx080vVZlTUl2fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AjhpbzB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P01MNH9P; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AjhpbzB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P01MNH9P"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CDDB7A00CF;
	Fri, 18 Jul 2025 19:58:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 18 Jul 2025 19:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1752883085; x=1752969485; bh=INDcrm+Q3IDlXn1fmQAnZioMOpHabOGs
	c54+S7UzAt0=; b=AjhpbzB3HzO5GsT38QJZN6hmHxHfAsDFJQSyoR2D6JOQQE6u
	YNrrn1PBrzw3/cq0ILHKb2rf9TEeY8rGGJm3eVzYFhH6dI+w0fWkgod7ifWQvaVi
	idCFf7i2E+yGTowkTDWAbWhTInn4urKFtL7xMpfnDnJLD/sJ872PQQu3DIWw0q3T
	KSSYas+FnrZG/or6owNgfhXEWGJgba4ji+gbnWuhjGZsbQYVZwhR3Mw1yBtpBjrH
	hyf4EW354Op7fb4sZD7R9DLVrhqpvB0tCTOdKj56YIQISJ+dgyXpTjPo+eNENhZ9
	9tb07YCuptGCkQo9Z4LcEupOvZLxOivrvmzcWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752883085; x=
	1752969485; bh=INDcrm+Q3IDlXn1fmQAnZioMOpHabOGsc54+S7UzAt0=; b=P
	01MNH9P/T+tsjvj1ghHHTgS9cg+AHjqoaN6wij5GL7Qd4vpgkSLLeqAYmziNq9DO
	kE0uO4qm28Q4JdMjAqZICdyDLX/qASnrjlK09+fhGiASUdkI28EHAaZwVDY+99vn
	ad+A9i3LRv3F3rQ0OGbc1Pm4MrdvNZbfVfcS+E6n4tU2FgKcPOlFL9A7+83YPi6W
	HsJDshmIRCBRUVliSjywT4cISxfGV4H6BkI6BfNqJTayQGZ4dVcQ1Fk7FeKWJDy9
	AzsHcVETqFatuP5ZWQUKFEj1y7I5SbTm03kOOc3BC0qSsVJ8KDYAc8O9ACk6Bxrt
	Yy0u5vNJCJVivMzJ3wQug==
X-ME-Sender: <xms:jd96aJWRJpTTLK-YFEhWRWCxKk5tcGyMp39jscT7iYF8zUmGn1nMIA>
    <xme:jd96aJzQ3FpUl9_vtRA508ncJoYJ0sx5NlL83jW4IvMtiETbs6Mp4I3rcx2gd1FG2
    DqU1eR3sWC4oWEuXQ>
X-ME-Received: <xmr:jd96aHNDG9PoOtE6e7-j-3wML7o-356PNvb4ezgHlwT_z13opKBnwVGXWOuoSF4xIedVtBesokIyiaGH4zb3RyuITK2NGmPR1AfL6Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeeigfeigefghfdtleevheeujeelkeehtdettd
    egffeuteelgfduueeikeevfefhkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jd96aK6H_zIDESIuQEfysAWceprQESk5uyLTJto6eYCVIdzzPJvaQA>
    <xmx:jd96aIMEs-BPesMF_6itm-ei_F_2gXP3hYEsJ09pT0hp6Miv6OgWWw>
    <xmx:jd96aIlQnyACWMoNwOyJOpnIZm28ioY8sH3kog6RzlPK6MluhzOYzg>
    <xmx:jd96aPRXTsSbk6CaMOT0x0P9MFljB-gq2Q3XisTgb8nA4ZuOVUppCA>
    <xmx:jd96aL77cBF-PcA75Y4e7_fumuLqv_duF-xIzIKKnM9FKbx0zJoKdLRo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 19:58:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] rev-list: make "struct rev_list_info" static to the only user
Date: Fri, 18 Jul 2025 16:58:03 -0700
Message-ID: <xmqqa551127o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The structure has nothing to do with what "git bisect" does; as
nobody other than "git rev-list" implementation uses it, move it
as a private data type to builtin/rev-list.c

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * https://lore.kernel.org/git/xmqq1qdptffk.fsf@gitster.g/ had this
   #leftoverbits tangent.

 bisect.h           |  8 --------
 builtin/rev-list.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bisect.h b/bisect.h
index 944439bfac..8621460f93 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,14 +27,6 @@ struct commit_list *filter_skipped(struct commit_list *list,
 #define FIND_BISECTION_ALL			(1u<<0)
 #define FIND_BISECTION_FIRST_PARENT_ONLY	(1u<<1)
 
-struct rev_list_info {
-	struct rev_info *revs;
-	int flags;
-	int show_timestamp;
-	int hdr_termination;
-	const char *header_prefix;
-};
-
 /*
  * enum bisect_error represents the following return codes:
  * BISECT_OK: success code. Internally, it means that next
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0984b607bf..0a89f4cbf7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -28,6 +28,14 @@
 #include "quote.h"
 #include "strbuf.h"
 
+struct rev_list_info {
+	struct rev_info *revs;
+	int flags;
+	int show_timestamp;
+	int hdr_termination;
+	const char *header_prefix;
+};
+
 static const char rev_list_usage[] =
 "git rev-list [<options>] <commit>... [--] [<path>...]\n"
 "\n"
@@ -652,7 +660,7 @@ int cmd_rev_list(int argc,
 	 */
 	/*
 	 * NEEDSWORK: These loops that attempt to find presence of
-	 * options without understanding that the options they are
+	 * options without understanding the options they are
 	 * skipping are broken (e.g., it would not know "--grep
 	 * --exclude-promisor-objects" is not triggering
 	 * "--exclude-promisor-objects" option).  We really need
-- 
2.50.1-446-g8227aac02a

