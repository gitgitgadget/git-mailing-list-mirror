Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E669C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiAQH4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQH4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 02:56:30 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF64C061574
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 23:56:30 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f8so10157786pgf.8
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYpJtAenMhDv3/6kCIjVIGlluNTu/6GmNN8LrkhpZQU=;
        b=jxsGrxqo1eFOSa6cFUXBdN1/2vF4IyyadRMNj+zGLr1sGYs3+j462QWBZD4RDiG2Mp
         wis0YuHi+ZgLcl8gs3aYQ5JIiM6Gv/gV3T9wltym4wQtlnqhF3XqVrHsR9M/vQFVmDsu
         /n0V1PuMjYV66bX2ggwTRxsmf2BoXi59ZZlS/rZAOYyBXz3TxCAwL7VzuKbwJnh6UNIQ
         n2rT24WggLST5mM2UIQlYcz1jEgMFCNDtvNyWVF4tjzcqTJYVNq4gdzzV+WzB/I6Qbc7
         IhujgHqflwkjLni6ZsgWySAwecWP8gSxIYnjVoGX1HUmNLHdwNqKYmcM7lUn6b1L8x6K
         HpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYpJtAenMhDv3/6kCIjVIGlluNTu/6GmNN8LrkhpZQU=;
        b=dQxwsL146s5fovrHnM8BanYc5yD+3qahDUH2bjNZ7j262fkXkyR2l3uV4Be7fzhRcb
         7NjuEib6RDY+vOojMaKYNqAx4N3Iemjq8F8Ery56h9dqXFsxOKZvFRrn4qi4A93SdkJp
         SuESjkETt5hb7NHBVHdcmbgxkLkWuhrHYMIUM6iVY1mJytzTJZtVAEntllil71t3dC8y
         tqy2EGLer1S0TjXNIShImyCA3EkZGDh1VmWEasheYLXLunh7W9yhTqMqvZVWN7LfftTY
         QCXz6KA4dpKfoFAA+IIVNG9/N5rkGptRpvQs1qV/dmm+wgY2aNu7++DZKS/H3RJleCYl
         80UA==
X-Gm-Message-State: AOAM531Y9xR/tZaEW8NZ/wNloNUqDkXqXaJC/Pu7CIG6DDqN62cMNRAL
        YiqiSBpnKZLxuV4APfLzwG24hpTyHldl1zOD
X-Google-Smtp-Source: ABdhPJx42GRaTOxDkwstNMKBzFqCNXJpJgpAijy8/2efkyLbaG+aBo/tT21TqfAX8U/2rcOOwpkEfQ==
X-Received: by 2002:a63:798a:: with SMTP id u132mr17740866pgc.561.1642406189749;
        Sun, 16 Jan 2022 23:56:29 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.33])
        by smtp.gmail.com with ESMTPSA id h3sm9094664pfg.18.2022.01.16.23.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 23:56:29 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sandals@crustytoothpaste.net,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 0/1] gitcli: clarify "options first and then args"
Date:   Mon, 17 Jan 2022 15:56:22 +0800
Message-Id: <cover.1642405806.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.391.g9ef3d6f133
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch adds some clarification about "options first and then args"
in "gitcli.txt" which was discussed in :

   https://public-inbox.org/git/cover.1642129840.git.dyroneteng@gmail.com/ 

Thanks.

Teng Long (1):
  git-cli.txt: clarify "options first and then args"

 Documentation/gitcli.txt | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Range-diff against v0:
-:  ---------- > 1:  fe748304d9 git-cli.txt: clarify "options first and then args"
-- 
2.34.1.391.g9ef3d6f133

