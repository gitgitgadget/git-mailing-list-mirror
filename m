Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53249C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhL1OfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhL1OfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A2C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso10181791wmf.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UcUwXpGesCQB2W73PVSYrlxW/BGjEAkhm3Z+vRSOkY=;
        b=Jg9JNrS/OqSeRlzF/twRqyQxCYgdDZ2g6NPtSBQHxOTX4oVgvUrG9U41dijVOi5qTk
         6DF2wmYwuXIMO9ULqmtp9VS9729fpdp9AM+QllhzCgT0l8MfJFXPOjlCBDhm6ygSP4lp
         XlIbB/PJchdTtseW94by2sf2+onysbkq7z2w87dFWQOOg58XuTwcozVnstADkzOFjPO9
         uzjl+o0hyuIKF5owMRUJnKKjR4KjsG+Lrr3GfK/CcWfcib3HhfmMz/EgT1/zGwuCY7ep
         wmHWv7pcI+1Ai12oXfxF/XQ6HZbh0HhfoUZBRP/J2HD52h1sZH/YIIqF2XEQloujvoa5
         hhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UcUwXpGesCQB2W73PVSYrlxW/BGjEAkhm3Z+vRSOkY=;
        b=pOEc95WZ/Jrlw+r/TEAS+wbnUXNaH7yZtOTAK+K4DA1CFOqLvlP6uhKHlgail0cqS7
         ZzxHRvRSE4Xf0l5S1DbFDyFgFWYzicSeGr2OV24NJL3nXfNW/Cvn6BZASLjQZjIP7E1w
         gCuSGg6xo7vDsuo0G9DkLO2lhDgrhgnH8tgtp73MczeM8nwPs0pSB7HWoY8/UJhh5hnF
         3at+mUhtNfxoN/TLT13C6Md5TXg+NyVGJ85S2jGoIlGyBXYOOBd93nlelQJqJK2h3F0D
         GgEm5C1m4pWUIX/7CiZmtxITbjcQFjDjX9Wb4Mm46zQqlsl7pyruSScTpeITN4hZUTt9
         NC0A==
X-Gm-Message-State: AOAM533+p8CkDwhkRl1u1JqaFNacJF89CnRolyLR0G+lR9yMpH0nCX2o
        2mjLoxuU6My9XuWtTPbnnjOAhWe9I3pr8jUv
X-Google-Smtp-Source: ABdhPJw3v35HLJ2j94xMmYkxl7zIRaI56M03piik21nmFCTbYvFsxmwGW8Hhfcg54xUDV9b2k3RL5g==
X-Received: by 2002:a1c:2544:: with SMTP id l65mr18111591wml.101.1640702112732;
        Tue, 28 Dec 2021 06:35:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m35sm42780660wms.1.2021.12.28.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:35:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/6] object-name: make ambiguous object output translatable + show tag date
Date:   Tue, 28 Dec 2021 15:34:56 +0100
Message-Id: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic improves the output we emit on ambiguous objects as noted
in 4/6, and makes it translatable, see 3/6. See [1] for v5.

This iteration addresses various small feedback from Josh
Steadmon. I've incorporated a variable rename fixups here, and
hopefully answered small questions on the v5 thread with amended
commit messages.

For the case of "dead" prefixed objects being unused but "beef" being
used I just added a test for the "dead" objects. They're not strictly
needed, but having them for the "dead...beef" symetry and for use in
future tests is probably better, so I kept them in.

1. http://lore.kernel.org/git/cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (6):
  object-name tests: add tests for ambiguous object blind spots
  object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
  object-name: make ambiguous object output translatable
  object-name: show date for ambiguous tag objects
  object-name: iterate ambiguous objects before showing header
  object-name: re-use "struct strbuf" in show_ambiguous_object()

 object-name.c                       | 112 +++++++++++++++++++++++++---
 t/t1512-rev-parse-disambiguation.sh |  84 +++++++++++++++++++++
 2 files changed, 184 insertions(+), 12 deletions(-)

