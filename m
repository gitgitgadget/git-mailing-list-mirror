Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EC11F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753886AbdLNVpA (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:45:00 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35379 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbdLNVoz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:44:55 -0500
Received: by mail-it0-f68.google.com with SMTP id f143so14506301itb.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kWgA6cD7QhQ2ZyB98I3UBKvVChi5VCxv0GO5rRDM7tw=;
        b=EHL1dPuaqypM8+4TNmteorym232p2uLoVrPNGRs5go4VcURffJEAZ+SB0gK/fHSYpu
         NK2iE6LEabjKpCwy5PQ63XxLwi42E39jebLX571Yx+JIstSmMtdd8gOQP70gLz8C/LqW
         qwfY78BhaahXsQGH5ME5b9iI18L/v7rZ3DVfOKcC7SVB8bcT9nL1uWJ/YvJdIVk9M13j
         LC19fXr2xRwJkv4wrj9d3cJ1ZVufdZ9i9KgvX7/dZijU0AUByuQ5JixtY1dILda0hCTc
         UDgl1PLdGqOzJ06/Z4o7WaME/o0M5QtiTAkCfJn6XRd+LjiHj+nJBlSe0dqR0jcBuX2r
         uO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kWgA6cD7QhQ2ZyB98I3UBKvVChi5VCxv0GO5rRDM7tw=;
        b=hZYq2UnX9rWToQic9Nvq32e/5DHvqulh5SsB9l/xTMHjOQUF2IfKmVB933iP8o8B9E
         EcuuVSIVTroybK3ZxvkR3vEY+dkC4tIEdO4U7hwPkq4IeJvdiNZZkpfVusJO//zSSH2I
         rMjAQiJzDSPeeTQ9W5g5/63tW1zANHxSyrLDLqJVPap9VsjZo2hRJ16T2y0Tcbopmvvn
         AnNwtYoK2M2A9x5MDW9tq9mkkVKcSaIvQTUYRUQi5etncMO8lVbVRM5k8nkWNBAGvaWg
         18cNmM77bJaY7pjftPoHqgeAPkiyFquWX5AlEQp6Z05+e+eMBTg84nW5C/cIMlSaVknq
         SbAA==
X-Gm-Message-State: AKGB3mItW04Ftjr+S8+NonqL7y3mbQuAz8mTqyK+urkABNhgbO9WbJ8u
        HrQpDeynhGnLz4AzKRa5h2fnnneANp4=
X-Google-Smtp-Source: ACJfBosfYcFHkEB0DNTtHdMXI3vB+0SG57s0ykp7/T/Q4Z8F43jSHH6fgWeEXBU+5q84Kpec/p67pQ==
X-Received: by 10.107.24.198 with SMTP id 189mr8964905ioy.213.1513287894018;
        Thu, 14 Dec 2017 13:44:54 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id q82sm3079498itb.7.2017.12.14.13.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Dec 2017 13:44:53 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, spearce@spearce.org
Subject: [PATCH 0/2] More transport API improvements
Date:   Thu, 14 Dec 2017 13:44:43 -0800
Message-Id: <cover.1513287544.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.32.g801bf3c5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that this is built on jt/transport-no-more-rsync.

I have found the transport mechanism relatively complicated, so here is
some more effort in the hope of making it more readily understood.

Patch 1 is probably good to go in as-is.

Patch 2 is a modification of the transport API by making certain
variables in the transport interface struct more private, and might need
more discussion. I also discuss the possible future work that this
modification makes possible.

Jonathan Tan (2):
  clone, fetch: remove redundant transport check
  transport: make transport vtable more private

 builtin/clone.c      |  3 ---
 builtin/fetch.c      |  3 ---
 transport-helper.c   | 23 +++++++++++-------
 transport-internal.h | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 transport.c          | 69 ++++++++++++++++++++++++++++++++--------------------
 transport.h          | 54 ++--------------------------------------
 6 files changed, 120 insertions(+), 93 deletions(-)
 create mode 100644 transport-internal.h

-- 
2.15.1.504.g5279b80103-goog

