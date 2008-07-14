Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 4616 invoked by uid 111); 14 Jul 2008 02:08:00 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 13 Jul 2008 22:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbYGNCHt (ORCPT <rfc822;peff@peff.net>);
	Sun, 13 Jul 2008 22:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbYGNCHt
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:07:49 -0400
Received: from george.spearce.org ([209.20.77.23]:36296 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbYGNCHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:07:48 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F026C3835B; Mon, 14 Jul 2008 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6E55A3835B;
	Mon, 14 Jul 2008 02:07:47 +0000 (UTC)
From:	"Shawn O. Pearce" <spearce@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
Subject: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date:	Sun, 13 Jul 2008 22:07:43 -0400
Message-Id: <1216001267-33235-1-git-send-email-spearce@spearce.org>
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <20080713011512.GB31050@spearce.org>
References: <20080713011512.GB31050@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4

This should resolve the obscene memory usage of index-pack when
resolving deltas for very large files.

Shawn O. Pearce (4):
  index-pack: Refactor base arguments of resolve_delta into a struct
  index-pack: Chain the struct base_data on the stack for traversal
  index-pack: Track the object_entry that creates each base_data
  index-pack: Honor core.deltaBaseCacheLimit when resolving deltas

 index-pack.c |  137 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 108 insertions(+), 29 deletions(-)

