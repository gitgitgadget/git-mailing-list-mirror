Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76DB20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753240AbdCWNGC (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36292 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbdCWNGB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so16491332wmf.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ew/I1ZJSJ/xYZGn/N7gWFM5M5be3curNQBsjslruoMo=;
        b=TBrisIyjO5lVzp6Xw1imQnltFSakUtIroYChzWCEr+1P7p6XECeDgZ+TiXILoyJeWc
         enbK2xfo9iB6vI+ldusHNOyRqZacN+iBlpn4+aVd2Jl+Kjnr23tdvN2Sa8h5Nimrlod4
         AV0N3YdJWWGLzt6wCF6MKuk7ktHrZgwkej4ZaMEp0zIp9YuVDhhfk9Zu0eZrKIbcSfEa
         AoU1zfY7h4mfiAlkfUnUS1chggGuZqhfApj3doL3bMBkEw7pANCm8tY7DtxuWuiPT981
         bBq+t18B9OebMTfGNvm7qmIyz+deuXq/PDaiD90usu+N9vgPQbI59TIR1//ZdneOV3tQ
         ALvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ew/I1ZJSJ/xYZGn/N7gWFM5M5be3curNQBsjslruoMo=;
        b=iMEYJDSb+18VJ9dlU+pC/HX2tTDcD7zpa6c2b/yJalnaiAl0H6oV09T1kQ9rS1hRwf
         3KVSo670uQsnOo43gVllWyLCaeryvVlZ9EtX/QhX+oZK6i5nD32n3FqFitaMT4uuLZd8
         2Afvu3sesXUCXVWsH2Lh3uXs3IDkxRUrCJBqKxGUCXjTEXQegoSDfukr3dLtV1OvCOEf
         +OQXX6tEA3DXoSWZ/ND49mRauNuv2kWYx4sR3npVFwmk/fFZuZFPBw9ZmKaRbG6s8/f4
         /Hq1Iso+6tir6I2/E+Z2xipH6E3v4z2+i05cGvDhiTmIPwbQCmxD8HRmtvbD1wiVR34y
         06pQ==
X-Gm-Message-State: AFeK/H2fO5BKEwZoiQKmkqulIQLNE0k+aUCGIfFe8XdttkKzBiJJLhxzfC2viiwZ4fSUCA==
X-Received: by 10.28.194.7 with SMTP id s7mr12425229wmf.136.1490274359417;
        Thu, 23 Mar 2017 06:05:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:05:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/16] Various changes to the "tag" command & related
Date:   Thu, 23 Mar 2017 13:05:13 +0000
Message-Id: <20170323130529.11361-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully the last version of this. Changes since v2 in
<20170321125901.10652-1-avarab@gmail.com>:

Ævar Arnfjörð Bjarmason (16):
  tag doc: move the description of --[no-]merged earlier
  tag doc: split up the --[no-]merged documentation
  tag doc: reword --[no-]merged to talk about commits, not tips
  ref-filter: make combining --merged & --no-merged an error

No changes.

  ref-filter: add test for --contains on a non-commit

Minor grammar fixes in the commit message, as pointed out on-list.

  tag: remove a TODO item from the test suite
  tag tests: fix a typo in a test description
  for-each-ref: partly change <object> to <commit> in help

No changes.

  tag: add more incompatibles mode tests

Reworded the commit message to be less confusing, as pointed out
on-list & added a few more tests for incompatible model, e.g. modes,
e.g. "-l -v -d".

  parse-options: add OPT_NONEG to the "contains" option

NEW: Junio pointed out that my new --without should have a OPT_NONEG,
which made me notice that --with and --contains have also had the same
bug for ages without anyone noticing, add OPT_NONEG to them all.

  tag: change misleading --list <pattern> documentation

Hopefully solves the sticking point with the "-l <pat> -l <pat>" test
I'm adding, there's now a big fat comment saying this was never
intended behavior but we want to test it blah blah.

Also change `git tag <pattern>` -> `git tag <tagname>`. See also my
just-sent "[PATCH] branch doc: Change `git branch <pattern>` to use
`<branchname>`".

  tag: implicitly supply --list given another list-like option

Minor typo fix in commit message, as pointed out on-list.

Squashed the "tag: implicitly supply --list given the -n option" patch
into this, as discussed on-list.

  tag: change --point-at to default to HEAD
  ref-filter: add --no-contains option to tag/branch/for-each-ref

The new --no-contains & --without options also have OPT_NONEG now.

  ref-filter: reflow recently changed branch/tag/for-each-ref docs

Add missing Signed-off-by.

  tag: add tests for --with and --without

Add a couple of extra tests asserting that --no-with and --no-without
error out.

 Documentation/git-branch.txt           |  33 +++--
 Documentation/git-for-each-ref.txt     |  12 +-
 Documentation/git-tag.txt              |  60 +++++---
 builtin/branch.c                       |   5 +-
 builtin/for-each-ref.c                 |   5 +-
 builtin/tag.c                          |  27 ++--
 contrib/completion/git-completion.bash |   4 +-
 parse-options.h                        |   6 +-
 ref-filter.c                           |  30 +++-
 ref-filter.h                           |   1 +
 t/t3200-branch.sh                      |   4 +
 t/t3201-branch-contains.sh             |  61 +++++++-
 t/t6302-for-each-ref-filter.sh         |  20 +++
 t/t7004-tag.sh                         | 245 +++++++++++++++++++++++++++++++--
 14 files changed, 441 insertions(+), 72 deletions(-)

-- 
2.11.0

