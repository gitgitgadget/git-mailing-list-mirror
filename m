Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530F49BB58
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400185; cv=none; b=E8Ymb/w73Hrfxnh066+eELmp7Gw3eq2P6NcQFXFO/SiRIRb4DfajcrJ1lDFZc7CMTDn/kqudLIVhANbFiyc5mgUsyU8xdQ5PQvDBcjeYdd5XQc9MiYYbxndb+3yaNpMlGoaraIWerLt5mkNdF+Z067rgD52EcmzbrCyXRTEFaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400185; c=relaxed/simple;
	bh=uLohj3JGZNOo+rTlgMKLGK9wfHcKJyiJOZY6d+jAdAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2h3yV4A7bAJDhltZcVrIzyF7UndJk6ZtVxMdSEniPGPVm92N5awhQCI6A1QLddjKSl4xS4lrEnHQWg+4EsgXGUi08FqvHbkYeFk2+jGk5l2OVDspHMhLWlmbZamV2wFBRkxOIZ9Ptr4YjTbam2A9fGGxxclv6rOA92UiO029XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uaexuFbD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4E0YRF7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uaexuFbD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4E0YRF7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CC111D0006A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 04:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792400183;
	 x=1792486583; bh=+MkpwoQ6xlTclq1GPDOeaZqH8eCe9rhmWC3K6gxJMSw=; b=
	uaexuFbDzt+/+p1g61bw6XgH+9SGmRw87zx1ht6sViU0TPCqtK9Y9sNoifraxmLS
	bqG6uZ9CaaOPocnBWIGihcUpmAH78IA7k41l2oxeWygeuQvdRBPRHxoH9jYutwVS
	eHfqU3PP8/vOolr+Pexl46tBXwLCaBC44MqNyv/oay4MYsPUuP9UlY/YosxMjJwq
	qIlPQlNLKE6zPmM6lq1hMVeZXC/HLBMC8wm3bEYugpFX3TkBzOegpgvy/UcyyV3u
	qV4MDbcCF5fFKM0FlIQS3eIsG54yD0+i7OVC+vY7CzNQTk2PsYyQsWjgYEMU4L7u
	wihvz7sCKptVBqpuBPc7/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792400183; x=
	1792486583; bh=+MkpwoQ6xlTclq1GPDOeaZqH8eCe9rhmWC3K6gxJMSw=; b=E
	4E0YRF7XFqOddnXITj8hm3zuws04chhMjrCaWOFDIdf1J8QOMtqUmZLuWYfJIyt2
	Wz+dVoIrfu8BPq6FsompF0Opak+e9p0ES/KLuG+URwE7tLLHxWRSqHVHeTztssf+
	eW9CRzib5CLDB84/+G393UBhE5GKErZWipRDuoFYeXtfeSdvTujFzTRfXAWi4YbN
	gpyieCdTHdz/n44GJkL1UuxRnh9tVCYcd7E9uJqEtaTJ/2Jx+zeH/3CCBprcdM8J
	2MrsPFayiTm5ERxhSOTDG6xyrsLPep86X20iNgfzt1+L4XrgU/WVVi/UIokCZs5Y
	rnhliC9QQ3OII2qVuUC0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792400183; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:h6dkxTlAaEmFbdcf99dXqx90rdIrIQ+UQkCvR1M1d7vY6MW
	jy1GaOyNPfrwBXZL+62iFBgj1sywkijWHXd5ON5oyW/3J1SRi4dGbTMMb8/m5LO/
	T+mh0XM9A/Ah79/FHTS9LVa0t9SHCsvW1AYXmyJESR1ZRUQdrGmJcGW+yGZeAI5M
	P0xUYHzD4zTwmoW62ghX+CDh/6UG+uGCV7pehCkPtVH2bw/fgSLBit87Ey2+Rz8a
	KNnOLJz3KaSRfV8h7QTsEs4h/WqoiLOD7z2Xq0v7EyyrQ/H9ctxeT/m3Yr405RBF
	wZSgrL2gA3lOouREk+W/7rtjRQz8q8UoqtnZWaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tx23UWw/puEFKszwfNQ77hGlxPLTERM7WA14UMbl2WY=:uLohj3JGZNOo+rTlgMKLGK9wfHcKJyiJOZY6d+jAdAg=;
