Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFD720706
	for <e@80x24.org>; Tue,  5 Jul 2016 17:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbcGERGX (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 13:06:23 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36334 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbcGERGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 13:06:22 -0400
Received: by mail-lf0-f45.google.com with SMTP id q132so138937624lfe.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 10:06:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fm+hWemOpvFtaOR+8e7MLjK2rbKSEDkBhO0oZ13Sfhc=;
        b=Vx2/qpgSMEA7my7f57uNrdrLC4GDIQJIyLtLQwvAr8Z4sLfSMKjTJ2Rd1XyKA4wF0a
         odCqLHOTBa1WjqxeMr7u1OZeixqPrnRfO8rPo3YL05f2T4U42CQ83guz9knWvTdFNeqZ
         om1t+/aqAjrNWT+Wo2LFGx7evh1551wIuGIHP4ixi6L3cqqquO3Uy9tA/P3T2i3G/RFh
         C86EkK0iyxuSvcr+5M8VibcProuXNwtYToERCa5Z9kzrA+ADz5ZuzX/7uksBWxdyf7OU
         bPsQBKAS0q1Kcu1WYm/qh1SWEklGDmHr1IPeCoFTaqif9h5jrvhtPY8OG8jOLXbjUkyu
         HPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fm+hWemOpvFtaOR+8e7MLjK2rbKSEDkBhO0oZ13Sfhc=;
        b=WYl0VLsnTvObpCgpeyOWX/Pxr8kdGMfwHdvnCAUXXLQxSqfowGL7kkAWm6jUWt/5mv
         Kgiwj64Vr//1z2syWFXjQdmZJpW1UHKU7TgayNBGKUzRUsoI+4kdeRy/yftlQqp76epc
         fJ9RogS/eQeCmb8IDrUeIxeLOtWR3PymjscpiBRbfS72khbD8C5PITsgdagI44Teq2fu
         iAw7Tth+tjulMTIWvCSHFyjR6Z+FXCIcbjTAwfGAnp/X1PqfuVWEzTbBTOVNTlkjx7ap
         3Gr6/+ofhzahN7g2uX2qHGh9Bbx9d54G7aofa7k/ZCDbJC1naNoEUBj8VKFMv2MTLFJJ
         BJUA==
X-Gm-Message-State: ALyK8tKaQTW/MfwGr/r4Dqo5c442mTm8+f4f+7VBBNoguehjqVy2RnOo3w7at2ATJJPgTA==
X-Received: by 10.46.5.138 with SMTP id 132mr4628473ljf.9.1467738380595;
        Tue, 05 Jul 2016 10:06:20 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 142sm5693793ljj.4.2016.07.05.10.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 10:06:19 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
Date:	Tue,  5 Jul 2016 19:05:53 +0200
Message-Id: <20160705170558.10906-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <1466807902.28869.8.camel@gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since I now could reproduce the problem that Christoph showed, I
decided to send the good patches out. To sum up, we use "unsigned
long" in some places related to file size. On 32-bit systems, it's
limited to 32 bits even though the system can handle files larger than
that (off_t is 64-bit). This fixes it.

clang -Wshorten-64-to-32 is very helpful to spot these problems. I
have a couple more patches to clean all these warnings, but some need
more code study to see what is the right way to do.

Most of the rest seems harmless, except for the local variable "size"
in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.

Nguyễn Thái Ngọc Duy (5):
  pack-objects: pass length to check_pack_crc() without truncation
  sha1_file.c: use type off_t* for object_info->disk_sizep
  index-pack: correct "len" type in unpack_data()
  index-pack: report correct bad object offsets even if they are large
  index-pack: correct "offset" type in unpack_entry_data()

 builtin/cat-file.c     |  4 ++--
 builtin/index-pack.c   | 23 ++++++++++++-----------
 builtin/pack-objects.c |  2 +-
 cache.h                |  2 +-
 sha1_file.c            |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.8.2.537.g0965dd9

