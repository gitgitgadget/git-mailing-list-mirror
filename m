Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F8C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FE620722
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roUEjkkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCXBIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:08:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45943 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCXBIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 21:08:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id t17so3547086qtn.12
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfLpWP9XmK/ljNgDB+yncwwqLxn8ROxkIZsaGmKphvM=;
        b=roUEjkkxXI7jXsEX/z3Uy6GnSHzlp7eTlAXsVclj0zXv0zaq2Ac91MGkFmev6iTY2n
         u5YYTPCIs3rEe9yAM0+bHkExDSsryFx2MhqwhBf9ibTGaPDoFvUTE9U77VNmCQwzrh/h
         gZnYG15nxGodF12uK8B67nLOBhRA0kmJLIEjsBDWvf4PWNLtACpxNtg/d3OtDWFP7/GF
         +hU5B81jwaR15FoVQ7tXqyUmnM9yWbLpzVhvdzPFYnZKHHBs6jIc3LDY9PO29269Ufqv
         W1j8OUg3oMpQjIX4G5KJCXa3sefqsho0EnoJJMWF0o+/DIhFDmDfNWH+1DmmkHpYOJ74
         osFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfLpWP9XmK/ljNgDB+yncwwqLxn8ROxkIZsaGmKphvM=;
        b=dcRNHW95uR2smQMypt4zlck/ihYL/HeQE01iik/Uq60o1VRIxYkavSVnpEGmj1yY/h
         ZbTz0gA107mHZ6lQ1GNZ04f+pALcFTElPqrz57J7LzSe0IhNltA/H5Ju/hMabjaptGmB
         ErdeAbTp1B/cu0WrwOe6mjzB1a6OvYTbybP9eriabFv/sLWtFRuRNg+vcsKbzqPRyJp5
         XlHV9/ooz11KEx/Bk4/H7WVomqbBS3740M0OxwXxFoz3ODQiahNUM/QTklG1OzrNFSZA
         XeaS2YbJEQUcUVCgK6v+HfnvghjRs+CW2M/b+A6rD8eqheQHA5viXqm2IYIjeocJLH1r
         JtKQ==
X-Gm-Message-State: ANhLgQ3GJ3NWYj0vZIGB5dTxJBlJ4XQN9mCSEyqQtdNjuepcAEhMgfI+
        KL7vcPYLt4zIFEhK+GdWT46I//3Y
X-Google-Smtp-Source: ADFU+vtKBOfIrsrSCbB6mnu7soZmGdlTUv1HIUXHMshncH+Zcn11ZP08hhSCuivI5TMG1usifhRmuA==
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr19382852qto.185.1585012093079;
        Mon, 23 Mar 2020 18:08:13 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-141-233.dsl.bell.ca. [76.68.141.233])
        by smtp.gmail.com with ESMTPSA id x9sm13301878qtk.7.2020.03.23.18.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 18:08:11 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Lib-ify functions in builtin.h
Date:   Mon, 23 Mar 2020 21:07:50 -0400
Message-Id: <cover.1585011949.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584786523.git.liu.denton@gmail.com>
References: <cover.1584786523.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the last revision, I tried to rewrite the commit messages to be
more subjective but I was also having some trouble with it.

In builtin.h, there exist a couple of functions that are very "lib-ish".
These functions can currently only be called by built-in commands but,
unlike all of the other functions in the header, it does not make sense
to impose this restriction as their functionality can be logically reused
in libgit.

Extract these functions into their own files which should make more
organizational sense.

Changes since v1:

* Rewrite commit messages to be less subjective

Denton Liu (2):
  Lib-ify fmt-merge-msg
  Lib-ify prune-packed

 Makefile                |   2 +
 builtin.h               |  16 -
 builtin/fmt-merge-msg.c | 655 +---------------------------------------
 builtin/prune-packed.c  |  44 +--
 builtin/prune.c         |   1 +
 builtin/repack.c        |   1 +
 fmt-merge-msg.c         | 653 +++++++++++++++++++++++++++++++++++++++
 fmt-merge-msg.h         |  13 +
 prune-packed.c          |  43 +++
 prune-packed.h          |   9 +
 10 files changed, 724 insertions(+), 713 deletions(-)
 create mode 100644 fmt-merge-msg.c
 create mode 100644 prune-packed.c
 create mode 100644 prune-packed.h

Range-diff against v1:
1:  d989ab8b08 ! 1:  fe76d79aa7 Lib-ify fmt-merge-msg
    @@ Metadata
      ## Commit message ##
         Lib-ify fmt-merge-msg
     
    -    In builtin.h, there exists the distinctly lib-ish function
    -    fmt_merge_msg(). Extract this function into fmt-merge-msg.c so that
    -    related definitions can exist clearly in their own header file.
    +    In builtin.h, there exists the distinctly "lib-ish" function
    +    fmt_merge_msg(). This function can currently only be called by built-in
    +    commands but, unlike most of the other functions in the header, it does
    +    not make sense to impose this restriction as the functionality can be
    +    logically reused in libgit.
    +
    +    Extract this function into fmt-merge-msg.c so that related definitions
    +    can exist clearly in their own header file.
     
         While we're at it, clean up #includes that are unused.
     
2:  249dbb9420 ! 2:  c6a80ce882 Lib-ify prune-packed
    @@ Commit message
         Lib-ify prune-packed
     
         In builtin.h, there exists the distinctly lib-ish function
    -    prune_packed_objects(). Extract this function into prune-packed.c so that
    -    related definitions can exist clearly in their own header file.
    +    prune_packed_objects(). This function can currently only be called by
    +    built-in commands but, unlike all of the other functions in the header,
    +    it does not make sense to impose this restriction as the functionality
    +    can be logically reused in libgit.
    +
    +    Extract this function into prune-packed.c so that related definitions
    +    can exist clearly in their own header file.
     
         While we're at it, clean up #includes that are unused.
     
-- 
2.25.0.114.g5b0ca878e0

