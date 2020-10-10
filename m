Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F0C433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 02:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2542225D
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 02:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vb2mYs83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgJJCMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 22:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgJJCAd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 22:00:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1EC0613CF
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 19:00:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k8so8384174pfk.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GNBOxPVvULfi1cc9bIexPddY04fVuntigEyd6CZtQWw=;
        b=vb2mYs83FIN4SI0Ao+9UHBLC1n1dc9J0EB+R1TEsSRNUMLY11tzsApzeY5TePJTBkx
         +9G+1at1RmC/YRqSbJQVrcG1cuo5Q+mja8kOEfvI4/6XI6xRkxGQccLcbAoFKHBou9gN
         o6sxn+atr8zbcs4CGTgxymL8WbOau2rrJTM1jOnShOqxOFbSBbwWAJSaG6CbxVeIsJJo
         eM1BhSORS9pDp2i15/G0NGNaDS4ylRKs79xah56P9cQow6vXschbL2WKVQgNsZqo3X9o
         MKY/5Szi+cpuH2QMIESu7Wrpu7wsLlMblws1Z6IPmcO2kTEg/0gPvCzckObNftNqugVg
         QBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNBOxPVvULfi1cc9bIexPddY04fVuntigEyd6CZtQWw=;
        b=jkevgxa1Wmp4Kwk9ZAb46N71ZH/f3pCN7skvxfd3jrJTHaczjrwAdkWyin/IyyYg/4
         iHOj+9S2LvytSlzL91c8dx4zJQ6qO9CY1Kw+g2QpEg3nQwyzkXsgw0mpDJeOND0jtjET
         rUG3q7SR7w/0vK3yM/OE3g6W1NE8SfY26wNDqgAiFxxfYPS0u4YUut82lF1knIfmmuiQ
         1bIuznddnprrxQSAYJA0evYYqVGAS1y+elDd1grr489tI4VA9s68tGy8lCCNZVx4pUo3
         wK6YL6KxYUKtYtlztvErbyFiRiwQ4HPNjcL6z2n6VEBv3vkMhvrsC43PhKlN5z4cTHzd
         S/2g==
X-Gm-Message-State: AOAM531ZO7/Gdc68tp2TKlA/5O9pWnhHpW+XcQkVbOTwZ/0XfvP/7gcS
        3WZkQgGjp+8WY7ZzDIMKxudbOc066CNFfQ==
X-Google-Smtp-Source: ABdhPJxHc/lU1PnzHpNCU/TUKnlQa6CoxYsrfRi9IVV6N6khql+Fr3/EUw9fhS3jU0PtkvcsgFji1Q==
X-Received: by 2002:a17:90a:8c8a:: with SMTP id b10mr6448107pjo.127.1602295232439;
        Fri, 09 Oct 2020 19:00:32 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.94])
        by smtp.gmail.com with ESMTPSA id t12sm12045422pgk.32.2020.10.09.19.00.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 19:00:31 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Daniel Santos <hello@brighterdan.com>
Subject: [L10N] Kickoff for Git 2.29.0 round #2
Date:   Sat, 10 Oct 2020 10:00:15 +0800
Message-Id: <20201010020015.66079-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.28.0.717.gbbef0a07d5
In-Reply-To: <20201006014258.26369-1-worldhello.net@gmail.com>
References: <20201006014258.26369-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Dear l10n team leaders,

With the release of Git v2.29.0-rc1, a message has been updated.  Let's
start a new round of git l10n based on this commit:

    l10n: git.pot: v2.29.0 round 2 (1 new, 1 removed)
    
    Generate po/git.pot from v2.29.0-rc1 for git v2.29.0 l10n round 2.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
