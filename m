Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FEC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhLHMiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLHMiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5A5C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1716554wmb.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/pYJUfyH48fYf9z+DKXa0T9slMGtkiSfQooTHUOglU=;
        b=pMW141rGhGRx1qMAHH0Oc4TX1HFqqbwHXTLvQYbV3lFaKgreVpgTEGlKpEp36uLy0x
         pyU/Uefy74PTQd8dxizxV0JKbiWKB5LdpEaCeD5uN5mwZTTTGsXI64LWubqHonk89mlC
         Lq4/r2IGxD010dDwxLgJFMevMyEy6Y+4coWt/f2SN2AIGnc0Bpu2JHiz5v9dycZyVxsI
         3YerAeFDHt27KYAfrkhWEy+BGK7DWYE/MFvS73ZqqKBNjrUUbzCuz6u7d7B4Cv+Tc6vp
         Em39G6UulxMicgZVa3ZGt6uzmQNrjaz1l+Y7Se0US1a/WYpdO3pcFq0sihuTdflq4wH8
         X/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/pYJUfyH48fYf9z+DKXa0T9slMGtkiSfQooTHUOglU=;
        b=kAUunqxNOuTKVndO/rnQWIzX6i6gb65REr8MTxjRtqT6NE8kpUOu25i3g0v5o8nOzZ
         Mf1FunO7VZkEVc/I3JShnDFTHbFKHOHHvXTWOUaGkmYqALq8MEfl2tCiU+/cCdSZHmPN
         qYNxAlSDJCk6UZPhRFENcVO9cTgpUBp0KDo5jMUYUcbO648sXF9oTTklbm3B9d8FqbHU
         sjNfpKMU8Utxj4hIwpiyOL7bp/PkNXuBO7BuDerRSz6rkxIq8luXUthYXoZS3LEM/13q
         e3Y77Uz7Itdoe9ZKhORbWta06bA4qJLyXpxFylfBDYD7MvyYxtB5fPDUFKK52uxJs5uM
         O4og==
X-Gm-Message-State: AOAM531DuTsWeQtJpVvSNCcvjfamnwlp4wB8goi2OJ55KTdl2c+Uizsx
        9g2ss5KHFt8m5CT2pxVqtb5CzjZ2Id+VVg==
X-Google-Smtp-Source: ABdhPJy4W9VxHmJJlhR0R6RD9/ZlGz1fKKOMhrgsnfHfNE7BcLdn5dfqFi/epH48bobo2y7iEzx8eA==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr16161075wmq.95.1638966866611;
        Wed, 08 Dec 2021 04:34:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/10] cat-file: better usage UX & error messages
Date:   Wed,  8 Dec 2021 13:34:13 +0100
Message-Id: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches to cat-file significantly improves the UX of
the -h output, see 08/10. For the v3 see[1], for the new usage output
see [2].

This re-roll addresses a minor formatting issue pointed out by Jiang
Xin in 7/10. I then updated 10/10 a bit to get rid of some repetition
and to reduce the diff size to the pre-image.

1. https://lore.kernel.org/git/cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v4-08.10-ebc8dd0a22e-20211208T123151Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  cat-file tests: test bad usage
  cat-file tests: test messaging on bad objects/paths
  parse-options API: add a usage_msg_optf()
  cat-file docs: fix SYNOPSIS and "-h" output
  cat-file: move "usage" variable to cmd_cat_file()
  cat-file: make --batch-all-objects a CMDMODE
  cat-file: fix remaining usage bugs
  cat-file: correct and improve usage information
  object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
  cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)

 Documentation/git-cat-file.txt |  10 +-
 builtin/cat-file.c             | 182 ++++++++++++++++++++-------------
 builtin/stash.c                |   4 +-
 cache.h                        |   1 +
 object-name.c                  |   8 +-
 parse-options.c                |  13 +++
 parse-options.h                |  10 ++
 t/t1006-cat-file.sh            |  92 +++++++++++++++++
 t/t8007-cat-file-textconv.sh   |  42 ++++++++
 9 files changed, 282 insertions(+), 80 deletions(-)

Range-diff against v3:
 1:  d77771e3ea0 =  1:  b3d8ec1697f cat-file tests: test bad usage
 2:  ab21a69864f =  2:  eb6fa584287 cat-file tests: test messaging on bad objects/paths
 3:  69ef1ae48c3 =  3:  01de6e4305f parse-options API: add a usage_msg_optf()
 4:  597bb97b90a =  4:  aa384803fef cat-file docs: fix SYNOPSIS and "-h" output
 5:  a9ea4c52222 =  5:  32365ff569b cat-file: move "usage" variable to cmd_cat_file()
 6:  fcb8331f091 =  6:  473ea3b0394 cat-file: make --batch-all-objects a CMDMODE
 7:  ad79e2afc89 !  7:  878d9052bfb cat-file: fix remaining usage bugs
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
     -	}
     +	/* Option compatibility */
     +	if (force_path && !opt_cw)
    -+		usage_msg_optf(_("'%s=<%s> needs '%s' or '%s'"),
    ++		usage_msg_optf(_("'%s=<%s>' needs '%s' or '%s'"),
     +			       usage, options,
     +			       "--path", _("path|tree-ish"), "--filters",
     +			       "--textconv");
 8:  a378dd30dd0 =  8:  ebc8dd0a22e cat-file: correct and improve usage information
 9:  145c00db08c =  9:  a7447510e4b object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
10:  45a24f97c88 ! 10:  a658099e3e1 cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
    @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
      	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
     +	unsigned get_oid_flags = GET_OID_RECORD_PATH | GET_OID_ONLY_TO_DIE;
      	const char *path = force_path;
    -+	if (!path && (opt == 'w' || opt == 'c'))
    ++	const int opt_cw = (opt == 'c' || opt == 'w');
    ++	if (!path && opt_cw)
     +		get_oid_flags |= GET_OID_REQUIRE_PATH;
      
      	if (unknown_type)
    @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct reposito
      	oc->mode = S_IFINVALID;
      	strbuf_init(&oc->symlink_path, 0);
      	ret = get_oid_1(repo, name, namelen, oid, flags);
    --	if (!ret)
    -+	if (!ret) {
    -+		if (flags & GET_OID_REQUIRE_PATH)
    -+			die(_("<object>:<path> required, only <object> '%s' given"), name);
    ++	if (!ret && flags & GET_OID_REQUIRE_PATH)
    ++		die(_("<object>:<path> required, only <object> '%s' given"),
    ++		    name);
    + 	if (!ret)
      		return ret;
    -+	}
    -+
      	/*
    - 	 * tree:path --> object name of path in tree
    - 	 * :path -> object name of absolute path in index
     
      ## t/t8007-cat-file-textconv.sh ##
     @@ t/t8007-cat-file-textconv.sh: test_expect_success 'usage: <bad rev>' '
-- 
2.34.1.926.g895e15e0c0c

