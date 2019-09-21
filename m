Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972E91F464
	for <e@80x24.org>; Sat, 21 Sep 2019 07:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfIUHlA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 03:41:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41682 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731099AbfIUHlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 03:41:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so8875246wrw.8
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsNYBRIdOieZv+/do9NdarO23+L7nFSoiW5VGu1L4ms=;
        b=KYO/BJKnrkukHxqSKlTnAXcE6OU1ZTtne/T98kJjY1yNt4VrC4vHBiCh9E+2+noATt
         vQmS/jzUKT678ln8fiy/sD26Ysqs/1O8+JL9y/dXn/AWbUb2jXQBzG7b/7z9f0dytu+F
         17LozjRZ5wy++/mfxyyIn7o0A3kLzraZk2NYjFPoF4W2wlPmuI+Eh3MVnREyXQc72iZM
         ItEa/HYju7tK/f5qiYiE16FKvPxEVTzAs+WJBOFdCie3TJDT4CnMkRnubHn5P/s9HAgX
         FE0LOnxQozUquhDEZ8eWQ5isd6jVdQyvwGm99vgWWdBgu1mY2Tnq9P9AUIEMMl259iOL
         46YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsNYBRIdOieZv+/do9NdarO23+L7nFSoiW5VGu1L4ms=;
        b=Cy521AgNbbNH/7JI14cMtiWLfnBavOEjKgYFIeAIhUgmXWQtdfZbn3AfnV4v1qdx9l
         Zf8KOxVhendphakAf3R7h/fyy24Uf7IijjXIS+QiloN1NYUH4lLMmtgyD5L2KGgkvozb
         vd5ENsLNKeYvIP91bvOubaFmc/owA3jtbPitSwA5W2IIpVV/4UsbWM7Sk9lf7J56lrwS
         QrFSzXaau/azdQ4ZZcc9mlEomz7sCHppMBImE/89TQwf5W4m0UKsh6KVBo2TQ+cDKh5O
         h019lUEGTwgXLlGmqUHHv6QsqfUJjmmuH30aBf09jmHLpYTwvrXSU+jTHNc7HtJ8iC9A
         vITA==
X-Gm-Message-State: APjAAAVLejNmCvKzUyO420ndSi6q6BA2/KIQGztc9PKwH8TA6L648x3V
        lTWt1s+oFTGpl5X+fLJucVc=
X-Google-Smtp-Source: APXvYqy8e9Gif07pdlpYFqjsZE6zRUPbIbXdAbmZ/ydG15yktjUQBAAr+bEsopsCEvqKL+9lsDyi0g==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr13665236wrn.307.1569051658058;
        Sat, 21 Sep 2019 00:40:58 -0700 (PDT)
Received: from localhost.localdomain (x4db43ca8.dyn.telefonica.de. [77.180.60.168])
        by smtp.gmail.com with ESMTPSA id s5sm4926882wro.27.2019.09.21.00.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Sep 2019 00:40:57 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] travis-ci: do not skip successfully tested trees in debug mode
Date:   Sat, 21 Sep 2019 09:40:54 +0200
Message-Id: <20190921074055.8214-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <xmqqblvevn44.fsf@gitster-ct.c.googlers.com>
References: <xmqqblvevn44.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI offers shell access to its virtual machine environment
running the build jobs, called "debug mode" [1].  After restarting a
build job in debug mode and logging in, the first thing I usually do
is to install dependencies, i.e. run './ci/install-dependencies.sh'.
This works just fine when I restarted a failed build job in debug
mode.  However, after restarting a successful build job in debug mode
our CI scripts get all clever, and exit without doing anything useful,
claiming that "This commit's tree has already been built and tested
successfully" [2].  Our CI scripts are right, and we do want to skip
building and testing already known good trees in "regular" CI builds.
In debug mode, however, this is a nuisiance, because one has to delete
the cache (or at least the 'good-trees' file in the cache) to proceed.

Let's update our CI scripts, in particular the common 'ci/lib.sh', to
not skip previously successfully built and tested trees in debug mode,
so all those scripts will do what there were supposed to do even when
a successful build job was restarted in debug mode.

[1] https://docs.travis-ci.com/user/running-build-in-debug-mode/
[2] 9cc2c76f5e (travis-ci: record and skip successfully built trees,
    2017-12-31)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
Range-diff:
1:  e9badc7483 ! 1:  a1959d3e16 travis-ci: ignore already tested trees in debug mode
    @@ Metadata
     Author: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## Commit message ##
    -    travis-ci: ignore already tested trees in debug mode
    +    travis-ci: do not skip successfully tested trees in debug mode
     
         Travis CI offers shell access to its virtual machine environment
         running the build jobs, called "debug mode" [1].  After restarting a
    @@ Commit message
         the cache (or at least the 'good-trees' file in the cache) to proceed.
     
         Let's update our CI scripts, in particular the common 'ci/lib.sh', to
    -    ignore previously successfully built and tested trees in debug mode,
    +    not skip previously successfully built and tested trees in debug mode,
         so all those scripts will do what there were supposed to do even when
         a successful build job was restarted in debug mode.
     

 ci/lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 44db2d5cbb..1a09ac4b34 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -34,6 +34,11 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
+	if test "$TRAVIS_DEBUG_MODE" = true
+	then
+		return
+	fi
+
 	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
-- 
2.23.0.331.g4e51dcdf11

