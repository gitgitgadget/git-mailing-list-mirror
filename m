Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927336A342
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854560; cv=none; b=ZcBqyVBaRt0Iu5OeibKl9Hcsmk/FGy1MdgRecOiyShpRHAdZBaHGeN9n9CWVZjPsz456MhSA5qC2H9GsWXYkvQ9XHcRCnB6QKsqM7m7VOJALNETdtfVij9iFsd8sNkK+hViOiXsCDHdZ5srMNDqtnmmJuXcHmvQ9teYg95xNCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854560; c=relaxed/simple;
	bh=XbkDbMCc91GUOa3ih9E3ACU5DpG8N9IY+vu4McQIHas=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rhV1utFAA5Lm8RSLqh4Md+GALQ7eJLahTXgqbb7ZsHiKH0De1AnTIjMUQOjE1NsWloTxGLsGHsV5llY+kH2M4vXTeCwsnYutkzSkrzqdJiTbp5K7CC3IUnEtbbrYJ1QfZibRv7uzkCfQLN7kQHTKSD8EyPjP18bd6AFVlx7Xgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vUXruYZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaTxS0oz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vUXruYZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaTxS0oz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 874C3EC0100;
	Thu, 27 Aug 2026 14:15:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 27 Aug 2026 14:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787854557; x=1787940957; bh=2BUdUyYbKh
	QKb84J7FFHiAPrnNXkYoMAJ//exrXi3QM=; b=vUXruYZD5z17gtG3CSEj1g+/JZ
	3GGeeidegiPKgV1pM+XhdcvFoXOaiRbYvVdUkT0mFNlx6LdRG4zlmSZl+NPYc9KS
	dP0vAD7lfVgHZQ1peSKu+Sow7TStW7ftmTZvJz8LHvBYQ1DUX8lc5DbAnRu1VIqz
	e03M0RoPIAfnHbor+Df/WYp6xXNb0KqY0jdtrKkxucvQUtULDxh8ombK531NBHYd
	6fb7Do8GIGqjw+CzvqDrJ3cJ53VbKmJDdxqNWn0O+cLiLFu19qQv1ks0gFicsgf5
	vdCa/C5P5gw7TY2RCQ43Dq8LjTHYLtLzJ0uW/j8P+A8AYBg3kLyowfo5ROKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787854557; x=1787940957; bh=2BUdUyYbKhQKb84J7FFHiAPrnNXkYoMAJ//
	exrXi3QM=; b=IaTxS0ozYaL47Irju2Qq2yNsX1ATbOpgRwOdv0menif3duckpBn
	F34yx4rKXqbq0oos0i01eGR/S+K1wsvpBeL3ZhkIQw8jD7hpZqzDtUflsnhbCCjz
	7s8vYGRv9mgYmCRMyC7D1UMgr2PZ14E7PJRmSyQM+eIcytcwHUQmKJlrCt4h+Z26
	wLTowXnEQyOekKNRgRj521wbxkbynhIl9vCnIHviM8hlOafm+HHjw4E62HenEExX
	OhKGTM/gPCUoi0k4OTADpFPuPZW+7OyjTsavj9zyg47OsZZ9S2KwlIQbF64xkud1
	PE9muSmmcCJd3NcRKmUcKpLsPfDjjdDQCqQ==
X-ME-Sender: <xms:3X6Qal_JvRiNjbbIbz4qPIRKbsIdXo52TC1HYJGMUyQjkmZZYkhHAQ>
    <xme:3X6Qavu24el7aZAP8BJ--0GTYTFJdzlxu2wPbIbqVWuG1YkC-_ha0Bjc_qTgqAkM3
    ExhzmJvEwLdfMbivcHe0RYmRks43IDxjECIcNX6vfLT0-R3kIMQmA>
X-ME-Received: <xmr:3X6QagphLe2ReML9yf-o8nsEGMko4tK7xUk_AbaiH-K27BBRGu5mcSPuAimlrrGhH8eRW8Xh6kH6YvWnsnnTK5kQ8uIZKyNWVQ>
X-ME-Proxy-Cause: dmFkZTEa2xhPrlLBJY2THBEF7SLa3AKUSdw+HuGCSaEFJJjI8oE21en4LQd+ygP4BJTkjQ
    2b3PWvG9g00beOkIM8R1PEdvokQAA1omqF2b38BDFZf2P3+n3t//Nd2Nt5cX1gaL63u3Ys
    FdqgrZWpL/CF/qutZEPFGiLji5sJgh3QnIfrnSy3LA1H/Gjz3k9x5v+ufi+5CgtKi5LSgg
    hxNgGZEIKRch+v6ts5bUJ92gFPKozuqEFVr3mFHKn3GXrcNKjgqIfTKka3mnidJZRs84W6
    nJqKenAD8mwOVMPVFdywcc0tzlvoNrVVx7zswvhg0xyvfAHhdo0Z7Eg7bn/iGAccVT7MPb
    L6VS5F+BJwsWFZ155F2fl5Hma3XsV/UDAN3/jR1N4XKcwOqo09Mgp1tg+dvGTV8ZZlPgVw
    puJG9v9QXpLo1sg6Pw/r8NpDt7h2NhTwQE1ywi63xprGxGfsE5nWq/KGJpzW4sF9kJW4MR
    YHmrZ88zl6oKWkQHFEbKPNA0oD03hmZwk15l59WzoftWudEPU5CIhNQ3nspD5cJO67++ox
    Xaon7XeG6F2p6ASBkWX4GIZ6H7S22Y+GWXZtqNHi8EoTxpgGkTB6slL1hsOWPy1SNbbBnZ
    qh6H13XGwlrf0h4BXFrf2kyQQKcAMLSZ9fh3Tz0N2+WmqKthsN2Hr/HseFtA
