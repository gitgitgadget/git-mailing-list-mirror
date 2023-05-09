Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE165C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 05:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEIFSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 01:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEIFSx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 01:18:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA59025
        for <git@vger.kernel.org>; Mon,  8 May 2023 22:18:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so47721001fa.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 22:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683609531; x=1686201531;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKPadOr4qmJH+2RATDb5WUlGgb5E+93yPMHG+PfFABI=;
        b=PVFOm7zWdOXx6m8j/gGbLtqosFD8ZljagNvQAIfc3JPAiKYpJSxxbmlSsoW9i2jtnx
         uBQr3bb5OaQcvUsz3+6OVkzQKLse3ilcOdx9jeI9JD6POIqLt7SKzpqvf9FnuaXwZ42Z
         CVg5HXutvsMu4vIC2ZtpsLpnJsGB5BVa7xK9zvTzc/PswfvM2gblp293AMj72scHIU3F
         qQaeN1j0Dww8hgdRYB+4JnMhG4LyrVi4/szsBcIrZxK5EQsoXHU15G9TxvzJR7xSby8h
         zx27zwzrSQMb1v+cqvCdMS5t2ga/bzeho/lsOX2WkAZMPfT99rAP4fVg6kAphj5GoyMO
         paIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683609531; x=1686201531;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKPadOr4qmJH+2RATDb5WUlGgb5E+93yPMHG+PfFABI=;
        b=kFMOyXPjNuv59C6JrHGYZbatL3j7adsr7oQi+93yU7tx3VZozlweFNMYisWW60lTSS
         dkfen8ggMnmprjYs6vvtVXdNESzBGMi5FPbDDB2PEB8SjXsDgcxB9Lrz0NYvlhnuiY/x
         xvxvJrdCRZAhRRCPZ/8aDNVrbRURqGF2YPY4hJSatQdmI//WJzGXnTM8pEaHUuRbdFDH
         toj1jtJw6Nm48bjhLkK9696SgarQrg0RFSB/i4HcmWp9hV/Zvo2bcFjuzOdGF1T/FVbT
         Kw7CJaBzfWRja0Wn3ZkwMD2afdtK0Mgv0g8IE81dlyPyl7yU36hrCW5+r1C6FoQvemVr
         vphQ==
X-Gm-Message-State: AC+VfDxqz8kxJDrQ1UiHGj/B1ZtiRCVby4jnhleS1DcWdewMncMgvpJi
        TXEt8IhY0pJMnf+jswrDxA6LD5Uui4qliCVLWV+ZUMFqmQRKZA==
X-Google-Smtp-Source: ACHHUZ4uumTv9nTovuiCh7cVJmiT3cSXR52Lqe8gilE3oEKo/RqAjFgvW79n2ecPAFZt5DIJLLTrt4FIjs/HEnJGntI=
X-Received: by 2002:ac2:4ad1:0:b0:4e8:595c:60f9 with SMTP id
 m17-20020ac24ad1000000b004e8595c60f9mr362581lfp.32.1683609530769; Mon, 08 May
 2023 22:18:50 -0700 (PDT)
MIME-Version: 1.0
From:   Josh Soref <jsoref@gmail.com>
Date:   Tue, 9 May 2023 01:18:39 -0400
Message-ID: <CACZqfqDL7EUGGxHAsKmU6Y67FupHGog3PD-P-g_O0atG4NG23A@mail.gmail.com>
Subject: Re: Instead of "Revert "Revert "original"", give "Replay "original""
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://github.com/git/git/commit/42e073b5ff5f9e8bc2356151dbab0c95321d2454

The commit message says:
---
Merge branch 'ob/revert-of-revert' into seen

Instead of "Revert "Revert "original"", give "Replay "original""
as the title for a revert of a revert.

* ob/revert-of-revert:
  sequencer: beautify subject of reverts of reverts

---

However, the code uses `Reapply`, not `Replay`.
