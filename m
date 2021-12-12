Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E4EC433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhLLTus (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:50:48 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:42626 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLLTuq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:50:46 -0500
Received: by mail-wm1-f47.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so10368656wmd.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCCt74cRMnda5CIeblItW5a5FFx85OaFh2cI9g7HUz0=;
        b=B6hZFwoY42lOVQC0uUpowMVnUUcGaR0jjVJbFyu6qnULAUKuausATfyFN3yswNmEjD
         o+ZNus3XkqtTShgturRTyvGkBdhNhtDVu7gAZGKE+wao3WXwAlNJEF6HDQBoKOQqmKRJ
         mnjiCjarlO7xThxPAzEFZrk4JTAdkS2oK9gyDwcvKv+kIEr823obJniq3cnf9xiT+v3Q
         xwx7JEeoc/ZpUVHT9puP+0Bw2+797IIHuNosYOLQGzIU+I+1AXt5gjT5qkbskhHLQVV1
         8m9qhtkyDQraS7an8c0/r/z/IxtLDZs5LGyYU+2Ykx6a3DavumFcIiWkpjMZv5msh074
         Ak/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCCt74cRMnda5CIeblItW5a5FFx85OaFh2cI9g7HUz0=;
        b=cq3JAyjTAwiTby3AxRoTMl2QyfrhevyGMcPShSjHuiiYMk5CpD+ZAXCnnKhCgNdTv1
         vf6OFlPB5pdrVCp5HT60OuAnlAyxMP19MjauxilZw8Dbtp5b79wwcBVboASHzxjTybLh
         pwx2j/QPuKSt1YJK1H30JkT9z6ONZBKyV0flflikdek9UHRhGdpI3fsfSXWVAkGJdQBa
         YDeqmTJ1AKrMcSqV483igXAfIj1AUVTYoyoQ0qLOCJfOkr84RG5TSEUaCoornzYXMyYy
         iv9urcaN5pe/HZlwQrn9+ALkI1+hf4eb53QRRnij+1YO6YEOV1AmkfpDpalqhfgKWDqY
         +vpQ==
X-Gm-Message-State: AOAM533Orc9kjmfSgQ77ae/qDsM1kxmWFIuDwmM6zpbqUX/8GNXf1VWi
        DC7ADDQApmEJIJJ77j9q2kYnS/XcuWVObw==
X-Google-Smtp-Source: ABdhPJzok3uALMSxiZl38A0wMx0NMGBscaUBdHGZueYDcsv8Uq4ACWtodruxYpToZpm9H9SpPlmOww==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr32824553wmb.114.1639338584752;
        Sun, 12 Dec 2021 11:49:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g4sm8293822wro.12.2021.12.12.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:49:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>, Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] git doc + "git help": move "format" docs from technical/*
Date:   Sun, 12 Dec 2021 20:49:35 +0100
Message-Id: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.929.ge922d848c7a
In-Reply-To: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[This is a more meaty re-roll of [1]. It previously conflicted with
topics that have now landed. There is a trivial conflict here with
tb/cruft-packs, but that one's easily solved (they both edit adjacent
but otherwise unrelated lines in Documentation/Makefile)]

Most of git is documented in its manual pages, but we have various
"technical" and "howto" docs that aren't built as manpages, only as
HTML documentation.

In many cases that's sensible, e.g. we've got one-off mailing list
posts in there, but in the case of documenting git's core file formats
I think these belong in the main documentation space, especially as
many existing manual pages refer to these, but need to do so by
linking from "man" pages to "*.html" files the user may or may not
have locally.

This series starts out by creating a "userformats" category in our
documentation. The documentation for ".gitignore", ".gitattributes",
".mailmap" etc. is currently in the "guides" space. We now have a
"userformats" space with file formats users are expected to interact
with:
    
    $ git help --user-formats
    
    The user-facing file formats are:
       gitattributes          Defining attributes per path
       githooks               Hooks used by Git
       gitignore              Specifies intentionally untracked files to ignore
       gitmailmap             Map author/committer names and/or E-Mail addresses
       gitmodules             Defining submodule properties
       gitrepository-layout   Git Repository Layout

We then have (the main meat of this series) a move of relevant
"internal" and "protocol" formats over to the main documentation
space:

    $ git help --git-formats
    
    Git's internal file and network formats are:
       gitformat-bitmap                  The bitmap file format
       gitformat-bundle                  The bundle file format
       gitformat-chunk                   Chunk-based file formats
       gitformat-commit-graph            Git commit graph format
       gitformat-index                   Git index format
       gitformat-pack-protocol           How packs are transferred over-the-wire
       gitformat-protocol-capabilities   Protocol v0 and v1 capabilities
       gitformat-protocol-common         Things common to various protocols
       gitformat-protocol-v2             Git Wire Protocol, Version 2
       gitformat-signature               Git cryptographic signature formats

This isn't all of them, there's some in-flight conflicts with other
(trivial) changes to those files, so I've skipped them for now. Taylor
also has an in-flight series to add a new Documentation/technical/*
series. I'm planning on an eventual follow-up series (and have most of
the changes already) to move those over.

This also doesn't move over the part of the api-trace2.txt that deals
with the format users interact with, i.e. the JSON schema. I'm
submitting other changes in that are currently, and will eventually
loop around to moving that part over to this new "gitformats" space.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  git docs: split "User-facing file formats" off from "Guides"
  git docs: create a "Git file and wire formats" section
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move {index,signature,bitmap,chunk}-format docs to man section 5

 Documentation/Makefile                        | 19 ++++---
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-bundle.txt                  | 12 +++--
 Documentation/git-commit-graph.txt            |  5 ++
 Documentation/git-help.txt                    | 13 +++--
 Documentation/git-upload-pack.txt             |  5 +-
 Documentation/git.txt                         | 15 ++++++
 ...bitmap-format.txt => gitformat-bitmap.txt} | 38 +++++++++++---
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++---
 .../chunk-format.txt => gitformat-chunk.txt}  | 25 ++++++++--
 ...-format.txt => gitformat-commit-graph.txt} | 49 +++++++++++++------
 .../index-format.txt => gitformat-index.txt}  | 20 +++++++-
 ...otocol.txt => gitformat-pack-protocol.txt} | 22 +++++++--
 ...xt => gitformat-protocol-capabilities.txt} | 28 ++++++++---
 ...mmon.txt => gitformat-protocol-common.txt} | 23 ++++++++-
 ...tocol-v2.txt => gitformat-protocol-v2.txt} | 24 +++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++--
 Documentation/lint-man-section-order.perl     |  3 ++
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 Documentation/technical/http-protocol.txt     |  6 +--
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/pack-format.txt       |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Makefile                                      |  1 +
 builtin/help.c                                | 16 ++++++
 command-list.txt                              | 30 +++++++++---
 help.c                                        | 22 +++++++++
 help.h                                        |  2 +
 t/t0012-help.sh                               | 16 +++++-
 t/t5551-http-fetch-smart.sh                   |  4 +-
 31 files changed, 386 insertions(+), 89 deletions(-)
 rename Documentation/{technical/bitmap-format.txt => gitformat-bitmap.txt} (91%)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (78%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (91%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (86%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/pack-protocol.txt => gitformat-pack-protocol.txt} (98%)
 rename Documentation/{technical/protocol-capabilities.txt => gitformat-protocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitformat-protocol-common.txt} (88%)
 rename Documentation/{technical/protocol-v2.txt => gitformat-protocol-v2.txt} (98%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

Range-diff against v1:
1:  19a8be1fc73 ! 1:  960574b7f05 git(1) docs: split "User-facing file formats" off from "Guides"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git(1) docs: split "User-facing file formats" off from "Guides"
    +    git docs: split "User-facing file formats" off from "Guides"
     
    -    Create a new "User-facing file formats" section in the main "git(1)"
    -    manual page. The "Guides" section was added to the manual page in
    +    Create a new "User-facing file formats" section in the main "git help
    +    git" manual page. The "Guides" section was added to the manual page in
         f442f28a81b (git.txt: add list of guides, 2020-08-05), it makes sense
         to list all that documentation.
     
    @@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
     
      ## Documentation/git-help.txt ##
     @@ Documentation/git-help.txt: SYNOPSIS
    - 	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
    + --------
    + [verse]
    + 'git help' [-a|--all [--[no-]verbose]]
    +-	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
    ++	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>|<doc>]
      'git help' [-g|--guides]
      'git help' [-c|--config]
     +'git help' [--user-formats]
    @@ Documentation/git-help.txt: SYNOPSIS
      DESCRIPTION
      -----------
      
    --With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
    -+With no options and no COMMAND or DOC given, the synopsis of the 'git'
    +-With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
    ++With no options and no '<command>', '<guide>' or '<doc>' given, the synopsis of the 'git'
      command and a list of the most commonly used Git commands are printed
      on the standard output.
      
    @@ command-list.txt
     +# .mailmap etc. files lives in man section 5. These entries can only
     +# have the "userformats" attribute and nothing else.
     +#
    - ### command list (do not change this line, also do not change alignment)
    + ### command list (do not change this line)
      # command name                          category [category] [category]
      git-add                                 mainporcelain           worktree
    -@@ command-list.txt: gitweb                                  ancillaryinterrogators
    +@@ command-list.txt: git-verify-tag                          ancillaryinterrogators
      git-whatchanged                         ancillaryinterrogators          complete
      git-worktree                            mainporcelain
      git-write-tree                          plumbingmanipulators
    @@ command-list.txt: gitdiffcore                             guide
      gitglossary                             guide
     -githooks                                guide
     -gitignore                               guide
    --gitmailmap                              guide
    --gitmodules                              guide
     +githooks                                userformats
     +gitignore                               userformats
    + gitk                                    mainporcelain
    +-gitmailmap                              guide
    +-gitmodules                              guide
     +gitmailmap                              userformats
     +gitmodules                              userformats
      gitnamespaces                           guide
    @@ command-list.txt: gitdiffcore                             guide
     +gitrepository-layout                    userformats
      gitrevisions                            guide
      gitsubmodules                           guide
    - gittutorial-2                           guide
    + gittutorial                             guide
     
      ## help.c ##
     @@ help.c: static struct category_description main_categories[] = {
2:  5e80ee09523 ! 2:  b2d73f8c9da git(1) docs: create a "Git file and wire formats" section
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git(1) docs: create a "Git file and wire formats" section
    +    git docs: create a "Git file and wire formats" section
     
    -    Create a new "Git file and wire formats" section in the main "git(1)"
    -    manual page and start moving the documentation that now lives in
    +    Create a new "Git file and wire formats" section in the main "git help
    +    git" manual page and start moving the documentation that now lives in
         "Documentation/technical/*.git" over to it. This compliments the newly
         added and adjacent "User-facing file formats" section.
     
    @@ Commit message
         So let's start moving those over, starting with just the
         "bundle-format.txt" documentation added in 7378ec90e1c (doc: describe
         Git bundle format, 2020-02-07). We'll now have a new
    -    gitformat-bundle(5) man page.
    +    gitformat-bundle(5) man page. Subsequent commits will move more git
    +    internal format documentation over.
     
         Unfortunately the syntax of the current Documentation/technical/*.txt
         is not the same (when it comes to section headings etc.) as our
    @@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
      
     
      ## Documentation/git-bundle.txt ##
    -@@ Documentation/git-bundle.txt: using "thin packs" bundles created using exclusions are smaller in
    +@@ Documentation/git-bundle.txt: using "thin packs", bundles created using exclusions are smaller in
      size. That they're "thin" under the hood is merely noted here as a
    - curiosity, and as a reference to other documentation
    + curiosity, and as a reference to other documentation.
      
     -See link:technical/bundle-format.html[the `bundle-format`
     -documentation] for more details and the discussion of "thin pack" in
    @@ command-list.txt
     +# *.bundle format lives in mn section 5. These entries can only have
     +# the "gitformats" attribute and nothing else.
     +#
    - ### command list (do not change this line, also do not change alignment)
    + ### command list (do not change this line)
      # command name                          category [category] [category]
      git-add                                 mainporcelain           worktree
    -@@ command-list.txt: githooks                                userformats
    - gitignore                               userformats
    - gitmailmap                              userformats
    - gitmodules                              userformats
    +@@ command-list.txt: gitcvs-migration                        guide
    + gitdiffcore                             guide
    + giteveryday                             guide
    + gitfaq                                  guide
     +gitformat-bundle                        gitformats
    - gitnamespaces                           guide
    - gitremote-helpers                       guide
    - gitrepository-layout                    userformats
    + gitglossary                             guide
    + githooks                                userformats
    + gitignore                               userformats
     
      ## help.c ##
     @@ help.c: static struct category_description main_categories[] = {
-:  ----------- > 3:  5abd59b807f docs: move commit-graph format docs to man section 5
-:  ----------- > 4:  fb91009c18f docs: move protocol-related docs to man section 5
-:  ----------- > 5:  5cb41bb0dcb docs: move {index,signature,bitmap,chunk}-format docs to man section 5
-- 
2.34.1.929.ge922d848c7a

