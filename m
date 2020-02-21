Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E58C35666
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1B1206D7
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkqhPoea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBUVrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:47:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVrb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 16:47:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so6092566wmc.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TwqVMlM/FHDTOkrccxXWFX63zDRrn8QCIZ+4+us8qu0=;
        b=nkqhPoeaBLUMUylcScAFhEvzrK4dB50whnN0elSIcR7ZRzmY6Pai+Z+39WEnvZbF47
         nsZE/7JrxPm/sVKrxKnUZJ1nAhgjM1xaXFi/nskt4GjF5kPnCcim4yqD8unCblrFmjYw
         EEzi/I6PkBLhnqOt1KSmneIWCiNkX7EXCIQ8h0rOwGZQ9LXnt1XC1Wv88uapX7Ozcd88
         Rnj+dqyCbCm8CKER2tErnyMv2oZsf8M+obifD3udWmgimQ/UOp9MWZ+3A6PNhKdahZFv
         2PF3yPucGM1gLbDb6VU2gbOeayty6okKbwC33fnvtGzuB7cr7f50iUVq7Jkua2OtH213
         cxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TwqVMlM/FHDTOkrccxXWFX63zDRrn8QCIZ+4+us8qu0=;
        b=GBLqNYgl2is7lISQNeaVQSRpnqsDt2PnwY2vYkS72dHCgkR6p4T2vlk0QdRmzubsTU
         fBADnszhk26bBxjiuMSeZDLXmyU93PRRytTEQ4CDuHSKYvY/Xc3nl3JrO/atMvcN8rP3
         d+dDIsEVBkAy4QdBLZRLhwnRUe0oC3K+lU+cSTLsjVcYG4XhFW0+WNKxOCiRPK8+b1IR
         aBN5yNZvvLIjTQsmnzdIoOZai0U5mOTGskK2xullAp54ZZP4KX1SPUrDuS/SMCkR6xcO
         KvcWLEiYoQVNqGm/e11aHFJUfbrYa8NgIJWwwlxZTJiH+xadqup1RcaUFngRhIjcNGeD
         1zlA==
X-Gm-Message-State: APjAAAVbbWS4Cm8juNoAsbyKr65nfJ1sbrMzSBlton8onYbilvkaUzBY
        AS7qfk+PW0cCqjGn9uutihvswI2L
X-Google-Smtp-Source: APXvYqyyKuovw6kFs41fYf3Q09KLA7B3kPpL7j1Rx7tXIE66fORLGoIbtAcDVnOnmld/+vaewF8ZxA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr5590514wmb.76.1582321649435;
        Fri, 21 Feb 2020 13:47:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm5521821wme.16.2020.02.21.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:47:28 -0800 (PST)
Message-Id: <pull.556.v2.git.1582321648.gitgitgadget@gmail.com>
In-Reply-To: <pull.556.git.1582129312.gitgitgadget@gmail.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 21:47:26 +0000
Subject: [PATCH v2 0/2] Document two partial clone bugs, fix one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While playing with partial clone, I discovered a few bugs and document them
with tests in patch 1. One seems to be a server-side bug that happens in a
somewhat rare situation, but not terribly unlikely. The other is a
client-side bug that leads to quadratic amounts of data transfer; I fix this
bug in patch 2.

UPDATES in V2:

 * Added "|| return 1" inside the for loops.
   
   
 * Added an in-test comment about the test ordering.
   
   
 * Required protocol.version=2 in the tags test due to the bisect Junio
   performed.
   
   
 * Updated the commit message via Jonathan Tan's suggestion.
   
   

You can ignore the stack traces I sent earlier, as those seem to be from
states I cannot get into without being destructive to my .git directory.

Thanks, -Stolee

Derrick Stolee (2):
  partial-clone: demonstrate bugs in partial fetch
  partial-clone: avoid fetching when looking for objects

 builtin/fetch.c          | 10 +++++-----
 t/t5616-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 5 deletions(-)


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-556%2Fderrickstolee%2Fpartial-clone-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-556/derrickstolee/partial-clone-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/556

Range-diff vs v1:

 1:  dbc1bdcae16 ! 1:  04965a8c7a4 partial-clone: demonstrate bugs in partial fetch
     @@ -14,7 +14,8 @@
          In the first test, we find that when fetching with blob filters from
          a repository that previously did not have any tags, the 'git fetch
          --tags origin' command fails because the server sends "multiple
     -    filter-specs cannot be combined".
     +    filter-specs cannot be combined". This only happens when using
     +    protocol v2.
      
          In the second test, we see that a 'git fetch origin' request with
          several ref updates results in multiple pack-file downloads. This must
     @@ -41,15 +42,20 @@
       	grep "want $(cat hash)" trace
       '
       
     ++# The following two tests must be in this order, or else
     ++# the first will not fail. It is important that the srv.bare
     ++# repository did not have tags during clone, but has tags
     ++# in the fetch.
     ++
      +test_expect_failure 'verify fetch succeeds when asking for new tags' '
      +	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
      +	for i in I J K
      +	do
      +		test_commit -C src $i &&
     -+		git -C src branch $i
     ++		git -C src branch $i || return 1
      +	done &&
      +	git -C srv.bare fetch --tags origin +refs/heads/*:refs/heads/* &&
     -+	git -C tag-test fetch --tags origin
     ++	git -C tag-test -c protocol.version=2 fetch --tags origin
      +'
      +
      +test_expect_failure 'verify fetch downloads only one pack when updating refs' '
     @@ -59,7 +65,7 @@
      +	for i in A B C
      +	do
      +		test_commit -C src $i &&
     -+		git -C src branch $i
     ++		git -C src branch $i || return 1
      +	done &&
      +	git -C srv.bare fetch origin +refs/heads/*:refs/heads/* &&
      +	git -C pack-test fetch origin &&
 2:  937a882261d ! 2:  7c4c9f0f8e1 partial-clone: avoid fetching when looking for objects
     @@ -2,10 +2,13 @@
      
          partial-clone: avoid fetching when looking for objects
      
     -    When using partial-clone, do_oid_object_info_extended() can trigger a
     -    fetch for missing objects. This can be extremely expensive when asking
     -    for a tag or commit, as we are completely removed from the context of
     -    the missing object and thus supply no "haves" in the request.
     +    When using partial clone, find_non_local_tags() in builtin/fetch.c
     +    checks each remote tag to see if its object also exists locally. There
     +    is no expectation that the object exist locally, but this function
     +    nevertheless triggers a lazy fetch if the object does not exist. This
     +    can be extremely expensive when asking for a commit, as we are
     +    completely removed from the context of the non-existent object and
     +    thus supply no "haves" in the request.
      
          6462d5eb9a (fetch: remove fetch_if_missing=0, 2019-11-05) removed a
          global variable that prevented these fetches in favor of a bitflag.
     @@ -68,7 +71,7 @@
       --- a/t/t5616-partial-clone.sh
       +++ b/t/t5616-partial-clone.sh
      @@
     - 	git -C tag-test fetch --tags origin
     + 	git -C tag-test -c protocol.version=2 fetch --tags origin
       '
       
      -test_expect_failure 'verify fetch downloads only one pack when updating refs' '

-- 
gitgitgadget
