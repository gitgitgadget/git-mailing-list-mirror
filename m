Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E915120A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdAWUfj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:39 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34830 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdAWUfi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:38 -0500
Received: by mail-pf0-f174.google.com with SMTP id f144so43740913pfa.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pi0EzFe+DC8nIuP35g4NvQNZrhdlxBls0grGKhYH9hk=;
        b=u1y43OfDkxecsq1h2AipO0Mb5NME+vifAv96LqEb3WKktK1aYYtl37q5qyObpwO48t
         PpPpI2tSI4S7ZSnnEWLldiSbLorBaid+tmzWel6naLdVvQ2SpVtjltZPFaLd4cUwMxVL
         Qjs7TQlm0Uhxn9YSbZLA8FHnNQZZnOMee6yWeUXJdp3Rt6pjnGQ01IAVTs7XyZ/qe0Tl
         gL2Zwu1TNnod87/QkUWaL+K2D7TR4yde96Ppk0ifK87+o8TshSEEcReGxWvUo/iM0aFM
         UgoEbeNcpzABp8/qtgw4tw+gsOsQ3xkoerPU5SfUn/W3FbrwQADSf+j1CiN/w7GQpKNP
         YxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pi0EzFe+DC8nIuP35g4NvQNZrhdlxBls0grGKhYH9hk=;
        b=r0nj8UMgpwQFiR/eDmf7cDTLeAD66waMgcqGILG7Eqmh5JXN99U4SmDHs8mT/hBVkK
         FeN/zULt+sm4ooksdXLvz5AiMjHVqj58Sxi9d1yNLLeaW81uj4Orz7pyWoUnRQpYV392
         flfICSaGjQqmA2YTnv4OZ0TTC2QUw36gtDDTKytHj/3Ju5uqMUwvVerOQ4zMIvoyAhqJ
         mi74bbRnI9OmBlnSmLqOCaToA9nbTB3PAUxVD48dLVsE3oOIgqZvCWvhij98Ch+/2Wbf
         zI2Ctk9+3mRuBX5WC5HW6AkdJHCLx0kOob/uGLXZRqcw2ZsNbhFg2CnP8VXnddGgVV5b
         ZM/w==
X-Gm-Message-State: AIkVDXJWkiCL8w4ypzBiRBrtltTuzsoXuSAWpWQE3vTvkv82Ov+GlevSXIO7l0cCSZWoRezs
X-Received: by 10.98.9.206 with SMTP id 75mr35184183pfj.159.1485203737226;
        Mon, 23 Jan 2017 12:35:37 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:36 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 00/27] Revamp the attribute system; another round
Date:   Mon, 23 Jan 2017 12:34:58 -0800
Message-Id: <20170123203525.185058-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
* surround the mutex initializer calls by #ifdef
* mark file-local symbol static
* handling of attribute stacks.  Instead of storing each stack frame in a
  hashmap, there is a stack per attr_check instance.  This will allow for
  easier optimizing of the stack in future patches as well as eliminates the
  potential for memory to grow unbounded.  This is also more inline with the
  original vision of the attribute system refactor.

Brandon Williams (8):
  attr: pass struct attr_check to collect_some_attrs
  attr: use hashmap for attribute dictionary
  attr: eliminate global check_all_attr array
  attr: remove maybe-real, maybe-macro from git_attr
  attr: tighten const correctness with git_attr and match_attr
  attr: store attribute stack in attr_check structure
  attr: push the bare repo check into read_attr()
  attr: reformat git_attr_set_direction() function

Junio C Hamano (17):
  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()
  attr.c: tighten constness around "git_attr" structure
  attr.c: plug small leak in parse_attr_line()
  attr.c: add push_stack() helper
  attr.c: outline the future plans by heavily commenting
  attr: rename function and struct related to checking attributes
  attr: (re)introduce git_check_attr() and struct attr_check
  attr: convert git_all_attrs() to use "struct attr_check"
  attr: convert git_check_attrs() callers to use the new API
  attr: retire git_check_attrs() API
  attr: change validity check for attribute names to use positive logic

Nguyễn Thái Ngọc Duy (1):
  attr: support quoting pathname patterns in C style

Stefan Beller (1):
  Documentation: fix a typo

 Documentation/gitattributes.txt               |  10 +-
 Documentation/technical/api-gitattributes.txt |  86 ++-
 archive.c                                     |  24 +-
 attr.c                                        | 854 ++++++++++++++++++--------
 attr.h                                        |  53 +-
 builtin/check-attr.c                          |  66 +-
 builtin/pack-objects.c                        |  19 +-
 commit.c                                      |   3 +-
 common-main.c                                 |   3 +
 convert.c                                     |  25 +-
 ll-merge.c                                    |  33 +-
 t/t0003-attributes.sh                         |  26 +
 userdiff.c                                    |  19 +-
 ws.c                                          |  19 +-
 14 files changed, 800 insertions(+), 440 deletions(-)

-- 
2.11.0.483.g087da7b7c-goog

