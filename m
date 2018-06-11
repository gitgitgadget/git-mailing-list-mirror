Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E801F403
	for <e@80x24.org>; Mon, 11 Jun 2018 13:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933151AbeFKN6P (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 09:58:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44992 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933007AbeFKN6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 09:58:14 -0400
Received: by mail-wr0-f195.google.com with SMTP id x4-v6so12378622wro.11
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+n5664M1wHVHNA2FXlxsF0jq+jQ5HATIjoR14kZkdqY=;
        b=oGl+luR+OQqo6XGYGftp/AM58SKzNhZu05wgUXTYassVxECPYJG1hyDEdJt3h2x0+4
         kJbTGcTgXxKhFqjHZaS7Hgeyv+hqz95PQzEywYQRcCiasT3555L9pVu7ZSCbn/smqLkj
         KYRx3hLsnwQ0s//1iFnsTNKrbMvntg5ZSuflWTZnJG1vC7OLZ2hhyBC9mcF+vmR9IW0t
         PfwW6sIC7NMf2JeJChTCCUB9TqeO53UpBZeNy546n0V/MErZFGf0v/UX7uuf/eyd+ILI
         Z3rMOqPPU19Wm07YUf9Qd9oRaKSmN1V0SljypK4LH0/OJVbTrqgwL6uKEB8udy8ELbAH
         ClRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+n5664M1wHVHNA2FXlxsF0jq+jQ5HATIjoR14kZkdqY=;
        b=e5r+pkZoR8+HXrFa6bXGRXIsF9hm7lppTVR3Xg5veGamtmYtWOonvgDLCHerxqoyt+
         Ka/z1cxXcf/zxPScmdAqanzOjvDKRy944NpVp1gZwqjudGAhPbtJxvTAIkYdYEcPQ3i0
         L5Wdcnaz2OBqBDprppz8rel+/XDwT5450yJyNhrXe6ns9D8prW4KlK8eYbFzW5iD30d3
         hnUPgtorjo/iVEscihHZSPn8zVCruxXYAhSLVVArNJoCEK0UiknnoOh5dINtnbvZ2m/9
         Ue1pcx9VdYrxwQkcXmEjeIeSyfnZrIR2ffsI/pPGi7Bk4n+rI6W8xbobLGWB3tYvw99l
         BRvw==
X-Gm-Message-State: APt69E3tMPO3k+QqQue62xGdUx+JBWE8UAIv+OuxH+pTwSci5RNYuOT1
        194IeLuHblpockX45Km7DrTabZn2
X-Google-Smtp-Source: ADUXVKLD/m6lb7kYIQJ3Fpc+UZUynyRaFQhCSw8okykoy+ABhyylt4sgLC+oe08qWMGo4X+G9O26NA==
X-Received: by 2002:adf:9a31:: with SMTP id z46-v6mr12559589wrb.47.1528725492681;
        Mon, 11 Jun 2018 06:58:12 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-147.w86-222.abo.wanadoo.fr. [86.222.24.147])
        by smtp.googlemail.com with ESMTPSA id g11-v6sm10522944wrr.46.2018.06.11.06.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:58:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 0/1] rebase -i: rewrite the edit-todo functionality in C
Date:   Mon, 11 Jun 2018 15:57:13 +0200
Message-Id: <20180611135714.29378-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch rewrites the edit-todo functionality from shell to C. This is
part of the effort to rewrite interactive rebase in C.

Alban Gruin (1):
  rebase--interactive: rewrite the edit-todo functionality in C

 builtin/rebase--helper.c   | 13 ++++++++-----
 git-rebase--interactive.sh | 11 +----------
 sequencer.c                | 31 +++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.16.4

