Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F93D3B4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI951NGy"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D7102
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:19 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41b7fd8f458so36736201cf.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991658; x=1700596458; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h67uBtDj9QixuqFNHn6CByXAvsoJ40i70Ttc3Pco2u8=;
        b=dI951NGy5hn6/4Tr+DBerPJ0nuvvSB6/bbTZzic9FUpcL75Db8djD49LU5rJTI/f7g
         645xzTO+rNdhqmmJsb+tiyjiKILjh04smLzdhqMh4qZZSTTKhrEF+vFP2ab5gJiLTxVF
         OD9chS/UsSKJHvgRGzmLQnNDQ2ZztUMOi0yOoIL6NxL/MP/rkZCPvBIy9esULLldbLFc
         vmiFEpM/1Fj9GyMjcup2VKzPGQYW4J8HpDPRIRUOPsYX7nsShWHlbnefaZ6Hz3xGWCaz
         pVBas6RAJPRizPpHuD9GchzfVp0TYboTuU3d3cT5sE7sx9LVCw25S1uBWgUj/7m33AMT
         qKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991658; x=1700596458;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h67uBtDj9QixuqFNHn6CByXAvsoJ40i70Ttc3Pco2u8=;
        b=givBt9bkKDLYI2elfVN3kcANeL1OS1fQZLXNQSzzgx1trHRlFD+BSOtbvFjr4huF2i
         dJMKVuuGBBh6XXQPbmydZBs+Fw9Ufgves33ZyF2g6HxzoBSxYS88MZ+8nGUQcHnPpi2S
         mtYlXLrGtfnzuuhRfxZxRzMzOqT6hNLPwcRAiqbyd9Rx01HjXei3XdJtfMNvhFQullS1
         lQLu/x/scQIx2dfhpsfqL8fpQ3T6eCfutBRtI1ElC97f83pJfkwjpcZA1tTwMXJEB2pA
         R5Zk9L4UyrZd7syt2MBzjfK+HNRGZ0kRmPSonbb5ftetrOgVsv9KCiUFmvd3LQKSlgiB
         dTOg==
X-Gm-Message-State: AOJu0YybIuHO0lUlZif2e+0AKwXT8MWZX3l9IBP4Gij5sqYNsMv/9vfA
	/AeGQce+YkKHiOZ+lhn34mzF2AJXh5A=
X-Google-Smtp-Source: AGHT+IGspugj30OGP0JkrVCxufsf2P32HgWQO4XspN+zhdoAmMWa7PyjXuTUmj3csyg/wtkD5lQocA==
X-Received: by 2002:ac8:4e52:0:b0:417:9c40:c606 with SMTP id e18-20020ac84e52000000b004179c40c606mr4413656qtw.4.1699991658090;
        Tue, 14 Nov 2023 11:54:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b0041ce9ebaad2sm2981367qto.43.2023.11.14.11.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:17 -0800 (PST)
Message-ID: <48254d8e161de7f0e165510c06801195f9b0a8fd.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:57 +0000
Subject: [PATCH v2 09/10] ref-filter.c: use peeled tag for '*' format fields
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

In most builtins ('rev-parse <revision>^{}', 'show-ref --dereference'),
"dereferencing" a tag refers to a recursive peel of the tag object. Unlike
these cases, the dereferencing prefix ('*') in 'for-each-ref' format
specifiers triggers only a single, non-recursive dereference of a given tag
object. For most annotated tags, a single dereference is all that is needed
to access the tag's associated commit or tree; "recursive" and
"non-recursive" dereferencing are functionally equivalent in these cases.
However, nested tags (annotated tags whose target is another annotated tag)
dereferenced once return another tag, where a recursive dereference would
return the commit or tree.

Currently, if a user wants to filter & format refs and include information
about a recursively-dereferenced tag, they can do so with something like
'cat-file --batch-check':

    git for-each-ref --format="%(objectname)^{} %(refname)" <pattern> |
        git cat-file --batch-check="%(objectname) %(rest)"

