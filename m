Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B451F92A
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949879; cv=none; b=Tm5qMShRMOgciq1/+HyNlSPi6ezo9nkgRVY6sy7Lv9GzmDyjqKKCe/E7Zv17xtf6gakzi/InVzcFs7rk034gWH+ia1/ZuHehnpaBYJgBVG2yWg/hvTYCJQVoSOyri4YuscQUgmsU+0yIi+XevHuHBqx+9QFmt6Gh2h9Ls808+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949879; c=relaxed/simple;
	bh=cqKUND4n3bvqG5t3m8+mXi4261UUsCtAV3iVykEovrA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nZAv+oNPAOfIbZNRR18f679/4rj5Xo5c8sDt7Nodt2H2c1jNL5c8Ar7WPahaV7WNvO8nnRv37TeJq5Bb5ih33f1afvZ1IvpoMTBDh/6L7po1O+ghw5aGu/2qTtitDxbd1EHsrFs65S2olOtOLf8SQKSp8XAok8lhbVbYpnjm9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmfx8kua; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmfx8kua"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436a03197b2so39367175e9.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 16:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735949875; x=1736554675; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EYm3Z/oUa20DgNSBvwcBLJA1qOxzzBBGZllTCtWIkU=;
        b=Dmfx8kua9Fg4T8c7f0r+KwvDRh39wafj4WFeWdRCdi8Tiw0JhK+HNcOHN7sRR8MHV5
         bxlgIysge2QyTNiD/6MH/NbIH2z3yilwF5l1NaLp1EkeJ2D39UCz2eGbYLR2w8vqkMBM
         E7RgmmV++H0bsGB7Ly7Y2PXO7vzkcMwb7TmD3pZWaziKioRik+j91FxNrbQMxs4WX+1Z
         2h2vqN9CSdVKUjdDrU+BkQHM8v2HX5w84zOCpuo8JjvCBWKgv2sK0EPg2STP9f6rpV5i
         SQq1v3HoykFeMWJrIQehi7+vuXGmDr5Yk+rUob/SgB486ZwNGaPIpwWyObsA0KDoiSSN
         Tseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735949875; x=1736554675;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EYm3Z/oUa20DgNSBvwcBLJA1qOxzzBBGZllTCtWIkU=;
        b=FXGXFoTp+WC0hiVX3LNv2dh63gSjofUpFpYQk6dqZI7VvGr4BRK2szzK4FLK5YHGOy
         utK8bx969WPThGABwwAACdhrP2Udzeb1g/dIVwG+yGzAhl/SnY+aCqCEnT+PpNM+dFlT
         vn/gJH45EvWLcwXEFwhv0jQdZnBxeq8CMcvUxErfLZBIkDSMMmZtBrY12vSIg4AEXFug
         iDUdwGiZnVT9oWhXZsv7aAuFtvt1ov/Vlq35E7J2rUP0e44Jwu91SlvpjLOUvd1h20Pw
         njOPr11IXrbUaJ56kcjZ7dy3YIq1xBF2k/qJ5dx2yNTIZYpEG99Lx1qcJd1Ltkyl6nVW
         +IXw==
X-Gm-Message-State: AOJu0YyOM7jVnv+vA5DB32I6lNmcgpKT4M4eQhGLPaxdVAzpFWuBSj39
	rbIbk+bhML/jkGjRvdLs7PLneMhdez0K7xA1nqGOP/aE8okAgu5ZguiPPQ==
X-Gm-Gg: ASbGncua6aTttIFWVNTuxCM8uH9YImW0zkM2mGnv6Xbt3Sh9Rf1lcJbyAZh6DCmWjwE
	q2Kmj9B3uEXPu9VI67BW0BGAibVcJu8Fjy6K6dw07YSIjx/zXQJZu/UjkH8GHcux24lpw0q6yu0
	cuPMDp3qj+IzLXpBV6ot3J/sQxFNmL2NjiTVoKVaoRM1S9dK64tlgc2zjB2BjB6cA6guVu3Z5v0
	rg/GyTzWE5S6NvLnsMayGEi6Bg3goxsl73QuToJYZVcvQS15Tku86HZSA==
X-Google-Smtp-Source: AGHT+IHPM2H86KHgMiZafORBKE2fsJqxLUoLlGKKbp1B/nl1XpkfaW3QpPmHS9fI1TGLF/oFYdWFNQ==
X-Received: by 2002:a05:600c:35cb:b0:436:1af4:5e07 with SMTP id 5b1f17b1804b1-43668548867mr340831405e9.1.1735949874973;
        Fri, 03 Jan 2025 16:17:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm42519387f8f.45.2025.01.03.16.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 16:17:53 -0800 (PST)
