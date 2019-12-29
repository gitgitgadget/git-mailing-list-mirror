Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32172C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 22:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6820748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 22:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHTNyhVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfL2W1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 17:27:14 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37891 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfL2W1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 17:27:13 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so11839374qvs.5
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hm5+6btyUCeQ5oIxKue6cqiX6WndMX6wAwNU/56/+4Q=;
        b=UHTNyhVppJKkyTOoPrpfyifM0dQjAKlkPIdHN+O4OIQ1TD5BnMn5Qq7ryQ5HBuX/ai
         gQFnthPHtTu7n96ddwIYLswJGrU93/41d9Uj1h4yOhgAAsA8R3Kdm3gTT1GC2P48jQH6
         8zh2SlOniBbZCSzHKnMUhkD8lZEQcylWLuyS527UCSDC4+7CjYnNa5moyMtE5QT8/UCW
         aItHE5qbBKVoAaIzs1yzYXydGcX3CW5pIRJhqA6KTzA7NgP3W2RXUBIeDRV3vwLZDth/
         s7mcX/0nhReRpGJszSL/8fZn2auZDpXzn6PdwWcn3PDMUevX9vqDUJn6tJuTCpTBCbYh
         mCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Hm5+6btyUCeQ5oIxKue6cqiX6WndMX6wAwNU/56/+4Q=;
        b=ZJv1aZcy1LKfzjeX84DMxgxqyin1vkER52+ASn3TlX0Fk5IlhNNhp59FSgoZ08VKGu
         BcvyN3+QvaLoRx2Gf4WLToUnO9pvtuhYibNWKjsXyGh5cdvLZdU6OCLjpjMVUq/Ccc/J
         NO81B8gFznP1jp1RmxJS2f0d1xhznRIj7LVTFGlXD5hMxfub8PxlOo1Jgzjx0n21I/Vv
         cHNcvL5GRgIz4N+gE9ZZd+1PlIlj+UyQVmycruwikrgFYI+fl9i41ubQAIRv37jVmcFv
         gowP7atiszPUnWZhzXquRC1RAJpsbzqjaTLsovXWi4/e0jAapC6lPfBj+BNOujXUIG88
         Vczg==
X-Gm-Message-State: APjAAAXAe9CAdiOza8icfytCtaJc4YioBmRRLf6gJ+IFGtWlxbBMd2lV
        cIvJfh2G4eRIiDbC1MgXQyQgpk3x3fRKxw==
X-Google-Smtp-Source: APXvYqypok5LrAJsl8Ool3A57HZpS5AnqQ/EhHbCmSDxD8cgpGDypDqQ8pmaH35mF7xpGC8xrIah2g==
X-Received: by 2002:a0c:8dc5:: with SMTP id u5mr35093675qvb.168.1577658432741;
        Sun, 29 Dec 2019 14:27:12 -0800 (PST)
Received: from vmi286618.contaboserver.net (vmi286618.contaboserver.net. [164.68.111.199])
        by smtp.gmail.com with ESMTPSA id w20sm13200640qtj.4.2019.12.29.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 14:27:12 -0800 (PST)
From:   Arnaud Bertrand <arnaud.bertrand@abalgo.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Arnaud Bertrand <xda@abalgo.com>
Subject: [RFC PATCH 0/1] *** Add branchname in commit header ***
Date:   Sun, 29 Dec 2019 23:26:32 +0100
Message-Id: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
X-Mailer: git-send-email 2.25.0.rc0.7.g17b02bf28a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arnaud Bertrand <xda@abalgo.com>

For tracability purpose it is often necessary to know which
commit is envolved in a branch
Keeping track of the branchname in the commit header
will make this traceability easy and will facilitate
the graphical toolis that represent the branches and
that have today to use complex algorithm to try to
determine the branch of a commit that was known at
the commit time.

no big change in the code, today rebase is not considered yet
I'm waiting feedback about that before touching
the rebase code.


Arnaud Bertrand (1):
  Add branchname in commit header

 Documentation/pretty-formats.txt |  1 +
 commit.c                         | 11 +++++++++++
 pretty.c                         | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

-- 
2.25.0.rc0.7.g17b02bf28a

