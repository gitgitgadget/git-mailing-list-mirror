Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BF70830
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447185; cv=none; b=dCbtQZjdnGjFmwHG9Pvw2mmi/3vhVIMBoiIEaHUnAzYErh1bpBOQ83+KmiOfwKf652RYDqNOSukkR0U47gCgjpDEzJOPEGnxbxcjjq7/bqFhKEUxafYuWKI2w09z9Z0YbVG0UcGwTi7kFFBjvW2xZxkijp/XKwlMwO1BQiNm4PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447185; c=relaxed/simple;
	bh=XV3n1ZDg0qt4s0kbo1FHPqEIoesYYYr0AP/KZW7KMzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjJv07225cfQA0RTVHqzuIb0iKIDSbByfCtfB5xQnVS6mJomGqsBPB7AOr3KnYGLWFgJTta3tKhrBOptjgVZ5KUj5WNby7z+Fs7uSLproCLtr3CcYMfoImEPyPD5ugSKI8b3Isu1Z1q9O5Hx3xu3S1XThVGAcanR3dveS6/STRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Rssfri2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RPo1i0BF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Rssfri2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RPo1i0BF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BC9EEC00D1;
	Tue,  9 Sep 2025 15:46:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Sep 2025 15:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447181;
	 x=1757533581; bh=tljZ5UQJxHS3aO9xmC51nyrCsiM02NXxN6HPcZr4LYE=; b=
	Rssfri2Lmk2X0MypFlvQwewox4kmD9eoAUy7CxAvcaAaUefOOfbwTIFRnOIRo2Rn
	vMJWlFFIVvSr6QD+KhMGWy32Xk6895Hj4s4tpmfYClTy5iGfhKf9Fx9M9W2i59x3
	/RrjHQL0rPpIwp6DBfXuYdLgJDXZiBOkFUUdT07RbFLMqgtRQbP+J1/KUuSniDdw
	QIcSfAwgrCubwJJGV7USE3FAdqrzWQ6M7wt1ZfzGwsbgkl+WULP2j0floDlhyEom
	FUuZ4aqREOAdV+nsx1HrTYIM0b2WC/gbHWVBwoVdvDItsylN7lktIQLBrtLhyVSb
	qHeOQANEWXlAtgoRY5QGyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447181; x=
	1757533581; bh=tljZ5UQJxHS3aO9xmC51nyrCsiM02NXxN6HPcZr4LYE=; b=R
	Po1i0BFuoJzESSaZEs2Q8g61ab0XkvAVudaJi0WHWNqhtthhu8/GqQuwjqvxoWj0
	eAonaGh1a19dau6upspOdd1RTrr5xPcroe4F4BJCGiO87rK2K8HXuoC7o9NyWxCx
	YcIZrcJhWBQ/Ib4B4poaS5kMgjazgONwjOCe01mWJmc+yNd507NCwF8ZV8QjETyh
	4Ihsj3Nk8iqmDRyn0ajoAxjPHCODi9O1ixc4Q3UCFO10UDb4bqT9D9VttV2dBKF2
	TqEMcW+wrPsPV36i0zY0hlwwdybFCt13h+2q7gUDZQvs1BrkcVoIl1jh4SSHT85s
	bE3+XXgbdoGTOXzinFoFw==
X-ME-Sender: <xms:DITAaFcLsh_he8LUA2psaiR7eiCKfUQzi3vD8Hqk4i6viADQsO7rvwk>
    <xme:DITAaOuQRf4iDJ5yFIOjYEjWD_mCMq4zHsmtaSVaT6YwLT4z_6uxZ4wxCv44ZeCF2
    zcP0s0_SbHf6v_6ew>
X-ME-Received: <xmr:DITAaE8AF6wG5B3Hw1Ns4TGSit_S6TOlRcSb225ngyI4AvnIGsaXZbrRLP5T0_hiYIAVNjM6nNNX0UZsMnkJ2cD8JNiJgbO7IJVde_HQdOCF7Cd5SJ88e7H8LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepieegvdffvedvvdetjedtieeigeejjeelgfeugfevlefhtedvieeiteehvedtiedt
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DITAaJ3Y--8s0fGb343uyTx0np8zu7DEoA2kcY-adrTgxB7P7_9LfA>
    <xmx:DITAaJCikE18d3ly_bnfF5CU-apkS-St4ZJm5dlRvMy8bM9P_XObvA>
    <xmx:DITAaFffmwswFdNVPJmt_vaG7BB4qvOEKyGIwqNQMJMwADb0Km2XGg>
    <xmx:DITAaG6Dq0nsJUkJn5XYvZYzimC6YJGFrHQDtupfpoeDlStEGJSsmw>
    <xmx:DYTAaLkbxE5YJchaWzqyHqQuduCO8qVn9cCG7YWKZcHlZuZ29MctSYme>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:46:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/7] you-still-use-that??: improve breaking changes troubleshooting
