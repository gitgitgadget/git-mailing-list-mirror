Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD0C2D0BF
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2C206A5
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMxrW/nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfLRT3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39297 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLRT3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so3069715wmj.4
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xbAMdwUoczvFExTFmHXxzR/2/texrkL36eKuhAIvlbk=;
        b=eMxrW/ndFjc70f5o/0z7zOE5eFOBUnADz+0Hvm8hwLaafNLi8/Krxu+jNySNTeNpTh
         4OG8hFO1VXFfqzaI5iv+7JBHWuCDZ3NZ8hHofH/usY/8Mdtt8F+dq/bUTZAWt2XPOVS7
         3RjcIxYnpnwoEv7JaqTa4aq+s8SYZJpRkNWwoT85D4pkA9bMVF+LB6+AxSDl6ho16BJj
         FQLAfczqTEq2K+oIIJrEoU0ya1nxg/n+jamXjsa/Lijbl1ppwVbUji5o9ztZtnlx4H6O
         7no7cSDdhZbe9Sbiy2uAktuLF6CsrvwCtasxInMy+26o2GpLhimP1N/5dAUAnBYAlmmo
         qMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xbAMdwUoczvFExTFmHXxzR/2/texrkL36eKuhAIvlbk=;
        b=s3kSIL+rnPaM0Kc6ByVpUqImm/+3cpI8SKl8FyeDZXA5u7T0qWafSMDhsNIjrwmgDw
         zFsW3zH8BOKM6rj34LswsyFvpVF//wwOKSjyfmTi8a7hY4sfKQeZUXcHzroq/4juK10T
         SUSARuFlEYalnUxuEBT3exG8g0yE7Zx3TaOXjtC+ALV8grq6godEVpFIiw2dOroU6x6w
         SHuVq6zSRynuaAGJTdMALWxiAXpakGyIOtfqbBb/uDpVQMHMe9eQAvVRTGObQ3y8pe2V
         Nx76Co/6cklE67c6cs/DfD+DixtOQjA0artT2XYokTHxshbZTzQamDHtGMnEu/DJOH47
         kLCA==
X-Gm-Message-State: APjAAAUNBj+xd3f8XfHETNqbuxsOnWgYqfUuSFCn0hk4tuhv+FUzn6q1
        snoq53oAL7DbEbnjFosBAJc188U3
X-Google-Smtp-Source: APXvYqxkD961nzMx1zsG3CwuDWiUySlAlu9JJA3UBZHfA8wUxBOQPdggffY1utCXIurEF6sCCE/KVA==
X-Received: by 2002:a1c:3187:: with SMTP id x129mr5186435wmx.91.1576697391478;
        Wed, 18 Dec 2019 11:29:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm3575175wml.7.2019.12.18.11.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:51 -0800 (PST)
Message-Id: <8d2d98eec3c620c55100a322087ef83e4f51c8cf.1576697386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:42 +0000
Subject: [PATCH v4 4/8] dir: exit before wildcard fall-through if there is no
 wildcard
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The DO_MATCH_LEADING_PATHSPEC had a fall-through case for if there was a
wildcard, noting that we don't yet have enough information to determine
if a further paths under the current directory might match due to the
presence of wildcards.  But if we have no wildcards in our pathspec,
then we shouldn't get to that fall-through case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                                              | 7 +++++++
 t/t3011-common-prefixes-and-directory-traversal.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 5dacacd469..517a569e10 100644
--- a/dir.c
+++ b/dir.c
@@ -379,6 +379,13 @@ static int match_pathspec_item(const struct index_state *istate,
 			       item->nowildcard_len - prefix))
 			return 0;
 
+		/*
+		 * name has no wildcard, and it didn't match as a leading
+		 * pathspec so return.
+		 */
+		if (item->nowildcard_len == item->len)
+			return 0;
+
 		/*
 		 * Here is where we would perform a wildmatch to check if
 		 * "name" can be matched as a directory (or a prefix) against
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 54f80c62b8..d6e161ddd8 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -92,7 +92,7 @@ test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+test_expect_success 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
 	cat <<-EOF >expect &&
 	untracked_dir/empty
 	untracked_repo/
@@ -110,7 +110,7 @@ test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses int
 	test_cmp expect actual
 '
 
-test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+test_expect_success 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
 	cat <<-EOF >expect &&
 	untracked_dir/
 	untracked_repo/
-- 
gitgitgadget