X-ME-Sender: <xms:N9vVagxQvr811L2TNRMlL7SkfuKoWi71pDk1D1Kqo0LxC-uWTZcu7Q>
    <xme:N9vVarPxonnjXIxETrtM_oma6hA9GIuk818mezpSllCdTZjUkSAEYlJRoo73AmP2D
    xFTE8nyVcuPWKtNtbYhc-9gCkDUcoEKpnt-__kji7Uoljqn5gxa>
X-ME-Received: <xmr:N9vVan8mrrbITiVN9FMq-Lt7I9vW9I1J-b05Ofz9PzxkQNe_Z-qpHA>
X-ME-Proxy-Cause: dmFkZTFnhd/wn1r0kV/pU5LV6MuUIcorb6NMNAbr7qAVQQB7jx5vhPQSUR8U8c9EYIGusD
    Zx6LOLbCB+5bENWwZSUrzLM5wW8zORSXMtHXW+iJYgyzKxP+VctS/ye+8rSh1QKd4yqM7F
    tvBiJPaqHJQvyci+EQKeRfTiSModNM1eNWOTZV1UXMRB1rtJf2JbZpOrPMb8ywl/Clzsd3
    cit9eAXEl0U2yUgWgt8+JjeW36NHk6czKNQr6nqVvNcRddqbrVtOyw3t7PscUMDNQ+0xrv
    /kwzb+HoI22j+I+2cvVh3xk/Y5ctYXqGic81dlQbXetTbhTxo0USxeLqUHSpGHso57gCat
    MwRhb6ok3PrYS5RPS5y5BkPdnLtGhvVlNo0p/FcDEQn57cWauLLV44y3T88qkDM7F106m2
    mJUWREL3WNSmHK7FpytWGUHiXuRfXKnhm28GmrIy4/Z3Go22A7H8hshkJb2apDcOpysNLW
    tPHWtmpuoF6hBIjcfeJ1QV0TBp1ZR9nNeQG2WBN6a1Xm72ze6g/T3cIedejWVBC7z64ipg
    prUUP6skj35+Kxw9RmwDc/C6f7ECvYyJki2K9dB+Jg2LtaRZT+hBsbX2b9mAxc5aeiW9w4
    8la0LkneL2OnPm8Oi/G7jvvzzMpfz3ONyAtGrdZMQh/5WDcWFNw5dsPj4KUQ
X-ME-Proxy: <xmx:N9vVajr_RUbehJbmiB9OZNJkVDrpIW1RWBB6TYjwaI0t3f01E7lb8w>
    <xmx:N9vVah69uAUVU6c7rfD8NO3YRUJ5wJxVCiYrSmJ2SwbjaOaK-JYXbg>
    <xmx:N9vVarNm5Ib9mBVVCe-xz1vNDkqlqqHvTIYQbSQgU_G27SLOkI_eFg>
    <xmx:N9vVarOVh5mvbXyRVLto1AOpcsz8_aZKElC5EGErCoMGmuJe0QKFzg>
    <xmx:N9vVaiyRACxETQKWxWbCZD18sW6vxMTXkGnKdM_Gr9c4u5fIO9y6_E8n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Oct 2026 04:56:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70946b3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Oct 2026 08:56:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 19 Oct 2026 10:56:01 +0200
Subject: [PATCH 6/7] builtin/clone: introduce "--object-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-pks-odb-extension-v1-6-143a5963b77f@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
In-Reply-To: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Wire up the new object storage format in git-clone(1) via a new
`--object-storage-format=` option, same as we have introduced in the
preceding commit for git-init(1).

