Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD64A20401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdFOVHN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:07:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35514 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOVHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:07:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so4776147wrb.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfgEPktyYyf6tLTpYQVHjQt8H5mkO5uHndi5ZYxkAa4=;
        b=MUjMw16YupB5gjot26nUNx0QonsnqKDN4y2s6r/ZGDcPoDHnVp3H0tEAr73I9G6bEo
         XWS24ABxlrtIcUBUP0QXXgterPyx4Fcy+piH4AzfGT/72F4tlz0ewcTBDJbiw4FppTqx
         hxqw/hS58xS7dlU9cFFZq4nzh2B/3Y57KRJPf4yiWGe7cEU1d4fH66mJNFBRNCEVyLGZ
         o/sHcPM4Rx3MLZmL8gywBXSF33BavdkWWznBazGFOrXJmfz6/xxR0L5I1omkSJ7ES5lG
         gVzidRIEqJQ6KTPU1LWUZDaAQaHY320UdzyABk/TUI3+WlVGdzEuB/7mCeazBi+Fn6il
         aNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfgEPktyYyf6tLTpYQVHjQt8H5mkO5uHndi5ZYxkAa4=;
        b=Rlx+mHfyffqRjWJQRLMwUAp9S6U6x/eFM0qUP++ZEkdqQrNweBew8I9Q3fyaayZGaT
         ++TmVD7on+CNO2EDIdCTpDChyW4M63pWjU1y1DLAEqWsXNkai7c7ozzx9+ZwUoIBZcwm
         9/LVndbBnim+n5oOCSI/RnCrbeBubRzxYujvjgOcNsHtbSiXC47zgHQfoDxoLo56A7ap
         CjEqq3pVpibYIT0oQE7awlHX0JhszMmunz6Nw6WYf861v6iLIX50XYlTrZLw3op9VZAa
         TGLSbIRWJmAXx7rKVe6dHIfu5y4764KLRfIhWha2RIPv+MH1lwUPjCPkzmbE/ZczJY9K
         AgcQ==
X-Gm-Message-State: AKS2vOzmuLlgezCTBwu0FoMlvQ2CeYwLHf1khwaHf9aZ/uFxSbiEziaE
        wjnBOSZKB5g7bGk6Cq0=
X-Received: by 10.80.136.110 with SMTP id c43mr4776089edc.171.1497560830836;
        Thu, 15 Jun 2017 14:07:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o1sm267230edc.22.2017.06.15.14.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 14:07:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] Add a FREE_AND_NULL() wrapper macro
Date:   Thu, 15 Jun 2017 21:06:58 +0000
Message-Id: <20170615210700.16310-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
References: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15 2017, Ævar Arnfjörð Bjarmason jotted:
> I'll change it to FREE_AND_NULL and submit my patch as-is, my reading
> of the rest of this thread is that making it a function instead of a
> macro would be interesting, but has its own caveats that are likely
> better considered as part of its own series, whereas this just changes
> existing code to its macro-expanded functional equivalent.

Here's v3 with that change. Nothing but the macro name (and comments,
commit messages etc. referring to it) have changed.

Ævar Arnfjörð Bjarmason (2):
  git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr =
    NULL
  *.[ch] refactoring: make use of the FREE_AND_NULL() macro

 alias.c                  |  6 ++----
 apply.c                  |  3 +--
 attr.c                   |  6 ++----
 blame.c                  |  3 +--
 branch.c                 |  3 +--
 builtin/am.c             | 18 +++++-------------
 builtin/clean.c          |  6 ++----
 builtin/config.c         |  6 ++----
 builtin/index-pack.c     |  6 ++----
 builtin/pack-objects.c   | 12 ++++--------
 builtin/unpack-objects.c |  3 +--
 builtin/worktree.c       |  6 ++----
 commit-slab.h            |  3 +--
 commit.c                 |  3 +--
 config.c                 |  3 +--
 credential.c             |  9 +++------
 diff-lib.c               |  3 +--
 diff.c                   |  6 ++----
 diffcore-rename.c        |  6 ++----
 dir.c                    |  9 +++------
 fast-import.c            |  6 ++----
 git-compat-util.h        |  6 ++++++
 gpg-interface.c          | 15 +++++----------
 grep.c                   | 12 ++++--------
 help.c                   |  3 +--
 http-push.c              | 24 ++++++++----------------
 http.c                   | 15 +++++----------
 imap-send.c              |  3 +--
 line-log.c               |  6 ++----
 ll-merge.c               |  3 +--
 mailinfo.c               |  3 +--
 object.c                 |  3 +--
 pathspec.c               |  3 +--
 prio-queue.c             |  3 +--
 read-cache.c             |  6 ++----
 ref-filter.c             |  3 +--
 refs/files-backend.c     |  3 +--
 refs/ref-cache.c         |  3 +--
 remote-testsvn.c         |  3 +--
 rerere.c                 |  3 +--
 sequencer.c              |  3 +--
 sha1-array.c             |  3 +--
 sha1_file.c              |  3 +--
 split-index.c            |  3 +--
 transport-helper.c       | 27 +++++++++------------------
 transport.c              |  3 +--
 tree-diff.c              |  6 ++----
 tree-walk.c              |  3 +--
 tree.c                   |  3 +--
 49 files changed, 103 insertions(+), 197 deletions(-)

-- 
2.13.1.508.gb3defc5cc

