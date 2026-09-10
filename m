Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711E48F855
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052974; cv=none; b=RquxcZflufFo7lh0zej6x2tWKfLYEX+AHYT/WiqBdjCLIvZc2cKI5SskOGeenut53DK1hvX3zp0FBIf/EVH+NYEPBDihuJFjV924ywaAbNqJrMi6a7XYZEELjh39V8jP+KaUzYRcx2oL8E64ESon7UBgeQ6mFmBajDOg6waYv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052974; c=relaxed/simple;
	bh=Q+jtLU1BsGippiD9u64THTEVnhykN+3f80C5noVfULY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGfsMuBxJIhEzXzAkXMr+UEOoI7QUc8ArddCGxbgrm9dWvuin0s4Xuowll11RiYw8J2dvAYU/X4F20UvE8V3vQszejrqga+xriNf1rMaC5oBMrLwRLlyRkw227PHwZ9JMsKzgpjarfcRlJqkMm5dFuROqOMRHDKsMIHTwOSR43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VQsDjY5A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdxY4NAC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VQsDjY5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdxY4NAC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C4A8EC00D2;
	Thu, 10 Sep 2026 11:09:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052968;
	 x=1789139368; bh=Yo7k91wodyo7uZ+QD+47325koolU5nYeNFFPLbOnOec=; b=
	VQsDjY5Am4qp1YpIg0xrbvjT1X+dsUQX2dgtRxZrd3SArhCaFVhOWUgNz86E62MS
	5X/lUMeFMVVSIbMgL5x15IUsoor9PptW5U17IwRv2Zm9WCM3vSmpJ98Wh9iq36Pa
	pAqfomVXztKHKf+EZ0M0JHxYh5SHRpWT6HoNn4UOjyPr1A2y4hlTn1wQ6Zv05M0D
	N7AInvIUO8KitJAN4nb0cGi4N1bfK/AnW5wYqKwgIkyrSRfWkcq2Clpra4bD2Kh+
	pUsV0o+uXC1DnWZRFrXZfzDL7hkmBvGrGiRXJTWx2tJ2yBNuLMgKHcskvrV0U1Iq
	3P/+sOW5kaJ500kiihY4xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052968; x=
	1789139368; bh=Yo7k91wodyo7uZ+QD+47325koolU5nYeNFFPLbOnOec=; b=F
	dxY4NAC+RlVqVT4w1Fvo4G+1oNK3/tEA/c6GVl4rOLbK1knTir94Zw2b1TnMX9bT
	yO27ER1d/oOQ6iGpFtCL5eLHqd9p/aRuTcX7TrBFAAoITjFNox7omSHOKhoYoG46
	u96ZKaGpDI9K3h6FAXiwLnxVqgFlpOHVmaEC617oglzW8g44gJXQ0LqrqWfwRDnS
	Nz0vej1y5NyZJCwGkxBo9/V8Qcp1n0LAtHPxHUKm1dDQL+sJh9kUcpZhTvaxgynD
	AGY4EyY3esFWEAI6d6656B8wPoSsa4oT1r4DYre7jPEYjf0HyNgvMHaQyz9meuMP
	EsisUVVKiw/17pwUyF7+Q==
X-ME-Sender: <xms:KMiiasPI9V3N5RfnhewgXcOvEAvveN7rg6IP2XIpmqm-Eb6VAwQv_g>
    <xme:KMiiap2T9hwMu2gST1QJLHQ_5cTI72Nl1WbwGyep4ZB1bMHiWmOL__5kiL2n3ib2A
    CGmL7smGZJ7pru3vQ2jBaLYhA5I3p7tcbx7FV92oxohx6-hNYOTzQ>
X-ME-Received: <xmr:KMiiarl6artVvQwC-8qApQGFgRENwglPIzAB0YgTjoyv1Azj_3YfMQ>
X-ME-Proxy-Cause: dmFkZTFmToSEG6cpqmLCQ+r8QOZo2Uv1HNL8Pjsku61QT1eJxv8HAXxDAkSPnus9Vecpme
    pJafvckUfXllYevYRFBkacQXQBn8rdjuicwUxeuiCeGMLu8JV5gc998H1ANxSJZJOzN8ST
    fcVH+3fxr6p6VED5/2o1IDBicBEufCXUWBqkwMMuqmPUJ04FWOlsiERIZyEc1auESI2D1v
    8fOEzyOGNyBRwuu2ZC+3sLGRJwSWFrThXiJ5wahfsXtQegDTI0WAbln4OJXJ+DLBsD59Dl
    B9aM5LBBYPa4dZUBIuUN0qT0ZLAElCSu868se35c7jrWDNfeTWqToQ3iexsoc34cVFG3tD
    iDeDsQ/oZLFbIY7tA/OvN/4wpIoNs67P1nIe3M+P48Z+x8w7XjLXGBgv5x3GbIzZMNV7Zz
    6X72VsihNwKmIMDnDARSHZz+I8oGm7vIo10HDsFyJTpLtnw8e2wQEf9fyTwFlZOhEREdUZ
    QsRYteLVsRmeaBL40fdosK7f2vFMTcbFzCrVKXX9IX6Rui1lvypOSN7ZgubK1J9xSP+aYi
    xr1zDq/1fApQUxkGubBwLrX4VIW+KIWVWV/r9mi2adyboWYaBz/JHaYnuZXgS6P/RFVMnO
    HPyRU47cJvf5dw0iSWJoc6K5keOzKU504a7AWd7Rzt/PBKa2x00Yjv7+U1Og
