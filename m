Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F87C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjBACks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 21:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBACkr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 21:40:47 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8A4A208
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 18:40:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h8-20020a170902f54800b00194b9e80861so9111618plf.9
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 18:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XLe1wKEuM/nzzVu1rKCcRjVqAOFho6jsSuPO4ocEk6w=;
        b=OM6uiUz35uBMoswirGOOY4+SyLUm6KFveHk7wkwqaqCs5CRWESQZMoKkDRxDLSlXEi
         ZoZy9TKfjbvQS3wcqERvizgQtsCdODMybIaCoMkzLVTPp83t+GLavTR5F6aTSn1MGtjs
         KRwaMsQ0hUv1TyHJKO2CmXpn/UN/pxIB7DBQj6dm6XcILom/ZC4WqkOA5+qpTdkdTQFs
         Z+SoSGI2F1bOydzdtM1MTV9EmzXIGwskFgEApeo4SN18vBUJoldBMMveteb6s5JOjlw8
         nY8WzaksvQMBUiYb6a3UScncAWBLDaY5IKEDrJcKC+dASlzN+3cLdM8zNCG/rOwV3z/5
         qSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLe1wKEuM/nzzVu1rKCcRjVqAOFho6jsSuPO4ocEk6w=;
        b=ZLmrP6CttbSKxm4jrDy/5NsD31pfrfeAVJwccr1EdBGa80aNnw+1RJCQOIo9IYK+Ep
         BU4UKWeQyDJfAJH3z2Nljyv/2BH3yb3gRep0Fg5SM8GWMeIDFovipGFXfI5X7PUWFCsB
         /kD3nTW+V0YgEDqm5cG93SEfdE5BsPWPdTYJjB4Tb7t5G6gVdQiwNnV9sgjySMbxxDxS
         +ecDTsK7pjX1hsAvo66X5aKp+rtsHAVCIib+j1d/2q0K3N7EXyOvTr2z7km5Sb3BYMeN
         HhUd1hhhQRPmNRgiY/Kr52bEwKb1qBJFAZOXwIAOtxus5kYLLiuVJj82mPEvLq6SGm/R
         JwGg==
X-Gm-Message-State: AO0yUKWXfTQPlcKwQgmzSTZeuLJY8lOe74chnBam/hA/09WmD3v9cBNG
        Py/ElBu086pJQaek6p+TFBK87bCBzvbbXaQaxHEqRGVNfF+CBYBb67ARqgI4Ai+QboIQjhcqC9A
        5KHYG8CFQ0K+aaB5aEl/kRVU/NT9myewOe8eJn0OM5fd9y/BLTioqYIwC0F/8AdE=
X-Google-Smtp-Source: AK7set8TCPttdf5A5n+vGHO1TSjw45T3ZN0Cdnyx9q6bkLmIKpwA0iZiPoE96mAAlk4TB9mvhGEKCrfQsLiqCg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:3407:b0:593:c5c5:8be6 with SMTP
 id cn7-20020a056a00340700b00593c5c58be6mr161353pfb.11.1675219246412; Tue, 31
 Jan 2023 18:40:46 -0800 (PST)
Date:   Wed,  1 Feb 2023 10:40:41 +0800
In-Reply-To: xmqqmt5yy08d.fsf@gitster.g
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201024041.29401-1-chooglen@google.com>
Subject: [PATCH] docs: document zero bits in index "mode"
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation/gitformat-index.txt describes the "mode" as 32 bits, but
only documents 16 bits. Document the missing 16 bits and specify that
'unused' bits must be zero.

Signed-off-by: Glen Choo <chooglen@google.com>
---
>                 The existing explanation starts with "32-bit mode,
> split into (high to low bits)", followed by "4-bit object type", as
> if the "4-bit object type" occupies bits 29-32, which is not quite
> what we want to say.

If I am understanding you correctly (which I'm not sure, since I am
honestly clueless about bit numbering and big endianness and whatnot),
you're saying that highest 16 bits are zero, not the lowest? If so, then
I genuinely made that mistake, hah.

(We're storing 16 bits as bigendian 32 bits, so they would occupy the
lower 16 bits, right..?)

Perhaps something like this would be better. I took the "unused, must be
zero" phrasing from elsewhere in the doc. And if I am completely
off-base, feel free to patch it without waiting for my reroll if you
think that's easier.

 Documentation/gitformat-index.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitformat-index.txt b/Documentation/gitformat-index.txt
index 015cb21bdc..0773e5c380 100644
--- a/Documentation/gitformat-index.txt
+++ b/Documentation/gitformat-index.txt
@@ -83,11 +83,13 @@ Git index format
 
   32-bit mode, split into (high to low bits)
 
+    16-bit unused, must be zero
+
     4-bit object type
       valid values in binary are 1000 (regular file), 1010 (symbolic link)
       and 1110 (gitlink)
 
-    3-bit unused
+    3-bit unused, must be zero
 
     9-bit unix permission. Only 0755 and 0644 are valid for regular files.
     Symbolic links and gitlinks have value 0 in this field.
-- 
2.39.1.456.gfc5497dd1b-goog

