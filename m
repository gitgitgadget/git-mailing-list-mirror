Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919AC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30022064B
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grjjW2W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408905AbgJPUwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408830AbgJPUwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:52:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0E5C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:52:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a12so2742385ybc.20
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ff2EWuQmXMC0H0nv6LFRGzRd2madr/iTYPjKqibpkhA=;
        b=grjjW2W8Q7mCmRr7YuzqADfPomzrCYRrN7j1A/ZtrgsF8L9yLJOhavxL0obHmUxUe/
         4XKaJ2JC/NwODiF2nUiZkHSxTo+4TgduepolteDpOP9T8Q9W6jPPC9Zrt6P39g4cyFa+
         NzRzJMnTtRC4I0i46WmQtqh1uFhKJZ7sgqZUgDeCpUaNQTPAP5yt0LSFzXOhGOS2Mm4V
         cmD+6VBDrYsO//WuObBTLTz9AhCQcMejMCDSq8Ie9bBIUsELM/K37oEqvZV+PkeHTAr5
         CM0AFEH8hGef+nKqBnHPypCA6ZPLK94Jd7gDjFiwkd6lnEJLQyXN9IFeQtyOyDBGorI5
         f/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ff2EWuQmXMC0H0nv6LFRGzRd2madr/iTYPjKqibpkhA=;
        b=r1ceUGphwsN1JkDsqSx8XEjONKyONI1MRPtTjkdSsKwJoYterpsdI1BnT9Y5uAhCd2
         bOVQdSRlSo2DkWQUCCStrzHERuSkZSdECl6YbjlvB900qgNxqDG2M2VyIIAEvIsGbAkT
         zKazjB08OSudrjpU+jgEtflbeAwpryTBbt/ux5VkZspgogMVJzm/dEgoBY9ozbkf6nW9
         AhWA2PHYwGgm0B9YiYvcEbliDc7Huz4WCHus0bQMoyDjOSBoyYTAnCicSTA3gFo3qgHe
         5VE9EHYXJI+q82osGfDX+0ZJ2u5Ixcmq/M/fgxA85qGWHtdCZiJG2lnh/vwEZs3+vywB
         j0DQ==
X-Gm-Message-State: AOAM5305xvdIRRLAbFrLqmIua8Veg5jtF18i8VUpLvMg6xZ6Hn6Kwn+L
        PKEyMGw6ftQP3qjEqw4ovLAPXssG9io516q+ehXBDc00EyJANokNnes3f2AAL+ftLp7CASj43D9
        GAVwxOUZ2BjlBFd7fRJPjlL0H7C3QRYKQyz7wPDtKUhcRz4mmmwMmexiFxd0J4u9wmKYtS3cWGA
        ==
X-Google-Smtp-Source: ABdhPJzrHwE6f47ibBZalb9tM2EEugtkybA9WX094Eg4fP4T3E3ONND2Dtim1mGFS8NV0Lux8t8GIv5k5jfPBpkplOw=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:5f4f:: with SMTP id
 h15mr7628013ybm.407.1602881557682; Fri, 16 Oct 2020 13:52:37 -0700 (PDT)
Date:   Fri, 16 Oct 2020 13:52:30 -0700
Message-Id: <20201016205232.2546562-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 0/2] some small clarifying docfixes
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Probably didn't need to string these together but they're both pretty
small. I can separate them if needed.

Emily Shaffer (2):
  MyFirstContribution: clarify asciidoc dependency
  (Just reorders one note.)
  docs: demonstrate difference between 'am' and 'apply'
  (Adds a snippet demonstrating the effects of 'git apply some.patch' vs
  'git am some.patch')

 Documentation/MyFirstContribution.txt |  5 ++-
 Documentation/git-am.txt              | 58 +++++++++++++++++++++++++++
 Documentation/git-apply.txt           | 55 +++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 2 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

