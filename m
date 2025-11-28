Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9201CFBA
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334495; cv=none; b=Uktk10xb4suLFi/sRTqd6e7Oog6vggyTRo6ww9FXZy9+UPj+dZxsElK5dYLsnC/UpjqpSO097TSTnnTbgfzG1Vnm8PtyfdfQM5S7skiIsS4TDNT5uOpfpqWms4Q0XEozh0DnfKp81+SaSwbiZI/H3O/CTsz7BuFmL53Iwu7X2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334495; c=relaxed/simple;
	bh=0WEJut8SXhWtYoQ1TV6BLsrKm9LyjqGLpGeuf8u3FiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OoC95r5fIBGMXJ7Hjza7NSDLbKGy4op5e+ryBuuoPBVMalouG8nX8Y+nFqb0ABL6CCe53f9W5GsUALPSZrojZpLFhb2aXzYqPilbnQFvIlQdso1o4X/QyAxZIHvkNYj0Plxxk3gkNkoO9HuwVRMm7j/4zfg6vJgUmg8HiZRPk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UM0UjMvE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yg2ubP7B; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UM0UjMvE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yg2ubP7B"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DF0D91D00769;
	Fri, 28 Nov 2025 07:54:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 28 Nov 2025 07:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1764334491; x=1764420891; bh=I9
	4iKd40P1Xa2RA+x3s5Euat/zuDZ9YaWQeu4O2XIRk=; b=UM0UjMvE+qDu01zsJ4
	4EyUXPiK2I4J9BlErheb7g8zUf1mODrgT3POPRFLZK64E4KKsNwNnt2jcgfZMYkB
	/NZfsULMD4d9K7k+b7LeDHy4zoQqqcJ9qhfkTBU7mea4tr9s4mLci4kTCPAyV7nd
	TNRUb0AaIhSXfBwEkAkbEduJUHCXkMot2jPzDC/CyFMjIyI++g6HfFSvhvBL0rLn
	k19xCEoNU4/UXCyl4+LiMJBEcsCyRY3OyHU4CJgSkqs57DOCfe9cKA7FpcPkNOx7
	I/HhSwxMq9VBPzQ/OXHsQiAZd3vzswryVYapbH5xzYPhd7pI3C3wv4Y+OtX9CfkM
	pQdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1764334491; x=1764420891; bh=I94iKd40P1Xa2RA+x3s5Euat/zuD
	Z9YaWQeu4O2XIRk=; b=yg2ubP7BhoXT/E+34OngANS+z3/JPI7z4qcpaZaV23Hr
	KyApC8nb0UEBUtN3gYVQIpnAEUr82jvfeZOX4ZAs7Q7wz00vbXTUzZRWRbNJrWQO
	S4reXN7l3q7JcYiAyydIHMinT8pZ45cWm++VgEiQ0OH1hdOEAMyO87RDIR9ReQcg
	pZ2gDu9qNUjEJNqsWqV8ZZ3e3Kz6raDZ43bxz+O76YK9uvtTF1vjs8X4YzMp4wbp
	G3ZMG6uRJoDM/WI3KcSBxTTEawLOR7oQ/DDz3ux/Qdf64yaOSlVXvjBjOhsurUBP
	TORzh4e2UAd/0ydoQoBmD1l9iDgTLfo2Ffsuor/ehQ==
X-ME-Sender: <xms:m5spaTbMAH3Dbux_aoKkOl31hNKGm3fLaAeKSisK1z3-egs3r9S0xic>
    <xme:m5spaYYWK9-LLQV9MCI04mB87XTdS_LMHUFPxF8S3BjhLEY7NG7wXPA1v8btWO3nM
    dgw25GhsrKMWq9K-MTwNPeG8X2m1aPPwrpiHzPz-20UhZrRdPD5BA>
X-ME-Received: <xmr:m5spaTnxZedE1BZkVD6k_t152IvCK2SNDf9ziHf3wDTCAe5X1tZrFE9qJJr0Kg-jQQPic-a9obfq5T3cYQ3Vb3P7W0bOZMOwoncijGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:m5spaUw0hxNBaDmQ7RZy62bQXUXMsopTJKX3Y0Sp5f-kcGRkgPGoMw>
    <xmx:m5spaRMKZNHSbIDrzmZwxV7Z6kBnmeMlXA5lz8l8pcLfcgfYxGpqwQ>
    <xmx:m5spaYRHwWmKrT3QLIJtzQNxhjFHXFeCv9yiJ_4_QkZxyzs2QcYuwg>
    <xmx:m5spafa90O4JZ5_2i_zffwhS-Z6koR15H5OueZ62tnw0iUGbJO9CGA>
    <xmx:m5spaWwtrl08VRB3cOYUxqSVOSAPDprKvhgvcqVEt3ZTYF7IaGoVPGYw>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 07:54:50 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] branch: advice using git-help(1) instead of man(1)
Date: Fri, 28 Nov 2025 13:54:29 +0100
Message-ID: <advice_git-help.64@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

8fbd903e (branch: advise about ref syntax rules, 2024-03-05) added
an advice about checking git-check-ref-format(1) for the ref syntax
rules. The advice uses man(1). It’s better to use Git’s own git-help(1)
instead of an external command.

Also change to using single quotes (') to quote the command since that
is more conventional.

While here let’s also update the test to use `{SQ}`, which is more
readable and easier to edit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 branch.c          | 2 +-
 builtin/branch.c  | 2 +-
 t/t3200-branch.sh | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index 26be3583471..243db7d0fc0 100644
--- a/branch.c
+++ b/branch.c
@@ -375,7 +375,7 @@ int validate_branchname(const char *name, struct strbuf *ref)
 	if (check_branch_ref(ref, name)) {
 		int code = die_message(_("'%s' is not a valid branch name"), name);
 		advise_if_enabled(ADVICE_REF_SYNTAX,
-				  _("See `man git check-ref-format`"));
+				  _("See 'git help check-ref-format'"));
 		exit(code);
 	}
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 9fcf04bebb2..c577b5d20f2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -591,7 +591,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		else {
 			int code = die_message(_("invalid branch name: '%s'"), oldname);
 			advise_if_enabled(ADVICE_REF_SYNTAX,
-					  _("See `man git check-ref-format`"));
+					  _("See 'git help check-ref-format'"));
 			exit(code);
 		}
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e720dc10d..c58e505c43f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1707,9 +1707,9 @@ test_expect_success '--track overrides branch.autoSetupMerge' '
 '
 
 test_expect_success 'errors if given a bad branch name' '
-	cat <<-\EOF >expect &&
-	fatal: '\''foo..bar'\'' is not a valid branch name
-	hint: See `man git check-ref-format`
+	cat <<-EOF >expect &&
+	fatal: ${SQ}foo..bar${SQ} is not a valid branch name
+	hint: See ${SQ}git help check-ref-format${SQ}
 	hint: Disable this message with "git config set advice.refSyntax false"
 	EOF
 	test_must_fail git branch foo..bar >actual 2>&1 &&

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.52.0.10.g08704017180

