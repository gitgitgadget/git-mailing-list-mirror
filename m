Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F270BEC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjIGWUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjIGWUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA41BC6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c73c21113so1302630f8f.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125211; x=1694730011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oshtEUBu3rInF2GXSqCRg3I7HJsAuUIOhRZKp+I1ML0=;
        b=Xj+NzkIXv8p3F0KNjT+UYRCH6oCgZLDLMQfPW1PsebGJQwT3aeioHn3Lwfl7NPcsmk
         KL9LzjHJCzBpBeoRwmEMqlU8HUX5Jj2LTnDZRo1IDu2puZ1AZi/7JSd7NoxOq09QRorw
         Z63DvjLWwKsrKJT1oUFqirWJXxWeDvU1dq4UZEzaUi3bW5M64X7xc8A07oAt96P0mfE0
         sgHAYAJA+VIHDyib8+lHXlxfeolg2QryM9Jx2YTV6MfvRzd8Ri5+QynikC8FdAMI8tmq
         SusWZvt6eMN0hxUe2TXY4oIEbK163juV69Xje8TEC4nXQ0i0FJUP1vOY6E/J4yzXpY/x
         +muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125211; x=1694730011;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oshtEUBu3rInF2GXSqCRg3I7HJsAuUIOhRZKp+I1ML0=;
        b=xAytZHrmqDQNlpuRCPpeZGxiGBK9IEldXVqA00Aw0N/3B5tfzdbWQz7M801cjjtXHj
         23vl189+K8ykWIVAyQWBPF++aHIQylbsBAeQuCdncXQ2ulbpc/hTCsW1YxlXv4oFVcAS
         6iDxtXFWAcvzDSDIzksyY3pzwexwsZ2tOUiYZuFsYe84rrNuTIJHSMFNu1rdu7tBkVxD
         iPuMNacJwvoR+HfHEPXuaiVerG5yR6Wvi4lyrXB4oTz3n3Ec48E6YeafdEcBsG6LTX5x
         pDjXs5gs9weK5R7Xl0pkb14ePg2FzB7RGjW7tgdPD+01S5RN39X7ri61tkVMn1u6chN9
         Z7qw==
X-Gm-Message-State: AOJu0YxbONFWcK6Bnnwp3qQTzqtz/b6XxMXtb69Pejj48s6tIYsqVnk7
        eolxOKZYUruJ1B+WiXvUzoweF8gsTh4=
X-Google-Smtp-Source: AGHT+IFppOd8Q2MO3g22M4vL0gDELTf3j9luMMVLI5xyjV276Kf/ZhvwdCR3x80G9ztQ7zUuR5IDNg==
X-Received: by 2002:a5d:53c7:0:b0:314:420c:5ef7 with SMTP id a7-20020a5d53c7000000b00314420c5ef7mr554336wrw.11.1694125211349;
        Thu, 07 Sep 2023 15:20:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1-20020adff6c1000000b0031ad2663ed0sm429299wrp.66.2023.09.07.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:10 -0700 (PDT)
Message-ID: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:19:56 +0000
Subject: [PATCH v3 00/13] Fixes to trailer test script, help text, and documentation
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


Updates in v3
=============

 * Fix t0450 failure due to mismatch between the updated documentation which
   uses " or " and the help text of the interpret-trailers command.


Updates in v2
=============

 * Many additional patches to fix the help text and docs. No changes to any
   of the patches touching the actual tests (that is, Patch 1 and 3 have
   stayed the same, other than a rewording of the commit message for Patch
   1).
 * Of these new patches, I think the last one (about <keyAlias>) is the most
   important as it resolves a longtime ambiguity about what a <token> can
   be.

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
 builtin/interpret-trailers.c             |  12 +-
 t/t7513-interpret-trailers.sh            | 506 +++++++++++++++++++----
 3 files changed, 545 insertions(+), 156 deletions(-)


base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1564%2Flistx%2Ftrailer-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1564/listx/trailer-fixes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1564

Range-diff vs v2:

  1:  1623dd000dd =  1:  1623dd000dd trailer tests: make test cases self-contained
  2:  f680e76de84 =  2:  f680e76de84 trailer test description: this tests --where=after, not --where=before
  3:  4b5c458ef43 =  3:  4b5c458ef43 trailer: add tests to check defaulting behavior with --no-* flags
  4:  0df12c5c2dd =  4:  0df12c5c2dd trailer doc: narrow down scope of --where and related flags
  5:  040766861e2 =  5:  040766861e2 trailer: trailer location is a place, not an action
  6:  3e58b6f5ea2 =  6:  3e58b6f5ea2 trailer --no-divider help: describe usual "---" meaning
  7:  d1780a0127a =  7:  d1780a0127a trailer --parse help: expose aliased options
  8:  5cfff52da8f =  8:  5cfff52da8f trailer --only-input: prefer "configuration variables" over "rules"
  9:  ef6b77016cd =  9:  ef6b77016cd trailer --parse docs: add explanation for its usefulness
 10:  a08d78618ba = 10:  a08d78618ba trailer --unfold help: prefer "reformat" over "join"
 11:  4db823ac354 = 11:  4db823ac354 trailer doc: emphasize the effect of configuration variables
 12:  66087eaf5bd = 12:  66087eaf5bd trailer doc: separator within key suppresses default separator
 13:  7b66cf29d29 ! 13:  0b9525db5a0 trailer doc: <token> is a <key> or <keyAlias>, not both
     @@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
       
       EXAMPLES
       --------
     +
     + ## builtin/interpret-trailers.c ##
     +@@
     + 
     + static const char * const git_interpret_trailers_usage[] = {
     + 	N_("git interpret-trailers [--in-place] [--trim-empty]\n"
     +-	   "                       [(--trailer <token>[(=|:)<value>])...]\n"
     ++	   "                       [(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]\n"
     + 	   "                       [--parse] [<file>...]"),
     + 	NULL
     + };

-- 
gitgitgadget
