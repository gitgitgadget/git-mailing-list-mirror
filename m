Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB27C4708D
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 01:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiL0Azb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 19:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0Aza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 19:55:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5DC10D7
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 16:55:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d4so3194161wrw.6
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 16:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qzcsniO+CP5XxLQLighynh2srfcLo/oHwUyEam+szyw=;
        b=FSE8CPxrtk/xR1dXLZMkVrKfpN351Aet+YoHcWSvC3YxKczD8iZjuetF/d28Mc1cQj
         pL2Sh4ZVU82rJS+77LnkqhJSkDArxvZqOwYQ2v7p3moiIhnxvfMj7wp2q64mQhIIIVp/
         v3n6t4nTmrDYBSJ9HkurLJcXMU+1SxcHf4GyP77N/sLRDgPTTI4DZb/fLXAkx1rVuJkq
         VrqmS6KpYLcIaRiEazIaMEPmyevPsDV8Qlymz695Ydly6qGwZOpN3pgTA+fW2m0BUNqz
         XVq9W7fqWm5njh+Vz/a6h0o3LtBiDBHEzJBtVvdwtT2MeHwk2ijnDHzkYHthaPt5IvsZ
         WTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzcsniO+CP5XxLQLighynh2srfcLo/oHwUyEam+szyw=;
        b=455yijYLGaIc2dKeuPqSI1Ij6ZzvmhJlsNVVoZohLw7+to3DFtOmKNsMxHsXihwQXF
         ndAxTV570lM+2Y/Ychcyc3roTZYGMqx816GgCnYFxQy4LikgO0vpWwp9b2cuaIQR8ran
         hIcmC/f/otWRzgWSJ6tWHsEHUxSLaVH8GXR3r5IRZTdgX6Xem8xKmKh/OXH6nkpL/aUI
         GHwsDRi0Ry/0v1ENJEz1fF3v7L47ufCxm6Cvr2ptjdhkVUgR/cnRXBLoE796hPOXd9Bw
         WHg48CfcneNmiySe/fNa5Zvr4oocuuQ27uHRMdTSjuI5raKvJZXpL5m357Rvt8MaICp2
         A2LQ==
X-Gm-Message-State: AFqh2kojyB6qcjuLKhHfp4bB00AdGicowGHw4cMKotwjLXTk4hGDah+n
        DmtUT635CBQ7rZFEw96x4vBrepGLbkg=
X-Google-Smtp-Source: AMrXdXs8sENn88wuoHMz7NYgPRoBlyO5CBCcficAOgOLK43S0gwCDAOdxdsdUlhEP2O0oq4H+2DIlw==
X-Received: by 2002:a5d:4008:0:b0:241:997a:4f57 with SMTP id n8-20020a5d4008000000b00241997a4f57mr12217099wrp.39.1672102525248;
        Mon, 26 Dec 2022 16:55:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9-20020adff909000000b00267bcb1bbe5sm11351821wrr.56.2022.12.26.16.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 16:55:24 -0800 (PST)
Message-Id: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
From:   "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Dec 2022 00:55:23 +0000
Subject: [PATCH] ref-filter: add new atom "signature" atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>

This only works for commits. Add "signature" atom with `grade`,
`signer`, `key`, `fingerprint`, `primarykeyfingerprint`, `trustlevel`
as arguments. This code and it's documentation are inspired by
how the %GG, %G?, %GS, %GK, %GF, %GP, and %GT pretty formats were
implemented.

Co-authored-by: Hariom Verma <hariom18599@gmail.com>
Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
---
    ref-filter: add new atom "signature" atom
    
    This only works for commits. Add "signature" atom with grade, signer,
    key, fingerprint, primarykeyfingerprint, trustlevel as arguments. This
    code and it's documentation are inspired by how the %GG, %G?, %GS, %GK,
    %GF, %GP, and %GT pretty formats were implemented.
    
    Co-authored-by: Hariom Verma hariom18599@gmail.com Co-authored-by:
    Jaydeep Das jaydeepjd.8914@gmail.com Mentored-by: Christian Couder
    chriscool@tuxfamily.org Mentored-by: Hariom Verma hariom18599@gmail.com
    Signed-off-by: Nsengiyumva Wilberforce nsengiyumvawilberforce@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1452%2Fnsengiyumva-wilberforce%2Fsignature6-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1452/nsengiyumva-wilberforce/signature6-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1452

 Documentation/git-for-each-ref.txt |  27 +++++++
 ref-filter.c                       |  94 +++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 116 +++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6da899c6296..9a0be85368b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -212,6 +212,33 @@ symref::
 	`:lstrip` and `:rstrip` options in the same way as `refname`
 	above.
 
