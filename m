Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45163AF
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kpYf/ROA"
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B33C0E
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:03:13 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-421acfe16f6so16317031cf.2
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 20:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699675393; x=1700280193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOthb7pBkUtSHKNMo4oVJNN2+7U+fWdC9Jw/6jKzxcU=;
        b=kpYf/ROAayC8J2DwVMOi2LutFi0i2Be73AraTzbhekLHVX1kYzcWXlK2mQmcLbXkMh
         83W7Zc5H48TM6xwgm+O1n5CPnus+RAHLlFtm1g4nT7xSUXmPAvdKL3n9yZZpb8Lnfatk
         GpHz+SSkGUgM6W63uQW+JOTPzOcAsFJSS7ElNg5JKeirt2JMn24b30MQ8ACKn6fv8Njg
         HYLhbBl/8FXiqnpbUIlT7FqPxXqyjDCSQXqUQtKMsHql+VXYqjo5UWKc3XSt4TffGGm7
         +fd4Ebwr4mXtBRXVCRPv9euQQ7Q8TRJzUClQS7nyBc/cQUBBnqbrS6XstcxnFRG3/bSm
         70Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699675393; x=1700280193;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOthb7pBkUtSHKNMo4oVJNN2+7U+fWdC9Jw/6jKzxcU=;
        b=XbmoPmgoIfs2c7bhmBGS5QKAczi8SCmV79cdLkffkTWyMm9xy3MKbGo0giLfsRIzLI
         3qqnv+Hve05O/GvWvqihwC3l2/bwwSwIRgg1BO5rTtZ/uuFhO/LJA8p9W4+RaUMSdppa
         oUwVh0Rj/UODAgj6My0MvdZsWr/jk2E+8+Yn+OiTl1kzBtQl+wfE3lpjsrVo6wngGDAr
         CBGyKbjA15nrAlYUX1kDd3JxgrPaNnkFW7pwJ1qQI9DsQ/zo6qUXwo9hurIIfl7YBKAG
         /dDaWbHOfyHmZTnjIU0tO0BCEOb4yiIKsqjLmT103hZ+W2hn72noTdzvZAQmD8TWk9bQ
         lSNg==
X-Gm-Message-State: AOJu0YyiwQYb//wfOcyJia+pEznbpTHBsOK/7EuCkoDLrQQEplygTM0c
	RHGDR7CAbkmclZnHz4iRcbiOuxbMbp/8PdyUPGEUFq9EKSHOScnLMyDcGl+8OmlpTtBYNKvka6u
	TnL2v/eT9b5M2GRPpcPCD9GOMbrfFo6H8ViSD3ywjL61hieKjH/oh94nVPAoF
X-Google-Smtp-Source: AGHT+IFPEusLuLN03E8A2R6lf1GSg9VksijRNE/JT1qqXpVCJHyXCAuWnmH+IKNIZyPhn6zZaHyFvhXaGghu
X-Received: from jojwang1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:3b1d])
 (user=jojwang job=sendgmr) by 2002:ac8:1381:0:b0:41b:d0ea:b7b with SMTP id
 h1-20020ac81381000000b0041bd0ea0b7bmr21729qtj.7.1699675392920; Fri, 10 Nov
 2023 20:03:12 -0800 (PST)
Date: Sat, 11 Nov 2023 04:03:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231111040309.2848560-1-jojwang@google.com>
Subject: [PATCH 1/1] attr: add native file mode values support
From: Joanna Wang <jojwang@google.com>
To: git@vger.kernel.org
Cc: Joanna Wang <jojwang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gives all paths inherent 'mode' attribute values based on the paths'
modes (one of 100644, 100755, 120000, 040000, 160000). Users may use
this feature to filter by file types. For example a pathspec such as
':(attr:mode=3D160000)' could filter for submodules without needing
`mode=3D160000` to actually be specified for each subdmoule path in
.gitattributes. The native mode values are also reflected in
`git check-attr` results.

If there is any existing mode attribute for a path (e.g. there is
!mode, -mode, mode, mode=3D<value> in .gitattributes) that setting will
take precedence over the native mode value.

---

