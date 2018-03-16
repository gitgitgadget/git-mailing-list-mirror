Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822771F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCPUAh (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:00:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:10317 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbeCPUAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:00:35 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 237693F4084;
        Fri, 16 Mar 2018 15:41:15 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9D9A23F4083;
        Fri, 16 Mar 2018 15:41:14 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/2] routines to generate JSON data
Date:   Fri, 16 Mar 2018 19:40:55 +0000
Message-Id: <20180316194057.77513-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This patch series adds a set of utility routines to compose data in JSON
format into a "struct strbuf".  The resulting string can then be output
by commands wanting to support a JSON output format.

This is a stand alone patch.  Nothing currently uses these routines.  I'm
currently working on a series to log "telemetry" data (as we discussed
briefly during Ævar's "Performance Misc" session [1] in Barcelona last
week).  And I want emit the data in JSON rather than a fixed column/field
format.  The JSON routines here are independent of that, so it made sense
to submit the JSON part by itself.

Back when we added porcelain=v2 format to status, we talked about adding a
JSON format.  I think the routines in this patch would let us easily do
that, if someone were interested.  (Extending status is not on my radar
right now, however.)

Documentation for the new API is given in json-writer.h at the bottom of
the first patch.

I wasn't sure how to unit test the API from a shell script, so I added a
helper command that does most of the work in the second patch.

[1] https://public-inbox.org/git/20180313004940.GG61720@google.com/T/


Jeff Hostetler (2):
  json_writer: new routines to create data in JSON format
  json-writer: unit test

 Makefile                    |   2 +
 json-writer.c               | 224 ++++++++++++++++++++++++++++++++++++++++++++
 json-writer.h               | 120 ++++++++++++++++++++++++
 t/helper/test-json-writer.c | 146 +++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      |  10 ++
 5 files changed, 502 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh

-- 
2.9.3

