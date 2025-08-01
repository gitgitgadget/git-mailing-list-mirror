Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86C28DB7E
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085876; cv=none; b=HGw0g2t+fTwR1xSZqwSuu19GRkZqxS6OMBum/kuAYHWrFSO5VPDQv1G0W7Rm+MkyOWdLFETv0DKY+5cSHjb8sqdmZOH2tSnOUG8WwXM9Mwe2CrA9I2DsZAVFR5C/Dpa3T0aItMv/wSxcPdYhEdKFQJKLpBA2D/jOShGUnUP1zeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085876; c=relaxed/simple;
	bh=SpYoG5qLRZUdiYTC7L1izhUfX/P7QFWfaNe6VfYTZkI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7Ome98fr6cr35CtwKYCZXzAKG3dXFBD6J3u1PgSAFXTAEDyzb/6JVZg8E4A+9jsF4SRE10KksiYNEyHGmHzW3u2BLmofhuViRo1EawdB/MPVEF1FLwZLnaLcb0lLpA/LFa8vc4qsFM0iAOrxL7n6aSjGy+KvX9gm+GIBJY6hCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=frSfnYq8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2WfzZ0N; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="frSfnYq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2WfzZ0N"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 633E7EC15F3;
	Fri,  1 Aug 2025 18:04:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 18:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085874; x=
	1754172274; bh=ctF6F88Wr2rgECmF/NqYlgyNfm2hiz+tTd64/D7WH+k=; b=f
	rSfnYq8mQKqNZaL5KhE8sZEm/Ca/5t6zG06BMecA/fHQstrn5OEKbDVVWBQWVV9Y
	LwT5GQWDQZS1eFzs+NKtLPeLI6or4tBMonDChRYFMdifG7Dq9t1MQiXKjGIwGVr7
	ph6L1r0rsOpMxbv/e8/UItwYJXLGTX6vSfqzeGACbuFbLsaVh25Yrl5PLtLCRRxf
	U8TgcP7Ab+o7dHB79muLiNJRN/AcMUHl1W5/8jKFZnlPXSlQx5ZwqZOc2PMFmDDw
	CWoA1rZb4HJw/VK9d0N6ziuaej7AJ0MVPUcpqPY2HJNLg8AB7GWRlR7uwapxEyF2
	istSe8vRfWUKPzExl/3GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085874; x=1754172274; bh=ctF6F88Wr2rgECmF/NqYlgyNfm2h
	iz+tTd64/D7WH+k=; b=D2WfzZ0NafuicwWCyeQVOPnYdPPIM2fzkJ3Lc/PJFPgK
	24tOKiKOf9273tkaW7tfhkoiG6wAz1bejGG6TRpInFbCxrojOe+QKypXUitz97g4
	A/0OTN/+XtrEHZRGe8vKL6xhamy2u/4KFKwawIPD30nKt3NBkSIQeQdzISbIt2bp
	FRxYs7J1WxRkSFAHza+zblWWHoFL1NQvdkq++3QmV5JLaTJjQRtESWJ+UJSrs75D
	IKjCDLClHp0ZMEWJoMbhiTmXO/wvs4pqUx9pOjX4OUUbnxoVyGWeYaJJFh0PQ8Tj
	olMmVC/BoMzXfwbrWRBv/ghfqJrWs+/38DbFOVE8MQ==
X-ME-Sender: <xms:8jmNaOJ_pPdm3ydLMEeIDx44oPkYbZ77o-NZijpLehjtlTdtFey2Ug>
    <xme:8jmNaGV1kFAKe5O8JgMpSuJYguyYCiDMiHXk8bRXrNNV6Pc6Nh1fP8zZngbtj72Bt
    ZzJ4H5MMv6n5DOf-Q>