Message-Id: <31f1c37b31a2ac5cecee0f7f5913e0c466b7561c.1735949870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jan 2025 00:17:50 +0000
Subject: [PATCH v2 2/2] object-name: be more strict in parsing describe-like
 output
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

From Documentation/revisions.txt:
    '<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
      Output from `git describe`; i.e. a closest tag, optionally
      followed by a dash and a number of commits, followed by a dash, a
      'g', and an abbreviated object name.
which means that output of the format
    ${REFNAME}-${INTEGER}-g${HASH}
should parse to fully expand ${HASH}.  This is fine.  However, we
currently don't validate any of ${REFNAME}-${INTEGER}, we only parse
-g${HASH} and assume the rest is valid.  That is problematic, since it
breaks things like

    git cat-file -p branchname:path/to/file/named/i-gaffed

which, when commit affed exists, will not return us information about a
file we are looking for but will instead tell us about commit affed.

Similarly, we should probably not treat
    refs/tags/invalid/./../...../// ~^:/?*\\&[}/busted.lock-g049e0ef6
as a request for commit 050e0ef6 either.

Tighten up the parsing to make sure ${REFNAME} and ${INTEGER} are
present and valid.

Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 object-name.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t6120-describe.sh | 22 ++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index e54ef1f621e..71207729f6f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1271,6 +1271,58 @@ static int peel_onion(struct repository *r, const char *name, int len,
 	return 0;
 }
 
+/*
+ * Documentation/revisions.txt says:
+ *    '<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
+ *      Output from `git describe`; i.e. a closest tag, optionally
+ *      followed by a dash and a number of commits, followed by a dash, a
+ *      'g', and an abbreviated object name.
+ *
+ * which means that the stuff before '-g${HASH}' needs to be a valid
+ * refname, a dash, and a non-negative integer.  This function verifies
+ * that.
+ *
+ * In particular, we do not want to treat
+ *   branchname:path/to/file/named/i-gaffed
+ * as a request for commit affed.
+ *
+ * More generally, we should probably not treat
+ *   'refs/heads/./../.../ ~^:/?*[////\\\&}/busted.lock-g050e0ef6ead'
+ * as a request for object 050e0ef6ead either.
+ *
+ * We are called with name[len] == '-' and name[len+1] == 'g', i.e.
+ * we are verifying ${REFNAME}-{INTEGER} part of the name.
+ */
+static int ref_and_count_parts_valid(const char *name, int len)
+{
+	struct strbuf sb;
+	const char *cp;
+	int flags = REFNAME_ALLOW_ONELEVEL;
+	int ret = 1;
+
+	/* Ensure we have at least one digit */
+	if (!isxdigit(name[len-1]))
+		return 0;
+
+	/* Skip over digits backwards until we get to the dash */
+	for (cp = name + len - 2; name < cp; cp--) {
+		if (*cp == '-')
+			break;
+		if (!isxdigit(*cp))
+			return 0;
+	}
+	/* Ensure we found the leading dash */
+	if (*cp != '-')
+		return 0;
+
+	len = cp - name;
+	strbuf_init(&sb, len);
+	strbuf_add(&sb, name, len);
+	ret = !check_refname_format(name, flags);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int get_describe_name(struct repository *r,
 			     const char *name, int len,
 			     struct object_id *oid)
@@ -1284,7 +1336,8 @@ static int get_describe_name(struct repository *r,
 			/* We must be looking at g in "SOMETHING-g"
 			 * for it to be describe output.
 			 */
-			if (ch == 'g' && cp[-1] == '-') {
+			if (ch == 'g' && cp[-1] == '-' &&
+			    ref_and_count_parts_valid(name, cp - 1 - name)) {
 				cp++;
 				len -= cp - name;
 				return get_short_oid(r,
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 3f6160d702b..9217bd0fa89 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -725,4 +725,26 @@ test_expect_success '--exact-match does not show --always fallback' '
 	test_must_fail git describe --exact-match --always
 '
 
+test_expect_success 'avoid being fooled by describe-like filename' '
+	test_when_finished rm out &&
+
+	git rev-parse --short HEAD >out &&
+	FILENAME=filename-g$(cat out) &&
+	touch $FILENAME &&
+	git add $FILENAME &&
+	git commit -m "Add $FILENAME" &&
+
+	git cat-file -t HEAD:$FILENAME >actual &&
+
+	echo blob >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'do not be fooled by invalid describe format ' '
+	test_when_finished rm out &&
+
+	git rev-parse --short HEAD >out &&
+	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
+'
+
 test_done
-- 
gitgitgadget
