Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A531353B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444972; cv=pass; b=heE+2KVr9lD8+5iVjPUk3TCU7hY4G5YQwlyg3Njpvj1fPgO8ImO/dSfh9uxvaMJ7eT845dPJUMdEIX/CrXPNYRY6lgtsMFYVhi+uYLunQ7cAMOMV2akZ5XZ+XfCYG757oX/oW9w8rSLZ59c9+sVlZRINBA0grDA/Bqno6izrgoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444972; c=relaxed/simple;
	bh=jaJ5DjH1mJRZZCuH+hJwb9MkudUg90Yp17YAJB4H7qQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKOBXOTm+3s7Tb7QqzfdI8sfqf5Wa5ce4Gv7+sU7E0u5gU+gSdb+J1tGHzEnUrVbsI/rdqLDFty4mKLU6/G+7i3penyFlCcUeB7N82tLr//mg5j30UBwDywuHMYDQoJnYzwPwN9L/1tY+ivitg//Lkb7y60SO3nKUzgLZKF9LAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=XDgIdS8e; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="XDgIdS8e"
ARC-Seal: i=1; a=rsa-sha256; t=1760444792; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f/9SxzZyVDtTzVoWaf9BZm4+p7FU3fbep6rfSVa9vTu5B5aNBJunJ7W7mL5kka6LbUSRJGB3BJ/9zqg7OBt3XuaUd6zYejsyR2I9EVmYoC+Ro29HHgtAdcUXsI+3+FKQg/Z3w9HYYtHB5pAtRrbazdu5/RixsTEYnhHxU8uwUWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444792; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=PnOxXNL/n/BLd6VEeKOTrkaXgTpAcPum2a5fvXp3qIg=; 
	b=Uh9rQfaXPKihUpYJja7MGLiNoA/jmjxqIhsCZtBkGPMr4XIx/6xj04zvenh/BFK0kLV31L0zO2v2byiLsSFZemCL9vEqVELQH1Pcm4IqCWTawTRYY2sCbkxTdibS4SQUxYaxNPIvy1yTP6nwv0u5znwyer7zbx0tkHF9NtQjmg8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444791;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=PnOxXNL/n/BLd6VEeKOTrkaXgTpAcPum2a5fvXp3qIg=;
	b=XDgIdS8ec2tdExrL/X+Vtx0WHww2oGE3KRJqcCklp/MovGX5aAbYNwFZaLwfgyZU
	tdYTpxkPZFKmB9ch+T3dJgCTTGm5AfHTktU/jrgShEPig9GLOluObYUiJ9MVkHJiHSk
	/RZx2VZ7lcYnPJ0Ip9+i6BZXl97S4SzzvX79lfXA=
Received: by mx.zohomail.com with SMTPS id 1760444787103792.2903963451851;
	Tue, 14 Oct 2025 05:26:27 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 29/29] sequencer: honor --trailer with fixup -C
Date: Tue, 14 Oct 2025 20:24:42 +0800
Message-ID: <20251014122452.1851103-30-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add an interactive rebase test that exercises
todo lists containing fixup and fixup -C commands,
and teach append_squash_message() to append trailers
when replacing the commit message.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 sequencer.c               |  4 ++++
 t/t3440-rebase-trailer.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index c02364cfce..fbf35cb474 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2027,6 +2027,10 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 		if (opts->signoff)
 			append_signoff(buf, 0, 0);
 
+		if (opts->trailer_args.nr &&
+			amend_strbuf_with_trailers(buf, &opts->trailer_args))
+			return error(_("unable to add trailers to commit message"));
+
 		if ((command == TODO_FIXUP) &&
 		    (flag & TODO_REPLACE_FIXUP_MSG) &&
 		    (file_exists(rebase_path_fixup_msg()) ||
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index ca0619655e..d0526ea0e9 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -97,6 +97,33 @@ test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
 	expect_trailer_msg HEAD^ "third"
 '
 
+test_expect_success '--trailer handles fixup commands in todo list' '
+	git checkout -B fixup-trailer HEAD &&
+	test_commit fixup-base base &&
+	test_commit fixup-second second &&
+	first_short=$(git rev-parse --short fixup-base) &&
+	second_short=$(git rev-parse --short fixup-second) &&
+	cat >todo <<EOF &&
+pick $first_short fixup-base
+fixup $second_short fixup-second
+EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	expect_trailer_msg HEAD "fixup-base" &&
+	git reset --hard fixup-second &&
+	cat >todo <<EOF &&
+pick $first_short fixup-base
+fixup -C $second_short fixup-second
+EOF
+	(
+		set_replace_editor todo &&
+		git rebase -i --trailer "$REVIEWED_BY_TRAILER" HEAD~2
+	) &&
+	expect_trailer_msg HEAD "fixup-second"
+'
+
 test_expect_success 'rebase --root --trailer updates every commit' '
 	git checkout first &&
 	git -c trailer.review.key=Reviewed-by rebase --root \
-- 
2.51.0

