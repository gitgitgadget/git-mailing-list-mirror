Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C9C35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5473E20725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgg25Azg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBQExM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:12 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:55488 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBQExK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:10 -0500
Received: by mail-wm1-f42.google.com with SMTP id q9so15735402wmj.5
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TUewa9qUUsuqkI6sg+OxwTSwOsjB3oT5CT+AIku0CCI=;
        b=Vgg25AzgaF7at+iN0U+ppofQlULAktK3ZI4MZrF7JrE/VUxVlsw8BEVDwLhjRIXZ06
         66E2zqTk+ledf766Qoh0pNEsNgnbdLJPLNwRWLliq/wmGj+s/YE+ciTBkmf9cpenGvFA
         ZK8Knpz7pxwXkesQ0gHu1ywI/OnJHv3L47zexoCAc/14O7IRotQKjNRekd1vgjwB3okP
         eQOAUyQo6ffWO3KptGYpBxC2VahZZ4THeLpNvym5zlLJ62sp2O7CqKk8vO4DcdrMc82p
         nFstcsf/k65I3CUvTBWz9Gh45bdAqJqUMDee4bbmGhDHdklAjellQfDwWm70FoT6U568
         MZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TUewa9qUUsuqkI6sg+OxwTSwOsjB3oT5CT+AIku0CCI=;
        b=gbalh+dh0AVJZ075P+bMuedG2F5ea2++nZoKmX+t3QmUf4hrvLYzl5nhAvqtdpL1Sy
         dtIqD28FcpV39M74+U30XIyhcCF/ZD0z5x08sDPH6BrBJ192uedWDe8GOWLk1GdxrDKp
         NNEa1CC4ZiczYb8fcfyfHWpLAFwn8lMmBtEaLromFmC4JnhFL6/NSE2/AUQWmwvs1hbi
         YiW6FMjcUcNl/a3qW0aFvb8btd7Xv8Q8wTyPrsq7RIdODPTr/bERlYLtbwZPKMXJfs3Y
         O1mSEtxDaIlSIVemYoc9TblyEmuYF79t1JPD3XO2JG8rkS0rWu+lPu/lekbVqC5WFOT1
         HBUA==
X-Gm-Message-State: APjAAAUcrD4W4cBW5WqqwRVDteIf7qoSBy0jYHAmHx5KiW0f+K0Cxsbp
        l0OHhigf/wq7bgRvmgCc5sILYj/T
X-Google-Smtp-Source: APXvYqxa/oeOKfPPM9E4hQn++gtXrtoHFUjjnQ2XOF0vhG0P7Hn3v1+gY4BQLCECPPjbgd8c9U6W9w==
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr20331756wmf.102.1581915188714;
        Sun, 16 Feb 2020 20:53:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d22sm18594602wmd.39.2020.02.16.20.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:08 -0800 (PST)
Message-Id: <9004c95a72847615ded3d50779b80b77004df736.1581915186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.555.git.1581915186.gitgitgadget@gmail.com>
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:02 +0000
Subject: [PATCH 2/6] t/lib-submodule-update: remove outdated test description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The commands in the unpack_trees machinery (checkout, reset, read-tree)
were fixed in 218c883783 (submodule: properly recurse for read-tree and
checkout, 2017-05-02) to correctly update nested submodules when called
with the `--recurse-submodules` flag.

However, a comment in t/lib-submodule-update.sh mentions that this use
case still doesn't work.

Remove this outdated comment.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/lib-submodule-update.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1dd17fc03e1..5f9eb682f6a 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -908,7 +908,6 @@ test_submodule_switch_recursing_with_args () {
 		)
 	'
 
-	# recursing deeper than one level doesn't work yet.
 	test_expect_success "$command: modified submodule updates submodule recursively" '
 		prolog &&
 		reset_work_tree_to_interested add_nested_sub &&
-- 
gitgitgadget

