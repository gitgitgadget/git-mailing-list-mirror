Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF5BC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C7D20866
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exo9zz3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFMlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:41:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46058 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgCFMlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 07:41:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id h62so2309625edd.12
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7eurzkc944ta63h5cjtMc4owlZGkEkFll7UJNzvxzjQ=;
        b=Exo9zz3NqGfCnRS62TOiX0yXoDNEJyAWOjHHv4YcqqBoHPuZ+kXP2zFbIg6dwehhPL
         4CRqYJ6sXoSZao3f87yBoIir3UFcH0O93uMzBDXavaBo14tALmZKDZwqX5rdh6c2w6Un
         wojL4FOXQE6EqbSHbt2zI3Ki9ErMZSbXnshmro+Hz/sa9CDRHDISoqajckfBt9mxmhz1
         JSm2ehe0DcSoj72dsW0LGNgSq/jvbBdXPNFvI//Qjw829nEBI8PminkfdM4XVsBTue+O
         vxDLPeT5XbQphoqCcaHj99PmGZ1Vwm20p285MoyrfY9FGm6dU8jyUXFbu083AwEFD+HH
         PxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7eurzkc944ta63h5cjtMc4owlZGkEkFll7UJNzvxzjQ=;
        b=hlrffPWF+YYQ9uTRYKX/0SrmSlLBA1+hHvTLrp/ufdXAUvkQuonTS3XrriGChAPKmO
         VTTcoQFaHfo6L9kunc5KDWQaAHNT0+OfoIwT3j1WTqHU9qn6o87f1OxgbHunq3TRIs3V
         sGnDpGsNbgmHeMYlmS1rkidNo6/WbLjDo9BDpH/wRxvEpFWiHv9aZW+WooV24kRc1IoU
         z9aKZ4BZENNByUwX36KdsxuDe8F6k9qTOWiQqI4oGMr+3J9Dwq6M4hnB2QLHbZjyKqhd
         tcgsQChhz6xFVkq2z9T3/MU44C44iJzX/YGaLWVKmZCWSVtNPdpYYFaOqpJRB98hf29t
         e58A==
X-Gm-Message-State: ANhLgQ3uqMshoogMSzbslNDzoPL4oaA/VoHVsHYx0UoMua3qPcrFIiVA
        ei9mhhu3WOt48Cxx18hZAJvdgv6f
X-Google-Smtp-Source: ADFU+vumpVkuMq7hOxLtZC4iCQDKgX9sxwuQvp0YmyO01rffcCKmOwIvQBKobotWEqcWyLRLnHPF2g==
X-Received: by 2002:a50:f70c:: with SMTP id g12mr2958119edn.142.1583498509543;
        Fri, 06 Mar 2020 04:41:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm98193edq.78.2020.03.06.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 04:41:48 -0800 (PST)
Message-Id: <pull.574.git.1583498508362.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 12:41:48 +0000
Subject: [PATCH] prepare_shell_cmd: add code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

While debugging something else, I was quite puzzled to see that
`prepare_shell_cmd()` duplicates the command before sending to sh, like:
    sh -c "git-upload-pack '../testrepo/.git'" "git-upload-pack '../testrepo/.git'"

A Windows programmer myself, initially I thought that it's a bug.

Add a clarifying comment.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
    prepare_shell_cmd: add code comment
    
    While debugging something else, I was quite puzzled to see that
    prepare_shell_cmd() duplicates the command before sending to sh, like:
    sh -c "git-upload-pack '../testrepo/.git'" "git-upload-pack
    '../testrepo/.git'"
    
    A Windows programmer myself, initially I thought that it's a bug.
    
    Add a clarifying comment.
    
    Signed-off-by: Alexandr Miloslavskiy alexandr.miloslavskiy@syntevo.com
    [alexandr.miloslavskiy@syntevo.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-574%2FSyntevoAlex%2F%230259(git)_doubled_prepare_shell_cmd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-574/SyntevoAlex/#0259(git)_doubled_prepare_shell_cmd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/574

 run-command.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/run-command.c b/run-command.c
index f5e1149f9b3..95ab3c168bc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -284,6 +284,12 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
 			argv_array_push(out, argv[0]);
 		else
 			argv_array_pushf(out, "%s \"$@\"", argv[0]);
+
+		/*
+		 * -c expects shell_name after command_string.
+		 * Pushing entire original argv below will pass argv[0]
+		 * as shell name.
+		 */
 	}
 
 	argv_array_pushv(out, argv);

base-commit: 076cbdcd739aeb33c1be87b73aebae5e43d7bcc5
-- 
gitgitgadget
