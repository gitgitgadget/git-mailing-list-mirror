Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F380481AB6
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667164; cv=none; b=jdr8vL5/xs4jVnnNZaMwpDc+RJKTQcw+0RCo8SraHL+6DmP71WF9TTN1X5kjjPb9Z6ZIWsFoC4hjJOtye9c0y877ue6iA0N0oADZtG1llnepaYgltwRC4+GuXVFKTi5R7tq0AoFn3LzgJFiAueGdqkNhn0xrF9KUg2+44bXcmZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667164; c=relaxed/simple;
	bh=PkTjcZN3pMGV5kXaYqtWW9ZmGnDkdfEdg80GgzM77oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9huhnEQklrNh+WDNHZwF0j2DFSH1KM5kPaB7pt2qT20L6NdUHhqbM8RxCRTFkDYWXSXrheHE3QHQy1+8ZS/S7fUxVUtn27iNxufmJZ5WogO8iPABEHkxLpeqcCeI+SRJtwQ2cM8H90j7TtifbGsOw1yMTswhaV32SoOhIvHp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dI/wG3e5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mdR89MXI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dI/wG3e5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mdR89MXI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 186BE1D00113
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667161;
	 x=1787753561; bh=hM5d+XdvC7zhnClW/jL7jVgjRy8Nnj6Do0nwmOw0Y6k=; b=
	dI/wG3e56W3STuLCwIlH8jQTIhEAW556geVKqsfEKtXlv3wt2YQXENYjTpQ2ZbxE
	ETOVKHRbUEuwapoTD3n9QbeUqdoVGZxGHsQOSqIh0F9oXE0EJ8h6NghM26OzjXE9
	5zDufoXVfltYRnsQEA4u01kSEXLGqEzbgjEfJl1oKaZXOi+PSgX15BrSgcnIPQ9c
	dMnmV3Ij1uFNTzeG6TIvcoSxkpEk/57I3cnM0L27V9+wGBdqsVRe6sonJFVMo8EI
	RkXQt2k3pVZSoBUWGKd0R9wDPKAxQ2Tsw63hx32rgEcn/9TU+TCc8sYDRXyFm8I8
	T/OBi7bDDbKj7sMBB11vMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667161; x=
	1787753561; bh=hM5d+XdvC7zhnClW/jL7jVgjRy8Nnj6Do0nwmOw0Y6k=; b=m
	dR89MXIRCBhGLi8O/Uiy9r5OcM8irVHgU4l/hqjWV9upT1IhsDl65Qj6zolZEPsj
	2S3fpYyNKEINs3gQsMRZd0ZBj1Kv+bNHzFGQn/x2e4Ed4EiBVEb13m/k2Hua2Myy
	ht+x5njHwzfriPYWHDvvuRCRt6R9o63EQhMUNOwvpUykBj+hibyeXv9pu6B+qJM7
	+mOVPfY+60LlPOPFW76i8o8VTmUKQsgRGHa7FosJYBcTZptb5pJfcVsdTCL1HeGq
	FKSHvcp6XWQNmxB5wkbzl1dr/88iBdhBouYIJ2htyzHUBMhFEpbevJZ+GjUU/Djk
	xZ+8Wbw2v9Hof1Vo3hM/g==
X-ME-Sender: <xms:2aKNaqXoyOgFWXXE3Uy8a0uOn6y_9URNDIuFMgik54O7tf8dxAbj9g>
    <xme:2aKNathgS9O5a39gDbng7ziZWCNkkc06fGBBio7pqqbIU2BUUx6dk8kuTFhnj8jiT
    3SlJ9Ni1uRAti5XPf8o8gmHa4Aqk4odLRo0rD8rwYGoNMBpA5JMxLM>
