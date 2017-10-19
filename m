Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039A9202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 12:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbdJSMai (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:52324 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdJSMah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id k62so8144250wrc.9
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sPrKBDUz584r0u4l4gbsd7MYm7otIAxmAUnDzuopssU=;
        b=EroRj7PWHzBbGQZ5MX2sLcmp6aqHpc5VRqiyeIB8XTeGNSayDYwbglVTW5Bm1M1ejX
         l4gPssV+N2Ki3+vt0IZ7ay4Aw+xOPdHsek9dRCrHW8itUsJs+MnQAh/HJ10duR46veYa
         p+tic0U2k9olTFTP8sMPIGajgZWTkcSz74sfcavSwiFHybHqVHqyftYYEzZWMYEryuGU
         6dRBpoCDapyFLoJQWBqLGkiOLGcAHIvSUXwIo5PCOVhwjplHB7tKPcFnt51zUykGykL5
         DDPVBoFJwh5fx1j6Fn1qzx8c6FVFjblfX3xkD42wc1j6v8ipSk0IOmyrhsH2jFN1v/A3
         4xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sPrKBDUz584r0u4l4gbsd7MYm7otIAxmAUnDzuopssU=;
        b=GOCccHgoXN7FpDkwa6k4owmeklk7w/yv2td71KeWheKEsj7UtVN4FCyFE1hawa8JRa
         kj9A5iKN6emU26tj4GF6CP/148CquXUeJN9TugCihY7JVvU4OR8SuSF5n1/H/kaEhjZ8
         QN044F2ick3dJ0foqOKgPj5bQIPzqgbPrbW9Of17fYz71hFZJZXB/D8np4jahLG3YEtS
         KmEhroy6gIuV6B7BuKc8urNByrlVhU2pUrBX5UEg3Gkk+k+qvDgB/PB1R8L5tSwAro+S
         in9noBleI87JPj6pfcHoCqpsujpbi4Bj2MYuTDXC2ReAzvV5/5rM284g+fUVYypNQT3q
         ncog==
X-Gm-Message-State: AMCzsaWXBq+g+UvYhvRJsjn635H+5JV/t0Qjuj6KDPARAQBNDoxqmtrE
        OooDaMhDKmdnmS5qwDU/rAT6Lw==
X-Google-Smtp-Source: ABhQp+QPfTDpkUVNz0LEh6Wnagxr5ZQXZOQ3xCQiz5A6QqIjSPSuTNkxCyw2LjWokHiKFl5iXGPFIQ==
X-Received: by 10.223.146.197 with SMTP id 63mr1396409wrn.180.1508416235504;
        Thu, 19 Oct 2017 05:30:35 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:34 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/6] Create Git/Packet.pm
Date:   Thu, 19 Oct 2017 14:30:24 +0200
Message-Id: <20171019123030.17338-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

Packet related functions in Perl can be useful to write new filters or
to debug or test existing filters. So instead of having them in
t0021/rot13-filter.pl, let's extract them into a new Git/Packet.pm
module.

Links
~~~~~

This patch series has been extracted from previous "Add initial
experimental external ODB support" patch series.

Version 1, 2, 3, 4, 5 and 6 of this previous series are on the mailing
list here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170916080731.13925-1-chriscool@tuxfamily.org/

They are also available in the following branches:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61
https://github.com/chriscool/git/commits/gl-external-odb239
https://github.com/chriscool/git/commits/gl-external-odb373
https://github.com/chriscool/git/commits/gl-external-odb411


Christian Couder (6):
  t0021/rot13-filter: refactor packet reading functions
  t0021/rot13-filter: improve 'if .. elsif .. else' style
  t0021/rot13-filter: improve error message
  t0021/rot13-filter: add packet_initialize()
  t0021/rot13-filter: add capability functions
  Add Git/Packet.pm from parts of t0021/rot13-filter.pl

 perl/Git/Packet.pm      | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl | 110 +++++++++-----------------------------------
 2 files changed, 140 insertions(+), 88 deletions(-)
 create mode 100644 perl/Git/Packet.pm

-- 
2.15.0.rc1.106.g7e97f58a41

