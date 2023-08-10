Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A8C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjHJVSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHJVSH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573EB2112
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe82a7873fso4548775e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702284; x=1692307084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YZOea5Ep/+30sxrxMJU08Dy0lXBLS68gc5q3O/0cIA=;
        b=gGTt+DLwFepIfuVs74qm2V5vDDg57+Q1NoDXfrToxYe27V1DummmY1tWLWoNqPxISh
         sslv5bL1O9OjggUbz+1ODQN6jDWGR/rq9bnVMy+xt3SkFWJlt03P1LmgVlfZAJ+gjdzI
         T61yY78OtLF1AgZYkvZ4LppCu01SCdUaD5nU/1NMZgc6zHpLMgWfLkVqJh+v+feqRUr9
         4R9sz5jl2BA8vZUg99rhoWvOpALrPqpQ2D3j6VpSIxtPHau42YU0nX8WsoKwkaqOEBNP
         7HAny9xdzZ9B8cEWGTYqphZ3prur0ABb6D6watRC/XvetIVArnYRmKhr2Ff4xzsQAbbD
         Edcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702284; x=1692307084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YZOea5Ep/+30sxrxMJU08Dy0lXBLS68gc5q3O/0cIA=;
        b=lDfIHo08Bb1SdPGEZfv9b77aR59RSWhV2I6dlWHnWScKAMXzaT5UoyGLRRgUzBgEom
         88OZOj5rl2wiUaG5GCUDusWU5Z0n2kOMAFBuqQIIiLrDH270NOlMy0dTj1fUio7lKii2
         jxC2gq+UFeiPkuCXgc1z3p/pt1dgPCX0BEma9+sFkU4Lcn7yyPkE8+Qhb1vJUSPYIh8q
         8PoIIBwCUZfcc9efOHGep3g65M8jr+2B+/fQpx56rjotzOH006jnVoY6c9B6bEX72m88
         Daxk4xRfkXBEykSOWfgCU9MHd56zcx1JVNzymwsRvW+NWbV6/GQkzDwRZ5s8hq5dDz14
         Uy6Q==
X-Gm-Message-State: AOJu0Yx4xfdhPn8ydPhjVRhA33fhD6NcKCkTPj6SZA4JLjJdf6HMeVjs
        0+nAgQpYpn2Im429DMAfwVAr50yvugQ=
X-Google-Smtp-Source: AGHT+IGRKoT18cLnzE+MP+JPWAfH0onvbuzTuPNvEug5TbR0YlC3VcGZ8XpAGjSIbNh88ZyOsdRMRg==
X-Received: by 2002:a1c:7910:0:b0:3fb:e643:1225 with SMTP id l16-20020a1c7910000000b003fbe6431225mr62467wme.13.1691702284357;
        Thu, 10 Aug 2023 14:18:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fa95f328afsm6113856wmr.29.2023.08.10.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:04 -0700 (PDT)
Message-ID: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:50 +0000
Subject: [PATCH v2 00/13] Fixes to trailer test script, help text, and documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series contains various fixes to the trailer code. They pertain to
fixes to the test script, the command line help text for the
interpret-trailers builtin, and the documentation.

Patch 1 is the most important as it does cleanups in the tests where we used
'git config' in a test case without cleaning up that state for the next
test. This makes the tests self-contained, making it easier to add new tests
anywhere along the script, without worrying about previously-set implicit
state. These test cleanups exposed lots of cases where the test cases are
mutating more configuration state than is necessary to test the specific
behavior in the test; however such extraneous configurations were not
cleaned up to make these patches easier to review (again, we are not
changing any behavior and we are also not changing what the test cases
themselves purport to do).

Note that Patch 1 was originally a 22-commit series, but was squashed
together to make it easier to see the final diff for each test case. You can
see the 22-commit breakdown at
https://github.com/listx/git/tree/backup-trailer-22-commit-breakdown