X-ME-Received: <xmr:8jmNaAgD8Q1kjLPkX8QhtcL4uO6PEctLpBLfHP7KGaLXL6ON0SlFhboV6VD6uHH7s6kvqNWM8h4nyP_WceDHrsUIO_jxHzQDaq_XyqE>
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
X-ME-Proxy: <xmx:8jmNaB_4fR3hExuEmTCg9gFYguhHSjlanEyT7k-Z4ABBOjNkZgobMQ>
    <xmx:8jmNaKBquvfx5lR_YwvxNcOEKJLQAYQVkpJArd-l_X-DZMxqc5DL2A>
    <xmx:8jmNaOLYP90zLI5JL9H1pbwqczjJvtHlMn-quhoQR0kVLvwW8WZUiQ>
    <xmx:8jmNaNlbNC9BuvBLMr4RIht7lBxBhWFj3f49gH6-7GFfVOFvFKEopw>
    <xmx:8jmNaIsUzWkRMZ3Y0e-wnIuPFTtODV4eygxbni19QcuoxsJdvp3zG2XW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 6/7] string-list: optionally omit empty string pieces in string_list_split*()
Date: Fri,  1 Aug 2025 15:04:22 -0700
Message-ID: <20250801220423.1230969-7-gitster@pobox.com>
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

Teach the unified split_string() machinery a new flag bit,
STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces to be
omitted from the resulting string list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c                |  3 +++
 string-list.h                |  2 ++
 t/unit-tests/u-string-list.c | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/string-list.c b/string-list.c
index 86a309f8fb..343cf1ca90 100644
--- a/string-list.c
+++ b/string-list.c
@@ -294,6 +294,9 @@ static int append_one(struct string_list *list,
 				break;
 	}
 
+	if ((flags & STRING_LIST_SPLIT_NONEMPTY) && (end <= p))
+		return 0;
+
 	if (in_place) {
 		*((char *)end) = '\0';
 		string_list_append(list, p);
diff --git a/string-list.h b/string-list.h
index 87ccc5f1e6..c25f28e9a3 100644
--- a/string-list.h
+++ b/string-list.h
@@ -286,6 +286,8 @@ int string_list_split_in_place(struct string_list *list, char *string,
 enum {
 	/* trim() resulting string piece before adding it to the list */
 	STRING_LIST_SPLIT_TRIM = (1 << 0),
+	/* omit adding empty string piece to the resulting list */
+	STRING_LIST_SPLIT_NONEMPTY = (1 << 1),
 };
 
 int string_list_split_f(struct string_list *, const char *string,
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index daa9307e45..a2457d7b1e 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -92,6 +92,13 @@ void test_string_list__split_f(void)
 			      "foo", "bar", "baz", NULL);
 	t_string_list_split_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
 			      "a", "b c", NULL);
+	t_string_list_split_f("::foo::bar:baz:", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+			      "foo", "bar", "baz", NULL);
+	t_string_list_split_f("foo:baz", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+			      "foo", "baz", NULL);
+	t_string_list_split_f("foo :: : baz", ":", -1,
+			      STRING_LIST_SPLIT_NONEMPTY | STRING_LIST_SPLIT_TRIM,
+			      "foo", "baz", NULL);
 }
 
 static void t_string_list_split_in_place_f(const char *data_, const char *delim,
@@ -125,6 +132,14 @@ void test_string_list__split_in_place_f(void)
 				       "foo", "bar", "baz", NULL);
 	t_string_list_split_in_place_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
 				       "a", "b c", NULL);
+	t_string_list_split_in_place_f("::foo::bar:baz:", ":", -1,
+				       STRING_LIST_SPLIT_NONEMPTY,
+				       "foo", "bar", "baz", NULL);
+	t_string_list_split_in_place_f("foo:baz", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+				       "foo", "baz", NULL);
+	t_string_list_split_in_place_f("foo :: : baz", ":", -1,
+				       STRING_LIST_SPLIT_NONEMPTY | STRING_LIST_SPLIT_TRIM,
+				       "foo", "baz", NULL);
 }
 
 void test_string_list__split(void)
-- 
2.50.1-633-g85c5610de3

