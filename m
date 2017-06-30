Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD76201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdF3TOP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:14:15 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35352 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdF3TOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:14:14 -0400
Received: by mail-pg0-f45.google.com with SMTP id j186so67742195pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhjKGDhmtDhQ4UKUM1fwguPVGFFxOVrNyK0WHS9iQV4=;
        b=gNfzclp2s7LIKJY4dPc37raVZ+UebL1e6Mqs63E7J8Veyf1imC2hS/WR2Si1aHSHP0
         A4yuxLGNWBm/3nZ5y5MmBiuE0GiNYdrkySPYSMm/sttvFki64O7S6VfUU/TyemXXjj4X
         /qobxVjtDLTFqjVyqs+h+sfhX/bh0OLj4aMPRIvEiAYR2OP9auLqjy+m8Q5lVIJVn9Aa
         2idBoghBX8FwcYSEDyuxcoQncPNeT6mp6tzxS+0XQV74ndi2eKo1hmVWoJCbOedZ6Gcm
         vGVvQJkwnp0R+mzNHPYggy8LX+uFruTHpPyK6ZvaN/XTiL0rul4DBVfn+d1fiD9JIyzA
         kXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhjKGDhmtDhQ4UKUM1fwguPVGFFxOVrNyK0WHS9iQV4=;
        b=Nf/h4mn6dIuqet9RT2/lDhQ6jp7VXueA1GNX2pqJqQY1LZOov3IEqSn2sWOvkmfQh4
         o3whgR0I8cQO6Ejn2D5kzXNcYpnN6Mi+8s79OlRvAEfaMTA1C2CGmwf0nCIlquWd25SV
         C0wmr3W48bf+kCm3pRGs/vCtCIi/+qCBYxUPpIxZt5TweUOuetx4dimYBB6wNPE6pr2Y
         i1zTPL/4Tgh9cOuAO+Ah7V7IcabXNNGQHdhTLIno31z35R81CST3TWJoQmHi8uQCEoaH
         mxvZmItdjB12Pc6cHVBtD2XJEcOxlvymAjk/UZimjMK8f1sE7l6Rm+Lji6cjIKAbKgRG
         nWkQ==
X-Gm-Message-State: AKS2vOwEULKlnatqqfu6EJR1FfeGCEnR4fU80zPyEE1b7WmPn0JAOiqY
        9NC7fcsA3JYfCxWN
X-Received: by 10.84.228.207 with SMTP id y15mr26236047pli.13.1498850053670;
        Fri, 30 Jun 2017 12:14:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 8sm21795903pfs.23.2017.06.30.12.14.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:14:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCHv3 0/3] Introduce data field in hashmap and migrate docs to header
Date:   Fri, 30 Jun 2017 12:14:04 -0700
Message-Id: <20170630191407.5381-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170629235336.28460-1-sbeller@google.com>
References: <20170629235336.28460-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3:

* fixed first patch to call the data 'caller provided' instead of arbitrary.
* moved the position of the caller provided data to first position
* split up the rather mechanical change of function signature with
  fixing the API usage of patch-ids.c

v2:

addressed all but the last point of Jonathan Nieder.

Thanks,
Stefan

v1:

https://public-inbox.org/git/xmqqpodnvmmw.fsf@gitster.mtv.corp.google.com/
for context why we need a new data field.  Implement that.

Once upon a time we had a long discussion where to put documentation best.
The answer was header files as there documentation has less chance
to become stale and be out of date.  Improve the docs by
* migrating them to the header
* clarifying how the compare function is to be used
* how the arguments to hashmap_get/remove should be used.

Thanks,
Stefan

Stefan Beller (3):
  hashmap.h: compare function has access to a data field
  patch-ids.c: use hashmap correctly
  hashmap: migrate documentation from Documentation/technical into
    header

 Documentation/technical/api-hashmap.txt | 309 ---------------------------
 attr.c                                  |   7 +-
 builtin/describe.c                      |   8 +-
 builtin/difftool.c                      |  24 ++-
 builtin/fast-export.c                   |   7 +-
 config.c                                |   9 +-
 convert.c                               |   3 +-
 diffcore-rename.c                       |   2 +-
 hashmap.c                               |  17 +-
 hashmap.h                               | 360 ++++++++++++++++++++++++++++----
 name-hash.c                             |  16 +-
 oidset.c                                |   5 +-
 patch-ids.c                             |  10 +-
 refs.c                                  |   5 +-
 remote.c                                |   7 +-
 sha1_file.c                             |   5 +-
 sub-process.c                           |   7 +-
 sub-process.h                           |   6 +-
 submodule-config.c                      |  14 +-
 t/helper/test-hashmap.c                 |  19 +-
 20 files changed, 431 insertions(+), 409 deletions(-)
 delete mode 100644 Documentation/technical/api-hashmap.txt

-- 
2.13.0.31.g9b732c453e

