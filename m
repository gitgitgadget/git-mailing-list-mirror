Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025529DB61
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947729; cv=none; b=ajHacdyZdym67rF8g1Us8iuVH7YD7TBDiY0em1tpy5S8HgiM8SVPNthW+jgGh4syKDDj2nLVnBNTGQNjR6Hr4BZ0f9cWAtBpXBURlN8WNxqjxY899d6vQz9HLcO4YfoNoESGwaAmeDSaonOVA7OFhgBGQ7thUF6Q4nwkuh8IoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947729; c=relaxed/simple;
	bh=eP7eXWiFQ3P3qb/Ri4g5XN7WvHk49kIQxI/UC0AeK9g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+5+EJtu6Qb0CxLRvvBLWc2rTMiOx9hK6rtqwFejnVhCKifiNLwzmgz8iitLCVFPZWPHsjk+owkPFTT3SH+QXq1XPVFAxatHI73Q8Xsq2NeUFKSm4XD3NFsiycH/A851jkJSYdqiy+EShM5FrN71Fx9XppBX8LkZ9+5Ea6UOmSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lAW+oYes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHdQiR1H; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lAW+oYes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHdQiR1H"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D34C51D00BD7;
	Thu, 31 Jul 2025 03:42:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 31 Jul 2025 03:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947726; x=
	1754034126; bh=QkocPr6bKV/q5NfjUb9ln5kiksDNiA9snVlHvTsFCm8=; b=l
	AW+oYes7vWus7olMnvN7ncH+3VmbQmkrf4I5I+Hiz+kt441NU7YNO+M7W2p9049x
	oMdj7OOoh8NAISvzwVG8Su6kUaBAmR5wUVy6FrElwKp/Ig+Dm1TIXQhaNnf4ly+p
	6w3N3ufkaOkz7U4RYSsBSWxyg7psSA1v4bGdB0W/ffJg06iqzUQJGK5tAPNLy8AY
	FE0x9JQ9z7GlBFuesYVhqbvAUnWnvJHNk0j8c9fEZQCWMJW7AzTmJx+Mr2MJLgjF
	e/kmeARbDfNLuFxJ1MpwmrBTAIdNxGD+o9PtS0TUODYsguD8UVDOSKkBpzfgbF15
	0N62HOPwmTOju1Czc0IFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947726; x=1754034126; bh=QkocPr6bKV/q5NfjUb9ln5kiksDN
	iA9snVlHvTsFCm8=; b=YHdQiR1HLLCyYZ9RawdkidbUrAgAz0dw1H9YnFK82xgF
	sj6nA0fTTvyJ7P8E8Y9mOC8j7XlaQ791P2jcCKFgRszbzlm+UyfJHfru0jSBnVTM
	xDQt0FQHXdmAD2TpamEZjwWcQfGff4GsuYHwBYdBC7JZxj8DJCKou6KX+obQ7+EP
	MOZOwvG3MzOyZn9+E6QWbV3Bn52B/e/5BcfphyIl52cbJ8/At0B7TJCHYa7xiHwa
	HXWpt/HoLlH1ljQsiNGNTfoELGjr44zXmyHN4SBZQXNp5ZqOcFTwQaDb8XWqUGeF
	NZgoMcbYV0fNlaGW9ig+q7qsUIsb4/uEl9lnhRpqFA==
X-ME-Sender: <xms:Th6LaEwor-X6kGu9-lRmjJzvkzzAYe2BwO98v6DfUc5I_ylwIViG4w>
    <xme:Th6LaIdmIWzgo_qy5VG1s_6vXuQ4gCdz6mVVNQvhD2-hVxiLw6hhslhXOf88uGV_7
    k3RGuYavMbZ_8yo7A>
X-ME-Received: <xmr:Th6LaII6pMoGIyNMR93X3uY1Qe4v1MjBb1fawSSkNO2agUsAArtiy2JBEcsZzWAVW7cchuTAEF-R-SgErhtbJc8hGYwLOpfYijte-fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Th6LaBEzHGo2dKOEumtDM2c7-Q8XVgNmzJbJjeYJriTafa_Rh1U0AA>
    <xmx:Th6LaKrvJvMnOxkSOYOvMRJPoLFjbpw8S1POZ-QDIZT7UA8BPUxL5Q>
    <xmx:Th6LaCR6M7tgaYND4eplTEnhlC8RIlCQSgOVLlIivvReiyTjMK5OGg>
    <xmx:Th6LaPNQqXfewb2gDd65xhpaWFVRt6wTAQyfm_YKaJevziCJSVwaWw>
    <xmx:Th6LaPU5dsA8OXvNdjIFerLKfPy4VTVYbtvLy_gGKByh_1ran1W6Vyyu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 6/9] notes: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 00:41:51 -0700
Message-ID: <20250731074154.2835370-7-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731074154.2835370-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading the copy instruction from the standard input, the
program reads a line, splits it into tokens at whitespace, and trims
each of the tokens before using.  We no longer need to use strbuf
just to be able to trimming, as string_list_split*() family now can
trim while splitting a string.

Retire the use of strbuf_split().

Note that this loop is a bit sloppy in that it ensures at least
there are two tokens on each line, but ignores if there are extra
tokens on the line.  Tightening it is outside the scope of this
series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a9529b1696..4fb36a743c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -375,18 +375,19 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		struct object_id from_obj, to_obj;
-		struct strbuf **split;
+		struct string_list split = STRING_LIST_INIT_NODUP;
 		int err;
 
-		split = strbuf_split(&buf, ' ');
-		if (!split[0] || !split[1])
+		string_list_split_in_place_f(&split, buf.buf, " ", -1,
+					     STRING_LIST_SPLIT_TRIM);
+		if (split.nr < 2)
 			die(_("malformed input line: '%s'."), buf.buf);
-		strbuf_rtrim(split[0]);
-		strbuf_rtrim(split[1]);
-		if (repo_get_oid(the_repository, split[0]->buf, &from_obj))
-			die(_("failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (repo_get_oid(the_repository, split[1]->buf, &to_obj))
-			die(_("failed to resolve '%s' as a valid ref."), split[1]->buf);
+		if (repo_get_oid(the_repository, split.items[0].string, &from_obj))
+			die(_("failed to resolve '%s' as a valid ref."),
+			    split.items[0].string);
+		if (repo_get_oid(the_repository, split.items[1].string, &to_obj))
+			die(_("failed to resolve '%s' as a valid ref."),
+			    split.items[1].string);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, &from_obj, &to_obj);
@@ -396,11 +397,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 		if (err) {
 			error(_("failed to copy notes from '%s' to '%s'"),
-			      split[0]->buf, split[1]->buf);
+			      split.items[0].string, split.items[1].string);
 			ret = 1;
 		}
 
-		strbuf_list_free(split);
+		string_list_clear(&split, 0);
 	}
 
 	if (!rewrite_cmd) {
-- 
2.50.1-612-g4756c59422

