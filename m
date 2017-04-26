Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A17207EB
	for <e@80x24.org>; Wed, 26 Apr 2017 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032521AbdDZXMw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:12:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36014 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032511AbdDZXMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:12:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so822302wmu.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUBTX56BEkweBkE67//gL8DL4GpIDHS+bhP/0jF93OY=;
        b=ADs9elj3Gu8knRdtyEzS2ZHV7Drb9QCX8H0bZrEiyMgX3pTmPQsKX7ulEuB6EA74gH
         8Lf+YeTNLfIeKDFeBAZ4BeZsYNYPW0kBQszrPszWU8hRxaaYykQu+wwDAc2h2fi+Mn3Z
         Pp2t5+dZH6Q0I9hcxXnyASV/iAOrgwW71Y4j0hDHAM1HqTe61k2apRDONhjKnhrh9J5o
         nO4fKqADNvUfRe/KdvI7REb064jdxIgm/g8NgByg0nszOTDjD0vSIzuR81W/Tu8hm66Z
         EfGTR5RNgHvxJvu7VWAQtCm5cCe/geTK/DsQ2tq1VjnJppDe22UBUPbCSom5ILPoPeWO
         uqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUBTX56BEkweBkE67//gL8DL4GpIDHS+bhP/0jF93OY=;
        b=qEn1ho4RXD+DEWL0rI9PmB0x/LTedFkicL2JYT7njxvpM8/UF2+PONqazEkLtzuIpY
         aVAAyKFqRPeVplaEVRWXXQvPrBBFgwhJ8xuoCSo441fJtzjdA9PJgZACkNRYjuV0q0ZA
         LbTR973PS/NsvXjHhHcBJwFDTw8Po6K+fjFqx1dps0NfiSFxzGQLM7Sa0DMFcFsppDSS
         mGC0uuc7TrqIx63R+bVq2MhmZAEmCxx0rD0lrkfRt01dgrTZTG2B5X5FZrILuSP3dWFc
         94e0ihhUE9Y2Swi+2dEhreN6RymJXywmSbPu1LAz/0BxGEl9PORVF9LBxHNYeUUrE2o+
         +VNw==
X-Gm-Message-State: AN3rC/5uqZVpMoNajZQ8gV5jiw2J+eRv86TU3OzFrVNiTHdwAooWsctH
        jL75OSz5jLtEDw==
X-Received: by 10.28.31.200 with SMTP id f191mr169819wmf.63.1493248368649;
        Wed, 26 Apr 2017 16:12:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 133sm1053097wms.22.2017.04.26.16.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 16:12:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] clone: --no-tags option
Date:   Wed, 26 Apr 2017 23:12:31 +0000
Message-Id: <20170426231236.27219-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an expansion of the previously solo 02/05 "clone: add a
--no-tags option to clone without tags" patch (see
<20170418191553.15464-1-avarab@gmail.com>).

This addresses the comments by Junio & Jonathan Nieder on v2 (thanks a
lot), and in addition implements a --no-tags-submodules option. That
code was implemented by Brandon & sent to me privately after I'd
failed to come up with it, but I added tests, a commit message & bash
completion to it.

The WIP 5/5 patch implements a submodule.NAME.tags config facility for
the option, but is broken currently & floats along in this submission
as an RFC patch. AFAICT it *should* work and it goes through all the
motions the similar existing *.shallow config does, but for some
reason the tags=false option isn't picked up & propagated in a freshly
cloned submodule.

I'm probably missing something trivial, but I can't see what it is,
I'm hoping thath either Stefan or Brandon will see what that is.

Brandon Williams (1):
  clone: add a --no-tags-submodules to pass --no-tags to submodules

Ævar Arnfjörð Bjarmason (4):
  tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
  clone: add a --no-tags option to clone without tags
  tests: rename a test having to do with shallow submodules
  WIP clone: add a --[no-]recommend-tags & submodule.NAME.tags config

 Documentation/git-clone.txt                        |  21 ++++
 Documentation/git-submodule.txt                    |   8 +-
 builtin/clone.c                                    |  19 +++-
 builtin/submodule--helper.c                        |  21 +++-
 contrib/completion/git-completion.bash             |   3 +
 git-submodule.sh                                   |  13 ++-
 submodule-config.c                                 |   8 ++
 submodule-config.h                                 |   1 +
 t/t5612-clone-refspec.sh                           | 103 +++++++++++++++++---
 ...odules.sh => t5614-clone-submodules-shallow.sh} |   0
 t/t5616-clone-submodules-tags.sh                   | 106 +++++++++++++++++++++
 11 files changed, 284 insertions(+), 19 deletions(-)
 rename t/{t5614-clone-submodules.sh => t5614-clone-submodules-shallow.sh} (100%)
 create mode 100755 t/t5616-clone-submodules-tags.sh

-- 
2.11.0