But the combination of commands is inefficient. So, to improve the
performance of this use case and align the defererencing behavior of
'for-each-ref' with that of other commands, update the ref formatting code
to use the peeled tag (from 'peel_iterated_oid()') to populate '*' fields
rather than the tag's immediate target object (from 'get_tagged_oid()').

Additionally, add a test to 't6300-for-each-ref' to verify new nested tag
behavior and update 't6302-for-each-ref-filter.sh' to print the correct
value for nested dereferenced fields.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-for-each-ref.txt |  4 ++--
 ref-filter.c                       | 13 ++++---------
 t/t6300-for-each-ref.sh            | 22 ++++++++++++++++++++++
 t/t6302-for-each-ref-filter.sh     |  4 ++--
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b136c9fa908..be9543f6840 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -296,8 +296,8 @@ from the `committer` or `tagger` fields depending on the object type.
 These are intended for working on a mix of annotated and lightweight tags.
 
 For tag objects, a `fieldname` prefixed with an asterisk (`*`) expands to
-the `fieldname` value of object the tag points at, rather than that of the
-tag object itself.
+the `fieldname` value of the peeled object, rather than that of the tag
+object itself.
 
 Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
diff --git a/ref-filter.c b/ref-filter.c
index 48453db24f7..fdaabb5bb45 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2508,17 +2508,12 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		return 0;
 
 	/*
-	 * If it is a tag object, see if we use a value that derefs
-	 * the object, and if we do grab the object it refers to.
+	 * If it is a tag object, see if we use the peeled value. If we do,
+	 * grab the peeled OID.
 	 */
-	oi_deref.oid = *get_tagged_oid((struct tag *)obj);
+	if (need_tagged && peel_iterated_oid(&obj->oid, &oi_deref.oid))
+		die("bad tag");
 
-	/*
-	 * NEEDSWORK: This derefs tag only once, which
-	 * is good to deal with chains of trust, but
-	 * is not consistent with what deref_tag() does
-	 * which peels the onion to the core.
-	 */
 	return get_object(ref, 1, &obj, &oi_deref, err);
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0613e5e3623..54e22812598 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1839,6 +1839,28 @@ test_expect_success 'git for-each-ref with non-existing refs' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'git for-each-ref with nested tags' '
+	git tag -am "Normal tag" nested/base HEAD &&
+	git tag -am "Nested tag" nested/nest1 refs/tags/nested/base &&
+	git tag -am "Double nested tag" nested/nest2 refs/tags/nested/nest1 &&
+
+	head_oid="$(git rev-parse HEAD)" &&
+	base_tag_oid="$(git rev-parse refs/tags/nested/base)" &&
+	nest1_tag_oid="$(git rev-parse refs/tags/nested/nest1)" &&
+	nest2_tag_oid="$(git rev-parse refs/tags/nested/nest2)" &&
+
+	cat >expect <<-EOF &&
+	refs/tags/nested/base $base_tag_oid tag $head_oid commit
+	refs/tags/nested/nest1 $nest1_tag_oid tag $head_oid commit
+	refs/tags/nested/nest2 $nest2_tag_oid tag $head_oid commit
+	EOF
+
+	git for-each-ref \
+		--format="%(refname) %(objectname) %(objecttype) %(*objectname) %(*objecttype)" \
+		refs/tags/nested/ >actual &&
+	test_cmp expect actual
+'
+
 GRADE_FORMAT="%(signature:grade)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
 TRUSTLEVEL_FORMAT="%(signature:trustlevel)%0a%(signature:key)%0a%(signature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index af223e44d67..82f3d1ea0f2 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -45,8 +45,8 @@ test_expect_success 'check signed tags with --points-at' '
 	sed -e "s/Z$//" >expect <<-\EOF &&
 	refs/heads/side Z
 	refs/tags/annotated-tag four
-	refs/tags/doubly-annotated-tag An annotated tag
-	refs/tags/doubly-signed-tag A signed tag
+	refs/tags/doubly-annotated-tag four
+	refs/tags/doubly-signed-tag four
 	refs/tags/four Z
 	refs/tags/signed-tag four
 	EOF
-- 
gitgitgadget

