Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BE61F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFDR5W (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:57:22 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:51977 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfFDR5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 13:57:21 -0400
Received: by mail-oi1-f201.google.com with SMTP id w5so6680226oig.18
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=vxwWEB0L+2xXcvqv05spbAbEOiHij5fIQP3VRsntF9g=;
        b=VHRxumewFKhw/KN6loDtij/P04SAjHUKC0pln2XxLGOxlO0REJ2IAU5mS1pwchLXfK
         fNTfCKsXCuszcmUR53oBam1MNe7cKbPe+g8RQQdbejGaLLC0RLlRCuF+/2gQWOnI7x88
         U8YoLFXLF5pHAjRsJCedruExyKVU42mKJ0UU+R0PtWGnetce6BGzYMZ7nyRPsIED6uYf
         b+gZyyK/579St481WZ6/hgOa1KgPUL1YLQ34BjyYVO2rc51ZAFik+DW4G8BdpGqbT/ub
         UGzvbLA64qpH2BdQu2Rc9gpn06CPcZ0a1mw/iMNRlb/TC6kCW+dBODtdSzMKXAf15FCB
         B9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=vxwWEB0L+2xXcvqv05spbAbEOiHij5fIQP3VRsntF9g=;
        b=s68ntRMaVt/ahU0tY+dSOxshhouYhfgdcfWT71JOlFgt77Lmndsn3R/YJo8fw5Ayz/
         1zxNGmbhAlTC29H/jtISHTTMJzzixib/NBy8wP2bvGPh4OGSvWGaLXDVRljHhxpRqTAT
         wsGqZ/fMof7d41cBranOrscxHLYUBM7lYeWQQE6VDBWdD2vv9VyWYaw0Gr/jMSIwF5Vl
         7p9wE+k8a8IWC2TKj8CJyD42O3YIK4SaIcB2TUeunZcU5GQAz8Z/WhlwKFDUq0Vptl4b
         12iIJYesX//17VCdRjoAdCsrI+QOcRgMG2XPeLuyHnPGN9ryOW53IirrJFe54qoS9nDc
         RXKQ==
X-Gm-Message-State: APjAAAXzwUuyL7Q/jwXVTt2NcgpRUOPVZdcXbo0n+2mAjJh1wn0DcVi/
        52Mbc5Pb/FzX5/qtwL8R2PsSGCYocyTdX/naZzOsZ67CdDDE5AxpRsj0rqetAn5nFOE7giH4LE+
        QwX5H8R0YJT8hG9kKdQuibBVCwJNSMf/ycFMYXxBKX6vbpz7EYVYSyzftbqE=
X-Google-Smtp-Source: APXvYqxW2cWwggY5TolWoelTCR1WKziUqvlsxvPVl0GoF3Yqw83CTR3RDo3bgQGHDLl80l1ISYKHjCDDzy3H
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr2953210oia.74.1559671040972;
 Tue, 04 Jun 2019 10:57:20 -0700 (PDT)
Date:   Tue,  4 Jun 2019 10:57:03 -0700
Message-Id: <cover.1559670300.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 0/2] Harden url.c URL-decoding logic
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sandals@crustytoothpaste.net,
        jeffhostetler@microsoft.com, l.s.r@web.de, gitster@pobox.com,
        spearce@spearce.org, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This roll-up includes simple but important fixes from Brian Carlson and Ren=
=C3=A9
Scharfe.

 - fix typo of "NUL" in commit heading
 - re-enable %-decoding in non-NULL-terminated strings

Matthew DeVore (2):
  url: do not read past end of buffer
  url: do not allow %00 to represent NUL in URLs

 url.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.21.0

