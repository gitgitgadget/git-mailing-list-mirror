Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90837CD37
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932947; cv=none; b=uFtOtp6cYkVRobLAkhYOJVomQ52X8z8XEjstT/qfMIACy8c3bFnrOFHD8pDy5AFCWklknEV8DjnnL0f1To6Wj5Afg8wq7vIaBY+mraD1qSt0AQJ2Pj4dxGTuMO4nJsfAKdkeoSvIbS6kiGwUN4D6Rn3caVJ4qLcNYQlNrNcqeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932947; c=relaxed/simple;
	bh=YObhbiR+fJsXOy46a3sUgZhkTvGQ8YyDzTh9XCqDfo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ki09QvLmR2UFsfFa2fuslUo7vwLLL4QmIkQTeZk6OxQPNDAmkDx9K3kgQ6r5UbVU3lOkuPpPUiWIsIikBSikIfxxjfWwKTom5cpXXCTn0aO0sAlhcUGAwYnCS3ZQ4DbT85q9uol61zSoT9DobUMhuaPlvg8nI49Xu0Wcq8g7EeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eLYXqorC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JHuXAhNl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eLYXqorC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JHuXAhNl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C17B17A00AD;
	Wed,  9 Sep 2026 01:49:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 01:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932945;
	 x=1789019345; bh=FCvfUhVwpj73qydBa5/xItMw/LyXxq89RA9+VcYOk7g=; b=
	eLYXqorCOCe9pFQtk2oD73wKlRqy289A0IGZzi89mLg/KYYP/uhCd6NeJ+yfxDJT
	yTod3GgVec5MUAsD+nsrdLoW0VFEtVk5OY3ggQyY3Muv8JJNQD/7gRtaVluCDkTu
	OJTXfz8RhU0Oj8oBchS5EjP0UcBOM+oDLBnD61VdegZzTS3NfRkV5mzXraTXQZZX
	E/w2MSK3RvUvf6RMHowXtGJAvLgEkqKhtu2hkh/o+tgxjmrN4G9P5joDsnALboEl
	ULxykBtgEOpJA0tltlMPEaOrNpkUcrfnICD4uQAjHrnOFJ6SjCzSlkE0FQUP7qvI
	QG14xn4DpKAbuJX5IdfyMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932945; x=
	1789019345; bh=FCvfUhVwpj73qydBa5/xItMw/LyXxq89RA9+VcYOk7g=; b=J
	HuXAhNlEiFB3gCU42hS2qikdeEMmEwGH5Khm7SxXa4Hff89OsciA2qWA1QD+1c8p
	Ewn4cTGu0QUZHoxl/69WWgWElxR8B0NJruGon/XfsBKcQ+G4oBUYGTg11D7JTIoh
	wTFfvqpDu0peJQMvq4paGK2F2wiwnFA8kdcR/mpiOotMXFk/m4xVy0+UfJnyd9qx
	aZFOE9YsFKAbIUGVa2R2WR441nk/273tEO8O8cgUtguICOl/OvLmmY/3t/iTpi7M
	RmmtY6ZivrThZrFfaN45UZo1Fd7aTVZHaXtZ2YFg3DhzgGOgCq9cTO1pnWMhCo7i
	66EYpIDiEyiE9to3A/t9A==
X-ME-Sender: <xms:UfOgamakUphV0-lC87cqf6s962F4luNjBTlWVByLmYy247SVOBSWVA>
    <xme:UfOgagZkGoA0JeuA72Ddfvqax_raJjkaNqFyU-iaYjyIkBF4Hdvwl4HPnZv_91hLg
    PkohwjBgyVgWLOPPgYXuGlf5ftseyyQAHOB6Mwdtt4HGjtMWWakc3U>
X-ME-Received: <xmr:UfOgal8IjBgHw98-jEBIaohNvQr8Iqe829ZElAV3amvFrO080tJL79RvrZzOvEcPnCr3XA>
X-ME-Proxy-Cause: dmFkZTEO5N4/wRkUGETagV1iliwdFQpV+cs4U6YeYU5TvgMv/ATqJVK1f27ZFzwKVJOUS7
    wCoSru23TiKYHjTDNxQCgu7q4blsVPNJ+eUEzb5tjdqyknI9FyFC2q7Gsy/D7l26beIyVQ
    HHxlURFw8VEPIU0sxcuIuxpsH0HJwr5SAPAPnA94yxCdm5eo2gHVmCUbPKybOiJyBDC8W8
    wb5V7z8SQaRPfUSGu1Rmp1BwzrA04ODauUynmPX0aRXAER3Xzd5IgC6MDE2giTOD4cpMts
    0+5J5DPPtwD9wzjKGVG+sm9ORLCw3jBqNzMMFHGbjCtu69MYnBOEiGgpW0BzwPH4QgUQNU
    xgJvIux6opjKXE5H7LCvzv/LidxPpgLylvP5d/Pn5mqivjXGlOH3il1D5OH10z+ZDVTpKA
    9GqKatGnuZZPQID9aHoKjpFGgebqpfgKQTnCdPcTd+mhJOvXdEXPeaAD0T25r3rNA9ViDm
    iMoITO0ospKrZIt1kC8bzOqOruNte41QizWMCwpK3MUgCfDZUeAYTTJ9aExoblWwXPWhYI
    YrmuGUnN1Cazi+j903vj6unVWcllhA5NrdtZ1Ssc62yREnh0fjV1Ype3681ZrPjrgI2qP/
    0WETWODS0KBmCRfW4DV6Ts2uQLBg/2hozGFkXrzo3Mcy9Ds+i8kFuOX+DENA
X-ME-Proxy: <xmx:UfOganj42DWVwWxyHuVYR0aXPwKAVwz5OnBen_uQe92yFFsRsDvuhA>
    <xmx:UfOgatfQfqhfdtp_Pk960-PJKJwrpeCCS4HPnuahqgEJeDd6jneTQA>
    <xmx:UfOgampjavRfRMm-Q-ksv-BOwW8RB64wMwUawHo5_OZcrXktC8Llmg>
    <xmx:UfOgaqCjQMCYCqVDzCebf4MUy3UhHOEI4IceM_O8KoE8BHBhLQAhUg>
    <xmx:UfOgaq9hPInHBTfGfatUN4ZqUdKEv21P9LDC5YOJjliStHW_M-eILn-8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58603275 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:46 +0200
Subject: [PATCH v4 4/9] builtin/clone: refactor handling of
 "--reference{,-if-able}"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-4-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
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
2.55.0.1074.ge7621b4bad.dirty