Note that "--local" clones will not work if either of the object
databases is not using the "files" format. This is because we hardlink
loose objects and packfiles into the new repository, and that is
something that simply won't work with alternative backends.
Consequently, we either downgrade to a non-local clone with a warning,
or we die in case the user has explicitly asked for a local clone.

We _could_ in theory handle the case where the "files" backend has been
configured with an alternative object directory path (that is, with
"files:///path/to/dir"). But that's left for a future patch series to
implement for the sake of simplicity.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.adoc | 11 +++++++
 builtin/clone.c              | 50 ++++++++++++++++++++++++++++++--
 t/t5601-clone.sh             | 68 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 07f7cf1a98..dd3b44817a 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -360,6 +360,17 @@ include::ref-storage-format.adoc[]
 `--ref-format=<format>`::
 Deprecated alias of `--ref-storage-format=<format>`.
 
+`--object-storage-format=<format>`::
+Specify the given object storage _<format>_ for the repository. Backends that
+require additional configuration accept a payload in the form
+`<format>://<payload>`, for example a path or a connection string identifying
+the database that shall store the objects. The valid values are:
++
+include::object-storage-format.adoc[]
++
+Local clones (see `--local`) fall back to the regular transport when either
+repository uses a non-default object storage.
+
 `-j<n>`::
 `--jobs=<n>`::
 	The number of submodules fetched at the same time.
diff --git a/builtin/clone.c b/builtin/clone.c
index ba4fc16def..85c124dc37 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -26,6 +26,7 @@
 #include "refspec.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/source.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
@@ -378,6 +379,28 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	dir_iterator_free(iter);
 }
 
