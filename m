Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6084B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfFMQuX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:50:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37296 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFMEH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 00:07:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id 20so10138072pgr.4
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 21:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQVJ2cCDUzmsnpsgPypRI3b7jqyLzFjP2HcoXVgq0BY=;
        b=KGjyTlfJLPFv4DSrUW4mF5IZfCXE2FUjYa+VS4hhkdPuBBblvrZTZODM9GCUZvsO0V
         r2h+Ugx+v6GctjlAlHvPwH9c8+d6eFfmTGB6P0vAD7ZgHpizSAr9aRCtIiJ7MjCcKQZ5
         1YLpt4QokBds8ca+qdBhEc7jfGMxKWawT2s7kGZ1QOUdGN/MxmRPKoIOZ6/Qv70CcJ4j
         3z2DM9AruCjtodPGlFHafXWepi8OlS3A0vNSbMTj/qZqH6Ik5WLlm0K9ZNork3nqFzKj
         d579nH+XHztfYPc4+yx7sj6+/+ohr+OrDnOhY+mlufoz0u/jqb7qw+awAh+HMnNEolyq
         rncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQVJ2cCDUzmsnpsgPypRI3b7jqyLzFjP2HcoXVgq0BY=;
        b=WEu6b40dD8CKT3fsEQ79DpMinUyhLrQdcKBn6OvZTcq0it5WzcZe0laL25BC6zP6YP
         8oFBWOEwk4i3SNLNzIRCv35Z0rtBoMGP04HEg+v8iKFH1/0Qqm2Cjk6qs48F+ig2zbc/
         udneCVS/PYIo2wBC42A/0fTSZ1Xzi0hN1dpYD/rvOSwa7s31lanLW8wc21cuX1WkpMcE
         fihKEB697D1iJZDZNkTq7zOspP7wPgfh+ql5IjU78ftM/9tLu2P15K7RcjEeU3Ymk8OH
         Yz/TrsbKkqosSHUXe0MWGbU/paSucJLJO7Uykmdnp2EZoI9D4fqRlVbDh8FIybWW+vEu
         rA7w==
X-Gm-Message-State: APjAAAXPIOx/HBDxZNOIX0XYU9g1ph3NQszwCRaj0kt+RzZei4GSP2hY
        mPEA5yU7fKk8qJUb0WnsbBM=
X-Google-Smtp-Source: APXvYqwj4Zt43B+47fUdYN1Mj0qDocAx+8mDezwZ+257p8qCc6ldJWVYv70xYu/JlRtOZeCQcjTTsw==
X-Received: by 2002:a63:205b:: with SMTP id r27mr28826439pgm.330.1560398848818;
        Wed, 12 Jun 2019 21:07:28 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:2894:35ed:6485:6224:95ac])
        by smtp.gmail.com with ESMTPSA id k197sm1073288pgc.22.2019.06.12.21.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 21:07:27 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v3 0/3] Teach cherry-pick/revert to skip commits
Date:   Thu, 13 Jun 2019 09:35:01 +0530
Message-Id: <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding a `--skip` option to make skipping commits easier for the user
and to make the commands more consistent. This will serve as a small
step to the bigger goal which improving consistency of sequencer commands,
i.e., improving how command line arguments are handled, this will also
lead to better user experience because of the precise advice provided.

Rohit Ashiwal (3):
  sequencer: add advice for revert
  cherry-pick/revert: add --skip option
  cherry-pick/revert: advise using --skip

 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 +
 builtin/commit.c                  |  13 ++--
 builtin/revert.c                  |   5 ++
 sequencer.c                       | 106 ++++++++++++++++++++++----
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 122 ++++++++++++++++++++++++++++++
 8 files changed, 232 insertions(+), 27 deletions(-)

-- 
2.21.0

