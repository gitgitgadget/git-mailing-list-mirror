Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E9AC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 22:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiF0Wac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiF0Wa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 18:30:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED051E3ED
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 15:30:27 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s129-20020a632c87000000b00411564fe1feso362511pgs.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=48NXIYZ7OOs2CuKPgsFQZM4mtJM28116d4hTjiWEgXE=;
        b=UbVMZqExSA6tjrsijxVN3dF4jmcNl3evsJfMbzZ4uZUdzyY0I7EdW/aFuuk1EC6YbW
         ZJkZFWbGY+Sm/Indde8jdDYb64kMkZg64LHtxioehDUk//kalxKIz4P+m2UxX8jH7Q5F
         0WLUySKvFuagstbxBNZTSrNrZx857q2eH7tuwP93Glew5Dgu3LMdcJXMQHPwrYJaRgtZ
         V1ET+e3TCg9DebP/GC8mjxmkV5iyxFlVZrGn3reWCwAIfK95AwedecM3ut5aG9nwN4e/
         6aGuS0vznChlzEnRyG+7QLqhCzCBahEimkk21io8xTNHEwbcET51iaP+PAsflyjzkvP0
         2rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=48NXIYZ7OOs2CuKPgsFQZM4mtJM28116d4hTjiWEgXE=;
        b=adyLbMDEIwG3GCu01k5OyR25+oUmUfQTLTOtDHxj3s5a1HX4+tfUMSDSt9CQ3zLwtm
         i3dN7/h18y4eezo/35lR532iaI5MVbhe7mEdf6LLfVxHBO7rxhur9sbkrk7ztUej5d+r
         Gs7kjHj1BLjRYSusAqWshs4DOzGtTdPa8syQev3ooP7J3GqpKbKxcWRTlyX8kq4fWrnZ
         aOAvXxYGXIhsGfXxnbqt2POE8MBfcNSawEp3kLm2w+0pQUkVOCqecSox/xkETOCCfu0b
         IzNzFrze+71qhcl7/vGopoEjJOZUZgf8T63WaH8DyIEyNosVqRj7HqCRFP8IBq1V3WoQ
         y15w==
X-Gm-Message-State: AJIora9gX4DPbo5iMYR/eTaitB1DNn+1BjRqtmDngXUc2H0zCJ8BvBeu
        10TZCuzhDA8KtgjzdVWfvaTYBz/6fJpF0pk=
X-Google-Smtp-Source: AGRyM1sp6/JOpSlHQgHZuRhtnNROtaimrfjTnFsH0hPSwrSZifo3a/lUbciCZyyhyDttWbPISmqwj5ZQ+Ge7yks=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:230c:b0:525:59f3:cbea with SMTP
 id h12-20020a056a00230c00b0052559f3cbeamr1332641pfh.11.1656369027413; Mon, 27
 Jun 2022 15:30:27 -0700 (PDT)
Date:   Mon, 27 Jun 2022 22:30:17 +0000
In-Reply-To: <69d6204184363e491acb68f744ded0991be63a47.1655871652.git.gitgitgadget@gmail.com>
Message-Id: <20220627223017.2852209-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
From:   Calvin Wan <calvinwan@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +# Testcase 12l, Both sides rename a directory into the other side, both add
> +#   a file with after directory renames are the same filename
> +#   Commit O: sub1/file,                 sub2/other
> +#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
> +#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
> +#
> +#   In words:
> +#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
> +#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
> +#
> +#   Expected: sub3/{file, newfile, sub2/other}
> +#             CONFLICT (add/add): sub3/sub2/new_add_add_file

Grammatically, I could not understand

"both add a file with after directory renames are the same filename"

I also found the same issue with `Expected` that Jonathan mentions. I ran the
command separately and got

CONFLICT (add/add): Merge conflict in sub1/sub2/new_add_add_file