+static bool is_using_default_object_storage_format(const char *repo_path)
+{
+	struct repository_format format = REPOSITORY_FORMAT_INIT;
+	struct strbuf config = STRBUF_INIT;
+	bool uses_default_format = true;
+	char *payload = NULL;
+
+	get_common_dir(&config, repo_path);
+	strbuf_addstr(&config, "/config");
+	read_repository_format(&format, config.buf);
+
+	if (format.version >= 1 &&
+	    format.object_storage &&
+	    (odb_source_type_by_uri(format.object_storage, &payload) != ODB_SOURCE_FILES || payload))
+		uses_default_format = false;
+
+	clear_repository_format(&format);
+	strbuf_release(&config);
+	free(payload);
+	return uses_default_format;
+}
+
 static void clone_local(const char *src_repo, const char *dest_repo)
 {
 	if (!option_shared) {
@@ -927,6 +950,7 @@ int cmd_clone(int argc,
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
 	const char *ref_storage_format_uri = NULL;
+	const char *object_storage_format_uri = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -1008,6 +1032,8 @@ int cmd_clone(int argc,
 			   N_("separate git dir from working tree")),
 		OPT_STRING(0, "ref-storage-format", &ref_storage_format_uri, N_("format"),
 			   N_("specify the reference storage format to use")),
+		OPT_STRING(0, "object-storage-format", &object_storage_format_uri, N_("format"),
+			   N_("specify the object storage format to use")),
 		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
@@ -1060,6 +1086,10 @@ int cmd_clone(int argc,
 			die(_("unknown ref storage format '%s'"), ref_storage_format_uri);
 	}
 
+	if (object_storage_format_uri &&
+	    odb_source_type_by_uri(object_storage_format_uri, NULL) == ODB_SOURCE_UNKNOWN)
+		die(_("unknown object storage format '%s'"), object_storage_format_uri);
+
 	if (option_mirror) {
 		option_bare = 1;
 		option_tags = 0;
@@ -1213,8 +1243,9 @@ int cmd_clone(int argc,
 	 * their on-disk data structures.
 	 */
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
-			  option_template, GIT_HASH_UNKNOWN, ref_storage_format_uri,
-			  NULL, do_not_override_repo_unix_permissions, NULL);
+			  option_template, GIT_HASH_UNKNOWN,
+			  ref_storage_format_uri, object_storage_format_uri,
+			  do_not_override_repo_unix_permissions, NULL);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1362,6 +1393,21 @@ int cmd_clone(int argc,
 			is_local = 0;
 		}
 	}
+
+	/*
+	 * Local clones copy or hardlink the object directory of the source repository
+	 * into the destination. This only works when both repositories use the "files"
+	 * object storage format.
+	 */
+	if (is_local &&
+	    (!is_using_default_object_storage_format(path) || !is_using_default_object_storage_format(git_dir))) {
+		if (option_local > 0)
+			die(_("cannot perform local clone with non-default object storage format"));
+		else
+			warning(_("falling back to non-local clone because of non-default object storage format"));
+		is_local = 0;
+	}
+
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 06f6121f82..85f439d6b6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -181,6 +181,74 @@ test_expect_success 'clone with garbage ref format' '
 	test_path_is_missing ref-storage
 '
 
+test_expect_success 'clone with files object storage format' '
+	test_when_finished "rm -rf object-storage" &&
+	git clone --object-storage-format=files --bare src object-storage &&
+	test_must_fail git -C object-storage config get extensions.objectstorage &&
+	git -C object-storage rev-parse --show-object-storage-format >actual &&
+	echo files >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with object storage payload' '
+	test_when_finished "rm -rf object-storage" &&
+	git clone --object-storage-format=files://objs --bare src object-storage &&
+	git -C object-storage config get extensions.objectstorage >actual &&
+	echo files://objs >expect &&
+	test_cmp expect actual &&
+	git -C object-storage rev-parse --show-object-storage-format >actual &&
+	test_cmp expect actual &&
+	test_path_is_dir object-storage/objs/pack &&
+	test_path_is_missing object-storage/objects/pack
+'
+
+test_expect_success 'clone with object storage payload and bundle URI' '
+	test_when_finished "rm -rf object-storage src.bundle" &&
+	git -C src bundle create ../src.bundle --all &&
+	git clone --object-storage-format=files://objs --bundle-uri="$PWD/src.bundle" \
+		src object-storage &&
+	git -C object-storage rev-parse --show-object-storage-format >actual &&
+	echo files://objs >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clone with garbage object storage format' '
+	cat >expect <<-EOF &&
+	fatal: unknown object storage format ${SQ}garbage${SQ}
+	EOF
+	test_must_fail git clone --object-storage-format=garbage --bare src object-storage 2>err &&
+	test_cmp expect err &&
+	test_path_is_missing object-storage
+'
+
+test_expect_success 'local clone into non-default object storage bails' '
+	test_when_finished "rm -rf object-storage" &&
+	test_must_fail git clone --local --object-storage-format=files://objs src object-storage 2>err &&
+	test_grep "cannot perform local clone with non-default object storage format" err
+'
+
+test_expect_success 'local clone from explicit files object storage succeeds' '
+	test_when_finished "rm -rf object-storage object-storage-dest" &&
+	git clone src object-storage &&
+	git -C object-storage config set core.repositoryformatversion 1 &&
+	git -C object-storage config set extensions.objectstorage files &&
+	git clone --local object-storage object-storage-dest
+'
+
+test_expect_success 'local clone from non-default object storage bails' '
+	test_when_finished "rm -rf object-storage object-storage-dest" &&
+	git clone --object-storage-format=files://objs src object-storage &&
+	test_must_fail git clone --local object-storage object-storage-dest 2>err &&
+	test_grep "cannot perform local clone with non-default object storage format" err
+'
+
+test_expect_success 'local clone from non-default object storage without --local warns' '
+	test_when_finished "rm -rf object-storage object-storage-dest" &&
+	git clone --object-storage-format=files://objs src object-storage &&
+	git clone object-storage object-storage-dest 2>err &&
+	test_grep "falling back to non-local clone" err
+'
+
 test_expect_success 'clone to destination with trailing /' '
 
 	git clone src target-1/ &&

-- 
2.56.0.269.g68944adf51.dirty

