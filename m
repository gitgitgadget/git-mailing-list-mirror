Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948494A33F5
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400177; cv=none; b=SCf9U++TYVsEjihHuBcLiUtoOgeeh4PN16ah1329ywugynBy4G6XGrwMkajJyjFrsIqZft5CYrhonM1TxiLqpse7vQXxcfKzIfFXGEzkRpkWR9lOk/AlB6OU22cuNThLtVgeMzBSsJ0C2ITiZtGVA8MCxUEtlG27JQ2/We28MJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400177; c=relaxed/simple;
	bh=y/nG2CGDh2uttJP/s13IIEwjaKmA72B1KSnjhB1moWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egRgzwrHN5pCKcdP68dwanIKw4bKaaUsOpXynfUPYlARZw8fcMtoI3h5+dP7p0QgdRn00j9o8zn5lEpuf8nQHH53uL3bWAwEJVzy3IqhJzJnfVXOlkeESBGnoAcWkg6Tfkg50MlwIohj+n624QdONsztO0l872SqbR4JlfeyTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MiIAt49d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmIL33qL; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MiIAt49d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmIL33qL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BD36D1D0005B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 04:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400175;
	 x=1792486575; bh=6puPAtvUS259XFo/+40CPi/50wgJuUCypMsdk71m06A=; b=
	MiIAt49drwKIwAWkD/fsl6YWKC7o6SzkCdAfRuxXXvoOSOHPg+jcx8rSBjFCASBj
	7LOvN8hEqHZOjFPvfMPcXBW61q/mWSGz7n5QHopU1kILwmIFDIN3TNQShtKyFvib
	Q+lZX7mWnA670J8Msom7GATNUKoLdNPX6ytC5BA4jRwjRiALHbc6YtNzp+t9KWIu
	Qmmm51+g0ROTy+xZy53nxF/xqolPUXsgMY55O8K/fGn3IOg1rxjT7H2DEbVTOIS2
	oVvPWpBHglA7TwZrsvWsbq/PdPox3VPmZuyi8mY/8QSgzsZMjN56+cefks0QIAGF
	w+k/qO57M8b53naR+FXUIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400175; x=
	1792486575; bh=6puPAtvUS259XFo/+40CPi/50wgJuUCypMsdk71m06A=; b=l
	mIL33qLeEDF0wAuLrNXMMhd8isvHRKR6xvRzcEdOPIVvoYxICsS/XPTjs7jbWQk6
	Su9cifCX60arhdfSJojUpxoYRVjF+PwAOMw4OP16nzaWajhtmDLDNbxnhcRxXLUn
	XlPvjv8jdVN9sRDGPLbz6y/PEvEgaxRyTMITwxfmEGBwJvud5RXpVHsIkV8G/SB2
	hjwkEbwXa6OLVnMZ+NgGFXG3moIQCVqALGa4Q2PtWmGEBfnNuc6Y/pk9lMJc78JU
	3IIzBk5HvslOZ+kORognaC+4CbmIS6PifaHwRDLcTa27pCrF+Xcy/XFRfsXfCIPH
	SNW/bp0VbFjDxpQlSWOnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400175; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bQjT3G1Vu2qmepCuZUeGJxeDkWeraRrtEFJ5yIeuncV417H
	US7eHL7c91t3vVti9ImjWIHTyXpfPTq9PDdsFvYjBrTThM1fotU1yivikLQQxenG
	Eg9Eeld1+BRPzLT1TZFt+sEL7GUqVnhD8+odDrJdKK1VahFbTJ7skLMVBZZVsvI5
	nV4oM1rmGmBKGPzERJo6LHrTGC7odR6WLTYabSJmlR32tcDgdjv+7QqCCv1gzUj2
	SkYDFUx38gzQPYYHiJcQuFxJZ37fwMhMzKq1+ekJr6hoq74bxhX4By7Oye06Zn3r
	wmCvTd+QS92U9QbFKQqGcUGcdrPZaaSCzk4+sMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FuAhlhFpQxnKiHgKm1FbeiQDKutmDsdcfcwp3AASw1I=:y/nG2CGDh2uttJP/s13IIEwjaKmA72B1KSnjhB1moWU=;
X-ME-Sender: <xms:L9vVak5ULmFwUpZRbBZQ5nYNjYk249oNHVSEq1Qgb6RXCqzUlMg83A>
    <xme:L9vVas0NAANAGXmhoo3pC84MdKQ8MyYR3sVYnInEo9H2tVJQn3l9xPpHjGLkUp-Yy
    6ikh8uUAoemUY1FPZ9VpS1ojejhX0DXJZMMdbOFmK66ANKT7j3nDg>