Date: Tue,  9 Sep 2025 21:45:50 +0200
Message-ID: <cover.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Based on the recent i-still-use-that reports about whatchanged, improve
the error reporting with this command in mind:

1. Give more possible actions instead of just (only) asking them to send
   an email
2. Hint how to replace their git-whatchanged(1) use with git-log(1) or
   an alias `whatchanged` (you can alias deprecated commands now)
3. Minor documentation changes
4. Add `deprecated` to `git --list-cmds`

§ What the errors now look like

    $ /git whatchanged
    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
    hint:   git log <opts> --raw --no-merges
    hint: Or make an alias:
    hint:   git config set --global alias.whatchanged 'log --raw --no-merges'

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this
    $ git pack-redundant
    'git pack-redundant' is nominated for removal.
    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20pack-redundant
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this

§ Changes in v4

• Patch 1: updated with suggestion from Patrick
• Patch 2: better `is_deprecated_command` implementation suggested by
  Junio and Peff
• Minor adjustments based on the previous

Kristoffer Haugsbakk (7):
  git: add `deprecated` category to --list-cmds
  git: allow alias-shadowing deprecated builtins
  t0014: test shadowing of aliases for a sample of builtins
  you-still-use-that??: help the user help themselves
  whatchanged: tell users the git-log(1) equivalent
  whatchanged: remove not-even-shorter clause
  BreakingChanges: remove claim about whatchanged reports

 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/alias.adoc    |  3 ++-
 Documentation/git-whatchanged.adoc |  8 ++++--
 Documentation/git.adoc             |  3 ++-
 builtin/log.c                      |  8 +++++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 git.c                              | 43 ++++++++++++++++++++++++------
 t/t0014-alias.sh                   | 34 +++++++++++++++++++++++
 usage.c                            | 33 ++++++++++++++++++-----
 10 files changed, 115 insertions(+), 23 deletions(-)

Interdiff against v3:
diff --git a/git.c b/git.c
index a452ce3f9e9..b3aafebfe4c 100644
--- a/git.c
+++ b/git.c
@@ -52,13 +52,9 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-/*
- * 'include_option' and 'exclude_option' are mutually exclusive.
- *
- * The default ('!include_option') is to include everything
- * except those filtered out by 'exclude_option'.
- */
-static void list_builtins(struct string_list *list, unsigned int include_option, unsigned int exclude_option);
+static void list_builtins(struct string_list *list,
+			  unsigned int include_option,
+			  unsigned int exclude_option);
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
@@ -677,18 +673,16 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(struct string_list *out, unsigned int include_option, unsigned int exclude_option)
+static void list_builtins(struct string_list *out,
+			  unsigned int include_option,
+			  unsigned int exclude_option)
 {
-	if (include_option && exclude_option)
-		BUG("'include_option' and 'exclude_option' are mutually exclusive");
-	if (include_option) {
-		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
-			if (commands[i].option & include_option)
-				string_list_append(out, commands[i].cmd);
-	} else {
-		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
-			if (!(commands[i].option & exclude_option))
-				string_list_append(out, commands[i].cmd);
+	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
+		if (include_option && !(commands[i].option & include_option))
+			continue;
+		if (exclude_option && (commands[i].option & exclude_option))
+			continue;
+		string_list_append(out, commands[i].cmd);
 	}
 }
 
@@ -809,8 +803,8 @@ static void execv_dashed_external(const char **argv)
 
 static int is_deprecated_command(const char *cmd)
 {
-	return !strcmp(cmd, "whatchanged") ||
-	       !strcmp(cmd, "pack-redundant");
+	struct cmd_struct *builtin = get_builtin(cmd);
+	return builtin && (builtin->option & DEPRECATED);
 }
 
 static int run_argv(struct strvec *args)
