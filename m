Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA549BB58
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400179; cv=none; b=pBqSTO+3DYfjlQYE6ANwZsfsT+712csOk6OyvWKHW3cNW7soW3YeNiPZYL1S/m7qWFW+2EVrSMCH25ge1MKdZxtR8gx8IdrzVMDvBpV2zwi8Yqdt5JEOLY5hNYxZ2UJFGraxlKaKVLnqmnZdcJwIgWLJEfQeMhSj3OJoxvVPKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400179; c=relaxed/simple;
	bh=rFcU2ArdufdDq72fz6NAJwplwlMkDvGkazg8iQkwRPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MTuDFvTVCWsYtrsys14G2JWT+w+u79nman+Kmy2aJcDhAoXb+dJSE56IG0vwufBvfycl/HIMZG0lyPfBG08WbWzpK2jFgX8/2jDyGmeXp6VntTdkCnpYIpLTOlipupdKh6KJL3rnSYGazbhYlEgCutmOFmO3mVSX69K0hPjPaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jbSdNBbL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xkn+GJjm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jbSdNBbL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xkn+GJjm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2EA87A00CC
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 04:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400177;
	 x=1792486577; bh=aOev6tnbKZ/91so7fbCimKo/fTheCMV/Q4hrsOWyzaU=; b=
	jbSdNBbL1c1fgCcAjf4QP04qgwh4MA/99gvx5e7Ur3NT9nKBAQwyZPTJDrZBK/Bx
	5by00MeFvQq5WEGanbMQZ3mS9+ckty3HXYrTrBxQWl+N6VbWerzdszvV9W22Vr0n
	FoMr4UMDolHhwsunsWqQAt79j+4pkun6Qip7bsMlGzuJ4d4veIokb2dB1DEgALlD
	mpKqp2lKZhUiNHlFScquXpabf95/y06fIWeyiOTv61Z20WKNhjNcw54/5CuLroin
	tF5r/5FIldEa0OtC0mHvpkj0GV+d4n0CC1BrPdqYt+YIylTChAgvpZX6qj4YM5bs
	zn2hbRW231dnsPQGdEQo2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400177; x=
	1792486577; bh=aOev6tnbKZ/91so7fbCimKo/fTheCMV/Q4hrsOWyzaU=; b=x
	kn+GJjmOYJcqnN4YPO4ArPYmTqBsAdtWEV1y9j2qyNdGgxxUcHq2mlXsz6McAx7u
	aPWogDAMNQzazkZjxTQ6Vhyjxd5RqAoZvVdoqRhsxpf9ydXGZ5uczwMckO81Mprc
	VsbaOn+UkeKuC22DWe/jp4/8jDm7SxXd3u2y7sSKJy38qWBWUKpmCor2XdAS90jW
	e9FKYXPRwatOdCxArGsejDSE4EZ+d5RwMLPkazftebDVn/zM6HCsbECGzJDfiry8
	kVeOTjXuHLw6Op/opmTMW+Za8flOk2jHOH9yf2+bvk4bnDgC1GDBXDh7Da1shGzW
	v9Kz09unJ3Kt4c1+BjIUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400177; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AHD4BvR9/qX7M3n8YAwJH8+9e+Ri+pxEmpjg2MA5chEtTO5
	v+kD2rVw2WSYxMtxINrWAHbxWUV9GnDqdUjSFXPGEg5jE/KUpFxx5s/DNmtHNcCp
	tHEEwsVMQcHd98vd9Z11wZJjaUZxYSW1DoBSgUz0KhOELXlmjs6N07e8BHlZkz9B
	Q2eVr6oN3ulCGj1ADtQENezGrHHvAqIwx70LqTbz+BExjPd6D2UBKDvM38jLDM+7
	mGVzLw2WSuIaKflwvftaMKVouVNG/7s5z2OIWtj3gEFE7xZqQg4jerzUMywPzV0D
	meNABUzjDm5zFdFipvfnSk7N3eNnjqo0zhKR/UA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qZTosoPAv4p79a+PI/4nLzfRw5oxqwrstPdV9hyZA3Y=:rFcU2ArdufdDq72fz6NAJwplwlMkDvGkazg8iQkwRPc=;
X-ME-Sender: <xms:MdvValwvGaH-R1Oo75j4VWy7VC3vgbMDS8sPagPOwXNJ1C0Dg3LAjg>
    <xme:MdvVasPmtU-KYNYY1eK-Rq_Vw5D2GkZK7GeokZLvXkzYysIBymH-E_EHL06J_UKsZ
    ik_bHN0d5Xg3Yt6uluo-38z6bIxycAFtE8H965mYrswIC6bi-nP_Q>
