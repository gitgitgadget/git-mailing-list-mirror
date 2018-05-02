Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A24721847
	for <e@80x24.org>; Wed,  2 May 2018 00:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeEBAbj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:31:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39992 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeEBAbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:31:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id f189so10248814pfa.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYX1ee9tG+4S/ls5bUU3emytJzVhTRRFNmqp1iA2LHY=;
        b=ceMEl8CgHEx+lfVlh2VKbFH+Zq8j1cmDuFnnj0RtT5M+66+h7STEFzseHu49nH2vsH
         WutNQ0h1UL6bKPvBctwJ7SmIozcA/2hH5koLOO2Elz/4MTvmj8fA0VyRS1eQ9cMBe0v4
         bcCsQIYIIkrJdDU8tl+ddUDwfT+TYju50l9Qw+E07eC+X3DTIzeGtDsDDNXZpWKK3pcf
         RvqZAg8buBFTQL8nmPj+CoLaqYBbdO7Z5QxpnGuHwPBVy1Zn8d4AoOMw4nfUNi293vbZ
         vzKCskHHHS7ZwswSs1TE1X4eODv4pX1JuEFXXDgTOn7EeELCgWpT1g5JqOVQ0WjZBoKO
         FNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYX1ee9tG+4S/ls5bUU3emytJzVhTRRFNmqp1iA2LHY=;
        b=Ht3lLZ5nA3JAk9Uj7LtO3f6hmBAlH2shWIXVSgBTNJQ1Ju9kWw7hZ+jZ7r/5tRTsYH
         CANIa6eOTI3CnFrT75d4cfeiChjomJj2CeIGycfRO6wECVSvNa4InjwRi8qqnCuCaq+M
         OsjczhxFTGn43NtFZWuezSjtkKl1IDUNMgZnwHeRLJkKvrvqruCwp+APKx4IXPxRu8Z8
         tU1u8EAn0soyK/qSRI6ne3q8bAhbeL5oA8QsrBj0wCe6wxgvYl6jsE8cXcR4W7Dc5uxq
         1QeIz30alJYDxxek5b9FwwDlsRmWNGRCrZ0u6FN+qkgeWMUAH/xHQ9ycp6tqyLmotWf7
         2PTQ==
X-Gm-Message-State: ALQs6tACjxgxHz172pSF+Y+I75ONS+p4TuFiUVhVfIgTuyBpakCogkp7
        1vH90ddii38PMvyF8jXpthk9ytWi6p0=
X-Google-Smtp-Source: AB8JxZqH49fRPyc8vhR0YcG/AMRq3n/izHbsMigJWV2cS1DExdN9Rez6C5QUz2ABYwFecIiAUgmmRw==
X-Received: by 2002:a17:902:887:: with SMTP id 7-v6mr18477694pll.319.1525221097415;
        Tue, 01 May 2018 17:31:37 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s6-v6sm6306585pgq.19.2018.05.01.17.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 17:31:36 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH v2 0/3] Supporting partial clones in protocol v2
Date:   Tue,  1 May 2018 17:31:28 -0700
Message-Id: <cover.1525220786.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is a bit difficult to read and there is no reason why we would need
> to read the entire upload_pack_config to determine if we need to filter
> things (we will need to read the config if cmd "fetch" is requested
> though).  Instead it may be better to do the following:
> 
>   if (value) {
>     strbuf_addstr(value, "shallow");
>     if (repo_config_get(r, "uplaodpack.filter"))
>       strbuf_addstr(value, " filter");
>   }
> 
> This way its easier to read and you only are reading the required value
> from the config.

Thanks, Brandon. I went ahead and used repo_config_get_bool(), and
indeed it works.

Removing the call to git_config() from there exposed another issue in
that configs were not read if upload-pack was used with protocol v2, so
I inserted a patch in the middle addressing that. While writing that
patch, I noticed that uploadpack.packobjectshook couldn't take filenames
with spaces, which I think is due to prepare_shell_cmd() in
run-command.c not quoting properly. Adding single quotes around "%s"
worked, but made other tests fail. Instead of continuing down that
rabbit hole, I just made the uploadpack.packobjectshook not have any
spaces, just like in t5544.

Jonathan Tan (3):
  upload-pack: fix error message typo
  upload-pack: read config when serving protocol v2
  {fetch,upload}-pack: support filter in protocol v2

 Documentation/technical/protocol-v2.txt |   9 ++
 fetch-pack.c                            |  23 ++++-
 t/t5701-git-serve.sh                    |  14 +++
 t/t5702-protocol-v2.sh                  | 112 ++++++++++++++++++++++++
 upload-pack.c                           |  19 +++-
 5 files changed, 171 insertions(+), 6 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

