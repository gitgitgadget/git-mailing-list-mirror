Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10FC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6799B208C4
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk/fpE74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgBQRZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35509 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgBQRZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so20715028wrt.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NrHF6qHexomGhpxcmp/b4ZbDFtdOkYdqA3hQ2rcex18=;
        b=jk/fpE74Q7/cRKydXQRPeCo9tTeWA9mpxOBOdsq46OIFRgblTlT4CTsh3EyCETOTZy
         o+uC1QHLV/zxJq28VgAklG9RCH/XCA/Z42cuSIyfFOAtly1CHoaqLVUxZk8IWMDSVqse
         mzU3UbzVi/kxm6a742umv7+8VCKp1rHSVNmZUfXwJMhcb6UWipbNLTtq9rgWjzxfqmUQ
         z9SpOMtX7BVUKx0GrevCyNUuw0CTCm6//yYWRU18wMSV5Zsjiewnirq91kgJBvYhMSQl
         AGBfVxcshYj/i4KN5oB80xchuPBA0Up6KFcdjlK5Z5oaHPQwjPaS+SCbWFPDn7pgXl5W
         70qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NrHF6qHexomGhpxcmp/b4ZbDFtdOkYdqA3hQ2rcex18=;
        b=kDFzC6IeDzK0snlvLu355Fu3ECB9jFJR2Xh1w4WWRtZ3xYlkJH+6/z81SPisQ1EAPP
         hI95qP+3vCzUeIeWFF5yewdK34FJ+FSiwRO7rROb1FjirNveK3ajg75OSCvHK1k/5lf3
         X1/ttl5d3oEYAbFohC5CaBtTKXup3oV1wQz4HYbSDdsE4zjAaZgA/6twdR03wMVjkq7P
         2ATKnczQvIADMlZWGmTfNTy/Q3Qiez50O76ezYzIjH90uUTFrlO+bEqNuhLbIMYWh0dX
         Xsqbpw/NzlCnnafGmyZe2N/I68FQABAsxqsyzSqB/gunLjArFnoY3i5xMn3+fqFlJLjK
         lX7A==
X-Gm-Message-State: APjAAAXXjCzEjASdSunracO1GdbSdAo665rqvbBpWGR0+Hg2Otty5i/g
        yzGq4z6JHIlkbOiAJD7puDTFZIe/
X-Google-Smtp-Source: APXvYqwPzS6eHBblwmmTTanSl/BVzV2a6G0Lz9DKFpvpYs3UmqZFAqW51UV7MHBkgyVRJWDdiEYO/A==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr23562509wro.359.1581960323277;
        Mon, 17 Feb 2020 09:25:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm1822571wrp.95.2020.02.17.09.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:22 -0800 (PST)
Message-Id: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:14 +0000
Subject: [PATCH v3 0/8] Support --pathspec-from-file in rm, stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V1
------------------
Some polishing based on code review in V1
1) Improved error message for the case where pathspec is not given to `git rm`
2) Removed explicit variable initialization to 0 / NULL
3) Polishing in docs for `git stash`

------------------
This series continues the effort to support `--pathspec-from-file`
in various git commands. Series already in `master`: [1][2]

Cc'ing Paul-Sebastian Ungureanu because I touched his git stash code.

[1] https://public-inbox.org/git/pull.445.git.1572895605.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/

Alexandr Miloslavskiy (8):
  doc: rm: synchronize <pathspec> description
  rm: support the --pathspec-from-file option
  doc: stash: split options from description (1)
  doc: stash: split options from description (2)
  doc: stash: document more options
  doc: stash: synchronize <pathspec> description
  stash: eliminate crude option parsing
  stash push: support the --pathspec-from-file option

 Documentation/git-rm.txt       |  61 +++++++-------
 Documentation/git-stash.txt    | 144 +++++++++++++++++++++++----------
 builtin/rm.c                   |  28 +++++--
 builtin/stash.c                |  79 +++++++++---------
 t/t3601-rm-pathspec-file.sh    |  79 ++++++++++++++++++
 t/t3903-stash.sh               |   5 ++
 t/t3909-stash-pathspec-file.sh | 100 +++++++++++++++++++++++
 7 files changed, 381 insertions(+), 115 deletions(-)
 create mode 100755 t/t3601-rm-pathspec-file.sh
 create mode 100755 t/t3909-stash-pathspec-file.sh


