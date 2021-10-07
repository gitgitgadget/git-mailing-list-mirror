Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E61DC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5109160F92
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbhJGDjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhJGDjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 23:39:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD9C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 20:37:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d20so3329133qvm.8
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8hi//sTzZxfQwD8+SmGSn3IKWwQkZO08pXHVkxWGkM=;
        b=Wu6D1ZniqK0b+hUR0zy+MgFpPS65XuExQc4tNgPkKgbArNhBnQzulmUowgPa17fJyO
         BzpfzBtGIExuHWcbESglHD8AGAy8I3UJnF+PveXcTGprLE857iormHtbezQDIZQbHOey
         PGmg4aiwj6VGSNHLSSvrqGjirDJr92QCTTNnvGZMiErV3WBkymiS1LSizj5rhWevlS7p
         xMK70pWRTHFFe+mlQxT56CY3ihG2/LPRpC0OjN01MBg47GDnB5KzcLcL0iIoKukwisu/
         d610rqZCQZamqiJjhVY30Yyg7LK4eAWozn6MLl1254iqJ8FMrFOlTrvt4inAZm5UohZc
         xJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8hi//sTzZxfQwD8+SmGSn3IKWwQkZO08pXHVkxWGkM=;
        b=baqMDNnW0jt6BGgr/z4ywchNexGoLjczVofc4BTgr6CsmLNKCe02jLxv/m80TZhNY5
         AQhGUTQKCnDUpzOkeDdDQZHQF1PiiX3srK17kK6rXS+XamktRR8AxnbnhnibJIV9Q8Js
         R6sQmJffhC9KJKVKAI9x5Gu4diGxrAgpbgZy0AAIuY6RhRGXNbhqIhdH4Kf2nDAu1vjo
         XwlFUIe7ZOgtuUc9j1LhCyfvAvNc/iETdLZzyp+KFqXlssLH1hkF32aLje4bJdBRPSnt
         XT2YWcWM/EhNXOcesYqVuaNAltFjcdGS4vx2DBENulgWHXwWFGYRfA5c0sM4JX+hw4SL
         1Qcw==
X-Gm-Message-State: AOAM5309vKbXx6Dpkikocjo316hRBHDPjgaAfR7A4M0uLXIIQGobPGNc
        urxmjKZvEhMjO+BirzboRujhZcda+ZHl4g==
X-Google-Smtp-Source: ABdhPJwh0vWHIdVDkkr9RwcZMkrl+MnxsMGkTQk26NdQ8cjc95NbIJrMTsVO8rP7yamAFE81iFY8iQ==
X-Received: by 2002:ad4:4ee6:: with SMTP id dv6mr1711934qvb.5.1633577873295;
        Wed, 06 Oct 2021 20:37:53 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id x6sm13892860qts.79.2021.10.06.20.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:37:52 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v6 0/3] send-email: shell completion improvements
Date:   Wed,  6 Oct 2021 23:36:49 -0400
Message-Id: <20211007033652.80793-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
References: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Differences from V5:

Addresses original Ævar's patch:

- Effectively including all combined options, which ends up adding
  --dump-aliases and --identity.

- Manually excluded --h and --git-completion-helper. This is consistent
  with "git format-patch --git-completion-helper".

- Completely dropped sorting, because it seems the current git
  subcommands don't really care about it (I verified "git format-patch"
  and "git apply" only).

As mentioned earlier, the following issue remains open:

> "The following options exist in GetOptions but not in the current
> usage string:
>
> --no-signed-off-cc --sender --signed-off-cc"

I wouldn't mind adding a fourth patch to this series that fixes the
current usage, just let me know which wording you'd like me to add.

Finally, I will note that I haven't touched the third patch of this
series (git-send-email.txt) because it is not obvious to me which
direction we're taking. My understanding is that Junio prefers to leave
things as is, but let me know if I should change it to e.g. Carlos' or
Bagas' version.

Thiago Perrotta (3):
  send-email: terminate --git-completion-helper with LF
  send-email: programmatically generate bash completions
  send-email docs: add format-patch options

 Documentation/git-send-email.txt       |  6 ++--
 contrib/completion/git-completion.bash | 11 +------
 git-send-email.perl                    | 43 +++++++++++++++++++-------
 t/t9902-completion.sh                  |  3 ++
 4 files changed, 40 insertions(+), 23 deletions(-)

-- 
2.33.0

