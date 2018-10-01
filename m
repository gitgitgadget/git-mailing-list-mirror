Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024BE1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 11:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeJAR6g (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 13:58:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37008 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJAR6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 13:58:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id c22-v6so223003edc.4
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kNdEip7Gd3rQA86IfR1rSbKzsFJ+zSxgaPg4ALGOo4=;
        b=hgYYKtOFVOvPomXfi/izctMZKXsj20Q4DSMIqxnDlxvMoNPqFKkzUGN2/9TwtnbOEf
         D0kmVvYTwYPR/8b4u7UW17PX8D9AhksUu8FMa0dNRLc033Lzud1I1pIaZSO+IG2jwjS9
         UB1KXLaTay21iuDeWS+RZRUPFxrWPZJ6nsx58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kNdEip7Gd3rQA86IfR1rSbKzsFJ+zSxgaPg4ALGOo4=;
        b=F4uaRsUReLz7Ai9jJ/T8NszwbbwhIH/igXB3wg5x395+583dYxpp99YfEveDKP2ZNG
         t92O+expiuWu7cE2FKIVizMgzQxNmEa+dvaBvc3D8u0ZCI9R1pUBCwDBhwLLgVNiBJri
         GnNLJDcVnt6VlK8A+Y49QE2Re1zD7eVtZMeEJ2wH0x53rVjb0s90AFkvBy9/TyV93uUV
         +YhwNCoOZ1iZ20MqlLjXouKB1AmrGpxX7gJWkTD+1H2lV7i0N4IPdocDGvLdAaBlwCUB
         9Iuu70K5ED+n9XTF0TzqK6xoB3WzbdRc7EqDJ2Bs6DtVVkTg59TAkrr1elypYEgxWWG1
         qj6g==
X-Gm-Message-State: ABuFfogaM+7AgMxQ6Y8+0aE04p7x2StH//n6zAidvjo2MpPCS/uyuC2Q
        1fLZJsspXfMRJMnD3cctcqIfuDtIUi/j+w==
X-Google-Smtp-Source: ACcGV63jnMOOsPO0XmBc5SitxJy5eHWhMgAHKhfG+05l3nDcCilNpxNEo+jRlikF7IT7P1X9QS7llg==
X-Received: by 2002:a50:b3dd:: with SMTP id t29-v6mr4979933edd.76.1538392876228;
        Mon, 01 Oct 2018 04:21:16 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-116-96.cgn.ip.fibianet.dk. [5.186.116.96])
        by smtp.gmail.com with ESMTPSA id d13-v6sm1908560eda.51.2018.10.01.04.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 04:21:15 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 3/3] git-help.txt: document "git help cmd" vs "git cmd --help" for aliases
Date:   Mon,  1 Oct 2018 13:21:07 +0200
Message-Id: <20181001112107.28956-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This documents the existing behaviour of "git help cmd" when cmd is an
alias, as well as providing a hint to use the "git cmd --help" form to
be taken directly to the man page for the aliased command.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/git-help.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 83d25d825a..37e85868fd 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -29,6 +29,10 @@ guide is brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
+If an alias is given, git prints a note explaining what it is an alias
+for on standard output. To get the manual page for the aliased
+command, use `git COMMAND --help`.
+
 Note that `git --help ...` is identical to `git help ...` because the
 former is internally converted into the latter.
 
-- 
2.19.0

