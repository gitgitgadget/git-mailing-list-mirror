Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6452A1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966345AbeF0Wa2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:30:28 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:41690 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966251AbeF0Wa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:30:27 -0400
Received: by mail-ua0-f201.google.com with SMTP id l15-v6so1032415uae.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=eQuVGKT1Fzj9D5d1gv3zUUhr4gd4zC90i74Ilxdta4U=;
        b=q4SncZsc8MZz9v5PmO1t3m9iqC0admMjlFv7VpnV0HLJzhgJb/gJzi548t22FfyfTV
         x7fgHdgJCtlQCNuzuZdpXCLGR1FY2wfAsl/fJBBzfFng3OEcRmjJKvzUfVorZ0ir5FiF
         7Plez3q4MxuvbSkQ/kIal12ncvUIQ96US1Kq/I7dHspIE21DO9EfbflpJ8dfi2BqJHqx
         cWdDDKMvp73FZvh9bWfi/5q7ANYyOY8tsQF4xn3Zc21neERYDS6LRu8JV2ZF2QZXbzvQ
         2sqLTvU72hYJla/ZdyZNc2YFoxwbb3EG8tLvGouf8eoRr3MB6UKXPbSepGpovEPrtbCV
         6fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=eQuVGKT1Fzj9D5d1gv3zUUhr4gd4zC90i74Ilxdta4U=;
        b=K62R6aFLRXi6CFAXgfmbhSXUpNEBNDQckriBGqIGSCrRKnECHmCp/N57wxZ7yaj8eN
         fWCFBoHA1dUg/zh6mGc9Z1XdcR7FJx1+8NbsfTGms/qKIbm3dUJ5wDIM7UIVGWFghMI2
         LgmtNoQH5f8JDw/oQKAvBEHTewf1KCjolb6mMufBq8u/Jy9+N8qwjaN5xgYHSO77qoVn
         uSesYxjR48yDeZrYgStQ1+Tt+JzOKiI2NjOrkCoDjVUIjR8PjJhRgIchnRoruIpltHKq
         wvPo5EeyAfjOJganKIX3EWO0IbhM5sLC4ULzaV6FrYGZA0QRpYo7oJkdywijaM4u2wx5
         N5Lg==
X-Gm-Message-State: APt69E14Qx4v9YiNjJBcfXDl7KtyLrfhNzecqtovN+lFkl4CUAfy6ubM
        9oJ5IeMA5HcFT7ymAcpaf1zaFb5WWpRxSHs7dmnY5/rmj340daN38Rp5u3BHeUwia907F0mcqzf
        Drw/HPYy6HN7wRPS7yRoE3/alN3qrmHyJVFuFT/K5RWFBtB+6iJkCWxcADg==
X-Google-Smtp-Source: AAOMgpdbIRNul4B1fQpxqkEJ2eHEeOhW3/AOtIapKsbWq7Vxz5Ck+sovruhjpIpsYvIuHJ8LKSYJNMkP6X8=
MIME-Version: 1.0
X-Received: by 2002:ab0:50f8:: with SMTP id d53-v6mr3157298uaa.88.1530138626599;
 Wed, 27 Jun 2018 15:30:26 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:30:15 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180627223023.49659-1-bmwill@google.com>
References: <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v6 0/8] ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v6:
* Stricter checks in tests
* Change the name of a test to better reflect what is being tested
* Various style issues fixed in shell scripts
* Renamed one-time-sed.sh to apply-one-time-sed.sh
* Client now errors out when an unexpected ref is sent from the server
  during the wanted-ref section.  Also changed the docs around the
  server's responsibility with the refs that are sent during this
  section.

Brandon Williams (8):
  test-pkt-line: add unpack-sideband subcommand
  upload-pack: implement ref-in-want
  upload-pack: test negotiation with changing repository
  fetch: refactor the population of peer ref OIDs
  fetch: refactor fetch_refs into two functions
  fetch: refactor to make function args narrower
  fetch-pack: put shallow info in output parameter
  fetch-pack: implement ref-in-want

 Documentation/config.txt                |   7 +
 Documentation/technical/protocol-v2.txt |  28 +-
 builtin/clone.c                         |   4 +-
 builtin/fetch.c                         | 135 +++++----
 fetch-object.c                          |   2 +-
 fetch-pack.c                            |  53 +++-
 remote.c                                |   1 +
 remote.h                                |   1 +
 t/helper/test-pkt-line.c                |  33 +++
 t/lib-httpd.sh                          |   1 +
 t/lib-httpd/apache.conf                 |   8 +
 t/lib-httpd/apply-one-time-sed.sh       |  22 ++
 t/t5703-upload-pack-ref-in-want.sh      | 377 ++++++++++++++++++++++++
 transport-helper.c                      |   6 +-
 transport-internal.h                    |   9 +-
 transport.c                             |  34 ++-
 transport.h                             |   3 +-
 upload-pack.c                           |  66 +++++
 18 files changed, 715 insertions(+), 75 deletions(-)
 create mode 100644 t/lib-httpd/apply-one-time-sed.sh
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

-- 
2.18.0.399.gad0ab374a1-goog