Range-diff against v3:
1:  bdc683a92b3 ! 1:  66e6a9554b1 git: add `deprecated` category to --list-cmds
    @@ Commit message
     
         Let’s expand the experimental `--list-cmds`[1] to allow users and
         programs to query for this information.  We will also use this in an
    -    upcoming commit to assert that all deprecated commands will have been
    -    covered in some manner.
    +    upcoming commit to implement `is_deprecated_command`.
     
         [1]: Using something which is experimental to query for deprecations is
             perhaps not the most ideal approach, but it is simple to implement
             and better than having to scan the documentation
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v4:
    +
    +    Incorporate Patrick’s suggestions about the for-loop refactor and
    +    formatting the overlong lines.  Now drop the function doc since it
    +    doesn’t apply anymore.
    +
    +    Also adjust the commit message now that we use it in the C source in an
    +    upcoming commit, not just/only as an assert-helper (in an upcoming
    +    commit).
    +
         v3 (new):
     
         This is something I wanted to submit independently until the point about
    @@ git.c: const char git_more_info_string[] =
      static int use_pager = -1;
      
     -static void list_builtins(struct string_list *list, unsigned int exclude_option);
    -+/*
    -+ * 'include_option' and 'exclude_option' are mutually exclusive.
    -+ *
    -+ * The default ('!include_option') is to include everything
    -+ * except those filtered out by 'exclude_option'.
    -+ */
    -+static void list_builtins(struct string_list *list, unsigned int include_option, unsigned int exclude_option);
    ++static void list_builtins(struct string_list *list,
    ++			  unsigned int include_option,
    ++			  unsigned int exclude_option);
      
      static void exclude_helpers_from_list(struct string_list *list)
      {
    @@ git.c: int is_builtin(const char *s)
      }
      
     -static void list_builtins(struct string_list *out, unsigned int exclude_option)
    -+static void list_builtins(struct string_list *out, unsigned int include_option, unsigned int exclude_option)
    ++static void list_builtins(struct string_list *out,
    ++			  unsigned int include_option,
    ++			  unsigned int exclude_option)
      {
    --	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
    + 	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
     -		if (exclude_option &&
     -		    (commands[i].option & exclude_option))
    --			continue;
    --		string_list_append(out, commands[i].cmd);
    -+	if (include_option && exclude_option)
    -+		BUG("'include_option' and 'exclude_option' are mutually exclusive");
    -+	if (include_option) {
    -+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
    -+			if (commands[i].option & include_option)
    -+				string_list_append(out, commands[i].cmd);
    -+	} else {
    -+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
    -+			if (commands[i].option & exclude_option)
    -+				continue;
    -+			string_list_append(out, commands[i].cmd);
    -+		}
    ++		if (include_option && !(commands[i].option & include_option))
    ++			continue;
    ++		if (exclude_option && (commands[i].option & exclude_option))
    + 			continue;
    + 		string_list_append(out, commands[i].cmd);
      	}
    - }
    - 
2:  183dd68d09d < -:  ----------- git: make the two loops look more symmetric
3:  eec01cbac16 ! 2:  672253e0e71 git: allow alias-shadowing deprecated builtins
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v4:
    +
    +    Better `is_deprecated_command` implementation.
    +
         v3 (new):
     
         Prerequisite for telling the user that they can alias `whatchanged` to
    @@ git.c: static void execv_dashed_external(const char **argv)
      
     +static int is_deprecated_command(const char *cmd)
     +{
    -+	return !strcmp(cmd, "whatchanged") ||
    -+	       !strcmp(cmd, "pack-redundant");
    ++	struct cmd_struct *builtin = get_builtin(cmd);
    ++	return builtin && (builtin->option & DEPRECATED);
     +}
     +
      static int run_argv(struct strvec *args)
4:  80fb02caeeb = 3:  00108f28f82 t0014: test shadowing of aliases for a sample of builtins
5:  d25ee26f989 = 4:  6bdcaf7f80f you-still-use-that??: help the user help themselves
6:  50621a0748f = 5:  58de9767b22 whatchanged: tell users the git-log(1) equivalent
7:  812c9870f1b = 6:  407b430d02c whatchanged: remove not-even-shorter clause
8:  0d23a4badf0 = 7:  fee752d2fb0 BreakingChanges: remove claim about whatchanged reports

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.16.gcd94ab5bf81

