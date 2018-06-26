Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C3D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeFZUzi (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:55:38 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:38573 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754926AbeFZUyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:54:43 -0400
Received: by mail-vk0-f74.google.com with SMTP id o142-v6so8003926vke.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=z91fIB9SOKr8IQ9jJqzlGnRDMz76tlFjIctPwh31YoM=;
        b=hDxLl74WO/kKTMCtadyLSeBSkTrlzEcVN2kGfgtErbchaXSwOMuaFyBNzfd5P3Hn5c
         gSZ+WGyVnGf+XFNQ+ilBUXZ5F2kZqMGF6G9rye2y9yyZwKSEUC4r7HN/x63vh9PEqRQY
         XF+WKa1CD7oc7J+Qfa7HirFB4X6jp2retsczXWzDYDMNB05AfX+hfKGk36odExcW+T/n
         mEktDQznLTCzvf9Xci6B9DaFY6zIih/42aDTrr06Bzkn0AUeIC7Eo1nHl9e0Fe2Jz1kY
         lhDyHq1OdX8bJlJuenMZvSwJ932oyQZxVGOIXobzYS2DyvOoC9iTJ+DOg4o4snrc7Guh
         4XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=z91fIB9SOKr8IQ9jJqzlGnRDMz76tlFjIctPwh31YoM=;
        b=khfu3VJkYw33IBS29OvBFfdqKCivKn9+fdp9UNp9Qh8EqiZDnxnnEsBtaysHAd/nLs
         LTG5wXPNdQ+t7kyZ3UH3aWUzrPaPF04t4xvi5AuRwdvgAgpUoFmmki8Aw8Tp839nSsRX
         cPqsF7Wp3FsAajCYg/Ozfan1zF6rX8OTbHH9RWFlFPV5dshKHKMZeYpaob9zke56qZUa
         feWxo3x+m2D41f4Gw9pwzw/l8WSf9APkbOHfBTHMFcuz/BwJh4QWxZo9NDUp6kySjRIi
         Iap5wdR+JeUsZk7LK86jeM/pCWN3xMStVNEIfTGagNhCsNsMdTKScCE2uyv+0mDLporu
         rl6A==
X-Gm-Message-State: APt69E28l1R4oSMbCQgvT0ABVDIo+ea7Le1qfRzX+Av2VKb6654/NRmt
        zeymwIcRpj7ZE+CY3GY2H6XBktToyvOZa4iHjAYsyR9hWZlTHgZi++g/wYsnOywgF9e20Eb7AsB
        jn9S0AGBiAeVujTRUoybKFnI8Iz0VGR0tAY4Mr+DXbdUzC70jy+x41+XJzw==
X-Google-Smtp-Source: AAOMgpc07P3tE9CUwhICCkJHh9CJPatPIKXxhIB20ALC1MQEoqdfVxN57pN86bv2xNPL7unkVpm2xEXTa5Y=
MIME-Version: 1.0
X-Received: by 2002:ab0:185c:: with SMTP id j28-v6mr1262824uag.89.1530046482216;
 Tue, 26 Jun 2018 13:54:42 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:30 -0700
In-Reply-To: <20180625185332.164142-1-bmwill@google.com>
Message-Id: <20180626205438.110764-1-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 0/8] ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v5:
* Added a comment explaining the one-time-sed.sh script
* Added a number of tests per reviewer feedback
* Fixed a typo in documentation

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
 Documentation/technical/protocol-v2.txt |  29 +-
 builtin/clone.c                         |   4 +-
 builtin/fetch.c                         | 135 +++++----
 fetch-object.c                          |   2 +-
 fetch-pack.c                            |  50 +++-
 remote.c                                |   1 +
 remote.h                                |   1 +
 t/helper/test-pkt-line.c                |  33 +++
 t/lib-httpd.sh                          |   1 +
 t/lib-httpd/apache.conf                 |   8 +
 t/lib-httpd/one-time-sed.sh             |  22 ++
 t/t5703-upload-pack-ref-in-want.sh      | 351 ++++++++++++++++++++++++
 transport-helper.c                      |   6 +-
 transport-internal.h                    |   9 +-
 transport.c                             |  34 ++-
 transport.h                             |   3 +-
 upload-pack.c                           |  66 +++++
 18 files changed, 687 insertions(+), 75 deletions(-)
 create mode 100644 t/lib-httpd/one-time-sed.sh
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

-- 
2.18.0.rc2.346.g013aa6912e-goog

