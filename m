Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EBC41513
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 14:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjHPO0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbjHPO0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 10:26:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BD72724
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:26:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff975a9318so36953e87.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692195958; x=1692800758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upy6/4ohUqIjpdDrWAcA5Hw3iU4dxg0GF9jpYhf4gTo=;
        b=N/te/K40nTJqrkeID6+sqs9mB73OD3EU0MXSQYudFg8XxPsk2YQSxKP2T0xnNlIEg9
         /sgt7u3PD60MY6mjSp/LNjRYPRu+SVB2PcxHEZEexUmiETGDihcFXFUrhuogJ8SZhfAn
         LxLSZ9SMb8STAdf64luaANzOiLOrRDuuELoTXmDRPTpZeQONfBiqACLUlkD0bGbWgGAj
         yYMLcdJglQCLGHhWMorftrKmXFjqLAt06YdPadA+MEoPIUSqkL1Tm4oauzy58cvvOvq0
         c+aibC6lPinKCKLP8sZ3EjSePMksbqVkbgJyPGt4R99vaw186o9rtAOXxuRLMO9H2oBZ
         LDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195958; x=1692800758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upy6/4ohUqIjpdDrWAcA5Hw3iU4dxg0GF9jpYhf4gTo=;
        b=RbxemMo5Iv7CbM9+pzrw2QsiAYJCErsHWsXYDF/uL22IbRHH/D1qr8skwWaWuUvYR0
         wT23DNKwT65FzmNtOpRCMftcsAD6NosKI9PZJwCrV9nDgNQaW+KqmuskjAy/rNVpgczD
         8RSJAE0SyQLXjt7i8czvfjBJ7jWfRmzMC/pALtaL2C2Rie4o+dozUJIHvDeogpKJSLG0
         EeZlsZtnFCj0nR0gP8cUGhGR3PdUOfbxCRKGQhhLj+6mxxxNET4I+xXWcDrUTQYThzoa
         Yp5deFMpVW1Ke4+p2p126H8FeChEwcE2HwITa+OEvkVpyEbLln3AuVWveJtqHsOlGopj
         SxwQ==
X-Gm-Message-State: AOJu0YzsHPcM2tXeLnwmb6r9jKGXxNwPwAtZ5U8x6irZmCugrujOqs4X
        ubrWAg0HyLf+ZsLL65o6KIvYv8bmJh0=
X-Google-Smtp-Source: AGHT+IFLXOlxMNrZJ8z5B5ZxzsJzeVBgUNW/o9jqZWKjdI81iR7l1TG9zFOqD/3ifAuzEUyXtklNzw==
X-Received: by 2002:a19:e05b:0:b0:4ff:8403:e88 with SMTP id g27-20020a19e05b000000b004ff84030e88mr1413559lfj.1.1692195957925;
        Wed, 16 Aug 2023 07:25:57 -0700 (PDT)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b004fe1c9ce61bsm2927925lft.116.2023.08.16.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:25:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 2/4] notes doc: tidy up `--no-stripspace` paragraph
Date:   Wed, 16 Aug 2023 16:24:34 +0200
Message-ID: <f2e31e70ff6cbf105d00aa5d1188554def34e142.1692194193.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.215.g538df5cf27
In-Reply-To: <cover.1692194193.git.martin.agren@gmail.com>
References: <cover.1692194193.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Where we document the `--no-stripspace` option, remove a superfluous
"For" to fix the grammar. Mark option names and command names using
`backticks` to set them in monospace.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-notes.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 9043274ce8..f8310e56a8 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -179,9 +179,9 @@ OPTIONS
 --[no-]stripspace::
 	Strip leading and trailing whitespace from the note message.
 	Also strip out empty lines other than a single line between
-	paragraphs. For lines starting with `#` will be stripped out
-	in non-editor cases like "-m", "-F" and "-C", but not in
-	editor case like "git notes edit", "-c", etc.
+	paragraphs. Lines starting with `#` will be stripped out
+	in non-editor cases like `-m`, `-F` and `-C`, but not in
+	editor case like `git notes edit`, `-c`, etc.
 
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
-- 
2.42.0.rc2.215.g538df5cf27

