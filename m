Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B21C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F54A2072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2A5+RxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfLQFHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:07:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQFHr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:07:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so9859848wrr.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 21:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uM8BdOS4w265mInIhJypHAyt/NCPaei8fecijQx/COo=;
        b=T2A5+RxFiRxFmmx3pJCRuD27g099G3b0zXnIQOkcQkX0bM+YyLEDMA0IHg9SCL6Vsc
         0iEEzLXqnnvGTNN688iGoExIIf9bF15w0yo6pC3dNcehSSDNL+Ylq7kZdjw6/ajMNNOI
         IzjEgYNDIhDj1J+LX2FPxS/Z3wYVxXCWXKQMUd32YKjxvPz5VpL0IAeAx858lxhp+bpg
         Aj3JC90ZSKtBYxdrbAv9DNCWSQUYwHj29PIaR+G94OWLIWAsuqXBgIdPP5TuZsFa8/a0
         yh7gvg5HRW/81pD9HpmR1SXtWwV1NZ1dTcERdKJw6mtYRH/KN9WEkBSoj4tYNaXUL3n9
         dJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uM8BdOS4w265mInIhJypHAyt/NCPaei8fecijQx/COo=;
        b=S0BuYDdtdv+YenxOvZcTPu/dT9+iZluAJLIwRpaM1IK9/WlqB8tL1X9kNnpGHrBnMI
         GPFyE7TzBPmG+L4bdxyiBTK74PU0UAYAW8a7UsgxidiStgAKwpck5+ZBrDs6OraNs9fM
         os3SDznXHThf1IJVjF+yQtD/mPj9unlJgEy6aH4JEvHwgJbn2pj71hZ7H+U7kyDGQ3VQ
         BYREHSCUrlvYH9jL08EwD9pIUS2+tNvf6ivTAOWV2Y5f8W+/L3XXFyNAzAnvm/7nr89f
         MjrgIEVvVnzqXLEzu4CzHRs59CLASTCA+CLsSeq5WogJC35SH4WfmXvp11w9qcffYMOv
         7zRw==
X-Gm-Message-State: APjAAAV6nzVpLV350HHXnVx+vzNf/8lHowIfWKArTMXaFoyBjzZ4vhn1
        1h7yWlQlket3vhxIeo+iYxXmKJjb
X-Google-Smtp-Source: APXvYqybRlQ4QJm/dfvhujWQvjotZIulI0t3OzfWmzyHV6pgtXkCch09RftGGIR/GrTMAEycgN3ffw==
X-Received: by 2002:adf:db84:: with SMTP id u4mr5455288wri.317.1576559264955;
        Mon, 16 Dec 2019 21:07:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm24047298wrp.4.2019.12.16.21.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 21:07:44 -0800 (PST)
Message-Id: <pull.494.git.1576559263.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 05:07:41 +0000
Subject: [PATCH 0/2] Improve line log documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Thomas Rast <tr@thomasrast.ch>, Junio C Hamano" <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches add more information to the documentation for line history
(git log -L) : 

 * Mention explicitly that only the --patch and --no-patch diff formats are
   supported 
 * Mention that any given regex must match in the starting revision

Regarding point 2 : I stumbled upon this while reading the history of
'filter_refs' in fetch-pack.c. I did

    git log -s -L :filter_refs:fetch-pack.c

which shows a list of commits starting with 745f7a8cac (fetch-pack: move
core code to libgit.a, 2012-10-26). So then I did

    git log  -s -L :filter_refs:fetch-pack.c -L :filter_refs:builtin/fetch-pack.c

which fails with

    fatal: -L parameter 'filter_refs' starting at line 1: no match

Philippe Blain (2):
  Documentation/git-log: document accepted line-log diff formats
  Documentation/git-log: mention that line-log regex must match in
    starting revision

 Documentation/git-log.txt | 9 +++++++--
 Documentation/gitk.txt    | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-494%2Fphil-blain%2Fline-log-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-494/phil-blain/line-log-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/494
-- 
gitgitgadget