X-ME-Proxy: <xmx:KMiiagWhxYxnng1hQB3MbxdgHNIyVVGnV3VDX-QaGQjCZbIe2m2vYg>
    <xmx:KMiiahvKgXqBIu27TIW6rbYEQaoAt3BmvNDS0SdyD1slMCzXRLgb5Q>
    <xmx:KMiiajapt4OJ2aiRkgtUFyqu7Sb5OGu1wdzC5mknIw6vVOw_dxL24A>
    <xmx:KMiiagXYOj9YtY5mWR5DIP5rXFHGy7KS1gelgYxBSBUzB5Chu00SNg>
    <xmx:KMiiaiziwPhaAgC2T84tPMKWyacDQzL5S_KgEP_06ihEHJ88znxpY3uS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d075890 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:14 +0200
Subject: [PATCH v5 4/9] builtin/clone: refactor handling of
 "--reference{,-if-able}"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-4-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Users can pass "--reference{,-if-able}" to git-clone(1) to instruct it
to set up alternates for the newly created repository. This allows it to
reuse objects from the source repository so that in the best case we
don't have to clone all objects over.

Those options are handled by the confusingly named `setup_reference()`
function -- without the above context, one might rightfully believe that
it was about refs, not about alternates. The function itself is rather
simple: we loop through all provided alternate paths and then, if such
an alternate is valid, we write it to the object database.

In subsequent commits we're about to consolidate the complete setup of
alternates into this function, and furthermore we'll refactor the setup
of the object database to handle doing this for us instead of writing
the alternates into it one by one.

Prepare for this refactoring by collecting the alternates into a strvec.
Rename the function to `collect_alternates()` to clarify its scope, as
it does not set up the references itself anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ac5843d7b9..08d913d306 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -154,24 +154,26 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 	return canon;
 }
 
-static int add_one_reference(struct string_list_item *item, void *cb_data)
+struct collect_alternates_data {
+	struct strvec *alternates;
+	bool required;
+};
+
+static int collect_one_alternate(struct string_list_item *item, void *cb_data)
 {
+	struct collect_alternates_data *data = cb_data;
 	struct strbuf err = STRBUF_INIT;
-	int *required = cb_data;
 	char *ref_git = compute_alternate_path(item->string, &err);
 
 	if (!ref_git) {
-		if (*required)
+		if (data->required)
 			die("%s", err.buf);
 		else
 			fprintf(stderr,
 				_("info: Could not add alternate for '%s': %s\n"),
 				item->string, err.buf);
 	} else {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addf(&sb, "%s/objects", ref_git);
-		odb_add_to_alternates_file(the_repository->objects, sb.buf);
-		strbuf_release(&sb);
+		strvec_pushf(data->alternates, "%s/objects", ref_git);
 	}
 
 	strbuf_release(&err);
@@ -218,14 +220,20 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
 	fclose(in);
 }
 
-static void setup_reference(void)
+static void collect_alternates(struct strvec *alternates)
 {
-	int required = 1;
-	for_each_string_list(&option_required_reference,
-			     add_one_reference, &required);
-	required = 0;
-	for_each_string_list(&option_optional_reference,
-			     add_one_reference, &required);
+	if (option_required_reference.nr || option_optional_reference.nr) {
+		struct collect_alternates_data data = {
+			.alternates = alternates,
+			.required = true,
+		};
+
+		for_each_string_list(&option_required_reference,
+				     collect_one_alternate, &data);
+		data.required = false;
+		for_each_string_list(&option_optional_reference,
+				     collect_one_alternate, &data);
+	}
 }
 
 static void mkdir_if_missing(const char *pathname, mode_t mode)
@@ -999,6 +1007,7 @@ int cmd_clone(int argc,
 			   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
 		OPT_END()
 	};
+	struct strvec alternates = STRVEC_INIT;
 
 	const char * const builtin_clone_usage[] = {
 		N_("git clone [<options>] [--] <repo> [<dir>]"),
@@ -1339,8 +1348,10 @@ int cmd_clone(int argc,
 		warning(_("--local is ignored"));
 
 	create_object_database(the_repository);
-	if (option_required_reference.nr || option_optional_reference.nr)
-		setup_reference();
+	collect_alternates(&alternates);
+
+	for (size_t i = 0; i < alternates.nr; i++)
+		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
 
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
@@ -1638,6 +1649,7 @@ int cmd_clone(int argc,
 	string_list_clear(&option_not, 0);
 	string_list_clear(&option_config, 0);
 	string_list_clear(&server_options, 0);
+	strvec_clear(&alternates);
 
 	free(remote_name);
 	strbuf_release(&reflog_msg);

-- 
2.55.0.1074.ge7621b4bad.dirty

