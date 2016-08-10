Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95951FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933770AbcHJTHe (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:07:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36698 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754AbcHJTHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:07:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so11362354wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:07:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/VWm5LQpkXci9qhqhLv/9Ct6XDMCmgNF/vv1huPHq4=;
        b=avcYo725Vxmwbd23WSFfQex5D1c9suWrxRcQTGwQt5byrO87p18A82ILbCn5okW1km
         vELvjFq+ntBbtyWjHYxFt7h739vCp6vecXkTOeBiwE0GGOCHkaqlfmXNbivlChBfcc1t
         2J0Myetl7CFgwPlpuaLrYuK4z8T1nU2vHNXmRp9ZQ4n3mPtFw8FaVmB6zJTuMNLjwQ0a
         XMW2pAuvSkgNqlaQu93hdb2viLzLPOqbpjIMAv05dYoXwWvqwPFI6x5+8BKtaCoUpr1m
         N/QhFC0DjSji3cNhJJ7cEt5UlK+BHA3ddHhW8G+TW8DlYP0CR7r7sRP0u3fZ2PtHhMnH
         u9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/VWm5LQpkXci9qhqhLv/9Ct6XDMCmgNF/vv1huPHq4=;
        b=CvZK7BONAop07CtQZhEmGoKrD0/zjO89NPS1MYL/+u9O0DbfygbjynvHckmIhkvPZA
         fl4jdetafkZOuH4CyDUhAMKbdgE/h14wheJZN/rabyiB2dg+zLNL/ZzAuMwZDeOXaxrL
         BUwz3Nm+iTvazZm571FEenpVJ+YcKMR+Vrx78rv5tJEpYV73t3ppqmFejCxtX8jjgMUM
         Fv8T3RPVkG2eXPnnOgoITtt5HF2GEm2gpd2jqEQ7cFXZOjYMyz934HNlZnC92Zg1blwK
         UxeyIbxL+HLTLS4OHh9lvTjfmIBCaeu+fqVXaPksJqsneS6bo6MO/FQQi1bsmPANnh1+
         oZGg==
X-Gm-Message-State: AEkoouuI+0APJorBgwYlSy+nU7TrdDJcLFADgqfiu5LaY9yVlnE7nI8YB/lH9OSWpFVZIA==
X-Received: by 10.194.87.101 with SMTP id w5mr4636933wjz.94.1470834254424;
        Wed, 10 Aug 2016 06:04:14 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:13 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 00/15] Git filter protocol
Date:	Wed, 10 Aug 2016 15:03:56 +0200
Message-Id: <20160810130411.12419-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com/>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi all,

## Notable changes since v4
* drop the shutdown capability
* add error-all response to signal that the filter does not want to filter anymore
* extend init sequence to negotiate version number and capabilities
  (plus detect wrongly configured version 1 filters)
* improve status response format according to Peff's suggestions
* fix Git for Window support


## Patches
* 01-09: Make pktline ready to be used for filters.
* 01 - @Junio: I know you told me twice that you don't like this patch but
               please look closely: the patch does not add a new interface to
               pktline. It is a private functions used 03.
* 08 - This patch changes the pktline interface as it renames packet_write() to
       packet_write_fmt() as suggested by Junio.
       (This patch is not required for the the series and could be dropped)
* 10-13: Prepare convert code.
*    14: Main contribution.
*    15: Proposed fix to make the long running filters work on Windows. See
         the discussion here:
         https://github.com/git-for-windows/git/issues/770#issuecomment-238361829
         (This patch is not required in Git core and could be dropped)


## Jakub
* http://public-inbox.org/git/607c07fe-5b6f-fd67-13e1-705020c267ee%40gmail.com/
  * make Git start the handshake with the filter to detect one-shot filter
    mis configured as process-filter
  * filter driver refusing to filter further

* http://public-inbox.org/git/e8b550ed-1765-764f-49e5-72e5a609d936%40gmail.com/
  * improve commit messages

* http://public-inbox.org/git/0b7d7d96-dfdc-54a4-2c24-2aead6743ae1%40gmail.com/
  * handle sigpipe correctly
  * use cp instead of cat where appropriate
  * explicitly name the test with a binary file (containing \0)


## Junio
* http://public-inbox.org/git/xmqq8twd8uld.fsf%40gitster.mtv.corp.google.com/
  * shorten variable names
  * do not initialize statics explicitly to 0
  * no // comments
  * replace "ret" with "!error"

* http://public-inbox.org/git/CAPc5daV3Tke4qHjtpri%3D6QCRaOax_K3uYhpFzRcd271%3DGHj1%2BQ%40mail.gmail.com/
  * rename packet_write() to packet_write_fmt()


## Peff
* http://public-inbox.org/git/20160803224619.bwtbvmslhuicx2qi%40sigill.intra.peff.net/
  * change capabilities format

* http://public-inbox.org/git/20160808150255.2otm3z5fluimpiqw%40sigill.intra.peff.net/
  * change status response format


## Eric
* http://public-inbox.org/git/20160805185559.GB463%40starla/
  * die if larger-than-4GB files are processed on 32-bit


Thanks a lot for the valuable reviews!

Best,
Lars

You can find a branch with the source on GitHub here:
https://github.com/larsxschneider/git/tree/protocol-filter/v5

I also rebased the series on top of the latest Git for Windows master:
https://github.com/larsxschneider/git/tree/protocol-filter/v5-win


Lars Schneider (15):
  pkt-line: extract set_packet_header()
  pkt-line: call packet_trace() only if a packet is actually send
  pkt-line: add `gentle` parameter to format_packet()
  pkt-line: add packet_write_gently()
  pkt-line: add packet_write_gently_fmt()
  pkt-line: add packet_flush_gently()
  pkt-line: add functions to read/write flush terminated packet streams
  pkt-line: rename packet_write() to packet_write_fmt()
  pack-protocol: fix maximum pkt-line size
  convert: quote filter names in error messages
  convert: modernize tests
  convert: generate large test files only once
  convert: make apply_filter() adhere to standard Git error handling
  convert: add filter.<driver>.process option
  read-cache: make sure file handles are not inherited by child
    processes

 Documentation/gitattributes.txt             | 139 +++++++-
 Documentation/technical/protocol-common.txt |   6 +-
 builtin/archive.c                           |   4 +-
 builtin/receive-pack.c                      |   4 +-
 builtin/remote-ext.c                        |   4 +-
 builtin/upload-archive.c                    |   4 +-
 connect.c                                   |   2 +-
 convert.c                                   | 367 ++++++++++++++++++---
 daemon.c                                    |   2 +-
 http-backend.c                              |   2 +-
 pkt-line.c                                  | 155 ++++++++-
 pkt-line.h                                  |  12 +-
 read-cache.c                                |   2 +-
 shallow.c                                   |   2 +-
 t/t0021-conversion.sh                       | 482 +++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                     | 176 ++++++++++
 unpack-trees.c                              |   1 +
 upload-pack.c                               |  30 +-
 18 files changed, 1267 insertions(+), 127 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

--
2.9.2