X-ME-Proxy: <xmx:3X6QakmWkwqJOWPaAfKaibPfhSJ8maukH9mzGXP1q11JjukE0drXtA>
    <xmx:3X6QaswQ79zW30AJfnXdnwVWWEmE55j_AlH3Q04zsiK461KBuBgXtA>
    <xmx:3X6QaklaidzcZ9H6eYm82C_ihjhQf1wbeQgSBAcNXznODhfx2b-i1g>
    <xmx:3X6Qate5ebIDYgNCVo9dNyKucg6mQ2_aGWZcl_igSo8R93FJfJsK_g>
    <xmx:3X6QahXzpVQeZAKrLyi1L2Yh73_NJ3qOX9uoHVvwy1cSrPJUoXdHm1b2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 14:15:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3] you_still_use_that(): reword the instructions
In-Reply-To: <xmqqjypchixe.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Aug 2026 10:48:29 -0700")
References: <xmqqo6epj6is.fsf@gitster.g> <xmqqjypchixe.fsf@gitster.g>
Date: Thu, 27 Aug 2026 11:15:55 -0700
Message-ID: <xmqqse3z8m5g.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The message is overly long and may mislead readers into thinking
there is recourse other than adopting the new workflow.  Clarify
that the message is there merely to help them find a replacement
workflow, and is not offering to reconsider a decision that has
already taken effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The text is unchanged from v2 except for fixing "mailing list";
   two tests that looked for "nominated for removal" string have
   been corrected.

 t/t4013-diff-various.sh   |  2 +-
 t/t5323-pack-redundant.sh |  2 +-
 usage.c                   | 16 +++++++---------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d35695f5b0..93d6e6e975 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -478,7 +478,7 @@ EOF
 
 test_expect_success !WITH_BREAKING_CHANGES 'whatchanged needs --i-still-use-this' '
 	test_must_fail git whatchanged >message 2>&1 &&
-	test_grep "nominated for removal" message
+	test_grep "will be removed soon" message
 '
 
 test_expect_success 'log -m matches pure log' '
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 2d96afd6f7..aff0bce099 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -47,7 +47,7 @@ shared_repo=shared.git
 
 test_expect_success 'pack-redundant needs --i-still-use-this' '
 	test_must_fail git pack-redundant >message 2>&1 &&
-	test_grep "nominated for removal" message
+	test_grep "will be removed soon" message
 '
 
 git_pack_redundant='git pack-redundant --i-still-use-this'
diff --git a/usage.c b/usage.c
index 527edb1e79..90f392e89e 100644
--- a/usage.c
+++ b/usage.c
@@ -386,21 +386,19 @@ NORETURN void you_still_use_that(const char *command_name, const char *hint)
 				 STRBUF_ENCODE_SLASH);
 
 	fprintf(stderr,
-		_("'%s' is nominated for removal.\n"), command_name);
+		_("'%s' will be removed soon.\n"), command_name);
 
 	if (hint)
 		fputs(hint, stderr);
 
 	fprintf(stderr,
-		_("If you still use this command, here's what you can do:\n"
+		_("If you need a replacement:\n"
 		  "\n"
-		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
-		  "- check if anyone has discussed this on the mailing\n"
-		  "  list and if they came up with something that can\n"
-		  "  help you: https://lore.kernel.org/git/?q=%s\n"
-		  "- send an email to <git@vger.kernel.org> to let us\n"
-		  "  know that you still use this command and were unable\n"
-		  "  to determine a suitable replacement\n"
+		  "- Read https://git-scm.com/docs/BreakingChanges.html.\n\n"
+		  "- Check what others on the mailing list suggest as a replacement:\n"
+		  "  https://lore.kernel.org/git/?q=%s\n\n"
+		  "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
+		  "  suggestions by others do not work for you.\n"
 		  "\n"),
 		percent_encoded.buf);
 	strbuf_release(&percent_encoded);

Interdiff:
  diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
  index d35695f5b0..93d6e6e975 100755
  --- a/t/t4013-diff-various.sh
  +++ b/t/t4013-diff-various.sh
  @@ -478,7 +478,7 @@ EOF
   
   test_expect_success !WITH_BREAKING_CHANGES 'whatchanged needs --i-still-use-this' '
   	test_must_fail git whatchanged >message 2>&1 &&
  -	test_grep "nominated for removal" message
  +	test_grep "will be removed soon" message
   '
   
   test_expect_success 'log -m matches pure log' '
  diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
  index 2d96afd6f7..aff0bce099 100755
  --- a/t/t5323-pack-redundant.sh
  +++ b/t/t5323-pack-redundant.sh
  @@ -47,7 +47,7 @@ shared_repo=shared.git
   
   test_expect_success 'pack-redundant needs --i-still-use-this' '
   	test_must_fail git pack-redundant >message 2>&1 &&
  -	test_grep "nominated for removal" message
  +	test_grep "will be removed soon" message
   '
   
   git_pack_redundant='git pack-redundant --i-still-use-this'
  diff --git a/usage.c b/usage.c
  index d421ca426b..90f392e89e 100644
  --- a/usage.c
  +++ b/usage.c
  @@ -395,7 +395,7 @@ NORETURN void you_still_use_that(const char *command_name, const char *hint)
   		_("If you need a replacement:\n"
   		  "\n"
   		  "- Read https://git-scm.com/docs/BreakingChanges.html.\n\n"
  -		  "- Check what others on the mailing suggest as a replacement:\n"
  +		  "- Check what others on the mailing list suggest as a replacement:\n"
   		  "  https://lore.kernel.org/git/?q=%s\n\n"
   		  "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
   		  "  suggestions by others do not work for you.\n"
-- 
2.55.0-862-g3c6f97f7b9

