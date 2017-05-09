Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4872018D
	for <e@80x24.org>; Tue,  9 May 2017 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdEITYA (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:24:00 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33214 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdEITX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:23:59 -0400
Received: by mail-pg0-f46.google.com with SMTP id u187so4475230pgb.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=O69D/BtfRLFkSwzB79jp29p7VT3z2qUaMuKMZQa131Q=;
        b=iYERNRIJXStu5R+csO28/HNx+Xd/VsDdrRk11YGvhlX38lLauJIlP9Wn0rRsRFrc7n
         q4VCdWmG4RkzjPjLsiCjjVjfrM0bBZtk740jtv9GBE5aDB2FR9lg4UCQ7ZIJKPdQa3ba
         aUQBErqPxJDi2aNEteQhGKh31x2+fkzEyTza85QVfdE3h8Bv8CsG9zC37Ndo2ZRs0llp
         S3PBI6F3vGEmU3lihXZZTXXp69vawhRvOf7tnC7Zh3s/LiK8xF9sOfMcXrAB7lmZdPSS
         VWsz2H9dIQ0qj6tGne+BRgyXxB94TTOxqSS5MmprhU1KHeMK8cGtAUS8y5l/YY/x4Va6
         8DGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=O69D/BtfRLFkSwzB79jp29p7VT3z2qUaMuKMZQa131Q=;
        b=E+0gH4AhlDjOKuMpXOublJhF/uX5jFuPJduRZBBdv5LXr4w5a5oAYdifNowryfh5s7
         7CJ4hvRXkY7zBGio4dqyaEyi+qQoQHuqMJ2QmuhB2vDiyHOyuTmp/EAU3LxOV5ZZSNAI
         /pZjFTFc8JwNGiBOYPedULpbiRSPPEneOtk+jYwA3AJ2sf7Wq7KrH27cWko16T6YC3CS
         VVsJ7HeLJbe1iKdfNmqe9KiyyMldq5qGfC8peEVaVZ35R6YcsL9yYKpSjHC8ZvAUSLZ8
         E0W5QFaLEJMLfQka4ALM16PoOvhtn9v0vLCovU9TTRbi+/d150jpCGRRUo6eZ5/8ZgPg
         hCsw==
X-Gm-Message-State: AODbwcAVumynKGOerJKm5O7I0zAgA6nS09V8QYVsGYp3f8DHGFuf2VSn
        lwZQpvfOyYWnj+qa
X-Received: by 10.98.152.214 with SMTP id d83mr1714695pfk.7.1494357838800;
        Tue, 09 May 2017 12:23:58 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s18sm1296073pfi.16.2017.05.09.12.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:23:58 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 0/2] Clarify interaction between signed pushes and push options
Date:   Tue,  9 May 2017 12:23:51 -0700
Message-Id: <cover.1494357692.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
MIME-Version: 1.0
In-Reply-To: <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
References: <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2:
 - incorporated Junio's suggestions
 - incorporated Ævar's suggestions

Jonathan Tan (2):
  docs: correct receive.advertisePushOptions default
  receive-pack: verify push options in cert

 Documentation/config.txt                  |  5 ++-
 Documentation/technical/pack-protocol.txt | 32 +++++++++++++++----
 builtin/receive-pack.c                    | 51 +++++++++++++++++++++++++++++--
 t/t5534-push-signed.sh                    | 37 ++++++++++++++++++++++
 4 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.13.0.rc2.291.g57267f2277-goog

