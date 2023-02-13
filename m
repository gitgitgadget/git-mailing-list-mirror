Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE72EC636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 13:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjBMNQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 08:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBMNQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 08:16:00 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849651B32A
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 05:15:31 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E046232004E7
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 08:15:27 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 13 Feb 2023 08:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marabos.nl; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1676294127; x=1676380527; bh=QJvxDUlpVFEWwhlFAPAK9FN2g6IIJPVcyHH
        dMWKs0CI=; b=T7BXxvKWSAr+EYWpBsjvao1DlIftYjqdhPJtU12duXcQcBpV+gw
        Ce0PQ5mIc8hdjk2BSW2NiNR0UvSOmICzfG0N1nQ2oWbRMJWIZUiswMcbv+bwGfei
        skeNyd5MVUnlW6FrUeIB2MkPCUYVmEt4m0PsxH94/sGEr8bycWiqsm2wC+ybVUYU
        GhaRlF/oDK+P9Tp1UeRkF3YaVyuMT6+DOkTVoqjyU0hDZ0Hl670Jj5LNmnmnb1m9
        wWpXaaQCh3a7bw+RyO60fmu9PRGj46aMNwk+xa6FeSZP0NyOglYHNIVLGSNzQSqC
        A4DQPGQe/03MR8vxE9k60eqBDjbu+iVgWEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676294127; x=
        1676380527; bh=QJvxDUlpVFEWwhlFAPAK9FN2g6IIJPVcyHHdMWKs0CI=; b=o
        HLHtTwl2XeNA794MMxYb1hLxjH3nDHtqFhP17rhmQgOYiguuUeydJwpce+Vj/hv4
        ozSUY7RW4Z5DVoxeVra+iXi0OBg98FBohvzNBY3OjaOenu0xKKfX90XvPfW5sNmi
        zRuCbA9fnQODeoduwIQJ2FeviRcJLpSMKMWEo8FaCvzVVg0o29kuxKHu90kKvLOn
        8vPk7E3ZM9t4SpV+2rOaQ7dzRWZze7u/vhhpc9/lL0IV2e5A/u+jxfpaDPMkin48
        kFSDXr/cWToTTBhE2VV6Y2/tmgFsKobk/8Xm87X1JSFgf65VZ3j3/1bLo2wqm+XZ
        5qZGT2Brq9y+RfBoxM5DA==
X-ME-Sender: <xms:7jfqY2Br-aHTz7jdJw9BhFR-7u2kyzw6aEChjQi0COhgBAdQ7ZyNzA>
    <xme:7jfqYwgUIZIySeaj_HG8B5l-OcYfnJjVD62KODw2W5UiC8X3PuMkcly2qezVYZeBi
    hdPu4yxjR9_Q5kYd8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpeforghrrgcuoehmrghrrgesmhgrrhgrsghoshdrnhhlqeenucgg
    tffrrghtthgvrhhnpeegudekvdffgfehjeevkeefffeuteeludehffeugfdvuefhfefhge
    eftefhgefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrghrrgesmhgrrhgrsghoshdrnhhl
X-ME-Proxy: <xmx:7jfqY5kP1U4WksndydluvPdwD56uzxhuATrciQG823dAvKEgjJ-KKg>
    <xmx:7jfqY0yGqlBHM4hhSA84Iwz0Aa9n-KxSGx4XNcUrjYnYXXMMUy7XtA>
    <xmx:7jfqY7Q6l3_1i-ogvdN9o8C1c2W3YaceFH3e-1Pt7AnujVjSix8qTw>
    <xmx:7zfqYyfiB3wNVndzBNWiaIyr_-oQscpPCD6jhF1vbMHCdeGgYFDajA>
Feedback-ID: ice0147e0:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BA2D8BC0078; Mon, 13 Feb 2023 08:15:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <623b0b8a-a5b3-408c-b924-9f88d9763b0e@app.fastmail.com>
Date:   Mon, 13 Feb 2023 14:14:21 +0100
From:   Mara <mara@marabos.nl>
To:     git@vger.kernel.org
Subject: [PATCH] Use correct default remote for fetching in submodule.
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git submodule update" first tries a regular "git fetch"
to fetch the commit, but when that doesn't retrieve the commit
it wants, it tries "git fetch <remote> <commit>".
For <remote>, it used the wrong default remote: the default
remote of the outer repository, rather than the default remote
of the submodule.

Signed-off-by: Mara Bos <mara@marabos.nl>
---
 builtin/submodule--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c173d8b37..50b96e0b9d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2225,7 +2225,10 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 		strvec_pushf(&cp.args, "--depth=%d", depth);
 	if (oid) {
 		char *hex = oid_to_hex(oid);
-		char *remote = get_default_remote();
+		char *remote;
+		int code = get_default_remote_submodule(module_path, &remote);
+		if (code)
+			return code;

 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
--
2.39.0
