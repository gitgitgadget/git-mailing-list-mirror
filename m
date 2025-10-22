Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C162F0696
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115293; cv=none; b=S4bPwJ82Op9LHgGQ1noHXkD4aOoc2eejfpVMPSicE8nki//Z3bqx5j7Frf8iRRRJ4E4Fu9PsGDdJ2SFVdO3saOSQvcxZ0SMbMEBdIp3UJXlUNNoyHmShDi+peRbCXdm4ao9jaBZbLykxFeXw/2tn+9IAtu9ZhbWQmnRpTo9vlyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115293; c=relaxed/simple;
	bh=Eg1zJEIyKJyFYBvrIE3tPW8fvRAH0yELrHzbw453xiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+qeYY0A78fip4+lJYGLxwEB+AIOYjGpU7qvgiiXay3qbL7RU+YsekbdGSGPvS5WxzbEq0XjCCwMEDdlCBOvlJQwYuA2rpXcsa7nQcd8LYm30ihqxZ9c5jnkxNEZ+rdqPxpEPK9ShbO4YzNnbmbTw1M8LJgeiE/K6tu++mEtj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SA9R1wRD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oCEkHq20; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SA9R1wRD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oCEkHq20"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEE917A0083;
	Wed, 22 Oct 2025 02:41:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 02:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115290;
	 x=1761201690; bh=8mtdVCGs99E5fz+dgg+jJjGgGj8bku7fdiHF7c1wRZI=; b=
	SA9R1wRDdsf8JQuJTl8Eacy9lrIOcsduTehytqWpx3yWtACJthL+HL5egMipRYlh
	KU8jpldNwabvuleESMT+bEVBHds0OvSzPpHoV/nfiMDjENRUgZ/ZBCEEMB30HuOR
	D7qxKrEHItlkQlY2mCf8aIGRCi+Sx7TQUOyQf3DdLnIVxAUF/LJcBxmC917hnHv3
	dkh/Dot4+vU5/utK6wvcFeCOZdcuUlkORrGr1li0VoVNrd1KjBEy/vaZ5kJ1A8AQ
	rm0oLcsnw/kru3hoG5iUDXt+0FqU0yGl8Jd5N8ucI1HYxBNRHtsz3CtIAellGlYb
	l7I0ym3OydZLJ+KMGKNeMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115290; x=
	1761201690; bh=8mtdVCGs99E5fz+dgg+jJjGgGj8bku7fdiHF7c1wRZI=; b=o
	CEkHq20tWt/PuGmRDkQUMT83GrHpw3n+tZTQLfUEUDz/lfmxaBs1W6V1iwIZQeGl
	h7+PreqYC7oiblw6KSQ7vvsjF+iHlpCSvZ+EDT32Umd6G6SPahLjyrzp1KsFejqE
	/1wN1lUFni1/eBiFFghy4F9nUAPxQzelMpRVw/L2iK/HWDejGW67bp79YQHq2r6Z
	rhznY/M1KcC/iOXRCHGgVUhqDVNKPa1QstD/iDNCh/yK0KIviDRTlxdOU76mA7/m
	sz9s1NLVEf63sT643P6iFPRDdXoI6+Xdl7p0YgcnRHRsbcQimRw15s3DY0cr4B0o
	wWCRCWrjQbn+ZqN+JEvSQ==
X-ME-Sender: <xms:mnz4aGootY6su4hsiG57EDiai3eyGT3aYUzaD2DDzs5cvJXtF061Ew>
    <xme:mnz4aIWymqpsG5qo9OtcZq7o8m_gGgOOq3U6AkVY9GcHSJousuEl5qdgVQh-ZtHD3
    XHudZrxyPUszEsPS-4iIKifjouRdIV4n-E7Osyg9Y7ivGswoe17Py4>
