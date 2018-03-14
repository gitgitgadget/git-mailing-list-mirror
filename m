Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB4F1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCNVel (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:34:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55279 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeCNVek (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:34:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id h76so6809180wme.4
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YjYCao4MuCJaDsnwi7E/vwnB+MVfLaPrFV6BPQIkWE=;
        b=bJ3Tp/SUdYtxlviOm1vh4cT1kkBNMxALtqCHSkEmhDh34D+IEECcenzKY73ATpHdhM
         /Gt2xZpPs7sALiY6v+PBUngs5h/2emTrEFeT0R8uXpCvlt56th5WiXoWYgYO4BoxJWQp
         SYY/zmgQtdBzRWrC7nXTKfSIM8dX4nAXCx13WlHmw46DGYQ4akxRPKts8P/3dvuK0Ci8
         furB8svroD0spjLqTS9WuSJ0Ym0qUyJ74puy7xceHCRRrCI3boPINukkiPkJTVRpGpdO
         YmUJw1Hqk2SZFk/+GFRayzHj2DpW5nhEoTYNs87ox4flKftXI1gjvHdei2wk4BWMfs3a
         xWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YjYCao4MuCJaDsnwi7E/vwnB+MVfLaPrFV6BPQIkWE=;
        b=XPc482FnD67HFqmUbahEStbvLEAehK0RlfvIr2ABianA9dnk1hIn/moEr6ZcjhUe5f
         Lou7HrruvOOtkZx09aY+YLAFqu9lup7kcWLnlHPiGAq470DH5vlWMVD54MihelgJwCQM
         rPgHZOfpDtqzlbK7HxJBAqPe+VIR2F1OsAFwJ6BkKDR5EoSUj0wFL0GEGmclCENuct1x
         p80pVPw49MXouYR678BYyiZg9lykJM8+NNQXHRvZN4H2TPqE5RgY5XUl/orS7Chb1qap
         Gnb9mxGwi8Sk9NI7HBzEFiBL3NwdLbGGyJFFmBwf3DCfQcpTW2lhQiUkcUz3rsLqghcJ
         ET0Q==
X-Gm-Message-State: AElRT7FYbLaKClZ+A3i6w4ejfGlMcn9k0I4Egm43foCQ0CZEHb8nKbaZ
        UKIeiOMCj3IFzJ7/JD9Jyv0GkQqa
X-Google-Smtp-Source: AG47ELs8IFqa8pm8CTrwOLxohoiy3q0uWlkNo/oZ0cgkyAvqJ8bxdbBixSwBqFxTJITrB/GHIPvQjA==
X-Received: by 10.28.197.140 with SMTP id v134mr2677094wmf.62.1521063278964;
        Wed, 14 Mar 2018 14:34:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 55sm5049688wrw.87.2018.03.14.14.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 14:34:37 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] shortlog: disallow left-over arguments outside repo
Date:   Wed, 14 Mar 2018 22:34:16 +0100
Message-Id: <cover.1521062188.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1520680894.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of my attempt at stopping shortlog from BUG-ing when it is
used incorrectly outside a repo. Thanks Jonathan and Junio for helpful
comments.

Patches 1 and 2 are identical to pu. The error message in patch 3 is now
more general. The error condition on the other hand is a bit more
specific, "argc > 1", to better match the intention and commit message.

Martin

Martin Ågren (3):
  git-shortlog.txt: reorder usages
  shortlog: add usage-string for stdin-reading
  shortlog: disallow left-over arguments when run outside repo

 Documentation/git-shortlog.txt | 2 +-
 t/t4201-shortlog.sh            | 5 +++++
 builtin/shortlog.c             | 8 +++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.16.2.246.ga4ee44448f

