Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B2C4363A
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 01:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E146207F7
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 01:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHNj36pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJFBnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 21:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgJFBnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 21:43:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F22C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 18:43:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l126so8087143pfd.5
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwwfb84wAnCR7bk5O+WHnZgVStMwahw31hXm9xbCIEI=;
        b=jHNj36pr8xfMUT4oZV5BmqWQ1OD8ey/bsR8T/aozbstb7uaoLhcjmovq8kTNghSflq
         XocFP+2DrKGMtvb2cMJ7ChKhRSoZq5YtV38FMLyg/5PKCT0Tm785THC/9CbyzXDcwYko
         QgTXbCuOXQIJ+OAVSPv33ZuwRYkiQgyNn8fWnqCc0K1VrIDqzB6CCERKACJB/BqG7qtT
         5YXM/7oPqueMAR+KdYBG1KV85vQnRYLQCd8/zgX8OYm0ClW6XTFzjdZQR6ocuA7kg6gr
         0kMCrMq6w9WJqQUFexWH7o7XcnxwHZ7K4OW6lCkFQCBvnFLuq3VI1MZVv9DCvNNVA3IZ
         QoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwwfb84wAnCR7bk5O+WHnZgVStMwahw31hXm9xbCIEI=;
        b=n/2KMkSUa/RModVnz0z2RcM358CUd0NeGPfNwyXFzAQ4aRS6356wKRlOZjhfBMS+Ng
         DEB/kAnyl4eNLXgK+X+aXXnsHlkSxzjMaoUiejOFgImbavDzG7xeRc/FrXhj6IhGa+zr
         WBRrRi39tTbZHvELROWNCcAaDk45Xk9PlTNjyZuZAKnabLkzo+JNR55Ro7x7Z7PN/cTo
         xgpJVOAJni/JfeuJvpgDNQSAhzisdkIrVRyUprtWgAs3RQN9hoKbSIKv3FN1uigQhyIy
         s4ONx4da/rdHRZRK+LDfgj4+/jnBq7AZmGaTWdZK3kjXcjTjoJUDU9pL/8lMVFDlzfVf
         KGzw==
X-Gm-Message-State: AOAM530CAiBNc33ikXbKSnbvH+i5bo+Fm9ydNxRm0YgKfJcGwYNHC8ts
        WymX9H2nmz7j7rOOTfP29Z/BvkgVs7eKmQ==
X-Google-Smtp-Source: ABdhPJwa4n5NEQJNEqs4HvFE8TYsQPoO6kfZ1o0CuM7mje4Jqm7o2oVZAM+bwjNMN9OtT97Mmh0IVw==
X-Received: by 2002:aa7:9af1:0:b029:152:6101:ad12 with SMTP id y17-20020aa79af10000b02901526101ad12mr2491639pfp.40.1601948587565;
        Mon, 05 Oct 2020 18:43:07 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u18sm957882pgk.18.2020.10.05.18.43.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 18:43:06 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
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
Subject: [L10N] Kickoff for Git 2.29.0 round #1
Date:   Mon,  5 Oct 2020 21:42:58 -0400
Message-Id: <20201006014258.26369-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git v2.29.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 124 updated messages need to be translated since last
update:

    l10n: git.pot: v2.29.0 round 1 (124 new, 42 removed)
    
    Generate po/git.pot from v2.29.0-rc0 for git v2.29.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
