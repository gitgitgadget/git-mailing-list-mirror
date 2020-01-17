Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D88C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0632072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8dg40J+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAQUov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:44:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43598 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgAQUov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:44:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so10306815pli.10
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoA79YeSWUH5+3SMNPKn3WvyiTEcZlk+S/Q5hVVbU5E=;
        b=N8dg40J+zzk2pOU1z5EQXCbeQuWQXH9LPrHmLO6mGcJXQOLcAH9TqqnXYn+mNlQ884
         D+1vsnreWvoDJnwatzSyQ0VdDspYyWjLhF28CrQw09Y9Zytxl8y7XY10C2lupiHnDgAk
         7dBXg8mHUUZu0gNxIv59LDXQ6R5bVRdS1uQ6gh7+JG59OpP1lqPKG+cvvPTqRKgxfHTs
         ChdB4Tf7z9Or9y7wYXXEOqi5HKYNqHW/tlosF7ioBo2DvP52cndXpXAlX6CZBLyTstb2
         Glsa3ruV7Gw5jwr1hONhMUcpCb/62qRqU/+WblYVkhx0JWIpFnKGd1ocYmG/O98zrdw7
         PDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoA79YeSWUH5+3SMNPKn3WvyiTEcZlk+S/Q5hVVbU5E=;
        b=JmqBKnYLO/z+VhogNcOwi7zB7r0VOc+XZFjClVxk8EDkHOWFIpF+936/d6UmurVVfO
         Pd4Ja3Fjy5YZV6btODl50mEH5mNK9EuAq5O8bAmr4kM0jT2MjGggsi4jqRETCcPzjFLW
         F3T5/QinjfyVSJUfZ4JH5Przb2b9LG2jQqm7OoziwT5o/xnsC+BHK067HpeTJfX7AcNf
         m0kwKytI34jY90tJns26DTyDtXfNq16ldS9huOyYTMGqKdyrOE0V9mHVejiVSXtk8otl
         QlVrN4dQa/YZmGtvHodPWZAykzOZ7EIGctzFwYsPLatsmkviee5xehvYEYWlvQJfHYdI
         vA9g==
X-Gm-Message-State: APjAAAUcNoukGwld6CBBZ1QTz/ZPdSUbE3LW6obcWlBohVHkfAFAxkCW
        3BLVBCXdnY1C59c+13hUakNu/G5Dq9G6tQ==
X-Google-Smtp-Source: APXvYqxhFdXe1qhgLlUkaknJRKYdswdcmDIiJ9GPUa+oJqS9SjCphcRyZy4/vvMoyrGQZ23csYsxsg==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr8246663pjq.11.1579293890791;
        Fri, 17 Jan 2020 12:44:50 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id u20sm28844190pgf.29.2020.01.17.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:44:49 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 0/3] t6025: amended changes after suggestions from the community
Date:   Sat, 18 Jan 2020 02:14:23 +0530
Message-Id: <20200117204426.9347-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

I have made the changes in my patch on the advise of Junio C Hamano and 
Johannes Schindelin. Thank you for looking into my changes, this has given
me confidence to contribute more in the Git Community.

Thank you,
Shourya Shukla

Shourya Shukla (3):
  t6025: modernize style
  t6025: replace pipe with redirection operator
  t6025: use helpers to replace test -f <path>

 t/t6025-merge-symlinks.sh | 96 ++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

-- 
2.20.1

