Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF531F576
	for <e@80x24.org>; Mon, 26 Feb 2018 10:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeBZKap (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:30:45 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43649 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeBZKao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:30:44 -0500
Received: by mail-pl0-f65.google.com with SMTP id f23so9015738plr.10
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIxrcP+bmmBGqzexj65gPIxdapCLic8CyvX5oDjtlGQ=;
        b=LhsTVvnB0kThduJUP7Uiq1EmLdiAxuyw4DIHTUEY8spivMpMyKulpuo8lfCE1on5eI
         1F5UM2Txaty4uzciR1Zer7NrSKbbmpOa7v1rs3Fn/pc6e0ntQKrZq89fJzpGRw5SUtPh
         bpr9AWKgSKGnnwb5yD1hceY3aUWHfpNdkF3VVIU542skG5u6jTeGMKzRmzrwawuD3Sq4
         N/93EntuZt6aaLxm36xaoOnibpLt43f8QaaZ0tP7U1hXCq56sbpCLlkl/1umIEBs4Cvt
         ikLR6ZwVXDqgKbSm8Wo5trwWlAkP/+DAXNW6TJ60gnJHf3SKSrfF6YENaRtcXIlNE3xk
         bZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIxrcP+bmmBGqzexj65gPIxdapCLic8CyvX5oDjtlGQ=;
        b=oJzahvZE3lFR7urYUePFUUeFNhqUqp4I8Sx2c4qML2cBAT8Kzm/2s7OmcsQu9bYP+a
         y1L7JqTp1KpFNhaYHDdgKzLPWPEihP3/KqjSiWu8gF3Uq6VcSXE/q9DOg1FvBJr4IVZF
         s9zmRmd8nTeUZ7MOvQECnuXMBUyx58iuy4SgXt7csYmrMRtRWEvDN7LNG7TcWGbBsFFy
         IacyT2ir4pm8ztsVZRiqaDI0f3uFQ9Es/TyrV8oxiEO1MYIWvi5Jp6P6hpYgDEjjKgdf
         1l4aTNcGHK6uPGXnve/uTTeCAF+3RBgBYX7A5SIKwitJxEaGO/AAV3PiVTCN7Wp72xUA
         kR8A==
X-Gm-Message-State: APf1xPCOTK996vvxQZyn7c/jSS+lEuc1rc70oqsRtH4G2KmQLKizU0cT
        rL1D+Hjg2xhyph+xAH/8Vt4=
X-Google-Smtp-Source: AH8x226qfNVlkvo5+2ZE184Gx0x/Ts+vk9sAUllD94eW+ckhDR/FExfTWr5MIyz5x1Z6/onGP+Eaow==
X-Received: by 2002:a17:902:6c4c:: with SMTP id h12-v6mr10044701pln.101.1519641044129;
        Mon, 26 Feb 2018 02:30:44 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 80sm19537424pfn.114.2018.02.26.02.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 02:30:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 26 Feb 2018 17:30:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 0/4] Delete ignore_env member in struct repository
Date:   Mon, 26 Feb 2018 17:30:26 +0700
Message-Id: <20180226103030.26900-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180214180814.GA139458@google.com>
References: <20180214180814.GA139458@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out I don't need my other series [1] in order to delete this
field. This series moves getenv() calls from
repo_set_gitdir()/repo_setup_env() and prepare_alt_odb() back in
environment.c where they belong in my opinion.

The repo_set_gitdir() now takes $GIT_DIR and optionally all other
configurable paths. If those paths are NULL, default repo layout will
be used. With getenv() no longer called inside repo_set_gitdir(),
ignore_env has no reason to stay. This is in 1/4.

The getenv() in prepare_alt_odb() is also moved back to
setup_git_env() in 3/4. It demonstrates how we could move other
getenv() back to if we want.

This series is built on top of Stefan's object-store-part1, v4. I
could rebase it on 'master' too, but then Junio may need to resolve
some conflicts.

[1] https://public-inbox.org/git/20180225111840.16421-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (4):
  repository.c: move env-related setup code back to environment.c
  repository.c: delete dead functions
  sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
  repository: delete ignore_env member

 cache.h        |  2 +-
 environment.c  | 13 +++++++--
 object-store.h |  5 +++-
 object.c       |  1 +
 repository.c   | 79 ++++++++++++++++++++++----------------------------
 repository.h   | 21 +++++++-------
 setup.c        |  3 +-
 sha1_file.c    |  6 +---
 8 files changed, 64 insertions(+), 66 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

