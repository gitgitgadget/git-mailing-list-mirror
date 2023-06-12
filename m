Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156B9C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjFLMyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjFLMxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA4171E
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso29924675e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574389; x=1689166389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE7FKCR7Q34boOA4FM3Fk6A0qBBnNg8uNK4v55FkdHs=;
        b=U14j1zBRhnEdoRayTHAaPOB0uRKz24P1FSl6s0m6Z5hjHm22VUHGISYh1C8Ie5Xudq
         wReE29Ft7E0solhHjkz4kUbAjIRSPTk8EA4UpImPXdKbkKk/cLrX3n1+uKMpvPCY66q/
         QpIDqGGpcDvqtQVLxMktrtqSHPs2dKxi2LN4gi5qRmdRqA+0YDtraASZBWqdqLsAqw6o
         gbUVzTjKyZlZEKbhttmc1UarqbRadhpH0B93Ju323yJAFlLZSkaesGqImrJ8OWib+e47
         HNHWGHeyNq8HhjLVRYRJIVNdA0U+27/7QgymB6XdRE2TmnM4EPtd3oaxmm71duvtMp1y
         eBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574389; x=1689166389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE7FKCR7Q34boOA4FM3Fk6A0qBBnNg8uNK4v55FkdHs=;
        b=J5vYa0diqiY8AQewqw7dZ7UU/qy+FzlWcYHejcpgxRy3UAhQwFYCXKyUuuqhkJSsRO
         eLJNOtN6pdEPxH24d6W24kvLQpJnw82qgr8TGo5HzlY0tkHRNDq0x1d3gaEN+OT0ojOF
         iYdK2lupSNeCqT0XlNW+m18yz3Ipy4zOHHKqf9OHL1HcJcUDalnbgM8vaNJytyL5oKbM
         0JsgmSmNSPOYKJhPkS9xFjpQ7x1H2hdvRK/SWHUuCo7VDvvTN36J1v2ZHlE6sK5AvFZd
         1ZRRPtf0zEdx1MTt2LX+dJZfXamqI2ItlN5E2vpB1rjpapkFKhyRVZ8awTkkH/jzEoz+
         g8TA==
X-Gm-Message-State: AC+VfDxWIs0CgJ4qInVcGdlZQ4P73lTWLCyVESGz+zaSyb4d/bd217cK
        07Pv9XoXUPINLo8m7seUE3wpFLhh0IY=
X-Google-Smtp-Source: ACHHUZ5GTs82oIhBQxGLP2mB8t6/OPvnQv0TaTJ1a7oKzOvvyWDLXe5b6k+O7r3B3uggTzgXTkO5yQ==
X-Received: by 2002:a7b:c40b:0:b0:3f4:27ff:7d48 with SMTP id k11-20020a7bc40b000000b003f427ff7d48mr5832467wmi.19.1686574389440;
        Mon, 12 Jun 2023 05:53:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f7f4b7f286sm11401782wmi.12.2023.06.12.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:09 -0700 (PDT)
Message-Id: <761c75d4aec988609a105db0f039ad9f15d2337e.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:45 +0000
Subject: [PATCH v2 17/25] completion: complete --output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec2e4c9e711..a34432796bf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1759,6 +1759,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
 			--irreversible-delete --line-prefix --no-stat
+			--output=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

