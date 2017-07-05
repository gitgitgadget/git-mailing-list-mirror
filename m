Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FFF202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 23:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbdGEXPV (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 19:15:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36089 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbdGEXPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 19:15:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so883351wrb.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPq8UsyDrk0mb5LDCsYXMtkEBq7boLn3e28f4zF5QZ0=;
        b=XR71rqjiRyq4/64qwHgLlx1Ah8sdZTE4jA53tKsXND9ST+qbGsyKBR0J2Y4U8rR3Vt
         kRMMX9acRq6Bbly6oAuNlHND4K/KvUqnU8Imw8CqnyG44g2kcoe3X41qDU2VbQAF1FdE
         NopofW2tEMMYGWgFZgqqIffkfEzKV2u1jCboEECvNAXdaD+e3GDUFtMuSE7g6RxIZGK2
         V+U8stiYmBjiYVHE8SNs772Nw+VbUb2BScTOJ1Oyn4jTvI2YbqXMYIz/FAfhIuoo06m/
         MNJ4siiu1kfgpTCsu16g6LT+Rf7VxLsd2Ih1mh4fxhnBuBl4T3xo+JolWqSylNlO+dj8
         qhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPq8UsyDrk0mb5LDCsYXMtkEBq7boLn3e28f4zF5QZ0=;
        b=QwFYUkQPierG2ICKZ7IPntWt+bYoDAI+ZE1DTK5iEuhN85XIclTnw1JYZ3kXIhmR/X
         fRULlCKdH8odbFp/EN1GqniPTqLCu/K5DP+kMu4YHRBvxkIdnodhRUy7EUXlJM0Akq6L
         QAKsCc3uEk6bs1FOVKrGTTkV9PseMiHbgQyBRGJRQIzGkaGjJs2kV9nDsBfTrkDDE+pH
         CK60phC+2BcnH7E25UmhPgFIHG06vEDtX9fr8xVepdUm9A/Wkv40YzwNrqUYtsJZetGZ
         gGQ4VDChCLlESrj/mmvSq0aOvCvJhpajv0XVPJqczGCa+pps7Nb1YYukLBZGDDUhAEDa
         GM7g==
X-Gm-Message-State: AIVw113ORCCcKJ8JRnqLmfdk1CRQytSziJQ1qw/ZTVGcPCDTyRWcBjap
        OWQ5ybM5HG7ruAguz3o=
X-Received: by 10.80.207.203 with SMTP id i11mr6118097edk.112.1499296518941;
        Wed, 05 Jul 2017 16:15:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x36sm8834938edb.64.2017.07.05.16.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 16:15:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] branch: add a --copy to go with --move
Date:   Wed,  5 Jul 2017 23:14:51 +0000
Message-Id: <20170705231454.15666-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05 2017, Junio C. Hamano jotted:

> * sd/branch-copy (2017-06-18) 3 commits
>  - branch: add a --copy (-c) option to go with --move (-m)
>  - branch: add test for -m renaming multiple config sections
>  - config: create a function to format section headers
>
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.
>
>  Has a bit of interaction with mh/packed-ref-store and bw/config-h,
>  so perhaps needs to wait for the former to stabilize a bit more
>  and possibly rebasing on them.

Now that bw/config-h has landed in master here's a version that's
rebased on that. No changes from v1 except:

 - moving the new config header addition from cache.h to config.h,
   corresponding to what was done in bw/config-h.

 - fixing a trivial comment whitespace issue which I see you applied
   locally.

Even though this modifies some of the same files as
mh/packed-ref-store it looks to me like this doesn't conflict with
that topic in any meaningful way, but I may be missing something. I
can't get a merge between this & gitster/mh/packed-ref-store
compiling, but that's due to issues in the latter which seem to be
fixed by some subsequent merge/fixup in pu, not something to do with a
genuine conflict with this topic.

Hopefully this'll allow this topic to land in 2.14.

Sahil Dua (2):
  config: create a function to format section headers
  branch: add a --copy (-c) option to go with --move (-m)

Ævar Arnfjörð Bjarmason (1):
  branch: add test for -m renaming multiple config sections

 Documentation/git-branch.txt |  14 ++-
 builtin/branch.c             |  67 ++++++++---
 config.c                     | 115 +++++++++++++++----
 config.h                     |   2 +
 refs.c                       |  11 ++
 refs.h                       |   9 +-
 refs/files-backend.c         |  46 ++++++--
 refs/refs-internal.h         |   4 +
 t/t3200-branch.sh            | 256 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 476 insertions(+), 48 deletions(-)

-- 
2.13.1.611.g7e3b11ae1