Patch 3 adds some tests to check the behavior of '--no-if-exists' and
'--no-if-missing', which weren't previously tested. It also adds
similarly-themed test cases for '--no-where' which only had 1 test case for
it.

The other patches aren't as important, but are included here because I think
they are too small to include in a separate series.


Updates in v2
=============

 * Many additional patches to fix the help text and docs. No changes to any
   of the patches touching the actual tests (that is, Patch 1 and 3 have
   stayed the same, other than a rewording of the commit message for Patch
   1).
 * Of these new patches, I think the last one () is the most important as it
   resolves a longtime ambiguity about what a can be.

Linus Arver (13):
  trailer tests: make test cases self-contained
  trailer test description: this tests --where=after, not --where=before
  trailer: add tests to check defaulting behavior with --no-* flags
  trailer doc: narrow down scope of --where and related flags
  trailer: trailer location is a place, not an action
  trailer --no-divider help: describe usual "---" meaning
  trailer --parse help: expose aliased options
  trailer --only-input: prefer "configuration variables" over "rules"
  trailer --parse docs: add explanation for its usefulness
  trailer --unfold help: prefer "reformat" over "join"
  trailer doc: emphasize the effect of configuration variables
  trailer doc: separator within key suppresses default separator
  trailer doc: <token> is a <key> or <keyAlias>, not both

 Documentation/git-interpret-trailers.txt | 183 ++++----
 builtin/interpret-trailers.c             |  10 +-
 t/t7513-interpret-trailers.sh            | 506 +++++++++++++++++++----
 3 files changed, 544 insertions(+), 155 deletions(-)


base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1564%2Flistx%2Ftrailer-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1564/listx/trailer-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1564

Range-diff vs v1:

  1:  6d67ae6b1f6 !  1:  1623dd000dd trailer tests: make test cases self-contained
     @@ Commit message
          This commit was created mechanically as follows: we changed the first
          occurrence of a particular "git config trailer.*" option, then ran the
          tests repeatedly to see which ones broke, adding in the extra
     -    "test_config" equivalents to make them pass again. This was done until
     -    there were no more unbridled "git config" invocations. Some "git config"
     -    invocations still do exist in the script, but they were already cleaned
     -    up properly with
     +    "test_config" equivalents to make them pass again. In addition, in some
     +    test cases we removed "git config --unset ..." lines because they were
     +    no longer necessary (as the --unset was being used to clean up leaked
     +    configuration state from earlier test cases).
     +
     +    The process described above was done repeatedly until there were no more
     +    unbridled "git config" invocations. Some "git config" invocations still
     +    do exist in the script, but they were already cleaned up properly with
      
              test_when_finished "git config --remove-section ..."
      
  2:  100a2297fa3 =  2:  f680e76de84 trailer test description: this tests --where=after, not --where=before
  3:  6b427b4b1e8 =  3:  4b5c458ef43 trailer: add tests to check defaulting behavior with --no-* flags
  -:  ----------- >  4:  0df12c5c2dd trailer doc: narrow down scope of --where and related flags
  4:  53adcd9bf14 =  5:  040766861e2 trailer: trailer location is a place, not an action
  5:  68bc89beb2a =  6:  3e58b6f5ea2 trailer --no-divider help: describe usual "---" meaning
  -:  ----------- >  7:  d1780a0127a trailer --parse help: expose aliased options
  -:  ----------- >  8:  5cfff52da8f trailer --only-input: prefer "configuration variables" over "rules"
  -:  ----------- >  9:  ef6b77016cd trailer --parse docs: add explanation for its usefulness
  -:  ----------- > 10:  a08d78618ba trailer --unfold help: prefer "reformat" over "join"
  -:  ----------- > 11:  4db823ac354 trailer doc: emphasize the effect of configuration variables
  -:  ----------- > 12:  66087eaf5bd trailer doc: separator within key suppresses default separator
  -:  ----------- > 13:  7b66cf29d29 trailer doc: <token> is a <key> or <keyAlias>, not both

-- 
gitgitgadget