X-ME-Received: <xmr:L9vVapF5ik5UTwHiZ-RX3PPDI2M4P5_fAChEsmnqE7Wk6Du526-zGQ>
X-ME-Proxy-Cause: dmFkZTGfTCDl6lUtR0YpWppdo23ln4jv3lH0xKWlUu7G6uFe8srcOriVaetMCFdYOyxqQh
    Hr8AcU1kgjJzkfBWAOsoOESOtAb6ToxqQo/glcL1RFxoi5HEY8NDh7o7yWVsMpg/4SJbyC
    Ee0RhLv5Z/LClTYB7Klx1zd81O5uXk7VQIM3x8R/zpf1qi5h0olmBbLQVoqqjdF2fHErUn
    GgQdFMkHZ2ZQUVX73yj3kmRnsZLrofdcFxVHcsVRe4zNV0HDojJqm8rLcDtzr7pnXN6rh5
    ETfI5C+vnxrskwXB7vMXv16EL/70ckpLtMvpMfgxUof+XnNLnkpbov+eAsWoepxKSY3zh0
    +9BDi7wi4R4ogCJeH5SttrOtShKZulgWbWKw9asNwGyOtOCvaq8olzdJdY9Q/VDRn3ZKbP
    dHV1xxmCraGcqgTauWgY9gTBmH76MLdSatscxuhznFY9Zl+rqDXttHVvukFbaPnyz6RGSN
    y4BcBNYN5MmzdHhXruUeP8ubl8DsUjapMqAvyx2bicW+2qUKC9/7k2yBLvj4NafG8d3Gb7
    iROW7sfQUq8Oh/LlGk10cAUv26/jorepgxzLaceoGChBtN264H4oWNnAe6MjEeVFNS2u3B
    BIY6leHZSrUmDL30aR9kMtqnYcGxj84/wJGLK0T/wgYXFy0BRGzIje5wzfNw
X-ME-Proxy: <xmx:L9vVauSJTxJMYCCIgkEs8tLZXjbx9LhSqmIHup9_bi5-9Ffn13Clcw>
    <xmx:L9vVaoCDFbmrz7C2Fe3O5T1zg_NRgEpv8i1WqEkh-EEtEdguO0lwYw>
    <xmx:L9vVam3q-B3kuiq95Boh5XKYjC3qp4ql5iDMXXPYfOHX-JutgZl5TA>
    <xmx:L9vVauXHFBc4v7NwDML66QcjHRwIIZj6GKJNdH8WWTNTzBQkzrbGQg>
    <xmx:L9vValYaiqLrHnm5lsmiwK5zF2EE4zOyE1T9c94kc8NJW8V7KHA5v9-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 524ce21f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:55:58 +0200
Subject: [PATCH 3/7] setup: allow overriding object storage format via
 environment
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-3-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The ref storage format configured via "extensions.refStorage" can be
overridden with the GIT_REF_STORAGE_FORMAT environment variable.
Introduce the GIT_OBJECT_STORAGE_FORMAT environment variable that
overrides "extensions.objectStorage" in the same way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.adoc |  5 +++++
 environment.h          |  1 +
 setup.c                | 14 ++++++++++++++
 t/t0001-init.sh        | 26 ++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 3abb4701c3..34812131bb 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -609,6 +609,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_REFERENCE_BACKEND`::
 	Deprecated alias of `GIT_REF_STORAGE_FORMAT`.
 
+`GIT_OBJECT_STORAGE_FORMAT`::
+	Specify which object storage format to use along with its URI.
+	See `extensions.objectStorage` option in linkgit:git-config[1] for more
+	details. Overrides the config variable when used.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index b336459e90..c26ef92b52 100644
--- a/environment.h
+++ b/environment.h
@@ -45,6 +45,7 @@
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
 #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
 #define GIT_REF_STORAGE_FORMAT_ENVIRONMENT "GIT_REF_STORAGE_FORMAT"
+#define GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT "GIT_OBJECT_STORAGE_FORMAT"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/setup.c b/setup.c
index 499b5bbe3c..98140a7641 100644
--- a/setup.c
+++ b/setup.c
@@ -2073,6 +2073,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *object_storage_uri;
 			const char *ref_backend_uri;
 
 			/*
@@ -2091,6 +2092,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
 			}
 
+			/*
+			 * Likewise, the GIT_OBJECT_STORAGE_FORMAT environment
+			 * variable should override the repository config for
+			 * 'extensions.objectStorage'.
+			 */
+			object_storage_uri = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT);
+			if (object_storage_uri) {
+				if (odb_source_type_by_uri(object_storage_uri, NULL) == ODB_SOURCE_UNKNOWN)
+					die(_("unknown object storage format: '%s'"), object_storage_uri);
+				free(discovery.format.object_storage);
+				discovery.format.object_storage = xstrdup(object_storage_uri);
+			}
+
 			if (apply_repository_format(repo, &discovery.format,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c7c464d3a2..5e7c25e42c 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -869,6 +869,32 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown b
 	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
 '
 
+test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides extensions.objectStorage' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	(
+		cd objstorage &&
+		git config set core.repositoryformatversion 1 &&
+		git config set extensions.objectStorage files://objs &&
+		mkdir .git/objs .git/other &&
+
+		echo content >file &&
+		oid=$(git hash-object -w file) &&
+		test_path_is_file .git/objs/$(test_oid_to_path "$oid") &&
+		git cat-file -e "$oid" &&
+
+		test_must_fail env GIT_OBJECT_STORAGE_FORMAT=files://other git cat-file -e "$oid" &&
+		GIT_OBJECT_STORAGE_FORMAT=files://other git hash-object -w file &&
+		test_path_is_file .git/other/$(test_oid_to_path "$oid") &&
+
+		cat >expect <<-EOF &&
+		fatal: unknown object storage format: ${SQ}garbage${SQ}
+		EOF
+		test_must_fail env GIT_OBJECT_STORAGE_FORMAT=garbage git rev-parse 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.269.g68944adf51.dirty