I went with 'mode' because that is the word used in documentation
(e.g. https://git-scm.com/book/sv/v2/Git-Internals-Git-Objects)
and in the code (e.g. `ce_mode`). Please let me know what you think
of this UX.

The implementation happens within git_check_attr() method which is
the common mathod called for getting a pathspec attribute value.

The previous discussed idea did not work with `git check-attr`.
(https://lore.kernel.org/all/CAMmZTi8swsSMcLUcW+YwUDg8GcrY_ks2+i35-nsHE3o9M=
NpsUQ@mail.gmail.com/).

There are no tests for excluding based on pathspec attrs in subdirectories
due to an existing bug. Since it is not specific to native mode, I thought
it would be better to fix separately.
https://lore.kernel.org/all/CAMmZTi89Un+bsLXdEdYs44oT8eLNp8y=3DPm8ywaurcQ7c=
cRKGdQ@mail.gmail.com/

 Documentation/gitattributes.txt | 10 +++++++
 attr.c                          | 42 ++++++++++++++++++++++++--
 t/t0003-attributes.sh           | 40 +++++++++++++++++++++++++
 t/t6135-pathspec-with-attrs.sh  | 53 +++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.=
txt
index 8c1793c148..bb3c11f151 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -156,6 +156,16 @@ Unspecified::
 Any other value causes Git to act as if `text` has been left
 unspecified.
=20
+`mode`
+^^^^^
+
+This attribute is for filtering files by their file bit modes
+(40000, 120000, 160000, 100755, 100644) and has native support in git,
+meaning values for this attribute are natively set (e.g. mode=3D100644) by
+git without having to specify them in .gitattributes. However, if
+'mode' is set in .gitattributest for some path, that value takes precenden=
ce,
+whether it is 'set', 'unset', 'unspecified', or some other value.
+
 `eol`
 ^^^^^
=20
diff --git a/attr.c b/attr.c
index e62876dfd3..95dc1cf695 100644
--- a/attr.c
+++ b/attr.c
@@ -1240,20 +1240,58 @@ static struct object_id *default_attr_source(void)
 	return &attr_source;
 }