base-commit: de93cc14ab7e8db7645d8dbe4fd2603f76d5851f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-530%2FSyntevoAlex%2F%230207(git)_pathspec_from_file_3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-530/SyntevoAlex/#0207(git)_pathspec_from_file_3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/530

Range-diff vs v2:

 1:  2e8c8ad8158 = 1:  cf065e905dc doc: rm: synchronize <pathspec> description
 2:  7ccbab52e51 ! 2:  7c657dea89e rm: support the --pathspec-from-file option
     @@ -5,17 +5,36 @@
          Decisions taken for simplicity:
          1) It is not allowed to pass pathspec in both args and file.
      
     -    `if (!argc)` block was adapted to work with --pathspec-from-file. For
     -    that, I also had to parse pathspec earlier. Now it happens before
     -    `read_cache()` / `hold_locked_index()` / `setup_work_tree()`, which
     -    sounds fine to me.
     +    Adjustments were needed for `if (!argc)` block:
      
     -    In case of empty pathspec, there is now a clear error message instead
     -    of showing usage. As a consequence, exit code has also changed. Judging
     -    from [1] it doesn't seem that showing usage in this case was important
     -    (according to commit message, it was to avoid segfault), and it doesn't
     -    fit into how other commands react to empty pathspec. Finally, the new
     -    error message is easier to understand.
     +    This code actually means "pathspec is not present". Previously, pathspec
     +    could only come from commandline arguments, so testing for `argc` was a
     +    valid way of testing for the presence of pathspec. But this is no longer
     +    true with `--pathspec-from-file`.
     +
     +    During the entire `--pathspec-from-file` story, I tried to keep its
     +    behavior very close to giving pathspec on commandline, so that switching
     +    from one to another doesn't involve any surprises.
     +
     +    However, throwing usage at user in the case of empty
     +    `--pathspec-from-file` would puzzle because there's nothing wrong with
     +    "usage" (that is, argc/argv array).
     +
     +    On the other hand, throwing usage in the old case also feels bad to me.
     +    While it's less of a puzzle, I (as user) never liked the experience of
     +    comparing my commandline to "usage", trying to spot a difference. Since
     +    it's already known what the error is, it feels a lot better to give that
     +    specific error to user.
     +
     +    Judging from [1] it doesn't seem that showing usage in this case was
     +    important (the patch was to avoid segfault), and it doesn't fit into how
     +    other commands react to empty pathspec (see for example `git add` with a
     +    custom message).
     +
     +    Therefore, I decided to show new error text in both cases. In order to
     +    continue testing for error early, I moved `parse_pathspec()` higher. Now
     +    it happens before `read_cache()` / `hold_locked_index()` /
     +    `setup_work_tree()`, which shouldn't cause any issues.
      
          [1] Commit 7612a1ef ("git-rm: honor -n flag" 2006-06-09)
      
     @@ -136,7 +155,7 @@
      +	echo D >fileD.t &&
      +	git add fileA.t fileB.t fileC.t fileD.t &&
      +	git commit -m "files" &&
     -+	
     ++
      +	git tag checkpoint
      +'
      +
     @@ -193,7 +212,7 @@
      +
      +	test_must_fail git rm --pathspec-file-nul 2>err &&
      +	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
     -+	
     ++
      +	>empty_list &&
      +	test_must_fail git rm --pathspec-from-file=empty_list 2>err &&
      +	test_i18ngrep -e "No pathspec was given. Which files should I remove?" err
 3:  8c212fc0ed4 = 3:  bb300215d49 doc: stash: split options from description (1)
 4:  db3a96720ce = 4:  fdaf4532404 doc: stash: split options from description (2)
 5:  f91ec08b472 = 5:  764b8668d10 doc: stash: document more options
 6:  04e2fd5865f = 6:  7353b06e30e doc: stash: synchronize <pathspec> description
 7:  0558cbbe38e = 7:  d34eaf4a272 stash: eliminate crude option parsing
 8:  0c6f28dc68d = 8:  6465a292b55 stash push: support the --pathspec-from-file option

-- 
gitgitgadget
