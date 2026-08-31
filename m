Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D503DAAB1
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170546; cv=none; b=aCCdYLaCiI/BnIQx2LnY3QrbWxukWMCyeqjt9R/2nntO2Qdusv+qHoqkLa2mdU7UFqKg1brg/85sJIhlSRv9n3RedkwtR88aMPiIyopMQhZQp5XKJxwhm0YCgYoawg7yfz33X+Q3DZ9jFWBmCUJAXCTvm8yFFbi2rYFcpFv79wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170546; c=relaxed/simple;
	bh=m+fws4GQDQdCNZ677JnIjZkhjJ6HGhzhR8EqubGE+Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0VaehjkU+6t7YNG3bleOY8+ATKy8/Q+2b47hCl02c7HEY3QGDy1mYkF6Wr5iIej9HstF9wVobnQ8TpPnVa35reaRsXesvW9bUj6rcFVU0jTpCEvD5ciUrjpTiZhbzu1xjez9vHkmd2D/C0WIaOsRRCSXmgXU2inn14EJaI7Uig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E8HJTzNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dmoOAeGP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E8HJTzNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dmoOAeGP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D170C1D000D7;
	Mon, 31 Aug 2026 06:02:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 06:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170543;
	 x=1788256943; bh=vQ2l2opDoWlTBgZOEg4y/7j5Mafi0KnLZp219ChcKiQ=; b=
	E8HJTzNRO1TsptrddQuwP/TRBYrROjcXPj2e5tE47nILUuZ1r0yRaw7/tMCVei4L
	fLwYNp9CcUH2/8TYIQwGSbOgbEO6iLiuJzt7ENm4+qXj0WIyLcWo2yEoFTl78M9z
	Sg91tS8n8q4Y9lfR614FlUZO76oGwlf0Z5D+l1ZFw58/z1XMYp5aBqjoaBUVa9Ht
	T0aRPiQnv6nWb0FBao0Mv47aF1xzAiU4LpvYL4Yri8zjfXdCD7I2vmrxzQW1YjQD
	KwIkDw2B98nJoK+AO0UktFoRjWLpb4MXSKBDeUrexKMDtJTYJyj3RZVZ+NQ61E0Y
	ui6RW04PwsHxEqMuEFHYew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170543; x=
	1788256943; bh=vQ2l2opDoWlTBgZOEg4y/7j5Mafi0KnLZp219ChcKiQ=; b=d
	moOAeGPCm8K3V+rF85pkWNIAezWIQAJnwsg2qyFShn++tuzDx/8KcjcZs63uE/wa
	2vVem/gO66CdmRkGiQ4u3L3CQX76648/JVzwA1MWn7L+hqSRwZ6lxemF8qOzryzx
	LoLGbZwQuzCOhQYzLhZOFU+JXdaByHBtzLXwcnSXiFTXhRcmIGNpuq60duTnW7F+
	NnkgvIBt3dEH2ZMuxjbjffQ+Xp13gh/o0c2AiR1h7WRxw4zvVzASfFepzEkRMDFd
	B9CLZxZAQeUZ0Hm0zXNGjz32iIaedCf8KhsJTiYlufcn5u50+EANMDA6ukjPOQLN
	XemOaJWZurGRBce+YTS5g==
X-ME-Sender: <xms:L1GVav4woRgwGnkZ1FPI1ZH4QW64E9nF6R4sB5xieiTV50HkIl7h-g>
    <xme:L1GVasUHoG7EmBlPfBR-IMrFC_4xBjrtrBjtIp5C-h3a3lzWscTVX5eBycjRBAXUA
    wvbUEhHmTMX0OuK0Sk0Z3EwQCwQhT8ZBZKmEM7RXszQyfTa9Tz72Wo>
X-ME-Received: <xmr:L1GVaj1VOBVYDWNsFtRketJlgf0STpGYmYPT279LeaMSlkoiu0IkNHLQmmNALGxlq00iww>
X-ME-Proxy-Cause: dmFkZTGHUA7KqT16GbV2AYtUMBXxZvbu0kHMHaGO2coG/xVALTL8GSgyyIm6N4JdTXGfGp
    fZgPoMuN16ezFPjkmTXw3ziS2HXJgeJN2u7RxLp4/LgPv5xacW5PfCcKnb5b4BL205mE+I
    LPzc7ig+H/7vlqOlBDYFsxEqoSVhsqlhJXzerLQAQubOaj+1f4HSzWEz4Wp3WhiIFLKi8v
    jJ/q9MY7B2IaedZpcYmNkRiuikA0csHZ7Dh/n05pQ0EdCKVmkWbFPiTuI2XkI6P0vvpmyU
    k8dQQ2PDEWJ6sYY8TYIz6BCO8Q6LquTNE350JkEmKCAN/krpBthd+MbEaRYqTa3EANbHJz
    KRXXp/Q3vGWi34zsGJgXHRKF0TSJUlwGfJgzvXsLGPQyDJO6A2LuuBGqaX1vRI60qagp5+
    ZpBTJDZZJY/NqnOCH71wIi76RIx3Kp4uE/isvQ6V+uvuBWjESNJ/v73atavikVV7fjIOXC
    X24jQ8OmadFm0ZTFpovGDDCMm6y+GZgWygxCvz2gA3eJnQoNnscuOg1z69ouFTXVwoio7J
    YKKx0dgh4tzpd1QGQYAKBZN0F8HSTyWSAsiEBW8l7Ea6uoI6Gg7v1xWZ1r0voGsakEOXZE
    pmz7FmIsWudnm0T6zyvk7fmULHKhfneqtm5HqgmYUe/M/1hkPGlzZv+7sMLw
X-ME-Proxy: <xmx:L1GVap2clwjzdAMqwHGg8Hpoj6K3dQWZ6cgc8HbXucs6VA5JCf8Z7Q>
    <xmx:L1GVam84YNADeuZDbzrE69qJBYdRRnDauJn34bYufOMR1p1SuNkxCQ>
    <xmx:L1GVam1CkX7OmD1JJCVzSaynw4dS6CkeCjxTg8rHAk10AOTB3zxRbA>
    <xmx:L1GVaj9A1pW_9kpq-meXRZ-RlLrL_vTYran31LG0hZygL2K0eCj78Q>
    <xmx:L1GVag9xbLTHYCCA3rPSMdt6wELQqpCfppuHfXOQXjRE8BcwTK_SE-XM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2843fba9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:07 +0200
Subject: [PATCH v2 3/8] builtin/clone: refactor handling of
 "--reference{,-if-able}"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-3-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
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
2.55.0.979.g7e5102b832.dirty

