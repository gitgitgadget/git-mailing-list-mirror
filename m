Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5426820282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbdFWTty (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:49:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33132 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754814AbdFWTtx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:49:53 -0400
Received: by mail-qk0-f193.google.com with SMTP id p21so7502256qke.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQlSoVmcaGUm1WV4eBCFuFU7otxs1TNVhdgNDUQkFvA=;
        b=CZ6MjCGxNQn1i/h+RMRmwB/6lNIbU8MtF2YYrnEVakD8qu/TnH2h8Ye7pEoXvjyasc
         4ng37pdM4ChLBdrCRkbet7II34oXBFOLOdeOlxPoZpavfV9JlLwoTDBIpZtzPX72FUfF
         Fui5/GURraWLF2bH2XM/+UTgHn/A4fcGgh5+BSI4pHIswrAS8g7ssjKOFnaDDPTd/SHr
         H1cnoUIfmN+nxIZ0YPQxN2JYujju5lE3RoRcqDJg0/GFxiWOCODTZwYdGvIfX/Ta9KBv
         DVigYuwNuiZH9FN1N0VTsExCJeypcPeAlIY4DGYNDNVxVxSUqglVse3cNCKHeMREH8Jv
         Exqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQlSoVmcaGUm1WV4eBCFuFU7otxs1TNVhdgNDUQkFvA=;
        b=LpydkbB/aFGPXHGhg1Ti0opQyyltc+rYwddmJ82A1BMSYR2Z3RiGZbhpTx8G1YPaCk
         7Wsoaj7MvPfQIrhey66O06FLcgk0n6L3M3A3mwfXj6bWkcEDTwF0evnvp7yV2cRu7iP/
         /xdIyOHWF9/G+DzHZLTKfChshcpdzfHBwdsBTbbSqVE/kswhRw+Z3dXtA4kfcvw7RfNe
         fA2zNzo2SUr6FG+tIRGlI4nNAFbmPbPStcQ1SmI6w4KnI7RFoU4HyXmIsmHtwbasS4Df
         bnjsQpLkchEzw+YiVe02UnM8fGIWMsW59dBiinzRDJGkhmNZGB9/duz5gVYW4CUYqtM1
         yWvw==
X-Gm-Message-State: AKS2vOznFAkL/uklA/z8t+htStXInzj+Woog+WZZyMO1lWP97h3PKT7f
        p6XEMJ+q1O5tpQ==
X-Received: by 10.55.32.133 with SMTP id g127mr10511103qkg.61.1498247392586;
        Fri, 23 Jun 2017 12:49:52 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j75sm1382007qke.34.2017.06.23.12.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 12:49:50 -0700 (PDT)
Subject: Re: [RFC/PATCH v4 09/49] Add initial external odb support
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
 <20170620075523.26961-10-chriscool@tuxfamily.org>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <466bd671-a123-094f-5d99-8da2cf94ab28@gmail.com>
Date:   Fri, 23 Jun 2017 15:49:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170620075523.26961-10-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/20/2017 3:54 AM, Christian Couder wrote:
> From: Jeff King <peff@peff.net>
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

I'd suggest you make the function names consistent with the capabilities 
flags (ie get, put, have) both here in odb_helper.c/h and in 
external_odb.c/h.

> +int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
> +int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
> +			    int fd);
> +
> +#endif /* ODB_HELPER_H */

The following patch fixes a few compiler warnings/errors.


diff --git a/odb-helper.c b/odb-helper.c
index 01cd6a713c..ffbbd2fc87 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -118,7 +118,7 @@ static int check_object_process_error(int err,
                                       unsigned int capability)
  {
         if (!err)
-               return;
+               return 0;

         if (!strcmp(status, "error")) {
                 /* The process signaled a problem with the file. */
@@ -192,7 +192,7 @@ static ssize_t 
read_packetized_plain_object_to_fd(struct odb_helper *o,
         git_SHA1_Init(&hash);

         /* First header.. */
-       hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), 
size) + 1;
+       hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, 
typename(type), size) + 1;
         stream.next_in = (unsigned char *)hdr;
         stream.avail_in = hdrlen;
         while (git_deflate(&stream, 0) == Z_OK)
@@ -253,7 +253,7 @@ static ssize_t 
read_packetized_plain_object_to_fd(struct odb_helper *o,
                 return -1;
         }
         if (total_got != size) {
-               warning("size mismatch from odb helper '%s' for %s (%lu 
!= %lu)",
+               warning("size mismatch from odb helper '%s' for %s (%lu 
!= %"PRIuMAX")",
                         o->name, sha1_to_hex(sha1), total_got, size);
                 return -1;
         }
@@ -587,7 +587,6 @@ static int have_object_process(struct odb_helper *o)
         struct strbuf status = STRBUF_INIT;
         const char *cmd = o->cmd;
         uint64_t start;
-       char *line;
         int packet_len;
         int total_got = 0;

@@ -946,7 +945,7 @@ int odb_helper_for_each_object(struct odb_helper *o,
         return 0;
  }

-int odb_helper_write_plain_object(struct odb_helper *o,
+static int odb_helper_write_plain_object(struct odb_helper *o,
                                   const void *buf, size_t len,
                                   const char *type, unsigned char *sha1)
  {

