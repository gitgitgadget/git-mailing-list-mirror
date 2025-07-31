Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4D1DE4D2
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973841; cv=none; b=V+I71BxyUzNRZfRn/L87lEXYOdK/A5ih7sIIv19RtmSNn+MJBjn/1yOzK5xsrDl+Ubz2f//AcK56Z079h3/ll0a64FhROXt4gfE9DMlKUJfzigwVapKUkqaYz+BOKNk58WMt17ZTVT6Y9NOjS0kN1nBNrLnsg9TS8vFKE26wI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973841; c=relaxed/simple;
	bh=Dntj7ItgjStFXoOCSTEF42cHW0BfIoD/7lrN1jRzyvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M549+B9qaVQ7oXf/m8bNtf3lgaoRpgkom4QNiR1pmEKKnS1i9HXFgJgtDlW6Dxb0KnXg/gyC78oMylu0daO981fxGdVLcdC34CJYHfSyv/+AkLEt1pbgNGMMx4sJcLHWUoGcDDm7ehpwzSgRhdi5LHGx+Ls6tDK//Bal1bTLXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gmJKwuZv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWfYtJry; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gmJKwuZv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWfYtJry"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADAAB14002E4;
	Thu, 31 Jul 2025 10:57:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 31 Jul 2025 10:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753973838;
	 x=1754060238; bh=bGKskvZ/TIrgtuYXp16YoX2DxZs41AHOQT2EZqGhB/g=; b=
	gmJKwuZvn3gI+ERyng3dASbCyFiLxa9tv141OhbIIetZpL6aiMpja12cxhFAeUGK
	jtgTTEXpo4yDpZl1xFXMA1Rx3aGS2C2K/cXff32z31ku8XbGY15RNaMVgFVNueIW
	NHLKnEUH6hoyh53hxOD5P/R12+8Gk6KVK/EEWwy0jiV8M21ReYkhndSRHYYt2CzD
	ytJWW4v3014/982pJPQvI1+lUj6CFIIw4QuCcBiFFfjVLeg2TwluyGW4zcjuZR5g
	GRsxJEfNcXR+XAs509oAK0UMMcQTo0i/NdQaumkVg9N8w1IhqDk/wnz2bNOD3jH/
	vnPQYj1lQDGY+XEdFX1c7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753973838; x=
	1754060238; bh=bGKskvZ/TIrgtuYXp16YoX2DxZs41AHOQT2EZqGhB/g=; b=E
	WfYtJry8A5JkxI0RM1QhLo4cFN1VBNrl9QbxqWeGvIUxE+rn90NHYoTRkYpZBU9Y
	XTy06WRe0TEfX4w3T4PdeSw7gxq5Ri5RLWCmVmxVe/b92xbvzGTJklYJAzCP56r2
	lmGwOZ2TmaeMKTXpbzV8hPIgSl7RvNF3kwVRtmVx7+W7m4UPUEsaq7ztq7U6XQxd
	UTvcCNR4gSDmbVLsXvrAyqeKp3m/xmDeZ1VhTrGTj1282yqQZXGnkeGYrw/CIu93
	ihLO2pxIBWKjPMjzsj8SZdNtZQG5g9vAtSk9bwlTKMKIBIRY//fI8zg3uUCQPgtK
	wMENI4iX47twfxe51DozA==
X-ME-Sender: <xms:ToSLaAVWV18bS-lPd1iZyFiJjPu90jBIf9JOxlmPS_M5eTN0kCXaPw>
    <xme:ToSLaNB41_rY0Q53soPixgXVytU9WFEyUW0lE43U6EWFBmQmFFsMyOfGJ2T9odARk
    J2yBWZFD9hN1Rhjpw>
X-ME-Received: <xmr:ToSLaE3A9gez9rMBVtQl1Htp76s4sJQgf2kmEoWZvLIGoMT8BAF9OEqPVi_lNTlfXVR9DikY_aNv7paWK4RuG25bz6qkSkYsnb9BXr4MdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ToSLaP3dRohQ_pOF-Hn9ePVfE89njzynNpckKh8mgyRehq_YvDMxBw>
    <xmx:ToSLaJDxCUztAtvmaHiepR93rsYw5pX--oKapQLUH8lrhka5Kcr4Xw>
    <xmx:ToSLaO6wC-5iLrLwPE3HxCqQHrKAwLm3pXVlt_biIYdgKFlNhQVxHA>
    <xmx:ToSLaKItJlo0tuIIOYKn8eqPB5ovzHW1Cwl3QqzfpMJ_w3F_qsgZKw>
    <xmx:ToSLaNwqnn0X7xDv3n0qmGYM6jqyYoH3gijby6Uo2t7i76bK43qYXWX7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:57:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 937e2e78 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 14:57:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 31 Jul 2025 16:56:54 +0200