+signature::
+	The GPG signature of a commit.
+
+signature:grade::
+	Show "G" for a good (valid) signature, "B" for a bad
+	signature, "U" for a good signature with unknown validity, "X"
+	for a good signature that has expired, "Y" for a good
+	signature made by an expired key, "R" for a good signature
+	made by a revoked key, "E" if the signature cannot be
+	checked (e.g. missing key) and "N" for no signature.
+
+signature:signer::
+	The signer of the GPG signature of a commit.
+
+signature:key::
+	The key of the GPG signature of a commit.
+
+signature:fingerprint::
+	The fingerprint of the GPG signature of a commit.
+
+signature:primarykeyfingerprint::
+	The Primary Key fingerprint of the GPG signature of a commit.
+
+signature:trustlevel::
+	The Trust level of the GPG signature of a commit. Possible
+	outputs are `ultimate`, `fully`, `marginal`, `never` and `undefined`.
+
 worktreepath::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
diff --git a/ref-filter.c b/ref-filter.c
index 9dc2cd14519..bb3624fb4e9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -144,6 +144,7 @@ enum atom_type {
 	ATOM_BODY,
 	ATOM_TRAILERS,
 	ATOM_CONTENTS,
+	ATOM_SIGNATURE,
 	ATOM_RAW,
 	ATOM_UPSTREAM,
 	ATOM_PUSH,
@@ -208,6 +209,10 @@ static struct used_atom {
 		struct email_option {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
+		struct {
+			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY, S_PRI_KEY_FP,
+			       S_FINGERPRINT, S_TRUST_LEVEL } option;
+		} signature;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -378,6 +383,30 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
 	return 0;
 }
 
+static int signature_atom_parser(struct ref_format *format, struct used_atom *atom,
+			       const char *arg, struct strbuf *err)
+{
+	if (arg) {
+		if (!strcmp(arg, "signer"))
+			atom->u.signature.option = S_SIGNER;
+		else if (!strcmp(arg, "grade"))
+			atom->u.signature.option = S_GRADE;
+		else if (!strcmp(arg, "key"))
+			atom->u.signature.option = S_KEY;
+		else if (!strcmp(arg, "fingerprint"))
+			atom->u.signature.option = S_FINGERPRINT;
+		else if (!strcmp(arg, "primarykeyfingerprint"))
+			atom->u.signature.option = S_PRI_KEY_FP;
+		else if (!strcmp(arg, "trustlevel"))
+			atom->u.signature.option = S_TRUST_LEVEL;
+		else
+			return strbuf_addf_ret(err, -1, _("unknown %%(signature) argument: %s"), arg);
+	}
+	else
+		atom->u.signature.option = S_BARE;
+	return 0;
+}
+
 static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
@@ -613,6 +642,7 @@ static struct {
 	[ATOM_BODY] = { "body", SOURCE_OBJ, FIELD_STR, body_atom_parser },
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
+	[ATOM_SIGNATURE] = { "signature", SOURCE_OBJ, FIELD_STR, signature_atom_parser },
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
@@ -1344,6 +1374,69 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 	}
 }
 
