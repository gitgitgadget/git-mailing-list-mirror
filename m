Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833281F932
	for <e@80x24.org>; Sat, 29 Dec 2018 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeL2VT2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:19:28 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45195 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeL2VT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:19:28 -0500
Received: by mail-vs1-f74.google.com with SMTP id t136so13845865vsc.12
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5LSszmdpEoYgEDqQx+410lbpMzZwyEOnOGNu/fep9Zo=;
        b=RPlBYTfwaJ+CNVlamZTgvfPm61yyn6V2PexJrRgx4RBu5yQ9ZuEtGmzJGBQDmYUaPm
         kb51/tT12B//KLdlkChiRZ3mOKnhuOmjEsA8SHh2+jPyOc/snu7y5J6VFKcvYniKZRX1
         E6QUhrb3W+3WSFBm7iLr1dyU0M035zXJmmAjJ1XuI8+Y67wLHTY6A1Tl8g7rbn/fYJ/4
         6sVvOq77l7lGIgYs03qMMG9YVMw8pGi1o6ekSBrM9ct2N0dX1xQPuuE+tWTYLNVeG69c
         9HoyD8wrK1w0f66P4z7m38D02DWe1jl3RfH+nACw5cXLKaY4qKzCMHvCzQkH5TjvjTi+
         C3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5LSszmdpEoYgEDqQx+410lbpMzZwyEOnOGNu/fep9Zo=;
        b=Mcyj10Ka9uVPeYIu7Qf/OTqPSjRWU+hMbkp2gztqGtFeeNRgwoB9Lom51ncIiGpRI2
         5c6xFK8x9PK6VwEnABLVoRBMXv8nO7qMit7t/PYK38LbB2BDKc7hJ0yK2QkADtsoURD6
         /mLhmNPk1ARFBrMqsoDV4VH+VEqsGczgRjJP6L6JyTodwvmtpOorGvJ6r1CQMgkVbxGL
         4YOrVkuJpzE4eRl9/HRCOaGqbHopzOjmfSU3NsqsJFGbnyxyAnxMRf6ro2DJyQctqRiK
         yOuw0mM3s94GAF/dErScXEhc40qL7B/WT09VCaLM5e+YKUkMifqz2jwO82iF/fdrVI85
         4/rQ==
X-Gm-Message-State: AA+aEWY6iSf+Nht135n7kdeZJnI36Cn3/4F0BBAVI8Qs850MwFcArlJg
        Mz3VWYtJFkR02dqQv4laf0aOIV6/t1i6weuOpnE=
X-Google-Smtp-Source: AFSGD/VUIgjIIMQBCP5EbDrpANMSa1wKiIb5DMfkDt6zzS+s4RcmDa3NetvoADwU4x2seFlPB6Lw+pEQqNxdz4jDhmI=
X-Received: by 2002:a67:7bc3:: with SMTP id w186mr27754012vsc.8.1546118366792;
 Sat, 29 Dec 2018 13:19:26 -0800 (PST)
Date:   Sat, 29 Dec 2018 13:19:13 -0800
In-Reply-To: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
Message-Id: <20181229211915.161686-1-masayasuzuki@google.com>
Mime-Version: 1.0
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v2 0/2] Accept error packets in any context
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible for servers to send an error message back to clients in
an arbitrary situation.

The first patch was originally sent in [1]. This version includes some fix.

The second patch was originally sent in [2]. Later, this was cherry-picked in
[3]. In the discussion in [3], we agreed that this error packet handling should
be done only against the Git pack protocol handling code. With this agreement,
the patch series sent in [3] is abandoned (according to [4]). This is a patch
series based on that agreement on limiting the error packet handling.

[1]: https://public-inbox.org/git/20181227065210.60817-1-masayasuzuki@google.com/
[2]: https://public-inbox.org/git/20181127045301.103807-1-masayasuzuki@google.com/
[3]: https://public-inbox.org/git/df7d3659ae5f11d163f1e992f3b9403be709ddb7.1544572142.git.steadmon@google.com/
[4]: https://public-inbox.org/git/20181213221826.GE37614@google.com/

Masaya Suzuki (2):
  Use packet_reader instead of packet_read_line
  pack-protocol.txt: accept error packets in any context

 Documentation/technical/pack-protocol.txt | 20 +++----
 builtin/archive.c                         | 19 +++----
 builtin/fetch-pack.c                      |  3 +-
 builtin/receive-pack.c                    | 62 +++++++++++----------
 builtin/send-pack.c                       |  3 +-
 connect.c                                 |  3 --
 fetch-pack.c                              | 65 +++++++++++++----------
 pkt-line.c                                |  4 ++
 pkt-line.h                                |  8 ++-
 remote-curl.c                             | 29 ++++++----
 send-pack.c                               | 39 +++++++-------
 serve.c                                   |  5 +-
 t/t5703-upload-pack-ref-in-want.sh        |  4 +-
 transport.c                               |  3 +-
 upload-pack.c                             | 40 +++++++-------
 15 files changed, 174 insertions(+), 133 deletions(-)

-- 
2.20.1.415.g653613c723-goog

