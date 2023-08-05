Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72089EB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 04:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHEEpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 00:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEEpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 00:45:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B54ED6
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 21:45:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso4713113e87.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691210741; x=1691815541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5C2RUivRPkhjM3FHZHrxtCNM82473MLJmyqe8BS37I=;
        b=dM/+EmCt+fmwR8rhe/ARasUtzsdjraAlHtYvhJ/9YvI0ULSz7/MlTNKVYMKrtYQwKO
         6HDXY+snL8JpDqT3PWNXam7LlSksAvp8IxbPfvqnkKtwfP65q/ngfaVui/RvpNkryehl
         k80+qXDjPh3QRBREcWtaYgO9QLuVJDMAqAg+HkgsWQEMT5HZSLMMEJP9IA31CJocKPR0
         byHtV/xhkOgQ6xOxREh8GPddDoGouKBReJKEEqYtoeEKabzBdDHle12i9xHNt+6ObdfN
         vc/1NnYk3MUV/HyWTvtVKp24YUYUaUHoqSbWjSusc+gpUTwgPjj/2LdSXsYvUu+V2a/2
         nbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691210741; x=1691815541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5C2RUivRPkhjM3FHZHrxtCNM82473MLJmyqe8BS37I=;
        b=BFmdLvtmGVoyajxn7RGUol03s0p45FL1yokjDSjCtyYl+JO/aIaz5WXSuuLQn9X+cx
         HHFNhIohW8tmOomkzpb9qLvR16nk1Dn6OHRarIaAPmU8ptR4tYRWpqMn99OAkVbLy86P
         5rv/TdlW4rHz+4+JRjQNAybKg/By1q0bI/NewgF7t9KY+x9+nrssUPikHYCBUHkffFZa
         qGfdJ9yCMdrUJ60G1Oq/8itRR2bLFReElSM61+Iv6psYWDaZayhrB1KCRhE/KlVB5Brx
         7371OLF9sKQ9ntEQKYBFBKrAVxZJd2yIQmRIyJHOqkJCwylCSABdpZNFRa+vZWvRvuuO
         xrpg==
X-Gm-Message-State: AOJu0YyFC0zhwsRvUBZwg5U6J359pGKgjVqdiiMesXfMi2HhCQanwhGg
        gpRLyOm0+tZP9DjOeXrIKZvcqNvV/18=
X-Google-Smtp-Source: AGHT+IE2dFQjN1HUyMw9HYYDMDA2h7dGPqaQqOlio9OTpgn/vTVm140zWjVKvzGsa6Vdzo1bIkkvNw==
X-Received: by 2002:a05:6512:159c:b0:4f9:5ca5:f1a6 with SMTP id bp28-20020a056512159c00b004f95ca5f1a6mr3197256lfb.17.1691210740457;
        Fri, 04 Aug 2023 21:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c261400b003fe2ebf479fsm3930051wma.36.2023.08.04.21.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 21:45:40 -0700 (PDT)
Message-ID: <100a2297fa3710dc107c095778b86ce3d2a3b0a6.1691210737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 04:45:34 +0000
Subject: [PATCH 2/5] trailer test description: this tests --where=after, not
 --where=before
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t7513-interpret-trailers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 5b31896070a..ed0fc04bd95 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -792,7 +792,7 @@ test_expect_success 'overriding configuration with "--where after"' '
 	test_cmp expected actual
 '
 
-test_expect_success 'using "where = before" with "--no-where"' '
+test_expect_success 'using "--where after" with "--no-where"' '
 	test_config trailer.ack.key "Acked-by= " &&
 	test_config trailer.ack.where "before" &&
 	test_config trailer.bug.key "Bug #" &&
-- 
gitgitgadget

