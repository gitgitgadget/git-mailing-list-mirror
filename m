Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095BC636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBHQAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBHQAT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:00:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C4449E
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:00:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m2-20020a17090a414200b00231173c006fso2189199pjg.5
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt6/JZAbSEB1lSSaqLrZ4VZK86AyIv42u7xWfrpkciY=;
        b=TiGj2roRlghyRn/cbpJQp556JmnLTiF1oq3+gCp2gd6r9AYZ3IqWTjGUEKMT9YwDME
         wy1Nx/Ju9sSondMnmUZriJBWllqpuNtDJJJYhdmOOyeGgdsxolbvwpA3r2lGjVmTzADP
         74DPwzZfWcDvky2P3SPak0nXmGdMlPisNeq0tod9ZlXRtV1o7nlMzSsx9eW5WzjgZEa/
         1WRkL6O6z4TLc+fkQVWk0MaEqG7W9gwa6MxtCFuUhMWBucGEmg5F6wSmNF0F9DVYAyfP
         AHVpMf5BdA6Opxo7F6TXo2xbHx/NxFpaakmDsGeq6KcaWFuh7y4kfDJc/LW+WomVK/kA
         urzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt6/JZAbSEB1lSSaqLrZ4VZK86AyIv42u7xWfrpkciY=;
        b=jI/Qg+mxqz4frvxjQoqVpPBxa1xzmjUbnKPp29IqUDbDWvoS8Q5ci402BxOsU0HQk+
         +WVQy155F8BIVJ6iuQlLLT2RIH8KPl3yZogT1u6kYiMiuYckhMomu9KkSEekNkIn6OUs
         zC+iSNEdqdMo9PDqhRUmG8E3k+XCzxA5NU1VS1kLXcNvGhpbi0TmGx4Ej9pQ02ltB5+s
         cxvN2tw8dJKKOf4Pdx1k/vcoWKF3vLeJcPVqVhnjjyvQNuGZaG1YepSQCusUY472JnNm
         d/ofVSqeBiRNieUE/NoS2vfFiOtwpnivQAh6gUcK4TdzaEHyKr5NBfw7fdxUzzmz6PoL
         2s4w==
X-Gm-Message-State: AO0yUKXsAe1e3HEG1iI6Wr1LuQkpHk4XQVatf6hVjk92K1HNx825c6nm
        GPdKFH0g+tHznylS05NRfnA=
X-Google-Smtp-Source: AK7set8keSNiAkVG+skQmklLyfPSo7gmDghy6wPYWhY5eE4dn1csOHHuvjLaMVQfHxHR559wC5Ap2g==
X-Received: by 2002:a17:902:db11:b0:199:2e77:fe56 with SMTP id m17-20020a170902db1100b001992e77fe56mr8864052plx.52.1675872018149;
        Wed, 08 Feb 2023 08:00:18 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.149.188])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902b70700b001869b988d93sm11200571pls.187.2023.02.08.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:00:17 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH] commit: warn the usage of reverse_commit_list() helper
Date:   Wed,  8 Feb 2023 21:30:13 +0530
Message-Id: <20230208160013.186288-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqk00tz4rt.fsf@gitster.g>
References: <xmqqk00tz4rt.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 8 Feb 2023 at 00:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> After re-reading the original, I realize that "in-place" is good
> enough clue to say that this is destructive.

I see. Thanks for the review.

Kousik
