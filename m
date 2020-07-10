Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A53CC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBA92078B
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyvqiDI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGJQr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJQr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:47:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F16C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:47:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so6635472wrl.8
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGY4yuP/y5Csd4mj7Upi6N/HzrvlL0Xpqk7Sj8/VB2A=;
        b=nyvqiDI4UY87yMin0Tz/7J91jO2V1/WwEVbZF/oh0wZp5wuQYFYqJW4MdyrjxBz2qd
         xl6J3GDB8iz8nvK+aYDQ6+IyjtDBGT+czSLwyUK0QpnKQtAauCob32VWd8EY8le4Q0Th
         BVQ0FIIUlFo/fMIH/U48mXUC6MU5bEhaGg2VyHP1N0fbAbl73JyIYgG1eWXu9SF77CKm
         AEQq1nFSfPj8K7TnHEEqCSx/ZYoRqCHuAJCTKIzxva91kBLg/p5YdqSOb7cjZMbbv4gE
         WC0eg7rTcKdqsLYA7VfBh3l16YJyFFrBKzmIZUbWKLM9HtJBiwFJDIfhA40to+yaHANN
         i9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGY4yuP/y5Csd4mj7Upi6N/HzrvlL0Xpqk7Sj8/VB2A=;
        b=BiPjPlVtuLh5Xc0tfdT2zHJ4dV+mla0aDrwXi3XUP/+NnlTZwHiYYafLCmMpareGX5
         H6V1fi8HwmcJL2us+R84aCjH9wBv9VL6MyXP2eZWkwWEmSqcHlpq+Iu1slgSReUzxbKt
         Vw2Ltkz6WjujPEDuo4oLBj9UZiUuRFEyigTkMV2nt+Bhzn4rjy76IUURyS2NNIzCA9Rc
         IoZXhgJ9gFxIfDeNUCZ6eq6aILSfsbIcZV/o/MAGmPHCBGRaoWk1qrs+COfw7X+VW5r5
         ls/KaIYoI1AYoNdUDyArE8+OzlCWw6AFbfaxIFh5MvDfVytbwe8VOcCgNXmo1PtcNzrL
         +yKA==
X-Gm-Message-State: AOAM5313H6hbrZ3Mp4260SQ1Q1OXN3ksHxOYdR30wfhB2yImvgmanylM
        imYAq5tsnl9O2E109aQCDuFhRfMOKvI=
X-Google-Smtp-Source: ABdhPJwoiifIhyUvnw6kkDBbxQFM/bRnJIrOPFLsfJ1apVvWFE49i98GFi4n/PM3Mu1Qn2Zalrjf0w==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr68330202wrq.91.1594399676993;
        Fri, 10 Jul 2020 09:47:56 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.54])
        by smtp.gmail.com with ESMTPSA id m4sm9883385wmi.48.2020.07.10.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:47:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 0/3] Add support for %(contents:size) in ref-filter
Date:   Fri, 10 Jul 2020 18:47:36 +0200
Message-Id: <20200710164739.6616-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.347.gb620d8b0da
In-Reply-To: <20200707174049.21714-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is version 4 of a small patch series to teach ref-filter about
%(contents:size).

This patch series is based on master at 4a0fcf9f76 (The seventh batch,
2020-07-06).

Previous versions and related discussions are there:

V1: https://lore.kernel.org/git/20200701132308.16691-1-chriscool@tuxfamily.org/
V2: https://lore.kernel.org/git/20200702140845.24945-1-chriscool@tuxfamily.org/
V3: https://lore.kernel.org/git/20200707174049.21714-1-chriscool@tuxfamily.org/

Thanks to Junio and Peff for their reviews of this series!

The changes compared to V3 are the following:

  - Squashed patches 1/4 and 2/4 into 1/3 as they were both about
    %(contents) related doc improvements.

  - Improved patch 1/3 as suggested by Junio.

  - Simplified setup test in patch 2/3 about creating a ref pointing
    to a blob as suggested by Junio.

  - Modified test_atom() in patch 3/3 to automatically test
    %(contents:size) after testing %(contents) as suggested by Junio.

The range diff is:

1:  b04b390f32 ! 1:  f750832fc7 Documentation: clarify %(contents:XXXX) doc
    @@ Commit message
         Let's avoid a big dense paragraph by using an unordered
         list for the %(contents:XXXX) format specifiers.
     
    +    While at it let's also make the following improvements:
    +
    +      - Let's not describe %(contents) using "complete message"
    +        as it's not clear what an incomplete message is.
    +
    +      - Let's improve how the "subject" and "body" are
    +        described.
    +
    +      - Let's state that "signature" is only available for
    +        tag objects.
    +
         Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/git-for-each-ref.txt: Fields that have name-email-date tuple as it
     -line is `contents:body`, where body is all of the lines after the first
     -blank line.  The optional GPG signature is `contents:signature`.  The
     -first `N` lines of the message is obtained using `contents:lines=N`.
    -+The complete message of a commit or tag object is `contents`. This
    -+field can also be used in the following ways:
    ++The message in a commit or a tag object is `contents`, from which
    ++`contents:<part>` can be used to extract various parts out of:
     +
     +contents:subject::
    -+  The "subject" of the commit or tag message.  It's actually the
    -+  concatenation of all lines of the commit message up to the
    -+  first blank line.
    ++  The first paragraph of the message, which typically is a
    ++  single line, is taken as the "subject" of the commit or the
    ++  tag message.
     +
     +contents:body::
    -+  The "body" of the commit or tag message.  It's made of the
    -+  lines after the first blank line.
    ++  The remainder of the commit or the tag message that follows
    ++  the "subject".
     +
     +contents:signature::
    -+  The optional GPG signature.
    ++  The optional GPG signature of the tag.
     +
     +contents:lines=N::
     +  The first `N` lines of the message.
2:  b62cab2630 < -:  ---------- Documentation: clarify 'complete message'
3:  b9584472a1 ! 2:  51c72e09d2 t6300: test refs pointing to tree and blob
    @@ t/t6300-for-each-ref.sh: test_atom refs/tags/signed-long contents "subject line
      
     +test_expect_success 'set up refs pointing to tree and blob' '
     +  git update-ref refs/mytrees/first refs/heads/master^{tree} &&
    -+  git ls-tree refs/mytrees/first one >one_info &&
    -+  test $(cut -d" " -f2 one_info) = "blob" &&
    -+  blob_hash=$(cut "-d     " -f1 one_info | cut -d" " -f3) &&
    -+  git update-ref refs/myblobs/first "$blob_hash"
    ++  git update-ref refs/myblobs/first refs/heads/master:one
     +'
     +
     +test_atom refs/mytrees/first subject ""
4:  23f941132e < -:  ---------- ref-filter: add support for %(contents:size)
-:  ---------- > 3:  c2ed3e228b ref-filter: add support for %(contents:size)

Christian Couder (3):
  Documentation: clarify %(contents:XXXX) doc
  t6300: test refs pointing to tree and blob
  ref-filter: add support for %(contents:size)

 Documentation/git-for-each-ref.txt | 27 ++++++++++++++++-----
 ref-filter.c                       |  7 +++++-
 t/t6300-for-each-ref.sh            | 38 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 7 deletions(-)

-- 
2.27.0.347.gb620d8b0da