X-ME-Received: <xmr:2aKNakC3XMOqsCewvB6JMAdbeFBBF22hMt_sBhDiJ4GRbD94q-llpbE72_MzPt44rYgE-3XpScDmxMgNtctg9z8EBROoNTbJrrHmJ7UGww>
X-ME-Proxy-Cause: dmFkZTEsXi3aaEhf5NN082pEBCN2IoLit4x4y55COggZ/ldf/Z6KlO3Y+c+xvlMhdzJL9F
    6K5RIkbCT4SQvHLC+gmdx9M8UiE2B6ZxkBKRd0z9oiUi188IUTeKgQ9Z5Rs+RN8yxQU9Qc
    lAKP1FIOQ6GKDPUMxsTD0RwTelpsL8gg5ZKJU0FroW0wfvl7TREjmrracHWBxsuhDw65F7
    fBi4NNfkKdVTwfZEVgSySH5Vs83taVEpd8c3WR5hK+EhZf7PeOLWMTljD1i8QOyRvmnDAm
    q5V8c1wIZXv4PO0Dw/qqtThLyYTCv1b/OPkAyR8Sh0H9xhriwPEWmQ7ZQ6K6O2jxqHM1X8
    +yI+dis5nWrk5eG6rQQgexRtdDImlkCLxq+/PLlNT080hEXXTT6IOZggU6M5ane7lOwL7v
    BBCpDsH/F7yShuyzKakgB40ZB321G5jXN7nLHsvp5S2+KHFRgCPIHcP9ousYTu+SnhWz7e
    Xwr1WGDbYVIfjHHiqLu+bJ2JmevVhsIsaOPBQ0sEtjKlyH0C0HwcWVRF59SPo0Eb/Y1mRZ
    ekXCESy9tgtlj1/tjqET5SVQRHP7dYjJCOMMqfuYgi2P88I2QRjj3tOxY86EM2cMvw3MHV
    R4Btvza6ziCxY7yUw0nyn325VM3RHu4cupqdamaB1MgBWAVku8WRTBdbbTqw
X-ME-Proxy: <xmx:2aKNamcHk1Ib93CqjDHrH4lSOipxppjT_lU67UYy0rjTlwCSC1ABHw>
    <xmx:2aKNakemWQfNFuL65rVLIb3GcYhDoMU6DGsjOgSKavD4UlWr0nZjwA>
    <xmx:2aKNaiiDrknynMctUEAJSWY2Uzg1m-ZAfAIuaXItG4iCHmHBQolQ4g>
    <xmx:2aKNaoTRAtGY2jacZ_NLPBS_rAwg1dJpfWU03vlbQJ3Cn2zZxIMC8w>
    <xmx:2aKNapn-A3ohZA3Nloy46jpixz6GON79CXEosMAoxXJe_2rgIJgcVgqz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0fd3a767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:52 +0200
Subject: [PATCH 3/8] builtin/clone: refactor handling of
 "--reference{,-if-able}"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-3-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
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
the alterantes into it one by one.

Prepare for this refactoring by collecting the alternates into a strvec.
Rename the function to `collect_alternates()` to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8c990ce0cc..8eae3ac7d9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -154,24 +154,26 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 	return canon;
 }
 
-static int add_one_reference(struct string_list_item *item, void *cb_data)
+struct add_one_alternate_data {
+	struct strvec *alternates;
+	int required;
+};
+
+static int add_one_alternate(struct string_list_item *item, void *cb_data)
 {
+	struct add_one_alternate_data *data = cb_data;
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
+		struct add_one_alternate_data data = {
+			.alternates = alternates,
+			.required = 1,
+		};
+
+		for_each_string_list(&option_required_reference,
+				     add_one_alternate, &data);
+		data.required = 0;
+		for_each_string_list(&option_optional_reference,
+				     add_one_alternate, &data);
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
@@ -1343,8 +1352,10 @@ int cmd_clone(int argc,
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
@@ -1641,6 +1652,7 @@ int cmd_clone(int argc,
 	string_list_clear(&option_not, 0);
 	string_list_clear(&option_config, 0);
 	string_list_clear(&server_options, 0);
+	strvec_clear(&alternates);
 
 	free(remote_name);
 	strbuf_release(&reflog_msg);

-- 
2.55.0.822.g20453c30eb.dirty

