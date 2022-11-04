Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE05C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKDBD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKDBDW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:03:22 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765321835
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:03:19 -0700 (PDT)
Date:   Fri, 04 Nov 2022 01:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667523795; x=1667782995;
        bh=+Aj0MAnQ+PokZzekdXICJISxmuXSjJwPXdeYf0QafEw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=j4dAkIRjK3FU3Zpiir8rF3qgi9fkOd75db8JpybqjH+4wHizDnA+G8NnCHoeam1MX
         n0DaKi2keGjLznxY9E5hbevmWxXcEtqsIzkOJU7XtP+5Owaiwac5QTsQyzwDynXAGA
         5UAZnGkiSKqnrZGwk5sr0uDbGZpQIwVTVZTunA/70VNyQ8+TRGIKdfM+8hxNiVf7h1
         BKzkdouuvYxmPM0mPBEgG2Jbjhj/4M3k0KZf49rKOvk8FW0Up9ujMpFg83gqhghjwm
         dmNSQQ5BJMWJzQX7gKXhoHHbPjHYqBUd4Mvs/oqZ4zTpvyK13G9EdD5l4zJrE/UhAI
         E7TUrnXl0ExdQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>
Subject: [PATCH 2/4] builtin/worktree.c: Update checkout_worktree() to use git-worktree
Message-ID: <20221104010242.11555-3-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updates the function to call `git checkout` instead of
`git reset --hard` to simplify adding orphan support.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index b3373fbbd6..d40f771848 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -357,7 +357,7 @@ static int checkout_worktree(const struct add_opts *opt=
s,
 {
 =09struct child_process cp =3D CHILD_PROCESS_INIT;
 =09cp.git_cmd =3D 1;
-=09strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NU=
LL);
+=09strvec_pushl(&cp.args, "checkout", "--no-recurse-submodules", NULL);
 =09if (opts->quiet)
 =09=09strvec_push(&cp.args, "--quiet");
 =09strvec_pushv(&cp.env, child_env->v);
--
2.37.4


