Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B17F202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 20:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935392AbdCLUDA (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 16:03:00 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:58141 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935166AbdCLUC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 16:02:58 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 07E0F2003D0
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 21:02:56 +0100 (CET)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: [PATCH] l10n: add framework for localizing the manpages
Date:   Sun, 12 Mar 2017 21:02:47 +0100
Message-Id: <20170312200248.3610-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This is first attempt at starting the internationalisation of the git
man pages. For now, only man pages are generated, only for git-add and
only in french. The chosen tool for this is po4a (PO for anything)
which can ingest asciidoc files and spit po files for each structural
entity. Then from the translated po files, the translated asciidoc
files are merged.

The main advantage of po files over plain translated files is the
ability to track changes in the original version and the fact that
maybe the translators of git can more easily pick up the task with
tools they already know. Po4a is ready for the simple addition of new
languages.

The problem with po4a is that we don't know before hand how many files
are created (it depends on the percentage of translated strings). This
leads to invoke make recursively to have the list of available files
after running po4a to actually process the generated asciidoc files.
