Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C4C77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjESESK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjESER6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:17:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE9A189
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30781184e78so231049f8f.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469876; x=1687061876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPvMqQ5zM1mmGlcpjFRZ1myV4Z5TAfG6l5tPCiA6izI=;
        b=BkQ2A8DsjGJOmjFxqzyqjlwXU7lrleUfVRgHctAoQj0G6njGOsW/DKjFMNhUosJZNF
         2CcVFQFp+SqiL6UDkxQzVAPLsZH5hub2KAncJrlUGAnuQaN5VC+EwdwcAtC3hIUSStka
         MWhqYAfWuOG4gWbJuKJ8n769n+iOC4EM3ZjhmTOkOWabcIsAF6tAaNzCxlFliibetunu
         VUp9AT6fwqs26IuJLSn+X/gzOuRHGFgjrqHw1ZD2Cz238cQrWz2u/BFb8n1CUxQUF/wY
         I7etW6eENZW2XYy9ltt3j4Tz/1o92PX5Fm7WkyIR3AetLe4Pcic5fO9P4u3CnE93RfI+
         SzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469876; x=1687061876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPvMqQ5zM1mmGlcpjFRZ1myV4Z5TAfG6l5tPCiA6izI=;
        b=YYw3vOIwHWnLYwu4z2+uoVJnSZuUVOIBKyaOJnD9uoDaAU8b9gmovV7WIYqWfGGKy1
         ZbEPcvaPlv/+4R7ysMIyeisqRywKove+TXqvDGeeRxuf9+zuDIMqph8UyEgAtLam2JPH
         Wljd9uA3c4oOLpZkC8GvCyYQatxJCP5RG1hfz1k1FduBFQuwf5WHZjW3KxUVO9up2rjG
         SzwSVdlvwNDolShT8HTwBtXD55YPNICVUfAeseLj503b22hnIENXaTwyl5dJum9T/D/a
         S02FnH0Ty5DdCW3e1pVHa5LF3dEl5QWmoFt2N7DkcyHTLvIGf+oKfrQC3RTKtgRFP1Ra
         qXLg==
X-Gm-Message-State: AC+VfDxFQOpvRgMWjAR1JKcDWKxHDplfB2IdD4zyVnvKffxsW3ueJxkZ
        AnH0OXPPUhrY6fEQGH/sej9boQ8WrVs=
X-Google-Smtp-Source: ACHHUZ4YPRFZ7tSRLlf58/rxVlWSc5O1ZpyWlUoIYTDEZZAyAqqjmdxOSKnQWipBLfeB6RF+DdJbJA==
X-Received: by 2002:adf:e909:0:b0:2fb:539c:5e89 with SMTP id f9-20020adfe909000000b002fb539c5e89mr636740wrm.4.1684469875718;
        Thu, 18 May 2023 21:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020adfe503000000b003062675d4c9sm3971405wrm.39.2023.05.18.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:55 -0700 (PDT)
Message-Id: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:48 +0000
Subject: [PATCH v4 0/6] Document the output format of ls-remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This iteration incorporates the feedback from v3. A capitalization
inconsistency was fixed and the 'peeled tag' / ^{} discussion in
git-ls-remote.txt was clarified.

Junio C Hamano (1):
  show-branch doc: say <ref>, not <reference>

Sean Allred (5):
  show-ref doc: update for internal consistency
  ls-remote doc: remove redundant --tags example
  ls-remote doc: show peeled tags in examples
  ls-remote doc: explain what each example does
  ls-remote doc: document the output format

 Documentation/git-ls-remote.txt   | 48 +++++++++++++++++++++++--------
 Documentation/git-show-branch.txt | 16 +++++------
 Documentation/git-show-ref.txt    | 40 +++++++++++++++++---------
 3 files changed, 70 insertions(+), 34 deletions(-)


base-commit: 950264636c68591989456e3ba0a5442f93152c1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1471%2Fvermiculus%2Fsa%2Fdoc-ls-remote-output-format-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1471/vermiculus/sa/doc-ls-remote-output-format-v4
Pull-Request: https://github.com/git/git/pull/1471

Range-diff vs v3:

 1:  fe442c2041b ! 1:  49382e81e02 show-ref doc: update for internal consistency
     @@ Commit message
      
          - Use inline-code syntax for options where appropriate.
          - Use code blocks to clarify output format.
     -
     -    This patch also swaps out 'SHA-1' language for the implementation-
     -    agnostic 'OID' term where appropriate in preparation for supporting
     -    different hashing algorithms.
     +    - Use 'OID' (for 'object ID') instead of 'SHA-1' as we support
     +      different hashing algorithms these days.
      
          Signed-off-by: Sean Allred <allred.sean@gmail.com>
      
     @@ Documentation/git-show-ref.txt: $ git show-ref --head --dereference
      +When using `--hash` (and not `--dereference`), the output is in the format:
      +
      +------------
     -+<OID> LF
     ++<oid> LF
      +------------
      +
      +For example,
 2:  cd51a70f3ff = 2:  ea10e7964a9 show-branch doc: say <ref>, not <reference>
 3:  8b644fb1203 = 3:  cdd933e6fc3 ls-remote doc: remove redundant --tags example
 4:  dc0c5ba1751 = 4:  68c35f605ae ls-remote doc: show peeled tags in examples
 5:  94380984533 = 5:  cfb5dd0e87e ls-remote doc: explain what each example does
 6:  de57b8aa563 ! 6:  115dba15ce0 ls-remote doc: document the output format
     @@ Documentation/git-ls-remote.txt: OPTIONS
      +<oid> TAB <ref> LF
      +------------
      +
     -+When `<ref>` is a tag, it may be followed by `^{}` to show its peeled
     -+representation.
     ++When showing an annotated tag, unless `--refs` is given, two such
     ++lines are shown: one with the refname for the tag itself as `<ref>`,
     ++and another with `<ref>` followed by `^{}`. The `<oid>` on the latter
     ++line shows the name of the object the tag points at.
      +
       EXAMPLES
       --------

-- 
gitgitgadget
