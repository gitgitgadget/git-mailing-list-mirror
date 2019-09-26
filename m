Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28B21F464
	for <e@80x24.org>; Thu, 26 Sep 2019 00:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfIZAdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 20:33:07 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42482 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfIZAdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:06 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so250744pgv.9
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ia7Ew7UqskrWVO4L1JtFW7BtVlvhW5GKyFs1jDMo5yw=;
        b=sqwQcAmlFmk/x3uRCXZz4B+u7VDEWzWNetij+JclkWcvwLAOSpY2beAXUm4KypQtYh
         cqOP84B5Gt/O4yB07nqnhEMxAxrRp2mhrKDi5yq7nMGvSFOSUzE12UPPGFs9r8kGnlhq
         v6PgMuD6YFNwCTmrNorv2kpy0TVrXyvlNcQ5NpI8p5wFiDquHsF9VaLY7cYw2j2+h6Bj
         zeGPs5vvIj7rdWaf0A3jq5re4hPxx33xCvmM7NUcC/MXc3MpOMKUdY2y1xteTHOLUu7+
         Esajr0tD5b2JK1IbZCSWOBYEcpHQ5hnG47rpVsJRrcF8HyOe+13C44od4Bg0UaMKlUsi
         Bbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ia7Ew7UqskrWVO4L1JtFW7BtVlvhW5GKyFs1jDMo5yw=;
        b=S1gPhPNaEtkYjtjUp403ROgvbTdI5L3bfSRUpY+T9UatklJPYXSCt5Q2jE68N94L/T
         YRUOzRQZ0cKQECLp67lQSeFLMsO/1oSiNj/pR1Xnnwetco2hy+PDUAoWkSyFQ4H/uE6e
         gpF+QbsBruXXu7IY3z2yS8ykevUiB0S6tbyHCrTiq7UpATTInfcOp6LBxwtAeNCxpu4Y
         +CSjKlgpjRLZKhF/OVI5h3+A96ZNVa1E5f40hgzAgDknjeo6bq0eyBpjXo8HSLmLRjw+
         pny+1ZSioyO5/bELAwMWZl/xsHrtGauKoi6HqLClV5G7XmLfdKrwglQxkp6F7IaJD5+A
         zpDA==
X-Gm-Message-State: APjAAAXXe13dVhx9yXOJSsc9cJJrSl6OfXTcT31dI5y8tZ5OaEnKvOln
        Mk72rT4Q3tWStXleOrKhViMoNnH75YuJj41kZJmirno/Vq9WMk/41Bnafpctw8Gc32xq/xRzYwe
        u8CtgJ6/NdiQUchio/4MtcmylhlLhyqKZMLD+2j8XC+CZAJ15AuGvWbfpn9NMCtFjSAzuWHYLVs
        2B
X-Google-Smtp-Source: APXvYqxvYoKLICgb4hFHZJeIMnVNloKN4g8jSyv9EbEiZNTll7ik7KPTJaR9sOvgOsZvDTvNXNxsrGL86VPYdbnLG7X3
X-Received: by 2002:a63:5005:: with SMTP id e5mr663438pgb.442.1569457985592;
 Wed, 25 Sep 2019 17:33:05 -0700 (PDT)
Date:   Wed, 25 Sep 2019 17:33:00 -0700
Message-Id: <20190926003300.195781-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Common thread pool API in Git?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does anyone have ideas or plans for this? I know that (at least) "grep"
and "index-pack" have their own implementations, and it would be great
to just have one that all code can use.

For those who want to know, this question was motivated by a big delta
tree occurring in [1]. index-pack does parallelize delta resolution, but
it cannot split up trees into threads: each delta base root can go into
its own thread, but when a delta base root is processed, all deltas on
that root (direct or indirect) is processed in the same thread. I took a
look to see if this could be parallelized, but thought that it might be
better to standardize on a thread pool implementation first.

Searching reveals [2], but I don't think it ever made it into Git.

[1] git -c core.deltabasecachelimit=2g clone https://fuchsia.googlesource.com/third_party/vulkan-cts
[2] https://public-inbox.org/git/1440121237-24576-2-git-send-email-sbeller@google.com/
