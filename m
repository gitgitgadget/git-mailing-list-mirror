Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684E11FAE2
	for <e@80x24.org>; Tue, 27 Mar 2018 21:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbeC0VCn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:02:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:49691 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeC0VCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:02:42 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 431633F40B3;
        Tue, 27 Mar 2018 17:02:42 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 98D333F4088;
        Tue, 27 Mar 2018 17:02:41 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        ramsay@ramsayjones.plus.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5] routines to generate JSON data
Date:   Tue, 27 Mar 2018 21:02:32 +0000
Message-Id: <20180327210233.29076-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 5 of my JSON data format routines.

This version address the uint64_t vs intmax_t formatting issues
that were discussed on the mailing list.  I removed the jw_*_int()
and jw_*_uint64() routines and replaced them with a single
jw_*_intmax() routine.

Also added a jw_release() routine similar to strbuf_release()
and fixed the indentation of sub-array when pretty printing is
enabled.

The following PR includes my WIP telemetry changes that build
upon the json-writer routines and demonstrates how they might
be used.  The first commit in this PR is this patch.

     https://github.com/jeffhostetler/git/pull/11


Jeff Hostetler (1):
  json_writer: new routines to create data in JSON format

 Makefile                    |   2 +
 json-writer.c               | 394 ++++++++++++++++++++++++++++++
 json-writer.h               |  91 +++++++
 t/helper/test-json-writer.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 253 ++++++++++++++++++++
 5 files changed, 1312 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

-- 
2.9.3

