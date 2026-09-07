Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168D443C061
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769560; cv=none; b=DbNUN+FSAuBQf/A0o7cnWJ3VyyFTlprhheSnn0lVqpsSXabM0nhJjppGvyoH/2A/no3z2lyHKrhULEt5kAuP2wLqD6eEZQQmm568iAGekYH6MA9ssG/Y+gYh00blR5INdV3M/4kGGoug7zokmgApealMFkDRB0hrs7TQzVl1kNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769560; c=relaxed/simple;
	bh=qeCjvkZSspoAXAS5n3pw2+4mF3Q+fzCLLk8+x4JKf1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iU8kCX2gBM+PKSNgdwIDD4a2fe8o/i7hAqUmdR8MSdRn6bJUviWR0fY3ByFr9fBv3UxYZKL2iUNRF6m8k+1C66+Dg2/iZvA43y6p9Vxele5nIdT6nXmh2K6S+KW8RSCToxqIa46HmV9M2cVXUPDZRqJ051u13oPHkCea4VD5jQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yZ2S2JTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bb6rL3vD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yZ2S2JTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bb6rL3vD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BFC31400203;
	Mon,  7 Sep 2026 04:25:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 04:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769558;
	 x=1788855958; bh=gDAAClCLKcGTrwXE8m8WUHdaXuIm0znTBMeCCFszgR8=; b=
	yZ2S2JTRS0Ghc9yre8CJsZ+/wTg/+QTfeYiUTsws0tM9S/XsVMWdh3HUOGyOFrMA
	iir4F3YUAntCIzj/UxcvdJ4qzH2eLNoS1nU57XGWSHZrQwkGtlXbhtH8uNw/GyeF
	hqh3wRNTVUS+jYmhPVZnqhKRdBTMMuGSkBCynVIQTeMsUDD4VvDigs+28PQNXiF4
	+O0hn2tdl0yDLtCCb8N0Xh7phkbGmEWJEBWNh+fcu+k3WKqhF3TEkR9iltEFqPei
	1P9kdE0e+MQcDnxjmjrRJYCroWplP7uky0/klOIgZUGakJyyfxZWgYvqPO4nMQD2
	CMDH/iQq67L2kT0lN0Cm7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769558; x=
	1788855958; bh=gDAAClCLKcGTrwXE8m8WUHdaXuIm0znTBMeCCFszgR8=; b=b
	b6rL3vDEm60Q6RrI3imJpiI1gz1ZTDITJV+zK3CbMC/ZRC6TpSBa8lOjBa7lYrqG
	kno7ws0qPotogkWrgaCz8hnVYLiRhraJHzQzJOADPRQ7l52J08f5TQ8cqTyhcpAj
	AKIOIVb/r6PwaILaGqwH1yykJZHuh3uwyKs6wUMVKSQ+kji7867WNlagaUeXZOJW
	tHvOj2zrMDdcD66AbO+eOhO0JLfbQbUua7+VXrORxq1hQH46ZVmuZ9yzfHpSwB9O
	BYyJXkOlwQ17MtAD9MDrTtSBpdYjotQrjYA0fBTdKcDM9mwEInwS2uqkGCG+/uV5
	mCEfH2NEp9llpbUEbo3kQ==
X-ME-Sender: <xms:FnWeavRFsW5QQXzyE0cNB4SNn_s5vo1BnWTiqPw9cWsYbxxWoAQoAQ>
    <xme:FnWeanzBct7_JKrK5qKTxJJF1v9EQw4iDnbVaeLpTmYPcpM1RkN1KcS0qZRKsZUAn
    N7nBdO9RCbdxL62j6zPDwgmlRaZfkp6xbbG9K6A2ncQMmolVmtkdSE>
X-ME-Received: <xmr:FnWeap3X6yS4h5b6vQqQnfBpMV5GQXCmELLV46u93zLu3kuwR43pwQ>
X-ME-Proxy-Cause: dmFkZTFaGqkO1AjSKqWu5USTouDfR2+xLPnyvHMo0VF+uv+Ced59IE+2FhBiH4GuRbxmLt
    yySFdAewrb7Vkimg2WUcFKTjL2x1cpewun543MaldnHFP8xb+/LGoac8gLCH+2tO6y1HME
    LkjSZyqOvbVGWBif9GT7Le15333QsiqiG5NqgSr8K6bJyslwICKC6Zsocnt3j7Z2R/JPpW
    GWStOMq/+KKMZg5TnzecS5toyLCCQvUZvLMmmMJ9b5OjBlwKRMNhfydFbTaGCZG026xgI8
    3yNb9gdcDfw9+jiazgomfUZtqeh19zauJiC8//7HH/DWzUyQHFQ3DVrI8D4AAfeVzoTKnx
    Sar4MBAlt9uIGbQXcbE8KUFIdxFAsXClccqFp69PtZ5bOVHsK7SEsesY4JhCwtTZpdBeDs
    hFLaiVy25tzJl9EfEiIFYshfYUc4DL8IArVfjUPristEqVWXmFlRD6VZWGAhK+CzWc/IEB
    6WtQjozGJyUTuKHAfXGXHQaFGavOxrgVISwiSH8Ov5DS4oq8VnX51Aq26QWH2+pVmpzS/C
    /IiD5TctBX8SZVCHgnJoQ95No0waWCkSlQMs0ZMkO70YV0j3l1fuHZqjOlQqhipnRkwe89
    bzLU71oehHXC8FXsqP3aCOu16MPKVSRMMe4oXIjDn2sDwP+WEjZp87ZoeOaw
X-ME-Proxy: <xmx:FnWeat7p_V_o9d_Q7epTyVUvd6LsPhWNPoLaVJgbX9rlymLob6X32A>
    <xmx:FnWeakU9I8kU4SqeBw-UV0CqIBMq6wm2b3QlFkn4R9FVQ75H48Kl7Q>
    <xmx:FnWeakBiP-1cNO9vE4saBFWTg06Ao6TsiUvgnBqeLSnpSIsL50x5xg>
    <xmx:FnWear5oLZEeSZNi4WPLtpGdIcONkpCU_bdCNJrqUIyEim-TjBvfkQ>
    <xmx:FnWeag1ujqV7kMqd-hs-0iWuDDhMLy6MVAHEtNPBLFxwCTlxFVf8-4W3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:25:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08f7fffc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:25:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:41 +0200
Subject: [PATCH v3 4/9] builtin/clone: refactor handling of
 "--reference{,-if-able}"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-4-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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
Rename the function to `collect_alternates()` to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ac5843d7b9..8786a49332 100644
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
2.55.0.1007.g17ff1f9808.dirty

