Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD254C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 15:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbjELPSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbjELPSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 11:18:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBBFF
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:18:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so27003285e9.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683904720; x=1686496720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o3o5zkygc+eS3Qd7pErnpXyidGTkquoW6H8v/1CiPZ8=;
        b=G9XulUdufUrvaVaa3N6NIxCsg9KOicuibwKb9XImGzu2WGB4fMBkDI1HOnmfTw/0SZ
         70KYhMvP36Nqwl5uffU2tuJ4w/MEkVC8KKW0zcOY7dNGQMMrryfvRi6/RX0r3ODicXIx
         l5T1CDC6nd8XmAbLutu9lzyK52dd8MaexybvrotBB2MeUiYbBtazOJyWj6aIJVqX6sdn
         JuDIQkbnN9oC23/7plfutissHvbJNOwOYZ7OBgbMuNowjaJja9IXbcIPZyEQzP49KOmI
         qIgGZjMBmXwkX8CArT1mH8Q1Iz3J/8wbVtyyGjpYBGHL6lr0XaWnbGhWNFtS2b9uP850
         zLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904720; x=1686496720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3o5zkygc+eS3Qd7pErnpXyidGTkquoW6H8v/1CiPZ8=;
        b=I1VWnX9S8gkq4RpvqJMU1eQVuXlW9G/C9STMROowsOmM0uXOO3ClsBNhjdj3nPS6p5
         w1P6KIDWV9k4PY5PiQuNGLBy5gu0NT7J6+tvjop87YnYxs8ll20YbMt9tEbtckyfd4mH
         7UVG5FaGNfbDpzYQiYkbUiV3K2qTS0KpgPdD+8t42TI1uinj9qdnAkAvxa1ops0Bgs/o
         3/H/7XhvwhHsdI880bmupDV6UuvC2eDfSIQg6gTkbL5TD4yewR+Gl0g4KRL1z/3ilQgR
         cAJw5/F9aPtgDIdyXkLgWq6utCRAqTszuYTP4ngR6+AEqjw+3TN2L+FaNfPO5J9hfPYy
         t7Bg==
X-Gm-Message-State: AC+VfDzPM2e9sMlYXbWcoj4f6S5AisYLY+PrFfabcd1KtcFPZQYWdJC5
        Fxs2i2/BkNJ5b7g1OxLnwqU=
X-Google-Smtp-Source: ACHHUZ5/dO5VxvrnKtNwCHIRmi+X4TTW92uhTMJAm0J/ZB5bwTdCH9+KnxKMeMgTbjP91Kciy5DGNA==
X-Received: by 2002:a5d:6d50:0:b0:307:83a4:5860 with SMTP id k16-20020a5d6d50000000b0030783a45860mr18620659wri.68.1683904720386;
        Fri, 12 May 2023 08:18:40 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bc5c3000000b003f0b1b8cd9bsm29136426wmk.4.2023.05.12.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:18:40 -0700 (PDT)
Message-ID: <a6c6d3a4-433d-f275-e31c-4eece062722c@gmail.com>
Date:   Fri, 12 May 2023 16:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase --root bug
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk
Cc:     Christopher Fretz <cfretz@icloud.com>, git@vger.kernel.org
References: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
 <288a9935-264b-4dc5-0d63-200c310f326e@gmail.com>
 <ZF0U6tneDjLfGxf1@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZF0U6tneDjLfGxf1@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 11/05/2023 17:16, Taylor Blau wrote:
> On Thu, May 11, 2023 at 03:21:11PM +0100, Phillip Wood wrote:
>> The cause of the problem is that --root creates an empty commit (known as
>> "squash_onto" in the code) which it uses as the "onto" commit. When it picks
>> the first commit in the todo list the "onto" commit is amended and so is
>> unreachable when the reflog is expired above. I think the best fix would be
>> to stop pretending that we have a real "onto" commit when --root is used
>> without --onto and either store "new root" .git/rebase-merge/onto or not
>> create that file at all.
> 
> Wouldn't it suffice to consider the squash_onto commit as reachable the
> same way we do for `--indexed-objects`?

We could do that rather than clean up the implementation of --root. We 
should definitely consider the commit stored in 
.git/rebase-merge/orig-head to be reachable as the following test fails

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff0afad63e..8ac5e2eec6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -66,6 +66,19 @@ test_expect_success 'setup' '
  SHELL=
  export SHELL

+test_expect_success 'orig-head is not garbage collected' '
+        git checkout --detach &&
+        test_commit --no-tag x &&
+        (
+                set_fake_editor &&
+                FAKE_LINES="1 edit 2" git rebase -i @~2
+        ) &&
+        git reset @^ &&
+        git reflog expire --expire-unreachable=now &&
+        git gc --prune=now &&
+        git rebase --abort
+'
+
  test_expect_success 'rebase --keep-empty' '
          git checkout -b emptybranch primary &&
          git commit --allow-empty -m "empty" &&

I'm not familiar with the gc code, does it use the --indexed-objects 
option of "git rev-list"?

Best Wishes

Phillip
