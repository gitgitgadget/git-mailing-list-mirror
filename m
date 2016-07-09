Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CED91F744
	for <e@80x24.org>; Sat,  9 Jul 2016 05:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbcGIFYO (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:24:14 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34862 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcGIFYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:24:12 -0400
Received: by mail-lf0-f68.google.com with SMTP id w130so8699345lfd.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:24:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bHr0EVYyXr46hGITgG6n40xSv1A4Utf0+Djcf/vGtQ=;
        b=iqvQoGOlHriiUZnBMs+VULUJBSbZKfi5wiv2wff9Ms/KnWvo/I2q7ixpaPPai6+jVN
         UlqKoBRjfVxMcdC2GoSx/yoNzpiYq4b1OSo1vbr76Gi5/5W5VFjJ1Limy/WIR2PHMnFQ
         m94oUmKkv3WlWdEzevQ57H0gvQH3ziOXPM5RKa18RjFGpYFfDejF6GTgyuazZMfJiYcw
         xCNCQ5eqXVKr21W+E6xRhSsjqRH09CRQZmDFME8nYK1BSxatMh/ClLZtNCBwW0H+LHkN
         AJCC9rBZMn1zeQiCk/+pcwXpitU6cUedqgee0sVhSzwF1prFXQeMlXUu0jRXMJySTPns
         D80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bHr0EVYyXr46hGITgG6n40xSv1A4Utf0+Djcf/vGtQ=;
        b=JycrqmAzhN8QbjiSKLnltpK9L8sRumv+wtD/vkPJxi/vdhBAQx5QCsWX3Z8eZ4my7g
         nzvAbKA7TEwVNAOjndJulGg/7LUnLi6c8QRLCcT7nviPSu8tZGGxYOZF34irZ+GYWD1j
         DnqkWxjiz96Yc7hSmF+g161Ju/wwFE4F1pjt/5DzaZ57mWAcBGpHbhXzfQVc56wqgFYV
         iqsqd2ByZuXOVxh8bHc2v798nFO1kON9cYsSO97MA4sHNY7YDR1zqC9ONrGKW/V2rOX5
         blkfZ7K0bz1jQJUrBzGtyhNLu8c4uYGAz+/WZvQuDvflN1j+3Q4gB5WDEKm02NlW1R7u
         6izQ==
X-Gm-Message-State: ALyK8tIj75m5ANk/YIc+euc30N6BgGHmdKcjhxjSdQu7nuPMR0FzuZ9GjClMKlE88uKeTQ==
X-Received: by 10.46.9.148 with SMTP id 142mr2337843ljj.4.1468041850508;
        Fri, 08 Jul 2016 22:24:10 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id f66sm1450237lji.13.2016.07.08.22.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 22:24:08 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/4] cache-tree building fix in the presence of ita entries
Date:	Sat,  9 Jul 2016 07:23:52 +0200
Message-Id: <20160709052356.30570-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160706184829.31825-1-pclouds@gmail.com>
References: <20160706184829.31825-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v3 fixes 2/2 (which is 4/4 now), allowing cache-tree to generate an
empty tree if the index contains nothing but i-t-a entries.

Since empty tree SHA-1 is involved and we don't want to make it harder
to move away from SHA-1 in future, 1/2 and 2/2 are added to keep SHA-1
for empty tree (and blob while we're at it) in one place.

Note that I didn't make lib-pack.sh and t5308 use $_EMPTY_BLOB because
the actual SHA-1 characters matter (t5308) and I'm not so sure about
variable expansion in the case/esac block and not wanting to check all
the shells out there again (lib-pack.sh).


Nguyễn Thái Ngọc Duy (4):
  test-lib.sh: introduce and use $_EMPTY_TREE
  test-lib.sh: introduce and use $_EMPTY_BLOB
  cache-tree.c: fix i-t-a entry skipping directory updates sometimes
  cache-tree: do not generate empty trees as a result of all i-t-a subentries

 cache-tree.c                         | 11 +++++++++--
 t/t0000-basic.sh                     |  2 +-
 t/t1011-read-tree-sparse-checkout.sh |  8 ++++----
 t/t1100-commit-tree-options.sh       |  2 +-
 t/t1700-split-index.sh               | 24 ++++++++++++------------
 t/t2203-add-intent.sh                | 31 +++++++++++++++++++++++++++++++
 t/t3102-ls-tree-wildcards.sh         |  8 ++++----
 t/t4010-diff-pathspec.sh             |  6 ++----
 t/t4054-diff-bogus-tree.sh           | 10 ++++------
 t/t5504-fetch-receive-strict.sh      |  4 ++--
 t/t7011-skip-worktree-reading.sh     | 12 +++++-------
 t/t7012-skip-worktree-writing.sh     | 10 ++++------
 t/t7063-status-untracked-cache.sh    |  6 +++---
 t/t7508-status.sh                    |  2 +-
 t/test-lib.sh                        |  5 ++++-
 15 files changed, 87 insertions(+), 54 deletions(-)

-- 
2.8.2.537.g0965dd9