X-ME-Received: <xmr:mnz4aFDboNHJXR1-AqwCvOXYgel2QQC-_TSDqNNpm-07HTOL3NzwoUDDzL5yxHfPCXsKOmOHuovM7RGfA0nl7_wos5JTxS3SeWONyggLHPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:mnz4aM2wNDiKO0529XGODMGIUrNsMmC_l5vLG_K7btUFPHA7IKk3cw>
    <xmx:mnz4aH1EuW6Hk2k6tpARNF_2tlJnmuXkrTzH77kWnuOUtru8pH3z2g>
    <xmx:mnz4aBCW1rBJ2FNp0nOanhI0TH9m5FcZSUWcnRXKfGaShMMzAkDzkg>
    <xmx:mnz4aG67-FoQeyrQSrtndaQBWeVERgItHURZy-Tqkerg8ST9Jp_QCw>
    <xmx:mnz4aPmoJ0bdlNvTVCeHQ0SKlhAKb6PMrei8KnjUnYHXCvdU0LZUpA4I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7b198661 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:08 +0200
Subject: [PATCH v3 08/14] builtin/show-ref: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-8-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The git-show-ref(1) command has multiple different modes:

  - It knows to show all references matching a pattern.

  - It knows to list all references that are an exact match to whatever
    the user has provided.

  - It knows to check for reference existence.

The first two commands use mostly the same infrastructure to print the
references via `show_one()`. But while the former mode uses a proper
iterator and thus has a `struct reference` available in its context, the
latter calls `refs_read_ref()` and thus doesn't. Consequently, we cannot
easily use `reference_get_peeled_oid()` to print the peeled value.

Adapt the code so that we manually construct a `struct reference` when
verifying refs. We wouldn't ever have the peeled value available anyway
as we're not using an iterator here, so we can simply plug in the values
we _do_ have.

With this change we now have a `struct reference` available at both
callsites of `show_one()` and can thus pass it, which allows us to use
`reference_get_peeled_oid()` instead of `peel_iterated_oid()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4803b5e5986..4d4984e4e0c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,31 +31,31 @@ struct show_one_options {
 };
 
 static void show_one(const struct show_one_options *opts,
-		     const char *refname, const struct object_id *oid)
+		     const struct reference *ref)
 {
 	const char *hex;
 	struct object_id peeled;
 
-	if (!odb_has_object(the_repository->objects, oid,
+	if (!odb_has_object(the_repository->objects, ref->oid,
 			    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
-		die("git show-ref: bad ref %s (%s)", refname,
-		    oid_to_hex(oid));
+		die("git show-ref: bad ref %s (%s)", ref->name,
+		    oid_to_hex(ref->oid));
 
 	if (opts->quiet)
 		return;
 
-	hex = repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
+	hex = repo_find_unique_abbrev(the_repository, ref->oid, opts->abbrev);
 	if (opts->hash_only)
 		printf("%s\n", hex);
 	else
-		printf("%s %s\n", hex, refname);
+		printf("%s %s\n", hex, ref->name);
 
 	if (!opts->deref_tags)
 		return;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled)) {
 		hex = repo_find_unique_abbrev(the_repository, &peeled, opts->abbrev);
-		printf("%s %s^{}\n", hex, refname);
+		printf("%s %s^{}\n", hex, ref->name);
 	}
 }
 
@@ -93,7 +93,7 @@ static int show_ref(const struct reference *ref, void *cbdata)
 match:
 	data->found_match++;
 
-	show_one(data->show_one_opts, ref->name, ref->oid);
+	show_one(data->show_one_opts, ref);
 
 	return 0;
 }
@@ -175,12 +175,18 @@ static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
 
 		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
 		    !refs_read_ref(get_main_ref_store(the_repository), *refs, &oid)) {
-			show_one(show_one_opts, *refs, &oid);
-		}
-		else if (!show_one_opts->quiet)
+			struct reference ref = {
+				.name = *refs,
+				.oid = &oid,
+			};
+
+			show_one(show_one_opts, &ref);
+		} else if (!show_one_opts->quiet) {
 			die("'%s' - not a valid ref", *refs);
-		else
+		} else {
 			return 1;
+		}
+
 		refs++;
 	}
 

-- 
2.51.1.851.g4ebd6896fd.dirty

