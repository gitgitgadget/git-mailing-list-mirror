Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BBC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D011860F11
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhHKBqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 21:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhHKBqh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 21:46:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B23C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:46:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u16so598524ple.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZsShDMJcitatU/m1p2KEhKMNc5I5pfFVncYRM0/Kz0=;
        b=RlfqJ0w6wi4YMtPhyyxwzxVFDv5TrIqblEsMEAeFFkh2cY7GsxXuCG3nwDY6ADzyKC
         kUJUyNxlGF+1z267tbmFOQWb/buiMZKCfcq6Fwpqq4zDEDPr6s+ajQNjWXuaY5kXEotd
         EGUCuVYc67cK/wmEPg5w5C8HWw9bNRqncYl+Ol4Fyf6MMlzqcL2DtjESMtkY1WXuVRCg
         bU07noAThofP/SlcnD4b+daHwkY8uXkG+eVOb5+AJHxGdh6YAFJHXUOFTMLGN7gXZpSk
         WrHN6G0O3Foun24jnnNu3xi1tSM20KgeP7DoY6cijdwHNGmQ5HqIpk0NpCPsRX6zym4T
         pSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZsShDMJcitatU/m1p2KEhKMNc5I5pfFVncYRM0/Kz0=;
        b=UgusnhUsXHISQrBrh6B7D2rXgVk3wJicV8lShdDBYWDPBcSJm557nMmR2v38r66C5n
         xqzCkkVM1x4qOQg0vvh7eWYYZU7DfJwkuCYttmdYlFzrJHdXHwKtYyA0MNOF/Epsa2L9
         fWSQNqzmKbL0ruzspj3ZjaB3ynDUKA84gJwYREcVdIaVVEcIJrtG+f3iaZ67z8cgFwg1
         JtRUKa/gHEbyEKBj8eQt+Pl60pMbibenetVt17FH9+lw5Z8HDGcp5sSARRgaEwd18RC5
         qREXIznwW4/X2QsJXK9doqdiQIl7Qw8dsxn8qyMG0UB06nQo66K9ZCTQbSucrRDdc0Rp
         InnA==
X-Gm-Message-State: AOAM533qtaHb9Zsd4j5GXMjUU6mwX/ur1AyugB2AWn2bUEtP3gzq2OVB
        9KfY8ejSfq5wy0otwMIISGk=
X-Google-Smtp-Source: ABdhPJxyAAFo0pSJ+IrXdrwadXcASoWGkwlspB2gDlDY8cOVzBy3p07XIqPBz4KFb/l/VBmo6EmUBw==
X-Received: by 2002:a63:2c01:: with SMTP id s1mr133521pgs.357.1628646374354;
        Tue, 10 Aug 2021 18:46:14 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e27sm25926177pfj.23.2021.08.10.18.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:46:14 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v3 1/3] packfile-uris: support for excluding commit objects
Date:   Wed, 11 Aug 2021 09:46:07 +0800
Message-Id: <20210811014607.15419-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <87a6m9ru85.fsf@evledraar.gmail.com>
References: <87a6m9ru85.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>>This looks like a good cleanup, but should be split into another cleanup
>>commit. It looks unrelated.

Agree.
Will split up in next patchset.

>>You've got all sorts of mixed space/tab indent here.

Yes.
Will fix wrong indents in next patchset.

>>Isn't accepting http and https the default?

I think it's NOT after I took a view at function `fetch_pack_config`.
This may be optimized in another patch I think and also will listen
to some other suggestions.

Thank you.
	     
