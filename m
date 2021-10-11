Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB839C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8696E60F3A
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhJKENB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhJKEM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 00:12:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54130C06161C
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:57 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c7so15446800qka.2
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ynkdkVHRY6E//M2JBm1V2tBxd3agh9DSpmrTzFaBVaM=;
        b=EWsrFf5NIZWFKAWCw4lkhAw8J5k1eSeAN7NNwPK9IcuXPbe8kqCvAxlUf8j5qEviBl
         7XOGIRL0PyRtz2YtqjUXnYr+t/noqcgTJw7/md2rjXZS/d1lKR1cgYgMr+d0HTia23VF
         5An7ucMoVD11ExDJ8TOgfuG0TUQRRGwdA6A57GckC9EuQnFa1MUhA7VEq6mibwTCvWlN
         KRsjqQHErgJw9UEQLJn3mbmvHfpyAliYayCW4XI4+wn//EVCZ+JTXREwtZ/yxHPaAHJ2
         80kgrhIXjXF3DvvJ0AFGiqC407q+PcRfMpnYkJtGs0XEVkqYizqeq8Jf3VxA82bnctfu
         BYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ynkdkVHRY6E//M2JBm1V2tBxd3agh9DSpmrTzFaBVaM=;
        b=Oso+lDuPWsmnjlrRBGg055k9RVy1Ng/yAvUaKLOjLGylrpQUhfuUrdrcBBWlr3VX6g
         DGVe7qlYq7HMSB8h+oQOsALO1MF6Jdpn6EU4ppSbslVrYot+CKhc7By4p3DxpmJ89ALM
         c1gSQvdH1+cl8Cp3lW+12hotpiL9/rtWJrv2LjTgpHcLrgCxCWqdvTDjYAdzNVIyVbyC
         nPdp39zqVJbELXSbZBKrLNgyji4G1yaO3GeR4sWY6qgrXeQJJDunjurxggZpVu0Y5phL
         UyBGrJEJbIElNXQ2MlrOQgiaQnzI7lfq6amzt/5ZDPlYQhoMBwxMQXCvNXJ5HHHQ0gad
         Pp1g==
X-Gm-Message-State: AOAM532lmwwgcJO2pz0cQ4SQIb4pv7KR9cHCqlXf6mxZpLskGpOGBKbo
        LqAyj6Vk6XcCMYMuTZw+Zh+x21smQfc=
X-Google-Smtp-Source: ABdhPJxlscgdaaFjbue2IGfqUIR8ftZRrEtH7zkgNDz0qPnygjMUcp0TqTcxoS/kc5JbiTggma9YmA==
X-Received: by 2002:ae9:ddc7:: with SMTP id r190mr12913209qkf.362.1633925456519;
        Sun, 10 Oct 2021 21:10:56 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id 74sm3683814qke.109.2021.10.10.21.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 21:10:56 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v7 3/3] send-email docs: add format-patch options
Date:   Mon, 11 Oct 2021 00:10:33 -0400
Message-Id: <20211011041033.20004-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
References: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-send-email(1) does not mention that "git format-patch" options are
accepted. Augment SYNOPSIS and DESCRIPTION to mention it.

Update git-send-email.perl USAGE to be consistent with
git-send-email(1).

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 6 ++++--
 git-send-email.perl              | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..41cd8cb424 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, as well as options understood by
+linkgit:git-format-patch[1].
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
diff --git a/git-send-email.perl b/git-send-email.perl
index 587e52d1d8..850c572dec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -40,7 +40,8 @@ package main;
 
 sub usage {
 	print <<EOT;
-git send-email [options] <file | directory | rev-list options >
+git send-email' [<options>] <file|directory>
+git send-email' [<options>] <format-patch options>
 git send-email --dump-aliases
 
   Composing:
-- 
2.33.0

