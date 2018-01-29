Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B9B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeA2RLl (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:11:41 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38739 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeA2RLk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:11:40 -0500
Received: by mail-wr0-f181.google.com with SMTP id a1so8059218wri.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=hgb+wPBGNW1yz3OtQeCG4yx6LCzCuHE6pQok50wUPIs=;
        b=LKaCePuokMeZzauJSC6lMzcLrWNz4m2B4j8PuiVjghLEhcupTzpLd0gIh+ATfZ90fV
         xwg++KoBB20INqCX9K+oI1FCIdE0ATsDXSYl+HBTNtC4Sw9FTYABEKklnTeK41zwlQ7j
         vRIYyzd0h4gtFA0nqnfsexY0fZ4FPqbXYsaNcmvn32ZtK1FBOc34KonlmUBzvJgQQRQt
         aTxP6tfsK3dqQuj/tRoOMRNDjzQ1y4gBmevWVf8asZUV/85rmAC0Z4/AWSw5YV8VgMhC
         ir8quZBmdsGge++utJfJIA3QzNNsVPkLFrxXhezWYCsv7XCOPfu2VahgREan6fJRl8Wg
         vY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=hgb+wPBGNW1yz3OtQeCG4yx6LCzCuHE6pQok50wUPIs=;
        b=ri+ZZxeLu8a+++ORnPTprDNF8fywARezvwSf+baAz6FDbxy1WKZaCSM+LrAh8tZQuD
         KhqLMVzNjE17HSu2TSsCEIsY+5Fi1VLxvgGS9PHDcKRc8M+FbPJA4+u2xKsA8d6MJsL1
         idShbCev9gMO7XgSZTlFcSYPb+9oCbnBxmKqeqn37H/Vgsf7RRrZorYwGwqdUWuMP2mc
         UEXlhXxqvpYRX8NubnkaoMJoDwZG7jjLyriZumty+CHf9+QoCURgusfm1JYldmstOVcw
         9iiLu1X8ixKdcrsI0XTZt9VYi7wM56/wbo3GkfgEmUW0Lp9BIZmzxi4FqZqbHvLpZVD6
         oqUQ==
X-Gm-Message-State: AKwxytcJ5ud+V8UFSXpXQIHu9WsBpX5yK36sSkXWo/o7XQxij4ENY4vw
        6Bokl2WFgCeZE8WwjYpOOfw=
X-Google-Smtp-Source: AH8x2253DwhEdr2Hsg1730L5l/RK5pYXdcO04pGcoyVtHcLzdi2+5LcKX+h+B219YrIum2R0Edr3Og==
X-Received: by 10.223.132.67 with SMTP id 61mr3274033wrf.120.1517245899281;
        Mon, 29 Jan 2018 09:11:39 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id x91sm13135300wrb.77.2018.01.29.09.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:11:38 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Rowan Thorpe <rowan@rowanthorpe.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: "git fast-import" crashes parsing output from "fossil export --git"
Date:   Mon, 29 Jan 2018 18:11:27 +0100
Message-Id: <20180129171127.17097-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <CACgDUr6XG+dZ+GJcf9+11Edf=q-=QLSkmgpGf=XmondaLaescA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "git fast-import" fails while trying to import the latest "Fossil"
> fossil-sources (it dog-foods its own source-code). Namely, the below
> pasted commands caused the crash report below them (I've trimmed
> irrelevant noise from the report for brevity). One of the tests
> included in Fossil uses example-files to test its handling of
> filenames with special characters - in this case an embedded newline
> in "abc[NEWLINE]def.txt" - and "git fast-import" causes the second
> part of that filename (post-newline) to spill over as the "command" on
> the next line of its input when transforming the "fossil export"
> output into usable input. Considering git can handle such filenames, I
> guess "git fast-import" not handling them counts as a bug - unless a
> design-decision was made to not be as rigorous for the sake of
> simplicity in the import protocol? Or is "fossil export" perhaps
> outputting the filename incorrectly for the "fast-import" protocol
> (maybe it needs some kind of quoting)?
> 
> * Commands which cause the crash:
> ----8<----
> fossil clone https://www.fossil-scm.org/xfer fossil.fossil
> git init fossil-git
> cd fossil-git
> fossil export --git ../fossil.fossil | git fast-import
> ----8<----
> 
> * The part of "fossil export" output which breaks "git fast-import":
> ----8<----
> ...
> 
> commit refs/heads/test-ticket-d17d6e5b17
> mark :26782
> committer jan.nijtmans <jan.nijtmans> 1353531216 +0000
> data 82
> Just commit some weird filenames, even one with a newline in it, to
> test the code.
> from :26779
> M 100644 :427 :abc
> M 100644 :10049 abc
> def.txt

A path like this must be quoted.  Quoting from 'git fast-import'
manpage:

  A <path> string must use UNIX-style directory separators (forward
  slash /), may contain any byte other than LF, and must not start
  with double quote (").

  A path can use C-style string quoting; this is accepted in all
  cases and mandatory if the filename starts with double quote or
  contains LF. In C-style quoting, the complete name should be
  surrounded with double quotes, and any LF, backslash, or double
  quote characters must be escaped by preceding them with a backslash
  (e.g., "path/with\n, \\ and \" in it").
 
