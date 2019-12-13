Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B7C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460B246A9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO+q1nzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLMVDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:03:49 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33377 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMVDs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:03:48 -0500
Received: by mail-wr1-f47.google.com with SMTP id b6so219972wrq.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iyFklqbJdMlBnGgLoMTMHwt8Strfpon3fUSow70zLSw=;
        b=mO+q1nzFJBKOL7aV028l+Tein0CeNSCfeOxUvdnKpAVyBeXpAU5plrqPCGA+1qioD6
         fMbmOjhi5966CRP3ZaNvEB5x/I9MnEeWwCavcxWB6ejZJ1CpX51XevjZcUyTlPPv4HqR
         u6dBwBxSpyZdyHhjdGDKJ3/mSChFFcEJG/C/CTtn+tESlf0RkuU0qo7Q67uBGvOt5a+E
         ha6Bu1a4jidOmHX00xdtJ+pUtz9Ib1nMNlhxF/1MnCWRroZq6RU5I+STA+GFnGGQPq7E
         I1PU+xLQTxNGQKCUvsUi2vozTwizPAL7WA0YNGlrUuWOJTYE+8pcXLvyPnNW4Ld+VzGi
         kwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iyFklqbJdMlBnGgLoMTMHwt8Strfpon3fUSow70zLSw=;
        b=lbYW0vSfBZtzAHwvt6LyOIDWNe+LBttkl5wHmyloGeYucgGALb2SFqMRNpshYpNXZA
         OCNY2qZomGZwW5QZ60IWCfxryo/0AL1XJ16UCcI2hLyhiddQ4ou6zl7O1NFJXcOkrHUA
         XBLoArYiF1df6JN6J2BDWqpbMI+tR4gVlrk9pQvxIdE6miBkAVlsX39Sah9ymN3eHCLk
         DAW1r0guD2E7laKl1a2cn3m2WO5HFNuz2BxB+aMMYqFF9dhXKp0cRXauk/Hms1oOHqJ3
         S27pzpNiwW8PlCTlbDfMqPY6pgTyFc3K/RccO/lZKqTSlCx1HTyIjm8wk7W1w9kxQDUA
         0o+Q==
X-Gm-Message-State: APjAAAUME+eRRM843gqiMIkgp1ysPRntInBGnp/VLEWhKdC+daTZLAk0
        ZWCJ2gulZdbimOz7lusfh/wvdEfM
X-Google-Smtp-Source: APXvYqxTl2own76XaXjYj2CRCVJTZB4iABwYXFN5iadrEy+wplUS/Jv2dJq7ItyK8WuvgFnNnwmSPg==
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr14968600wrr.104.1576271026494;
        Fri, 13 Dec 2019 13:03:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm11518824wmc.41.2019.12.13.13.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 13:03:45 -0800 (PST)
Message-Id: <pull.678.git.git.1576271025.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 21:03:44 +0000
Subject: [PATCH 0/1] t3434: mark successful test as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t3434.3 was fixed a week ago, but no-one noticed. Mark it as such.

Elijah Newren (1):
  t3434: mark successful test as such

 t/t3434-rebase-i18n.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-678%2Fnewren%2Ft3434-successful-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-678/newren/t3434-successful-v1
Pull-Request: https://github.com/git/git/pull/678
-- 
gitgitgadget