Range-diff against v5:
1:  767165d096d ! 1:  27f267ad555 object-name tests: add tests for ambiguous object blind spots
    @@ Commit message
         prefix are the same for both SHA-1 and SHA-256. This uses strings that
         I mined, and have the same prefix when hashed with both.
     
    +    We "test_cmp" the full output to guard against any future regressions,
    +    and because a subsequent commit will tweak it. Showing a diff of how
    +    the output changes is helpful to explain those subsequent commits.
    +
         1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ t/t1512-rev-parse-disambiguation.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +		echo 1bbfctrkc | git hash-object -w --stdin
     +	) &&
     +
    ++	test_must_fail git -C blob.prefix rev-parse dead &&
     +	cat >expect <<-\EOF &&
     +	error: short object ID beef... is ambiguous
     +	hint: The candidates are:
2:  ee86912f1c1 ! 2:  c78243dc701 object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
    @@ Commit message
         added in the preceding commit.
     
         So saying "unknown type" here was always misleading, we really meant
    -    to say that we had a failure parsing the object at all, if the problem
    -    is only that it's type is unknown we won't reach this code.
    +    to say that we had a failure parsing the object at all, i.e. that we
    +    had repository corruption. If the problem is only that it's type is
    +    unknown we won't reach this code.
     
         So let's emit a generic "[bad object]" instead. As our tests added in
         the preceding commit show, we'll have emitted various "error" output
3:  b79964483e8 ! 3:  daebc95542c object-name: make ambiguous object output translatable
    @@ Commit message
            then SHA-1, 2018-05-10)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
      ## object-name.c ##
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     -	strbuf_addstr(&desc, type_name(type));
      
      	if (type == OBJ_COMMIT) {
    -+		struct strbuf ad = STRBUF_INIT;
    -+		struct strbuf s = STRBUF_INIT;
    ++		struct strbuf date = STRBUF_INIT;
    ++		struct strbuf msg = STRBUF_INIT;
      		struct commit *commit = lookup_commit(ds->repo, oid);
     +
      		if (commit) {
      			struct pretty_print_context pp = {0};
      			pp.date_mode.type = DATE_SHORT;
     -			format_commit_message(commit, " %ad - %s", &desc, &pp);
    -+			format_commit_message(commit, "%ad", &ad, &pp);
    -+			format_commit_message(commit, "%s", &s, &pp);
    ++			format_commit_message(commit, "%ad", &date, &pp);
    ++			format_commit_message(commit, "%s", &msg, &pp);
      		}
     +
     +		/*
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
     +		 *
     +		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
     +		 */
    -+		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
    ++		strbuf_addf(&desc, _("%s commit %s - %s"),
    ++			    hash, date.buf, msg.buf);
     +
    -+		strbuf_release(&ad);
    -+		strbuf_release(&s);
    ++		strbuf_release(&date);
    ++		strbuf_release(&msg);
      	} else if (type == OBJ_TAG) {
      		struct tag *tag = lookup_tag(ds->repo, oid);
     +		const char *tag_tag = "";
4:  36b6b440c37 = 4:  b5aa6e266f6 object-name: show date for ambiguous tag objects
5:  8880c283559 = 5:  644b076b2a6 object-name: iterate ambiguous objects before showing header
6:  78bb0995f08 ! 6:  6a31cfcfc29 object-name: re-use "struct strbuf" in show_ambiguous_object()
    @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, voi
      		 *
      		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
      		 */
    --		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
    -+		strbuf_addf(sb, _("%s commit %s - %s"), hash, ad.buf, s.buf);
    +-		strbuf_addf(&desc, _("%s commit %s - %s"),
    +-			    hash, date.buf, msg.buf);
    ++		strbuf_addf(sb, _("%s commit %s - %s"), hash, date.buf,
    ++			    msg.buf);
      
    - 		strbuf_release(&ad);
    - 		strbuf_release(&s);
    + 		strbuf_release(&date);
    + 		strbuf_release(&msg);
     @@ object-name.c: static int show_ambiguous_object(const struct object_id *oid, void *data)
      		 * object.c, it should (hopefully) already be
      		 * translated.
-- 
2.34.1.1257.g2af47340c7b

