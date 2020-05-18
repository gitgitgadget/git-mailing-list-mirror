Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DEC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3014E20657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmvThY+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgERPrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERPrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7CC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c24so8444556qtw.7
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FE3LCiD842PT20eGuLantfoOVqLF2szZEn93imxKVl8=;
        b=qmvThY+eSN96py+X419KFjNHC0Tr//NTYGpiqPThY0hzW241yIrTCnEGRtsBmyVKai
         vsAJtGrvE2J+TQ0ZQc3m1x/23To6j47/bGJkAhDPdOT0bGkjrsnlpylsWQ1fp+6t4fkj
         hPtgxWQroowf8mt9drR1rJixvQfn7wnfQd0Bc7ItxbBvh+rLF9oacp25ZCsGZ0etTWZ6
         V9AvVxtLDYHZMdcaGN3jANlJhEzD/bg87pYraSZFkTDy0qqcXs1vtc462Yvr/ZfsYvDd
         QhYeeH5wftDijdKLxviKbiHcNUDLNYbTUlP6cm6+IebPLU17c5l3Mi+7ErY2IvH8McoQ
         URWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FE3LCiD842PT20eGuLantfoOVqLF2szZEn93imxKVl8=;
        b=Bi7hgo/byO9AinkYkpb7tUWSgzPMQoRaiToxw+4UcZuTeMU6j2gBlswb0bMeTP3t9d
         zoltenqkeuUr7wNWO2raj8myQP6uQFyDa6A/Z7TdFxM54+89+HwyHwdCitQt0YoMJYCw
         Bs6Kf0W9hl05Dz215iBFmOplvHKFZ8cI9pn8zN2uh4VjgT643fbfdiONtgSQMz/IQYd1
         5zDX6nUQ6/wX21tXeOBxWhj2Dn3jS3ygFpRDpsIPMDdwqThSuXEl/dMAULKE3igsP0iF
         nJ4Hc2Vs0mNNOxKmrIK3airT8N8vr3c9onv9lEULjVgoeCuljH6E6bDErA9KZv9SEZPJ
         3FnQ==
X-Gm-Message-State: AOAM532k7OiOPGVXBKnvwX0ZFmEmsyt4bJSW1wlaCLhQYfRLndzkaxtK
        xrXmiHNIzQROMzL9dbPeDNSWYKH5
X-Google-Smtp-Source: ABdhPJzMTD+YzsnSdToH0LvZ5w6P2kKzNnBIzKEI4B0LFzw4StY4wpqxnYiT1GeNo3Vects5Vdp4Aw==
X-Received: by 2002:ac8:1ab2:: with SMTP id x47mr18022403qtj.159.1589816853879;
        Mon, 18 May 2020 08:47:33 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server disconnects
Date:   Mon, 18 May 2020 11:47:17 -0400
Message-Id: <cover.1589816718.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following command hangs forever:

	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...

This occurs because the --shallow-since arg is incorrect and the server
dies early. However, remote-curl does not realise that the server
errored out and just faithfully forwards the packets to fetch-pack
before waiting on more input from fetch-pack. Meanwhile, fetch-pack
keeps reading as it still expects more input. As a result, the processes
deadlock. Original analysis by Peff:
https://lore.kernel.org/git/20200328154936.GA1217052@coredump.intra.peff.net/

Changes since v1:

* Remove fallthrough in switch in favour of just extracting the common
  call out of the switch in patch 3

* Add more detail in function comment and use `const char linelen[4]` in
  patch 4

* Implement most of Peff's suggestions[0] in patch 5

* Only operate on stateless_connect() in patch 5

* Add tests in patch 5

* Drop "remote-curl: ensure last packet is a flush" in favour of
  "stateless-connect: send response end packet"

[0]: https://lore.kernel.org/git/20200515213844.GD115445@coredump.intra.peff.net/

Denton Liu (7):
  remote-curl: fix typo
  remote-curl: remove label indentation
  transport: extract common fetch_pack() call
  pkt-line: extern packet_length()
  remote-curl: error on incomplete packet
  pkt-line: PACKET_READ_RESPONSE_END
  stateless-connect: send response end packet

 Documentation/gitremote-helpers.txt           |  4 +-
 Documentation/technical/protocol-v2.txt       |  2 +
 builtin/fetch-pack.c                          |  2 +-
 connect.c                                     | 12 +++-
 fetch-pack.c                                  | 12 ++++
 pkt-line.c                                    | 13 +++-
 pkt-line.h                                    | 11 +++
 remote-curl.c                                 | 72 +++++++++++++++++--
 remote.h                                      |  3 +-
 serve.c                                       |  2 +
 t/helper/test-pkt-line.c                      |  4 ++
 t/lib-httpd.sh                                |  2 +
 t/lib-httpd/apache.conf                       |  8 +++
 .../incomplete-body-upload-pack-v2-http.sh    |  3 +
 .../incomplete-length-upload-pack-v2-http.sh  |  3 +
 t/t5702-protocol-v2.sh                        | 47 ++++++++++++
 transport.c                                   | 16 ++---
 17 files changed, 197 insertions(+), 19 deletions(-)
 create mode 100644 t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
 create mode 100644 t/lib-httpd/incomplete-length-upload-pack-v2-http.sh

Range-diff against v1:
1:  b390875f87 = 1:  b390875f87 remote-curl: fix typo
2:  a2b28c0b28 = 2:  a2b28c0b28 remote-curl: remove label indentation
3:  c89c184100 < -:  ---------- transport: combine common cases with a fallthrough
-:  ---------- > 3:  3a42575bd5 transport: extract common fetch_pack() call
4:  891a39c853 ! 4:  c2b9d033bb pkt-line: extern packet_length()
    @@ Commit message
         need to access the length header. In order to simplify this, extern
         packet_length() so that the logic can be reused.
     
    +    Change the function parameter from a `const char *` to
    +    `const char linelen[4]`. Even though these two types behave identically
    +    as function parameters, use the array notation to semantically indicate
    +    exactly what this function is expecting as an argument.
    +
      ## pkt-line.c ##
     @@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
      	return ret;
      }
      
     -static int packet_length(const char *linelen)
    -+int packet_length(const char *linelen)
    ++int packet_length(const char linelen[4])
      {
      	int val = hex2chr(linelen);
      	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
    @@ pkt-line.h: int write_packetized_from_buf(const char *src_in, size_t len, int fd
      		*buffer, unsigned size, int options);
      
     +/*
    -+ * Reads a packetized line and returns the length header of the packet.
    ++ * Convert a four hex digit packet line length header into its numeric
    ++ * representation. linelen should not be null-terminated.
    ++ *
    ++ * If linelen contains non-hex characters, return -1. Otherwise, return the
    ++ * numeric value of the length header.
     + */
    -+int packet_length(const char *linelen);
    ++int packet_length(const char linelen[4]);
     +
      /*
       * Read a packetized line into a buffer like the 'packet_read()' function but
5:  3ed7cf87aa < -:  ---------- remote-curl: error on incomplete packet
6:  7a689da2bb < -:  ---------- remote-curl: ensure last packet is a flush
-:  ---------- > 5:  52ce5fdffd remote-curl: error on incomplete packet
-:  ---------- > 6:  744b078324 pkt-line: PACKET_READ_RESPONSE_END
-:  ---------- > 7:  4b079bcd83 stateless-connect: send response end packet
-- 
2.26.2.706.g87896c9627

