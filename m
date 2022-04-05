Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93016C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382574AbiDEVpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441973AbiDEPgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:36:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1CD5573
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 06:50:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a11so11016388qtb.12
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRs/JRU9963THcQWS6FmxRijMEKBNiP2wEoGMIu9X/Y=;
        b=I7eevAUB2lByc3vZioewAfHMhcfh1Oseza8veJlXy5QQpSmGoby/xassPb01y9niHB
         gvjvS1ucOBQF7+Bf3A8K6O15GZQevRYD3wFhQDzw++fLNmnttT/xGippUkURxZ/x0Sv7
         tRglnbzXQ2VC6PPXOL+ENKuFnsA9/MH7smpvF8mY6ydtcyMTR/56CG1CX6abfvBfAXB/
         89BdkXx/xUxDd+rakYssPLk/u6E9cDWpb2Bn3qjlSN+R2oxxEXyrB64kzZBrAnWKpN7p
         +ug1VgpUPAqYaAnjnB9+8O0UaFBsxqAdbiynL+v1XACHGpYWAg69COzGX1sk2neoR5Gb
         79CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRs/JRU9963THcQWS6FmxRijMEKBNiP2wEoGMIu9X/Y=;
        b=E6lMpYIf8bC+7Y4tUb/woMmm2faade7bpsol4Zj7ERJ9et2T1TiYqYDz/pEr7sL0aS
         d8A+Kfhlv3veWClDEYcSe3dnM9SO2Ki+uhZ4DBSk79/NCpAdOMXnllEL22Xwvucl6jYB
         r8sQCIzCY0SIKa/yQATdUCpggdxqHtADyT/Dk0Uh1kAtGah6gv9+wTbbPsymR/eOhOsi
         Roh+N02tF8Imw4t3bGZ5XV9ZsPUoChXcU+AGl2QiOZAZ5HI3SVy00+r7SyWbiGO2ri4I
         YZ1iUJpW2EZQV2LLZ6p9hCkFNgSDgrN6wjkSgwMttVAxnRkwi47aXkkmwfyCwgBg+H4u
         0KKA==
X-Gm-Message-State: AOAM531PzMTnr8X2vayixlLnURG4P0agqFqMx6CMXSLlZHHSbVEZ/qPD
        5Ak1oVHEglUqEYgzk3TIbwc=
X-Google-Smtp-Source: ABdhPJwSq42HsXA6gx2vpZFuBXNrT21dQrC4C9OSsjpRsEgg4JaOYuBAM3bvApgKxicwYNTf3OoDRQ==
X-Received: by 2002:a05:620a:2a01:b0:67e:ca07:4d49 with SMTP id o1-20020a05620a2a0100b0067eca074d49mr2247159qkp.412.1649166615174;
        Tue, 05 Apr 2022 06:50:15 -0700 (PDT)
Received: from e4a2938d721e.us-east4-c.c.codatalab-user-runtimes.internal (42.11.86.34.bc.googleusercontent.com. [34.86.11.42])
        by smtp.gmail.com with ESMTPSA id a16-20020a05622a02d000b002e20e4bf4aesm11330534qtx.23.2022.04.05.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:50:14 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     khalid.masum.92@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 0/1][GSoC] t3501: remove test -f and stop ignoring git <cmd> exit code
Date:   Tue,  5 Apr 2022 13:47:41 +0000
Message-Id: <20220405134742.17526-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402192415.19023-1-khalid.masum.92@gmail.com>
References: <20220402192415.19023-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T3501 contains two test cases where we used to check if a file exists using
test -f which is not necessary because we already have helper function for
it. In fact in one test case test -f is redundant because we grep right
after it. Also the use of git rev-parse can cause segfault.

This patch tries to resolve these two issues in T3501.

Khalid Masum (1):
  t3501: remove test -f and stop ignoring git <cmd> exit code

 t/t3501-revert-cherry-pick.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Range-diff against v3:
1:  aeb28e3249 ! 1:  1090429b86 t3501: remove redundant file check and stop ignoring git <cmd> exit code
    @@
      ## Metadata ##
    -Author: Labnann <khalid.masum.92@gmail.com>
    +Author: Khalid Masum <khalid.masum.92@gmail.com>
     
      ## Commit message ##
    -    t3501: remove redundant file check and stop ignoring git <cmd> exit code
    +    t3501: remove test -f and stop ignoring git <cmd> exit code
     
         In the test 'cherry-pick after renaming branch', stop checking for
         the presence of a file (opos) because we are going to "grep" in it in
    @@ Commit message
     
         In the test 'revert after renaming branch', instead of allowing any
         random contents as long as a known phrase is not there in it, we can
    -    expect the exact outcome---after the successful revert of
    -    "added", the contents of file "spoo" should become identical to
    -    what was in file "oops" in the "initial" commit.
    +    expect the exact outcome---after the successful revert of "added", the
    +    contents of file "spoo" should become identical to what was in file
    +    "oops" in the "initial" commit. This test also contains 'test -f' that
    +    verifies presence of a file, but we have a helper function to do the same
    +    thing. Replace it with appropriate helper function 'test_path_is_file'
    +    for better readability and better error messages.
     
    -    In both tests, we would not notice when "git rev-parse" starts
    -    segfaulting without emitting any output.  The 'test' command would
    -    end up being just "test =", which yields success. Therefore we could
    -    use test_cmp_rev
    +    In both tests, we will not notice when "git rev-parse" starts segfaulting
    +    without emitting any output.  The 'test' command will end up being just
    +    "test =", which yields success. Use the 'test_cmp_rev' helper to make
    +    sure we will notice such a breakage.
     
    -    Signed-off-by: Labnann <khalid.masum.92@gmail.com>
    +    Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
     
      ## t/t3501-revert-cherry-pick.sh ##
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick after renaming branch' '
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'revert after renaming branch
     -	test -f spoo &&
     -	! grep "Add extra line at the end" spoo &&
     +	test_cmp_rev rename1 HEAD^ &&
    ++	test_path_is_file spoo &&
     +	test_cmp_rev initial:oops HEAD:spoo &&
      	git reflog -1 | grep revert
      
-- 
2.35.1.windows.2

