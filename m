Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3136C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE3520873
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTQHIfay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBJOpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50181 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgBJOpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so621135wmb.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7YlkFoSwsO5AvIHEGGpHm0jZlaPEVrBTbZcD4xffmGs=;
        b=qTQHIfayyXCg89uOFK5XHFVyO4tOEAlyTW46u7hEy0/Pd3UKH73pk6SO9sdvcZXb2s
         272tsEe+JH/rerjmJGTQtR3jGGmqKKjtB4A0R+5fEcjcSiFl0TtH07jp96QxXAauNciV
         IUxD0yKiItoHUggmL8mypsDKwkbr6mVtIpziVmGOg4QA6oimnFdTNaeY3MnpcGGcsfwh
         lcZtwsx30AbvfEHZKwQsRzjQegyxZcUxgSDaejEX9/yq+krgkEovhrVmjGp6AsGzRRmr
         Lm4llWfn28RAZQQxcbmN2l+siU5/jJhzKVPNPnumRLbNBsJPejzYrgh352IUc+mLiete
         KMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7YlkFoSwsO5AvIHEGGpHm0jZlaPEVrBTbZcD4xffmGs=;
        b=DqKydhBFcns0rxIncxdfT/2E75BzRbzZ4rzj4GNBvXo+RZ+hnxIhNVvXswH+bLFHdH
         oEZib97dz0lCzbpcdrfTpVboN8vaXG2gEKWTcc9vfSQyu37PE6dZ9/CwWxU5W25HjktU
         i+DqFjWbhPO7nUJzj17x2Snnj3UJ7HAduxCgE4jJobH/o2h9lO51wlWAVUZ6osZhefdq
         y7txp4HUFFHpnjvKgr38sOdwEvxcvSJ5XHcGjKhy6pWhCylWwgYOKcDsqWyJ+IWnc5e3
         He7HPtdYCg72RpXpeG1aHOXyOYDVV38wFzYHuefgugOj4Gq2Ci3iNMhzjcAC2dQVCE9s
         Ikzg==
X-Gm-Message-State: APjAAAV0hBF0biedVo5T8q57hXHSmUPHp7NYRnWPBgsPn788QSP8l2fF
        yAZKygdflCLK0LWPdnMeWy8JknqN
X-Google-Smtp-Source: APXvYqz2J/oOzD7/RxT/J0pdTbs5bkd29887mLpSpuzpl1HCogS+sBVrX8W/hvmT6H0r0HDPtqz4/Q==
X-Received: by 2002:a7b:c778:: with SMTP id x24mr15663039wmk.59.1581345953509;
        Mon, 10 Feb 2020 06:45:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm808449wrt.91.2020.02.10.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:52 -0800 (PST)
Message-Id: <f91ec08b472db47b88443d68208ca6b2ef067f3c.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:44 +0000
Subject: [PATCH v2 5/8] doc: stash: document more options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c1c16623cb..6dc0a5b0ee 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -194,6 +194,18 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
+-q::
+--quiet::
+	This option is only valid for `apply`, `drop`, `pop`, `push`,
+	`save`, `store` commands.
++
+Quiet, suppress feedback messages.
+
+\--::
+	This option is only valid for `push` command.
++
+Separates pathspec from options for disambiguation purposes.
+
 <pathspec>...::
 	This option is only valid for `push` command.
 +
-- 
gitgitgadget