+static void grab_signature(struct atom_value *val, int deref, struct object *obj)
+{
+	int i;
+	struct commit *commit = (struct commit *) obj;
+
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
+		struct atom_value *v = &val[i];
+		struct signature_check sigc = { 0 };
+
+		if (!!deref != (*name == '*'))
+			continue;
+		if (deref)
+			name++;
+		if (strcmp(name, "signature") &&
+			strcmp(name, "signature:signer") &&
+			strcmp(name, "signature:grade") &&
+			strcmp(name, "signature:key") &&
+			strcmp(name, "signature:fingerprint") &&
+			strcmp(name, "signature:primarykeyfingerprint") &&
+			strcmp(name, "signature:trustlevel"))
+			continue;
+
+		check_commit_signature(commit, &sigc);
+
+		if (atom->u.signature.option == S_BARE)
+			v->s = xstrdup(sigc.output ? sigc.output: "");
+		else if (atom->u.signature.option == S_SIGNER)
+			v->s = xstrdup(sigc.signer ? sigc.signer : "");
+		else if (atom->u.signature.option == S_GRADE) {
+			switch (sigc.result) {
+			case 'G':
+				switch (sigc.trust_level) {
+				case TRUST_UNDEFINED:
+				case TRUST_NEVER:
+					v->s = xstrfmt("%c", (char)'U');
+					break;
+				default:
+					v->s = xstrfmt("%c", (char)'G');
+					break;
+				}
+				break;
+			case 'B':
+			case 'E':
+			case 'N':
+			case 'X':
+			case 'Y':
+			case 'R':
+				v->s = xstrfmt("%c", (char)sigc.result);
+			}
+		}
+		else if (atom->u.signature.option == S_KEY)
+			v->s = xstrdup(sigc.key ? sigc.key : "");
+		else if (atom->u.signature.option == S_FINGERPRINT)
+			v->s = xstrdup(sigc.fingerprint ? sigc.fingerprint : "");
+		else if (atom->u.signature.option == S_PRI_KEY_FP)
+			v->s = xstrdup(sigc.primary_key_fingerprint ? sigc.primary_key_fingerprint : "");
+		else if (atom->u.signature.option == S_TRUST_LEVEL)
+			v->s = xstrdup(gpg_trust_level_to_str(sigc.trust_level));
+	}
+}
+
 static void find_subpos(const char *buf,
 			const char **sub, size_t *sublen,
 			const char **body, size_t *bodylen,
@@ -1536,6 +1629,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
+		grab_signature(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index fa38b874416..5726517cfda 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -6,6 +6,7 @@
 test_description='for-each-ref test'
 
 . ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
@@ -1446,4 +1447,119 @@ sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
 sig_crlf=${sig_crlf%dummy}
 test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
 
+GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
+TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
+
+test_expect_success GPG 'show good signature with custom format' '
+	git checkout -b signed &&
+	echo 1 >file && git add file &&
+	test_tick && git commit -S -m initial &&
+	git verify-commit signed 2>out &&
+	cat >expect <<-\EOF &&
+	G
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	EOF
+	git for-each-ref refs/heads/signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'test signature atom with grade option and bad signature' '
+	git config commit.gpgsign true &&
+	echo 3 >file && test_tick && git commit -a -m "third" --no-gpg-sign &&
+	git tag third-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag second-signed HEAD^ &&
+	git tag third-signed &&
+
+	git cat-file commit third-signed >raw &&
+	sed -e "s/^third/3rd forged/" raw >forged1 &&
+	FORGED1=$(git hash-object -w -t commit forged1) &&
+	git update-ref refs/tags/third-signed "$FORGED1" &&
+	test_must_fail git verify-commit "$FORGED1" &&
+
+	cat >expect <<-\EOF &&
+	B
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+
+
+	EOF
+	git for-each-ref refs/tags/third-signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with custom format' '
+	echo 4 >file && test_tick && git commit -a -m fourth -SB7227189 &&
+	git tag signed-fourth &&
+	cat >expect <<-\EOF &&
+	U
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git for-each-ref refs/tags/signed-fourth --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with undefined trust level' '
+	echo 5 >file && test_tick && git commit -a -m fifth -SB7227189 &&
+	git tag fifth-signed &&
+	cat >expect <<-\EOF &&
+	undefined
+	65A0EEA02E30CAD7
+	Eris Discordia <discord@example.net>
+	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
+	D4BE22311AD3131E5EDA29A461092E85B7227189
+	EOF
+	git for-each-ref refs/tags/fifth-signed --format="$TRUSTLEVEL_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show untrusted signature with ultimate trust level' '
+	echo 7 >file && test_tick && git commit -a -m "seventh" --no-gpg-sign &&
+	git tag seventh-unsigned &&
+
+	test_tick && git rebase -f HEAD^^ && git tag sixth-signed HEAD^ &&
+	git tag seventh-signed &&
+	cat >expect <<-\EOF &&
+	ultimate
+	13B6F51ECDDE430D
+	C O Mitter <committer@example.com>
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	73D758744BE721698EC54E8713B6F51ECDDE430D
+	EOF
+	git for-each-ref refs/tags/seventh-signed --format="$TRUSTLEVEL_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show unknown signature with custom format' '
+	cat >expect <<-\EOF &&
+	E
+	65A0EEA02E30CAD7
+
+
+
+	EOF
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git for-each-ref refs/tags/fifth-signed --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show lack of signature with custom format' '
+	echo 8 >file && test_tick && git commit -a -m "eigth unsigned" --no-gpg-sign &&
+	git tag eigth-unsigned &&
+	cat >expect <<-\EOF &&
+	N
+
+
+
+
+	EOF
+	git for-each-ref refs/tags/eigth-unsigned --format="$GRADE_FORMAT" >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
-- 
gitgitgadget
