Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiFHQPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbiFHQPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 12:15:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CFB165359
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 09:15:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h192so12555926pgc.4
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jI5nbxZNUkL3IebWjBewF9xuhqD4dKbYlX3ZbBvJwuU=;
        b=CwUakLILesDiFvu9XVfbnjiB8ONwagCs0uNXgZlDcnmaLNliUv9aspckd5qauBUAkJ
         yK/T7ee/2RPZoF5zXhUU76b9DKOQM2GemTc9J2YtgYhyAY9FNjkHy75vsGZQvdbS0w1w
         TqM5Ejv93cH66aqWQHIRmYoUZnkt4hOZVu5l8dJ29Y2yPHQIqp4Qj61B8eHBjemxTV5J
         a0ZTPUFNsa8swyTB1FEqI5ugWENGRKd1lM0y8CkC+pDPo+Lvgq1lwODa5bmwyA3FfExc
         pXpEL3TeQCYjgBuKIpQiOhTk1XUhH6Eskh7d+Umtd61phkWaLHlhIlaiAwXAp3nG16X9
         z4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jI5nbxZNUkL3IebWjBewF9xuhqD4dKbYlX3ZbBvJwuU=;
        b=6dN4VvMrbdUy7fCz4lqb8WwFFF2iCFkEYq0jT442Im5QDLZw3KgPrtxEJzxTAcEr+Q
         KxjoiuOOQmkUzhpKm3jXIbgunOsuzrRE92yodK2WW415G1STr2IIQZLiKSF8fXLie66X
         SVQymZudcJqAMbs78uswkqLHsh7L/PrrRk0o+YUNYpKXu9POeZbZePKXHKyoIhPsS7lv
         OXUsRokVgN1Eae32KzRdR4FBrCV4GVpTJvgFhZzXSPzhOAM94kJrPNQAmOo8xeUCLfJo
         FuvZ+FwWwnLcU6OQZ4YU4lRra1kyaTpV8o+U9Osd2ilqo82hg2jZk2lIvLHXjK0eYHP4
         gsUQ==
X-Gm-Message-State: AOAM533C/6FiN8k9/toedI30VdyQzK6hU6a7zXGXfkiwphvZJ4jmNX9L
        YI55uGU6THhd7sAC3ZOXRao=
X-Google-Smtp-Source: ABdhPJzXYOOhtSuwYxl2TcPdXH7qbXv0dBv1d1P+MsusvCcjHxx+V/tMJKVWmpLjH5WqKhupKRynyA==
X-Received: by 2002:a62:8702:0:b0:51b:c452:33cf with SMTP id i2-20020a628702000000b0051bc45233cfmr27810468pfe.72.1654704941155;
        Wed, 08 Jun 2022 09:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d90:e070:30c2:fb1b:2653:5119])
        by smtp.gmail.com with ESMTPSA id o21-20020a170903211500b0015e8d4eb26esm14747947ple.184.2022.06.08.09.15.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 09:15:40 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/3] bitmap-format.txt: add information for trailing checksum
Date:   Wed,  8 Jun 2022 21:45:23 +0530
Message-Id: <20220608161523.10359-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Yp+7aXdaCX3Fh9SE@nand.local>
References: <Yp+7aXdaCX3Fh9SE@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> I assume by "Index checksum" you are referring to a checksum of the
> bitmap _index_'s contents. 

Yeah, I meant a checksum of the bitmap file's content.

> That term is used a little throughout
> pack-format.txt, but it's foreign to me. Assuming that's how you meant
> it, a more conventional term (I think) would be just "trailing
> checksum".

Actually, I copy-paste it from the pack-format.txt file ;). Will surely
follow your suggestions.

> It is also not guaranteed to be a SHA-1 checksum, if the repository
> which wrote the bitmap is in SHA-256 mode. So I would suggest that this
> addition just read:
>
>     * TRAILER:
>
>       Trailing checksum of the preceding contents.

Got it. Thanks !