X-ME-Received: <xmr:MdvVak_erK8ez9YvcFEuLTRTPUBZ_PP2PMcTbieg_9xCDiWLyboIsw>
X-ME-Proxy-Cause: dmFkZTFnhd/wn1r0kV/pU5LV6MuUIcorb6NMNAbr7qAVQQB7jx5vhPQSUR8U8c9EYIGusD
    Zx6LOLbCB+5bENWwZSUrzLM5wW8zORSXMtHXW+iJYgyzKxP+VctS/ye+8rSh1QKd4yqM7F
    tvBiJPaqHJQvyci+EQKeRfTiSModNM1eNWOTZV1UXMRB1rtJf2JbZpOrPMb8ywl/Clzsd3
    cit9eAXEl0U2yUgWgt8+JjeW36NHk6czKNQr6nqVvNcRddqbrVtOyw3t7PscUMDNQ+0xrv
    /kwzb+HoI22j+I+2cvVh3xk/Y5ctYXqGic81dlQbXetTbhTxo0USxeLqUHSpGHso57gCXS
    pXrG2T32+98WsOQXJZRn+IUQuuR8JoQo9vVrNWRB6SlpIo7J46cbRFQeohYGaRrrN9hivJ
    gumu6jc6yDQGuCaL+RfL7FTGf/brYK/IVgukxSdmeY7FGTYT2Wn6kBVnhjCOi4Xsn1hmBK
    jrfbfgqTRwXTdRSrQgDNSEXXGcf2bzWurcmzUfVMhrHQtYBt0yNC0HGFS+9x4nq5wkSFGq
    8kh6tuP7dFuFIdQmswSYsD3lDbYntF9StvMMi884ZfBcm7TGPHsNO1W6NMqfF6U8yXfvDP
    LnYNlGA2qS9bAzPQ3CeRFSPkgnIXI248b0o16FQkj5zo/p+eOBBsI/SfHfDw
X-ME-Proxy: <xmx:MdvVasoin_fHyYXLpzJnMvRczmM8cby8lgpF85yC16VnOeynJutrgQ>
    <xmx:MdvVam5BYEdJdpWFJO-5GWRqpdnPteo5Fn6S5DEh2EADANdQ3dPdrw>
    <xmx:MdvVasOc11VKs-wOF7kMUAA71ilZku7LtCrmS8VP4IRza3jMeR6dWg>
    <xmx:MdvVaoP6Z_CswkCWpEUKfbSA_VW6oy11D0F7sKOFtIB5kDCps2qeqg>
    <xmx:MdvVary4KQMbPpc-wjXADP0w2x_QQclNWq1L2ruVoFW-J9lNUuBxbaRK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84c3fe16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:55:59 +0200
Subject: [PATCH 4/7] builtin: expose the object storage format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-4-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The ref storage format of a repository can be inspected via both
git-rev-parse(1)'s "--show-ref-storage-format" and git-repo(1)'s
"references.storageFormat" field. Introduce the equivalent options for
the object storage format, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-repo.adoc      |  6 ++++++
 Documentation/git-rev-parse.adoc |  5 +++++
 builtin/repo.c                   | 10 ++++++++++
 builtin/rev-parse.c              |  7 +++++++
 t/t0001-init.sh                  |  5 ++++-
 t/t1900-repo-info.sh             |  3 +++
 6 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index cb8c1e7292..d2dc9b7a69 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -105,6 +105,12 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`objects.storageFormat`::
+	The object storage format used in the repository, as configured via
+	`extensions.objectStorage`. The valid values are:
++
+include::object-storage-format.adoc[]
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5b866af66a..9103d54d53 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -338,6 +338,11 @@ The following options are unaffected by `--path-format`:
 --show-ref-format::
 	Deprecated alias of `--show-ref-storage-format`.
 
+--show-object-storage-format::
+	Show the object storage format used for the repository. Prints the
+	value of `extensions.objectStorage`, or `files` when the extension is
+	not set.
+
 
 Other Options
 ~~~~~~~~~~~~~
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..da11a56ede 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -6,6 +6,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "parse-options.h"
 #include "path.h"
 #include "path-walk.h"
@@ -128,11 +129,20 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_object_storage_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo->object_storage_format ?
+		      repo->object_storage_format :
+		      odb_source_type_to_name(ODB_SOURCE_FILES));
+	return 0;
+}
+
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "objects.storageFormat", get_object_storage_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ec33c19bdf..b206944ad9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -17,6 +17,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "odb/source.h"
 #include "refs.h"
 #include "quote.h"
 #include "object-name.h"
@@ -1138,6 +1139,12 @@ int cmd_rev_parse(int argc,
 				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
 				continue;
 			}
+			if (!strcmp(arg, "--show-object-storage-format")) {
+				puts(the_repository->object_storage_format ?
+				     the_repository->object_storage_format :
+				     odb_source_type_to_name(ODB_SOURCE_FILES));
+				continue;
+			}
 			if (!strcmp(arg, "--end-of-options")) {
 				seen_end_of_options = 1;
 				if (filter & (DO_FLAGS | DO_REVS))
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5e7c25e42c..d080ab04a8 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -853,7 +853,10 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files bac
 	git -C objstorage config set core.repositoryformatversion 1 &&
 	git -C objstorage config set extensions.objectStorage files &&
 	test_commit -C objstorage A &&
-	git -C objstorage rev-parse --verify HEAD
+	git -C objstorage rev-parse --verify HEAD &&
+	echo files >expect &&
+	git -C objstorage rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown backend' '
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index d115d2d9f9..493a78f230 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -69,6 +69,9 @@ test_repo_info 'object.format = sha1 is retrieved correctly' \
 test_repo_info 'object.format = sha256 is retrieved correctly' \
 	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
 
+test_repo_info 'objects.storageFormat = files is retrieved correctly' \
+	'git init' 'objects-files' 'objects.storageFormat' 'files'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false

-- 
2.56.0.269.g68944adf51.dirty

