Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA05A1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCZOb6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:31:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:21947 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeCZOb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:31:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C63A73F4014;
        Mon, 26 Mar 2018 10:31:56 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 29FF33F4013;
        Mon, 26 Mar 2018 10:31:56 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        ramsay@ramsayjones.plus.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4] routines to generate JSON data
Date:   Mon, 26 Mar 2018 14:31:35 +0000
Message-Id: <20180326143136.47116-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 4 of my JSON data format routines.

This version adds a "pretty" formatted output.  I consider this to be
mainly for debugging, but worth keeping available in release builds.

I simplified the stack-level tracing as suggested by René Scharfe and
hinted at by Peff.

I converted the _double() routines to take an integer precision rather
than a format specification and build a known-to-be-good format string
to minimize the __attribute__(...) issues raised by René Scharfe.

It fixes the PRIuMAX and "void inline" compiler warnings on OSX that
were reported by Wink Saville and Ramsay Jones.  And resolved the "sparse"
warnings repoted by Ramsay Jones.

And I updated the commit message and header file documnetation to address
the JSON-like (Unicode limitations) mentioned by Jonathan Nieder.

Jeff Hostetler (1):
  json_writer: new routines to create data in JSON format

 Makefile                    |   2 +
 json-writer.c               | 395 +++++++++++++++++++++++++++++
 json-writer.h               |  92 +++++++
 t/helper/test-json-writer.c | 590 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 253 +++++++++++++++++++
 5 files changed, 1332 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

-- 
2.9.3

