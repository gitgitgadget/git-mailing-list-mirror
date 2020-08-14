Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7EDC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BC220B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh8SdLj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHNMWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:22:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D171C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so9689641ljg.13
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtdwTLp8zH+ZBg8KT0bydE4Zp++yryvvoXpXEvy078s=;
        b=hh8SdLj7pbs3f9JyUBRxN9DvC074IzxkI3xACkzcaHCzoTrQQ7LR7eG9sF7o9DiXsn
         8OwppxJtACFzqQiTz7AdbI7SjLVzKZghjrk0ElXniDXY2uD5xymksiXNnhsKY0aSS7fE
         rlHGCqwvNJX9AKe9pSS6Y2myXPyIZkKIPwtvAZPA387+WdXDjhJYNPJvZBWE3Ay5+F7g
         Az73TivijJsDhvKkVjedUv3K0d6a5Gtyc/BBbqq3zo+nAsoMxQsZPKNCXH37EPMPuwlX
         oXHj9p+Orr0DoSYlQFlXu54M6wkIAm6QqbVjzQ9yT64G59/K62e/YJifUoDQlfCt0WYJ
         O0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtdwTLp8zH+ZBg8KT0bydE4Zp++yryvvoXpXEvy078s=;
        b=mMNyqOYdODjgxynP/1RZc+nJk0Dp4sS7KXqR02JwQl6GJr7p9lz/Tw02ZVcN8wF1Cr
         aD+FJWzURXeZVhup/kUrjb0/89n05c+reFpGdJVSLJBy3x5RXIiqw7t96Kc9FGcZKTZD
         ZftPKELZq/+6yoOU8Wws70WErSASHiX5GrwiDL6Q3Sd3LCkaYePceXmhwC99qMN/7ihD
         xFfW5vKnEmOfhlpIh98d8lvQlEzzBLTX7dFQQSyVRUyDPNkQfs1tagvIdtAyGiE321HI
         v4Nnnx94Mlzu4CesBR0kgkz5CrZfEL1qTN1cVjfxzL3XDQoGXBsVibMO+X46Up0HAc0P
         J+8g==
X-Gm-Message-State: AOAM53246p8Vb1olWK5xyzT3ls2iEpRE/QFFeUfbjMerS+flbI77Yqat
        vrQhe0UoBQ1JRMosPgobfZb74i4fl0A=
X-Google-Smtp-Source: ABdhPJxYxPMYqBBlUJzSMfrmyexvbxQvi06UfBejqWwzy06YEPb9wcrtFM0t+QO1enmpZyAEMw3NAA==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr1233887lji.47.1597407718898;
        Fri, 14 Aug 2020 05:21:58 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o2sm1847407lfi.50.2020.08.14.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:21:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] more SHA-256 documentation
Date:   Fri, 14 Aug 2020 14:21:41 +0200
Message-Id: <cover.1597406877.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 14 Aug 2020 at 00:49, brian m. carlson <sandals@crustytoothpaste.net> wrote:
>
> As was pointed out recently, some of our documentation doesn't properly
> reflect the new support for SHA-256.  This series updates the pack and
> index documentation to reflect that these formats can handle SHA-256,
> and updates the transition plan to reflect what we've implemented and
> what the next steps are.

Thanks, this looks great. Now we're making clear what it is we intend to
be doing.

What about these additional patches on top? These are based on my
understanding, but hopefully they're not *too* wrong. I'm a bit hesitant
about the final patch and it would be interesting to know what you
think.

Martin Ågren (5):
  http-protocol.txt: document SHA-256 "want"/"have" format
  index-format.txt: document SHA-256 index format
  protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
  shallow.txt: document SHA-256 shallow format
  commit-graph-format.txt: fix "Hash Version" description

 .../technical/commit-graph-format.txt         |  4 +--
 Documentation/technical/http-protocol.txt     |  5 ++--
 Documentation/technical/index-format.txt      | 27 ++++++++++---------
 .../technical/protocol-capabilities.txt       | 11 +++++---
 Documentation/technical/shallow.txt           |  2 +-
 5 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.28.0.277.g9b3c35fffd

