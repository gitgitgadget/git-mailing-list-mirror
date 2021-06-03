Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB0C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C96F613E4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 16:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCQcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:32:14 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41874 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCQcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 12:32:13 -0400
Received: by mail-wr1-f52.google.com with SMTP id h8so6455831wrz.8
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KfbMo4OHPZFviIhBEBUFUD7CCPae2uLEKbGSSWVYR24=;
        b=UAUj+yapBxKMKBbzyY6Ft17yMy4aDOlgupp6k0QSOyCSSlJ57qEudIWQwwNHcV4hq5
         Bw2iCgLXu67hUwpZyPSGzUauqC+1XKO6rYuzXAUpuY2VkKgSo1Kikd07S2/TxRapzPKj
         XtdFXXCOkD6XAkfQtbU37R5p9QE87g5EDlDF7amnywVLAXS4ShIBt6cfMsqcu+DFZ9gj
         EH3TXTQi3hIbwmydLkrOlgg3eCnASWmBxSaaIvxqDsnYIQ3NiFsotxobkFYM+FzmCACZ
         DK6flY4bJlihSgiTxbpDmKGNxjgvn7HnVzYNxgfL7a0hNMUGmMan6aLk0CB2YcUD1bUn
         x6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KfbMo4OHPZFviIhBEBUFUD7CCPae2uLEKbGSSWVYR24=;
        b=EwvCtSXVXozKDyA6+5Das99lcvt3+jJ/9RlwJPSK54LRi52ExRILjJfASwimjdFlYX
         pd32Ad8tIS1M1fm8BRaINZVRFlCn7H7iaps+lzo4J9ZzRF4g0w3k2xpFmHocabKbhAD6
         ChnQzxfUwIZyf4fGI2CIxBD7vYPB//3C2InXZbNb6Nfb8B3kD/bLIf7Y0ouyJSykO0md
         np3KLk9iMYKzkW2NGBu69KWN2g6/WBjoJFqtH5DtbivUUoVnazbXWX2Gbx4W3Fki/aX+
         91ASN9EaxlhooQ00Zz86Rc/7ocoq65d64CdRosCb6VDdfIYWUq78fHX94qxtwTmpn3s5
         UNMg==
X-Gm-Message-State: AOAM533CI2tiTHZbaxXOQ/vrQosj6+Ls5lWcmgXfvIGW35nJsYhe8N56
        SCHzJYygvZ6xT3jm1vWS7NImR6yZnHY=
X-Google-Smtp-Source: ABdhPJxk2LgpTmBXhaPVmOOCZO1DoffFFvEMIm2uCZ3Wj6zTAnxR6WI3lN24cbmDM9KAVVsa4EUxJQ==
X-Received: by 2002:adf:e109:: with SMTP id t9mr782775wrz.372.1622737768113;
        Thu, 03 Jun 2021 09:29:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm4425129wrr.90.2021.06.03.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 09:29:27 -0700 (PDT)
Message-Id: <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
In-Reply-To: <pull.967.git.1622558157.gitgitgadget@gmail.com>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Jun 2021 16:29:24 +0000
Subject: [PATCH v2 0/2] [GSOC] cat-file: fix --batch report changed-type bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from last version:

 1. Modified the test structure under the recommendation of Peff.
 2. Use clearer and more concise commit message help by Peff.

ZheNing Hu (2):
  [GSOC] cat-file: handle trivial --batch format with
    --batch-all-objects
  [GSOC] cat-file: merge two block into one

 builtin/cat-file.c  | 10 ++++------
 t/t1006-cat-file.sh | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)


base-commit: 5d5b1473453400224ebb126bf3947e0a3276bdf5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-967%2Fadlternative%2Fcat-file-batch-bug-fix-v2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-967/adlternative/cat-file-batch-bug-fix-v2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/967

Range-diff vs v1:

 1:  495cd90dbaf4 ! 1:  4af3b958dd05 [GSOC] cat-file: fix --batch report changed-type bug
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] cat-file: fix --batch report changed-type bug
     +    [GSOC] cat-file: handle trivial --batch format with --batch-all-objects
      
     -    When `--batch` used with `--batch-all-objects`,
     -    with some format atoms like %(objectname), %(rest)
     -    or even no atoms may cause Git exit and report
     -    "object xxx changed type!?".
     +    The --batch code to print an object assumes we found out the type of
     +    the object from calling oid_object_info_extended(). This is true for
     +    the default format, but even in a custom format, we manually modify
     +    the object_info struct to ask for the type.
      
     -    E.g. `git cat-file --batch="batman" --batch-all-objects`
     +    This assumption was broken by 845de33a5b (cat-file: avoid noop calls
     +    to sha1_object_info_extended, 2016-05-18). That commit skips the call
     +    to oid_object_info_extended() entirely when --batch-all-objects is in
     +    use, and the custom format does not include any placeholders that
     +    require calling it.
      
     -    This is because we did not get the object type through
     -    oid_object_info_extended(), it's composed of two
     -    situations:
     +    Or when the custom format only include placeholders like %(objectname) or
     +    %(rest), oid_object_info_extended() will not get the type of the object.
      
     -    1. Since object_info is empty, skip_object_info is
     -    set to true, We skipped collecting the object type.
     +    This results in an error when we try to confirm that the type didn't
     +    change:
      
     -    2. The formatting atom like %(objectname) does not require
     -    oid_object_info_extended() to collect object types.
     +    $ git cat-file --batch=batman --batch-all-objects
     +    batman
     +    fatal: object 000023961a0c02d6e21dc51ea3484ff71abf1c74 changed type!?
      
     -    The correct way to deal with it is to swap the order
     -    of setting skip_object_info and setting typep. This
     -    will ensure that we must get the type of the object
     -    when using --batch.
     +    and also has other subtle effects (e.g., we'd fail to stream a blob,
     +    since we don't realize it's a blob in the first place).
     +
     +    We can fix this by flipping the order of the setup. The check for "do
     +    we need to get the object info" must come _after_ we've decided
     +    whether we need to look up the type.
      
          Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --unordered works' '
       	test_cmp expect actual
       '
       
     ++test_expect_success 'set up object list for --batch-all-objects tests' '
     ++	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects
     ++'
     ++
      +test_expect_success 'cat-file --batch="%(objectname)" with --batch-all-objects will work' '
     -+	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
      +	git -C all-two cat-file --batch="%(objectname)" <objects >expect &&
      +	git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >actual &&
      +	cmp expect actual
 2:  f02c1144d916 ! 2:  759451e784de  [GSOC] cat-file: merge two block into one
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -     [GSOC] cat-file: merge two block into one
     +    [GSOC] cat-file: merge two block into one
      
     -     Because the two "if (opt->all_objects)" block
     -     are redundant, merge them into one, to provide
     -     better readability.
     +    There are two "if (opt->all_objects)" blocks next
     +    to each other, merge them into one to provide better
     +    readability.
      
          Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>

-- 
gitgitgadget
