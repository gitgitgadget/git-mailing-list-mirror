Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86104C6FA82
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 01:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIJB0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIJB0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 21:26:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1F1409B
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 18:26:38 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q8so2558887qvr.9
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FgdONAzCq7SmtIvRqY9yCUgTx2DR13XBueQYeIeptuY=;
        b=oIVw02H8fumA7P/kZX9Nez6fiVTXrzWkVRCHTeO7T2Cfwn3Yr0fTabILO5DekRNb9Z
         p8GOVqIzT4Ue1V00t1VqSgGbc0xODaXTeGUq3UwvKgX7dsjwcJ6UcZg/+l8wTVYsLk30
         RO+VFdc4CTmnHoR//EAOosUvhycPMppocMn0DYExw30KoCH5NnUAODq3A8a/dcMZLOzX
         8o3aBU/vLVmLxfg7VLsy2vYX+BeYjo2JFFRl2C9KZ8LG60nfh/StvMo3L08ZHGm3E6GZ
         kFS95pMHTza2HXzG9T2/jnQiMHb5z2tzqjhKedIwIcsCsTx9LZUdu/5G/ve8vhjQQ+cG
         Ag9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FgdONAzCq7SmtIvRqY9yCUgTx2DR13XBueQYeIeptuY=;
        b=b+VqhiYRcFazIWYaNSI/ubMPH5Woiz8inbScMkwix//rCSXxRHD7SXjrvF6SpznwYH
         EWg/2kTveRB4uzOZAoEgXTsLIY2napsKwWyTkz+nEHWPEs1ucCWtrulkBz8r4aTc2VAG
         Rh+ON6NAYKkXfR3LcYxGjbICrp8ejQYfy7TryksNogV1QC0E/CjyPh3qnte0TJBj4EP9
         5j5prr0KeLwlKG3Sr14GeYzLgATyBh6KZO8twXyn9V0ktG8L9cxqOtD3/JQ4vYs1hDeG
         Wt60gtvGXIP0eitKVmXAaSmmu/qCq9ftjETP9nUB5kejkASpIxaPHGBI3vjSFpzy9tL1
         Tgcw==
X-Gm-Message-State: ACgBeo3v9oahlt/NahHfeugR/Yjd9FnIMkcnf2zwkeqibIK9MEuD3CLD
        XzufZX0FNmdQI6jBBFgpNOiqTJmIJfu+FyatRVL9Ad9LpQE=
X-Google-Smtp-Source: AA6agR7R0WmWKa4/OkpMvcyUpvPL2PuUlhmiJ058Hbb0n8fCdGWxa32zbvD1XbptfoscSG3IkgaxfcV4rDlmXpoDdC8=
X-Received: by 2002:a05:6214:27e4:b0:476:be6a:91c1 with SMTP id
 jt4-20020a05621427e400b00476be6a91c1mr14375566qvb.39.1662773197827; Fri, 09
 Sep 2022 18:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5yhwi1vw.fsf@gitster.g>
In-Reply-To: <xmqq5yhwi1vw.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 9 Sep 2022 18:26:27 -0700
Message-ID: <CABPp-BG3jqJXjAWaZPZr6nO=U2oBRae-cHajc8-zbkpehURzrg@mail.gmail.com>
Subject: en/remerge-diff-fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Sep 9, 2022 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/remerge-diff-fixes (2022-09-02) 3 commits
>  - diff: fix filtering of merge commits under --remerge-diff
>  - diff: fix filtering of additional headers under --remerge-diff
>  - diff: have submodule_format logic avoid additional diff headers
>
>  Fix a few "git log --remerge-diff" bugs.
>
>  Will probably need to rebase to make it mergeable to 'maint'.

Is this last sentence stale?  After the last "What's cooking" you said
not to worry about this[1].

[1] https://lore.kernel.org/git/xmqqedwnyx98.fsf@gitster.g/
