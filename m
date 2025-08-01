Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94CD21FF44
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085875; cv=none; b=W8HYQtwcZ/nMBishjopGsvsX6chOjILL/gLnwhXtexlhaXq8fVH3/sz/k7O1wdVRqKlCWteenG8CR17IpKHMKvQigOrDhdBVIqMsj6iMVb588IY79a47so8JQu3sooCbQHm5JzWfuzGNNaeB8iy4PzY9jPGFuaVjQ8/OXCKHBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085875; c=relaxed/simple;
	bh=Qo72M/1RcMRCV5d6TQvmQAHcXIb+cDyN5xO7FsPJCYk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qmsre6rXrAMhJuwGGl/AuVkHn76IfYJwaQXAcEF3qw+7p6ENewnkE8oFyHSk7yx6RyvdD0ShYJpX52jeEOmGyaAwlpWpvyZnNVnQPMy8GOU20DE7A6X1RdmrF3GO1GoaZJV9EBqewb/AGFzGDAt1Ao8u5esgcGtkmwDkn1FLkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GLcEnsoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FU+z35N/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GLcEnsoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU+z35N/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B783EC11DC;
	Fri,  1 Aug 2025 18:04:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 18:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085873; x=
	1754172273; bh=EYwBLtS7zWAAxL27klljr0ADzhu4iV684vgM/PRlSaI=; b=G
	LcEnsoZSVsXc2kWVEnvKbkx3+YQRvjw6qNyLhrW80var6eeqsK7sL7y6wm9BYght
	X8YoyHlKKRsR7+/ksEMwRiXJib/KA5zzExaQ61HT6pQ9vxxYDNhOaafT98vO6rbq
	0uq/VtkZ+tdMxvvoUDaA3Ys/VSFb27F8vVSpX1mgMJZreDkd4QGINLXmMNL47xtc
	dqW5b69tJubkH3R7+sZK4pNz0FEBfjDKtrU4gjJcwTYn312tdCyc1qESp/HmX0jb
	TYhHRRi1dWcOtmGQLd7vi+4pmU7n1yb7+rS6k3DnrelH6Z+Bt4Kw8eP3MqaB+VhS
	kvrvljypieSTqCYrGDI4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085873; x=1754172273; bh=EYwBLtS7zWAAxL27klljr0ADzhu4
	iV684vgM/PRlSaI=; b=FU+z35N/RSiuCxCYhpDfDx4JQkFuH2xkh1x/i/8zzO0u
	BXtjXzub/lPtnUMZmTRYHmSD8Nk9g/0JG058tjIMDrNXdF/eS88sWycfHra+F7P/
	Kgkzh84qrnTya9gOCX2hHmutjpJ5/ZN3x7mpUkHDpvY+gETFLpPYpzSZGsuaFS1S
	CI8Kq9og1or2yPn3oqinAdVJdjKCP1SvVhlkLcFoz0J+J6RnGiaEyOTi+jmiOpCH
	HVU/f5nyYtN3Im6LIMqimHVVUEGmz6I6miFOJb08L5Q0RGYCQpdxka6yDS/xWfkD
	ZXJh5OmYK19iSzvK2jeXtxv1gezKPxHOQ3SOU55esA==
X-ME-Sender: <xms:8DmNaENia2DUY2AwMuc8qAwk4dtOut-m9zcJhb0b2WCX11uPdKkMSg>
    <xme:8DmNaLL-DWw3MxFYHF9R13hQOGq7yoKZxmujptjGj04SfOlcX3-t7C312cQaf07-0
    HyjQ2KkwWmwYZ-NeA>
X-ME-Received: <xmr:8DmNaNGmu-SZKM9XAcmrAtPgIa5QvYA7moUtqqwjdb-FyMieOubdVA6nEOh40BetyiGiJJlqJSiR1gURpIGRAv7fMkp8WObGx7ZkhmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:8DmNaLRKOOwDD5FeEH8wBWh_NXdZsdi5X9Uirzq-A4ueQz2jEnch7w>
    <xmx:8DmNaBFynbouSu7myAkNQjIU8J38bTHpufJKQIbCWTF9To_rix3uEA>
    <xmx:8DmNaP-JxarsbFgY6E7RRJcnQApem5m372tlTw9FkbdfwZ3bzMXjYQ>
    <xmx:8DmNaDLT_DrkSe_MMpJEqsmsvnff7RW2gdd8r-FGfr6s6SOLYCAMgQ>
    <xmx:8TmNaGy7gd19m4Tw6AHf_EBFR8MpFcJZQuBLAMerQ5cnNjFN83oSArd5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 5/7] diff: simplify parsing of diff.colormovedws
Date: Fri,  1 Aug 2025 15:04:21 -0700
Message-ID: <20250801220423.1230969-6-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g85c5610de3
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to parse this configuration variable, whose value is a
comma-separated list of known tokens like "ignore-space-change" and
"ignore-all-space", uses string_list_split() to split the value into
pieces, and then places each piece of string in a strbuf to trim,
before comparing the result with the list of known tokens.

Thanks to the previous steps, now string_list_split() can trim the
resulting pieces before it places them in the string list.  Use it
to simplify the code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index a81949a422..70666ad2cd 100644
--- a/diff.c
+++ b/diff.c
@@ -327,29 +327,23 @@ static unsigned parse_color_moved_ws(const char *arg)
 	struct string_list l = STRING_LIST_INIT_DUP;
 	struct string_list_item *i;
 
-	string_list_split(&l, arg, ",", -1);
+	string_list_split_f(&l, arg, ",", -1, STRING_LIST_SPLIT_TRIM);
 
 	for_each_string_list_item(i, &l) {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addstr(&sb, i->string);
-		strbuf_trim(&sb);
-
-		if (!strcmp(sb.buf, "no"))
+		if (!strcmp(i->string, "no"))
 			ret = 0;
-		else if (!strcmp(sb.buf, "ignore-space-change"))
+		else if (!strcmp(i->string, "ignore-space-change"))
 			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
-		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
+		else if (!strcmp(i->string, "ignore-space-at-eol"))
 			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
-		else if (!strcmp(sb.buf, "ignore-all-space"))
+		else if (!strcmp(i->string, "ignore-all-space"))
 			ret |= XDF_IGNORE_WHITESPACE;
-		else if (!strcmp(sb.buf, "allow-indentation-change"))
+		else if (!strcmp(i->string, "allow-indentation-change"))
 			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
 		else {
 			ret |= COLOR_MOVED_WS_ERROR;
-			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), sb.buf);
+			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), i->string);
 		}
-
-		strbuf_release(&sb);
 	}
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
-- 
2.50.1-633-g85c5610de3

