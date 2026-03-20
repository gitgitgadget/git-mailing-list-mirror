Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49A35A38B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990480; cv=none; b=IBxu7ujmBWmNz8+AT86ci8Q6SJqYsoAkK59FuHOjNvN3qSQbWy2tP3FfeVF3nuUHRZ4862yUzzycrbTBaZ/sGWuUlcRPUU+3exGcYZuZPL5FZDG1cqCanJwVhjqZk55vbzELOis6k7cvdPRQe2DzfnWc9qYMIPIfwv7S4LqBfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990480; c=relaxed/simple;
	bh=jafjtXhd7gSU0yyuC3VjeeDo0IQw8W+BmGsixxKoOGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmg8/2enpRyWYePHip75PAJMTtoSjGV7dLHEu8z8wIRTKdTsuaQ6Vf6HcULd49DUcwFCknpUPChi8mGMdYJc6gTCgtiPXyLdCUlTxB+vfjveLE5y3FUlEtyGLGeNcrbAwzbgez/MzsX4l6iA1+G6zU11ff0OjM6i2FXuOfbWV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fg0dDBtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2lqZ5ccG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fg0dDBtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2lqZ5ccG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 83CD5EC018B;
	Fri, 20 Mar 2026 03:07:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 03:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990478;
	 x=1774076878; bh=p7LxMjqp6x3nv+w1b7cEth5lrBewKM+CXjMJFKt+E7s=; b=
	Fg0dDBtJGtr0ZcSpW2bUfx6b3Mgpc9EmcHYjRtIeGk2OkZQd5YgtZtJ/RmCJSYFc
	7Wz+3v78ZuNqsXCvunG/LalhK1jImrOsVlDxtFy0kJYRNJLKQHLCHJzGioB+Y/DD
	ms/OXoCDZLuJ7INK6TOIReTzjPTEJftE8S+sw01+8lFs+tdWoRzgUu6JFFrYizYL
	7MLvGyChDddzfw1HaVMj40aqtj5cH4tHm1sgx2EVJv1Bo6qW9hSp1/SdcRJcwIgD
	j+u85yzJIrYpgH/uSfSl0uOxPCCO5BOWK7pDDxdApRByyQnIBsaK0/ffOI1J5Wqg
	8BGXi5j6L+OY8AaECwH4pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990478; x=
	1774076878; bh=p7LxMjqp6x3nv+w1b7cEth5lrBewKM+CXjMJFKt+E7s=; b=2
	lqZ5ccG1PETN8cUhzJOrMFdRBZTcum7H1OgBWwnI02vfrfK7WIVXHx/8bAigL9OZ
	DHp/6605LeKnAplbw50Y4yVN/UwC8/86qUxiSzdlO3qAubyZ72+9kTfdUfRtJTee
	PP1k8Yk/mYoWbZ47jWckfmcAxKdANtGF/HKfptO1ZeVmzXfA9Zy2jq64MrDx+kso
	cfd/XeCVy6wDnqP4iyAOK9zRPGExYc9ODfr4l3bPvj7pq/l50yvE5ZZcUcYN6Wj1
	fScEcpXhpaBZtGE8esvcTql5RR5XFsNkLUXqSPlPayyeAy+OGGqCO0ObnHycYpmJ
	wMuPJVtifu4L0saF/HULg==
X-ME-Sender: <xms:TvK8aYIrnNcR5gD2DfGW9_TbfXTSq_4Rb-8bEmJ79yg61ktF4pDxQg>
    <xme:TvK8aflJP6YSnFW070WQNTHlm6ZmgjNdDfnBGF_ffmkwpnM2bb8jbnTPUGiM3TZKn
    X0Hx2E9Po5q1xGphqLyAqqWDdEYpVxpp1Ji4-9ShyOjQ97UTEjL>
X-ME-Received: <xmr:TvK8aWE9cvmLBcqlShdgzrevfUpUnqISlVo4b_VgR42rkavYklHcr-I1BU1u8eL30IFnBoHjq896G237BQSsIA3XNv4c2lmdaT8308vjBxyi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:TvK8afHL_3TEJuDfnXpwCTAoHTYALPafnznNF5do3aMrRbnwvUrizw>
    <xmx:TvK8aTPXsQw36n9ZXo5okGapOO1pImycX5O8PeWJMm_OyFaLM9TswA>
    <xmx:TvK8aeHzpdbm4QDxdOaojPRhfOc9pnpvujGLfh83FD6oxJKJH40K_Q>
    <xmx:TvK8aaMGBN0u8cZdUvweF5qNIRns1a4N9-pd00GNktPXkYfRFiu0Kw>
    <xmx:TvK8aSvVU7yrylZqBxrptq4l5BPWgPhAMQOWxuGQ8u3nc57pZBOKK22->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acf7b07b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:32 +0100
Subject: [PATCH v2 06/14] object-name: extract function to parse object ID
 prefixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-6-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Extract the logic that parses an object ID prefix into a new function.
This function will be used by a second callsite in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 60 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/object-name.c b/object-name.c
index ff0de06ff9..fd1b010ab3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -270,41 +270,57 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 	return error("unknown hint type for '%s': %s", var, value);
 }
 
+static int parse_oid_prefix(const char *name, int len,
+			    const struct git_hash_algo *algo,
+			    char *hex_out,
+			    struct object_id *oid_out)
+{
+	for (int i = 0; i < len; i++) {
+		unsigned char c = name[i];
+		unsigned char val;
+		if (c >= '0' && c <= '9') {
+			val = c - '0';
+		} else if (c >= 'a' && c <= 'f') {
+			val = c - 'a' + 10;
+		} else if (c >= 'A' && c <='F') {
+			val = c - 'A' + 10;
+			c -= 'A' - 'a';
+		} else {
+			return -1;
+		}
+
+		if (hex_out)
+			hex_out[i] = c;
+		if (oid_out) {
+			if (!(i & 1))
+				val <<= 4;
+			oid_out->hash[i >> 1] |= val;
+		}
+	}
+
+	if (hex_out)
+		hex_out[len] = '\0';
+	if (oid_out)
+		oid_out->algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
+
+	return 0;
+}
+
 static int init_object_disambiguation(struct repository *r,
 				      const char *name, int len,
 				      const struct git_hash_algo *algo,
 				      struct disambiguate_state *ds)
 {
-	int i;
-
 	if (len < MINIMUM_ABBREV || len > GIT_MAX_HEXSZ)
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
 
-	for (i = 0; i < len ;i++) {
-		unsigned char c = name[i];
-		unsigned char val;
-		if (c >= '0' && c <= '9')
-			val = c - '0';
-		else if (c >= 'a' && c <= 'f')
-			val = c - 'a' + 10;
-		else if (c >= 'A' && c <='F') {
-			val = c - 'A' + 10;
-			c -= 'A' - 'a';
-		}
-		else
-			return -1;
-		ds->hex_pfx[i] = c;
-		if (!(i & 1))
-			val <<= 4;
-		ds->bin_pfx.hash[i >> 1] |= val;
-	}
+	if (parse_oid_prefix(name, len, algo, ds->hex_pfx, &ds->bin_pfx) < 0)
+		return -1;
 
 	ds->len = len;
-	ds->hex_pfx[len] = '\0';
 	ds->repo = r;
-	ds->bin_pfx.algo = algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
 	odb_prepare_alternates(r->objects);
 	return 0;
 }

-- 
2.53.0.1055.ga2ffed1127.dirty