=20
+
+/*
+ * This implements native file mode attr support.
+ * We always return the current mode of the path, not the mode stored
+ * in the index, unless the path is a directory where we check the index
+ * to see if it is a GITLINK. It is ok to rely on the index for GITLINK
+ * modes because a path cannot become a GITLINK (which is a git concept on=
ly)
+ * without having it indexed with a GITLINK mode in git.
+ */
+static unsigned int native_mode_attr(struct index_state *istate, const cha=
r *path)
+{
+	struct stat st;
+	unsigned int mode;
+	if (lstat(path, &st))
+		die_errno(_("unable to stat '%s'"), path);
+	mode =3D canon_mode(st.st_mode);
+	if (S_ISDIR(mode)) {
+		int pos =3D index_name_pos(istate, path, strlen(path));
+		if (pos >=3D 0)
+			if (S_ISGITLINK(istate->cache[pos]->ce_mode))
+				return istate->cache[pos]->ce_mode;
+	}
+	return mode;
+}
+
+
 void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check)
 {
 	int i;
 	const struct object_id *tree_oid =3D default_attr_source();
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	collect_some_attrs(istate, tree_oid, path, check);
=20
 	for (i =3D 0; i < check->nr; i++) {
 		unsigned int n =3D check->items[i].attr->attr_nr;
 		const char *value =3D check->all_attrs[n].value;
-		if (value =3D=3D ATTR__UNKNOWN)
-			value =3D ATTR__UNSET;
+		if (value =3D=3D ATTR__UNKNOWN){
+			if (strcmp(check->all_attrs[n].attr->name, "mode") =3D=3D 0) {
+				/*
+				 * If value is ATTR_UNKNOWN then it has not been set
+				 * anywhere with -mode (ATTR_FALSE), !mode (ATTR_UNSET),
+				 * mode (ATTR_TRUE), or an explicit value. We fill
+				 * value with the native mode value.
+				 */
+				strbuf_addf(&sb, "%06o", native_mode_attr(istate, path));
+				value =3D sb.buf;
+			} else
+				value =3D ATTR__UNSET;
+		}
 		check->items[i].value =3D value;
 	}
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index aee2298f01..9c2603d8e2 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -19,6 +19,15 @@ attr_check () {
 	test_must_be_empty err
 }
=20
+attr_check_mode () {
+	path=3D"$1" expect=3D"$2" git_opts=3D"$3" &&
+
+	git $git_opts check-attr mode -- "$path" >actual 2>err &&
+	echo "$path: mode: $expect" >expect &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+}
+
 attr_check_quote () {
 	path=3D"$1" quoted_path=3D"$2" expect=3D"$3" &&
=20
@@ -558,4 +567,35 @@ test_expect_success EXPENSIVE 'large attributes file i=
gnored in index' '
 	test_cmp expect err
 '
=20
+test_expect_success 'submodule with .git file' '
+	mkdir sub &&
+	(cd sub &&
+	git init &&
+	mv .git .real &&
+	echo "gitdir: .real" >.git &&
+	test_commit first) &&
+	git update-index --add -- sub
+'
+
+test_expect_success 'native mode attributes work' '
+	>exec && chmod +x exec && attr_check_mode exec 100755 &&
+	>normal && attr_check_mode normal 100644 &&
+	mkdir dir && attr_check_mode dir 040000 &&
+	ln -s normal normal_sym && attr_check_mode normal_sym 120000 &&
+	attr_check_mode sub 160000
+'
+
+test_expect_success '.gitattributes mode values take precedence' '
+	(
+		echo "mode_value* mode=3Dmyownmode" &&
+		echo "mode_set* mode" &&
+		echo "mode_unset* -mode" &&
+		echo "mode_unspecified* !mode"
+	) >.gitattributes &&
+	>mode_value && attr_check_mode mode_value myownmode &&
+	>mode_unset && attr_check_mode mode_unset unset &&
+	>mode_unspecified && attr_check_mode mode_unspecified unspecified &&
+	>mode_set && attr_check_mode mode_set set
+'
+
 test_done
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.s=
h
index a9c1e4e0ec..fd9569d39b 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -64,6 +64,9 @@ test_expect_success 'setup .gitattributes' '
 	fileSetLabel label
 	fileValue label=3Dfoo
 	fileWrongLabel label=E2=98=BA
+	mode_set* mode=3D1234
+	mode_unset* -mode
+	mode_unspecified* !mode
 	EOF
 	echo fileSetLabel label1 >sub/.gitattributes &&
 	git add .gitattributes sub/.gitattributes &&
@@ -295,4 +298,54 @@ test_expect_success 'reading from .gitattributes in a =
subdirectory (3)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'mode attr is handled correctly for overriden values' =
'
+	>mode_set_1 &&
+	>mode_unset_1 &&
+	>mode_unspecified_1 &&
+	>mode_regular_file_1 &&
+
+	git status -s ":(attr:mode=3D1234)mode*" >actual &&
+	cat <<-\EOF >expect &&
+	?? mode_set_1
+	EOF
+	test_cmp expect actual &&
+
+	git status -s ":(attr:-mode)mode*" >actual &&
+	echo ?? mode_unset_1 >expect &&
+	test_cmp expect actual &&
+
+	git status -s ":(attr:!mode)mode*" >actual &&
+	echo ?? mode_unspecified_1 >expect &&
+	test_cmp expect actual &&
+
+	git status -s ":(attr:mode=3D100644)mode*" >actual &&
+	echo ?? mode_regular_file_1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mode attr values are current file modes, not indexed =
modes' '
+	>mode_exec_file_1 &&
+
+	git status -s ":(attr:mode=3D100644)mode_exec_*" >actual &&
+	echo ?? mode_exec_file_1 >expect &&
+	test_cmp expect actual &&
+
+	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
+	git status -s ":(attr:mode=3D100755)mode_exec_*" >actual &&
+	echo AM mode_exec_file_1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mode attr can be excluded' '
+	>mode_1_regular &&
+	>mode_1_exec  && chmod +x mode_1_exec &&
+	git status -s ":(exclude,attr:mode=3D100644)" "mode_1_*" >actual &&
+	echo ?? mode_1_exec >expect &&
+	test_cmp expect actual &&
+
+	git status -s ":(exclude,attr:mode=3D100755)" "mode_1_*" >actual &&
+	echo ?? mode_1_regular >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.42.0.869.gea05f2083d-goog

