Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F5C6FA8E
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 01:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjB0B5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 20:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjB0B5I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 20:57:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D09A12F27
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 17:57:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r18so4653058wrx.1
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 17:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9L9pfIRzS+uzJcyvd+DJCigPa9CEPnO6eLIcRHuPYY=;
        b=PiinkxdqOb/4H4XHyI3ufTzuK2PeyMQk6LnX9yUUm//1M5Ndpj7g26kY2foAZvI31S
         K121VffvMeB6eUDN9QbSOGNBWoZxnpSrD/WNtLfPZLDJ3paufzCViBOvOpl0MKt7u3Uj
         dJwjp5rASZ7vggnzJ283DL0M+5UfQ5kTSANwifKfL3YDRAHbfUXndYq9yRHvdPg2MSVO
         FOHx2kTUyVYkT7zGmvSocV2ZDJbF/eBqnki3YjuiYhQK6sHFjsaOPVB1Wvz8uCGQkGxF
         NFbuWULK+LSvqw0oxwQvJ2ALpuokf4xc1mnVlGmTg8M85/H37MfTTDRO/W6trxvMP2pK
         aJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9L9pfIRzS+uzJcyvd+DJCigPa9CEPnO6eLIcRHuPYY=;
        b=rczJb/LpMnaRzhBSB2H5QGrumFPE08ydMLwOd1Mfv03N1Uge91J/2+WUVPnuhokPM6
         1R8RqdJUrTPJdJ4Yb+fP0oQR+/qRnnXgdWLcoHwQxsjRtmwkwGWDILzzX6jNUxWEJf1j
         QiiEEgLONTtVi07pUY9YVRWmjKx1YUD+3NyVI8pMm0U9ppYbesU1gPGsUV7+lNWmBX+f
         dF5LtUSGuFkdlWa7hl3rC+khTHXYoYWt7ETfAsgftrEtTZqHQp1i7tFko5/Tr0Yq8NYT
         tIaK6JjzZ3o9roedkp4qFuNqjhAyhYFucH+AW2DOcQ8KjiThCyPsS9cVGGvzJUa7onQF
         mxOQ==
X-Gm-Message-State: AO0yUKUjV/2ogJFuujH2VGqOE2VcUf52En/f6mEbdVzPZX3efVstq1Oi
        GUSe2UGGdXWb+EG3nJFXsQZASWIiWiU=
X-Google-Smtp-Source: AK7set9X+UL+jA/RUPzcAQ2LAt5VbVc2fndXAyVptje0pcizqErODOK81C5H+bSZ8I22wsaK8hp/mA==
X-Received: by 2002:a5d:42cc:0:b0:2c7:aed:b97b with SMTP id t12-20020a5d42cc000000b002c70aedb97bmr12689482wrr.62.1677463025511;
        Sun, 26 Feb 2023 17:57:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a1c4b02000000b003e203681b26sm7204410wma.29.2023.02.26.17.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 17:57:05 -0800 (PST)
Message-Id: <4dc75f5b9614477bf8b729af5d456e1a5531f6ac.1677463022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
References: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
        <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 01:57:02 +0000
Subject: [PATCH v3 2/2] [RFC] push: allow delete single-level ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

We discourage the creation/update of single-level refs
because some upper-layer applications only work in specified
reference namespaces, such as "refs/heads/*" or "refs/tags/*",
these single-level refnames may not be recognized. However,
we still hope users can delete them which have been created
by mistake.

Therefore, when updating branches on the server with
"git receive-pack", by checking whether it is a branch deletion
operation, it will determine whether to allow the update of
a single-level refs. This avoids creating/updating such
single-level refs, but allows them to be deleted.

On the client side, "git push" also does not properly fill in
the old-oid of single-level refs, which causes the server-side
"git receive-pack" to think that the ref's old-oid has changed
when deleting single-level refs, this causes the push to be
rejected. So the solution is to fix the client to be able to
delete single-level refs by properly filling old-oid.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/receive-pack.c | 4 +++-
 connect.c              | 3 ++-
 t/t5516-fetch-push.sh  | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c24616a3ac6..af61725a388 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1463,7 +1463,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		find_shared_symref(worktrees, "HEAD", name);
 
 	/* only refs/... are allowed */
-	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!starts_with(name, "refs/") ||
+	    check_refname_format(name + 5, is_null_oid(new_oid) ?
+				 REFNAME_ALLOW_ONELEVEL : 0)) {
 		rp_error("refusing to update funny ref '%s' remotely", name);
 		ret = "funny refname";
 		goto out;
diff --git a/connect.c b/connect.c
index 63e59641c0d..7a396ad72e9 100644
--- a/connect.c
+++ b/connect.c
@@ -30,7 +30,8 @@ static int check_ref(const char *name, unsigned int flags)
 		return 0;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
+	if ((flags & REF_NORMAL) && check_refname_format(name,
+							 REFNAME_ALLOW_ONELEVEL))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f37861efc40..19ebefa5ace 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -903,6 +903,13 @@ test_expect_success 'push --delete refuses empty string' '
 	test_must_fail git push testrepo --delete ""
 '
 
+test_expect_success 'push --delete onelevel refspecs' '
+	mk_test testrepo heads/main &&
+	git -C testrepo update-ref refs/onelevel refs/heads/main &&
+	git push testrepo --delete refs/onelevel &&
+	test_must_fail git -C testrepo rev-parse --verify refs/onelevel
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test testrepo heads/main &&
 	(
-- 
gitgitgadget