Subject: [PATCH v2 6/6] builtin/remote: only iterate through refs that are
 to be renamed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-pks-remote-rename-improvements-v2-6-dda6f083674d@pks.im>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

When renaming a remote we also need to rename all references
accordingly. But while we only need to rename references that are
contained in the "refs/remotes/$OLDNAME/" namespace, we end up using
`refs_for_each_rawref()` that iterates through _all_ references. We know
to exit early in the callback in case we see an irrelevant reference,
but ultimately this is still a waste of compute as we knowingly iterate
through references that we won't ever care about.

Improve this by using `refs_for_each_rawref_in()`, which knows to only
iterate through (potentially broken) references in a given prefix.

The following benchmark renames a remote with a single reference in a
repository that has 100k unrelated references. This shows a sizeable
improvement with the "files" backend:

    Benchmark 1: rename remote (refformat = files, revision = HEAD~)
      Time (mean ± σ):      42.6 ms ±   0.9 ms    [User: 29.1 ms, System: 8.4 ms]
      Range (min … max):    40.1 ms …  43.3 ms    10 runs

    Benchmark 2: rename remote (refformat = files, revision = HEAD)
      Time (mean ± σ):      31.7 ms ±   4.0 ms    [User: 19.6 ms, System: 6.9 ms]
      Range (min … max):    27.1 ms …  36.0 ms    10 runs

    Summary
      rename remote (refformat = files, revision = HEAD) ran
        1.35 ± 0.17 times faster than rename remote (refformat = files, revision = HEAD~)

The "reftable" backend shows roughly the same absolute improvement, but
given that it's already significantly faster than the "files" backend
this translates to a much larger relative improvement:

    Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
      Time (mean ± σ):      18.2 ms ±   0.5 ms    [User: 12.7 ms, System: 3.0 ms]
      Range (min … max):    17.3 ms …  21.4 ms    110 runs

    Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
      Time (mean ± σ):       8.8 ms ±   0.5 ms    [User: 3.8 ms, System: 2.9 ms]
      Range (min … max):     7.5 ms …   9.9 ms    167 runs

    Summary
      rename remote (refformat = reftable, revision = HEAD) ran
        2.07 ± 0.12 times faster than rename remote (refformat = reftable, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 13 ++++---------
 refs.c           |  8 +++++++-
 refs.h           |  2 ++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index db481f39bc..60e67f1b74 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -720,16 +720,8 @@ static int rename_one_ref(const char *old_refname, const char *referent,
 	struct strbuf new_referent = STRBUF_INIT;
 	struct strbuf new_refname = STRBUF_INIT;
 	struct rename_info *rename = cb_data;
-	const char *ptr = old_refname;
 	int error;
 
-	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
-	    !skip_prefix(ptr, rename->old_name, &ptr) ||
-	    !skip_prefix(ptr, "/", &ptr)) {
-		error = 0;
-		goto out;
-	}
-
 	compute_renamed_ref(rename, old_refname, &new_refname);
 
 	if (flags & REF_ISSYMREF) {
@@ -932,7 +924,10 @@ static int mv(int argc, const char **argv, const char *prefix,
 			rename.progress = start_delayed_progress(the_repository,
 								 _("Renaming remote references"), 0);
 
-		result = refs_for_each_rawref(get_main_ref_store(the_repository),
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/remotes/%s/", rename.old_name);
+
+		result = refs_for_each_rawref_in(get_main_ref_store(the_repository), buf.buf,
 				rename_one_ref, &rename);
 		if (result < 0)
 			die(_("queueing remote ref renames failed: %s"), rename.err->buf);
diff --git a/refs.c b/refs.c
index 04c9ace793..7e2f02dddf 100644
--- a/refs.c
+++ b/refs.c
@@ -1839,7 +1839,13 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", NULL, fn, 0,
+	return refs_for_each_rawref_in(refs, "", fn, cb_data);
+}
+
+int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
+			    each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(refs, prefix, NULL, fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
diff --git a/refs.h b/refs.h
index 0bf50ce25c..19fb1d924a 100644
--- a/refs.h
+++ b/refs.h
@@ -428,6 +428,8 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 
 /* can be used to learn about broken ref and symref */
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
+			    each_ref_fn fn, void *cb_data);
 
 /*
  * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.

-- 
2.50.1.619.g074bbf1d35.dirty

