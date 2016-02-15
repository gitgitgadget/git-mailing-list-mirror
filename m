From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] worktree add -B: do the checkout test before update branch
Date: Mon, 15 Feb 2016 20:35:33 +0700
Message-ID: <1455543333-25814-2-git-send-email-pclouds@gmail.com>
References: <20160215094154.GA11698@lanh>
 <1455543333-25814-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	kirill.likhodedov@jetbrains.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 14:36:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVJKj-0003iw-D6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 14:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbcBONgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 08:36:43 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35542 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcBONgm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 08:36:42 -0500
Received: by mail-pa0-f68.google.com with SMTP id fl4so7202281pad.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 05:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CTDSXhjMxDjYnaH4PyY2XT5D5zitYVWAgtfk+Z9jRhU=;
        b=L857TuctTT0QcKTixLm6uBvoXkz8TuLyKVj3fEMpioQtNGFL9AW0ghK8eBE6q76me8
         49UukanlGtlp02XFGZb8Sd2Vr0eNgHvPxqPBzLfCsVgf5Y93XcyGLiKElNEjzoZitsoi
         Mav3nQjIVlRI82TEscO7nuam6+xv3d31fOqcudEiKGmK9sc878QEvvdTfDo+WePhJTV+
         8vbv8MshkD4U9Rs5/8X9X9L9ulJvz1Sih6cCeHHvkwisOvmtEZWasmjXRki8e891bSNg
         pvOJeI6URLb6113lCjH3kKEba9LgBz11SHdHLILnoQ3REQv91sGbxpO8GUWNlnSwdL0L
         xX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CTDSXhjMxDjYnaH4PyY2XT5D5zitYVWAgtfk+Z9jRhU=;
        b=PNznKenC699eso82S+qqRb8soVqO8tm+7AbFqdMpKW5XEDon+kEzzF2Fo69G2DpJqO
         PhFHGKlZwsiscIErrMWW/9JfwSQRay+y3Ca4++U5kTA7g4qY14twvcfESq9Kl1hRKA5M
         qmZVKko26zONRDsTVkgOWyg5vbnCDp9oAUJom2nzU7CHl4kyJYobcdw8kb5QiLsLAOvK
         8OQhhiPCRkkki8cABen+LmxEVpxvFvCFk9YSh1YhG3EH8zTjBdlu3YQlnu0zz6in1Zl4
         QTnkFGJvv1HRp1ueiam0I59ig89oKdwh4a+lLc0KzlWavDv/qXQux8oy42zH18w1viLl
         IWyA==
X-Gm-Message-State: AG10YOQolkTE4NeUA+XepqTo+vh0b5AWG20i9ZX6sQbVNYtS2maVCC7NibzSlpvgcieHlg==
X-Received: by 10.66.228.201 with SMTP id sk9mr23329016pac.1.1455543402035;
        Mon, 15 Feb 2016 05:36:42 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id yx4sm38861009pac.5.2016.02.15.05.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 05:36:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 20:37:03 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455543333-25814-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286204>

If --force is not given but -B is, we should not proceed if the given
branch is already checked out elsewhere. add_worktree() has this test,
but it kicks in too late when "git branch --force" is already
executed. As a result, even though we correctly refuse to create a new
worktree, we have already updated the branch and mess up the other
checkout.

Repeat the die_if_checked_out() test again for this specific case befor=
e
"git branch" runs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Something extra while I was studying this code. I'm not so sure if
 this is the right way.
=20
 Another option is do it in "git branch" which rejects with "Cannot
 force update the current branch", but only for current worktree.

 builtin/worktree.c      | 11 ++++++++++-
 t/t2025-worktree-add.sh |  7 +++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6b9c946..20cf67a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -334,9 +334,18 @@ static int add(int ac, const char **av, const char=
 *prefix)
 	branch =3D ac < 2 ? "HEAD" : av[1];
=20
 	opts.force_new_branch =3D !!new_branch_force;
-	if (opts.force_new_branch)
+	if (opts.force_new_branch) {
+		struct strbuf symref =3D STRBUF_INIT;
+
 		opts.new_branch =3D new_branch_force;
=20
+		if (!opts.force &&
+		    !strbuf_check_branch_ref(&symref, opts.new_branch) &&
+		    ref_exists(symref.buf))
+			die_if_checked_out(symref.buf);
+		strbuf_release(&symref);
+	}
+
 	if (ac < 2 && !opts.new_branch && !opts.detach) {
 		int n;
 		const char *s =3D worktree_basename(path, &n);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index a4d36c0..cbfa41e 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -193,6 +193,13 @@ test_expect_success '"add" -B/--detach mutually ex=
clusive' '
 	test_must_fail git worktree add -B poodle --detach bamboo master
 '
=20
+test_expect_success '"add -B" fails if the branch is checked out' '
+	git rev-parse newmaster >before &&
+	test_must_fail git worktree add -B newmaster bamboo master &&
+	git rev-parse newmaster >after &&
+	test_cmp before after
+'
+
 test_expect_success 'add -B' '
 	git worktree add -B poodle bamboo2 master^ &&
 	git -C bamboo2 symbolic-ref HEAD >actual &&
--=20
2.7.0.377.g4cd97dd
