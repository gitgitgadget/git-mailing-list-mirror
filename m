Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFCD1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbeAJLHu (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 06:07:50 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46148 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbeAJLHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 06:07:49 -0500
Received: by mail-pl0-f67.google.com with SMTP id i6so7064376plt.13
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 03:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zOK66Yk1aMNE76Bh9tcZeTMGwQVjwmmDrBrXgtAqkdg=;
        b=V7lrvDDThQp4Ur7Vrcoc+oOIjbVUB99oB4tseM7/seSP3YaXS9d9bJE87mxTd4PVNY
         c7xvfLXPV64wAlfRIVOaDWl0LhOa7ToKAGtfbsYyQyxF9NtlUwhVWIAPLf7eDpGZXTdL
         +P64rn6PSCdkbwivJTivMA9UXZfrbMFo+Mt78tSU/WBd/Phnp6PsOE9ZR6m9fCN2rf95
         mdNJxvNktRwVzzCa/24fvCa2IJbuuZ5Qs9DUUh697a5SzYA/AANqL7kw2RVKsMFWFhnE
         zfBxCrvOmjd9N6/7qVWtaNA4A1/W6J5O91GcCBNS60M+1Sz6adi4qvinMwEQxlfJANhD
         WHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zOK66Yk1aMNE76Bh9tcZeTMGwQVjwmmDrBrXgtAqkdg=;
        b=OTBJb68GSxAPN/9W+ZZIs9OUUAJaoTXVXsSLzfeulc87YKLFNcRLqRbVDhMESGFHd8
         8jC5VcWnhj0YaAwtYenAmxduxT/PbzVk5kScmmbVJhuyOQOZDh0cjhJ+xojnWbjz6HCw
         khOTGeiW2ras0K4AtjIOQq1ooFRE6IK+NkOEy/0aaQzfEKYszDG5hjwhWaFkkr+UWas4
         t4jjpXJVDhHX0dqlZPV/DDm6AzL2hKlwAQzHSZT9OWsp0aO3S51yVgvgfmkwFr5PC4l/
         9wJm70WTdFygcp75WSmoVojHgPxQ+oq/EzBc+3yteOO+4sA38bEyJorfPhbCND6xcTG/
         6wTg==
X-Gm-Message-State: AKGB3mIk6OfUN6LyR3C5uvQu+fQDhCkHeaxOAZmRIb/QlBFvQU0Lv8r+
        paYH5MxtVRSP2OpKHsM6LGmeYQ==
X-Google-Smtp-Source: ACJfBou7zAEDHBo8MTVY3QCUtqCyV38ueEPWQ4D8KBELKwKLiIdff2QobqlkR5tc0Q3A+Q1/oOD3SA==
X-Received: by 10.84.253.143 with SMTP id a15mr18691617plm.283.1515582468821;
        Wed, 10 Jan 2018 03:07:48 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id m14sm1725671pfh.35.2018.01.10.03.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 03:07:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 10 Jan 2018 18:07:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] add--interactive: ignore all internal submodule changes
Date:   Wed, 10 Jan 2018 18:06:43 +0700
Message-Id: <20180110110643.21465-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For 'add -i' and 'add -p' the only action we can take on a dirty
submodule entry (from the superproject perspective) is its SHA-1. The
content changes inside do not matter, at least until interactive add has
--recurse-submodules or something.

Ignore all dirty changes to reduce the questions 'add -i' and 'add -p'
throw at the user when submodules are dirty.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 $DAYJOB started to use submodules and this annoys me so much when I
 use 'git add -p'. I'm neither very familiar with add--interactive nor
 submodules code but this seems to work. Hopefully it's a correct
 change.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 28b325d754..964c3a7542 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -262,7 +262,7 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @ARGV)) {
+	for (run_cmd_pipe(qw(git diff-files --ignore-submodules=dirty --numstat --summary --raw --), @ARGV)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			$file = unquote_path($file);
-- 
2.15.1.600.g899a5f85c6

