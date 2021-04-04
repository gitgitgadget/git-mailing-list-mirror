Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB9FC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DB361365
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhDDJT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 05:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhDDJT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 05:19:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9417C061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 02:19:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so4275170wmi.3
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDfBjLJk7YXdAk7YnxtbT38ioYcpbYTDikX3uTw2Ly8=;
        b=LZxflTSEEVazdY1byLQ9+MYVSF/P6ILN2qVp9Y7OcYUEM+K9T7UYaxautuGsMJ7pMX
         F/okrS0S8JNLnhG4bOftwatMr9VvkQrONfFeu1fRwqBkFg6dAu+aeKjDT9m8pF4+aH4B
         vNcHy2RUSvrtW4PYkbguFtSLiij8d5HLMKfcFKl8fp2rQey2C7rFGqB4IxlQWW2cFhy4
         BFhiQbpEWlmqVIUJQdZEg2zS4tE+x8xysPQjcX9qhdZok/QJBQT/wuLEUkXZVsFdopSn
         dHlwRX2HJ0Kfyt13Oot9/2PyOe47bPjiwPBAaA9GITMKPkpccmGVRMQtG0LjxXTwgjRo
         ktRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDfBjLJk7YXdAk7YnxtbT38ioYcpbYTDikX3uTw2Ly8=;
        b=UmjuoYkTLVg427/1m2ejT/LAg550qe0bL9Z6djfDGE7RUgVHMfN7bUL0lLbspQWpaz
         BpQ73wl1KgJfiY9yAu9cKmmWc/Lbks1OjxbRubAYNaGUflOTZroIwdLkv/0jMoTdv6R5
         eTRpxSWJ7AODwtao5UbaVGOuMB6/Bj0aJTR9Jpaxw+lOy6JwvnRq2BpxhKRzlDXEAzAg
         v3pjC3aW9ghiE724u9Dgy/ArDAOiOw6ILY71Xv7amtxQPIxqdJQUKxQdtLjlJITDjQer
         VBCo6E9g4Gr7ET6ZmWa5Z0SX/voLjLGDEW3nStXTOIM4b8deny9R1CVG+HRFqsLnD6e9
         bwsg==
X-Gm-Message-State: AOAM533fCUZpWDNuzaLdJAHX/tD6yc9ZZIiOI2h0E9K/Rial8MbhJ4MO
        +RhC2ZjvGHUApGfuvTSf8V57uphu8VfD8g==
X-Google-Smtp-Source: ABdhPJyBqfWMgrB8XbRplO7Tl0Ek6edAd3p7bQ/abEeHNOg04zCHoxsjX6pFMLeGvhNSLDVdN34psw==
X-Received: by 2002:a05:600c:2cd8:: with SMTP id l24mr20013857wmc.88.1617527990182;
        Sun, 04 Apr 2021 02:19:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z25sm22480540wmi.23.2021.04.04.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 02:19:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] refactor duplicate $? checks into a function + improve errors
Date:   Sun,  4 Apr 2021 11:19:42 +0200
Message-Id: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was a silly error in v1 noted by Junio. In practice we didn't
hit that "die $msg if $die" in system_or_msg(), but it didn't belong
there.

I see 1/2 of v1 of this series was merged to "next". I'm sending the
full thing anyway, but presumably just 3-4 will be picked up. They
apply cleanly on "next".

I added two patches at the end to improve the error output, the first
two patches in both v1 and v2 just reproduced the current output
bug-for-bug, but I've now made it more sensible.

Ævar Arnfjörð Bjarmason (4):
  git-send-email: replace "map" in void context with "for"
  git-send-email: refactor duplicate $? checks into a function
  git-send-email: test full --validate output
  git-send-email: improve --validate error output

 git-send-email.perl   | 45 +++++++++++++++++++++++++++----------------
 t/t9001-send-email.sh | 35 +++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 25 deletions(-)

Range-diff:
1:  bea11504a67 = 1:  e37b861f239 git-send-email: replace "map" in void context with "for"
2:  f4bace5607c ! 2:  f236f083e36 git-send-email: refactor duplicate $? checks into a function
    @@ git-send-email.perl: sub format_2822_time {
     +sub system_or_msg {
     +	my ($args, $msg) = @_;
     +	system(@$args);
    -+	return unless (($? & 127) || ($? >> 8));
    ++	my $signalled = $? & 127;
    ++	my $exit_code = $? >> 8;
    ++	return unless $signalled or $exit_code;
     +
    -+	die $msg if $msg;
     +	return sprintf(__("failed to run command %s, died with code %d"),
    -+		       "@$args", $? >> 8);
    ++		       "@$args", $exit_code);
     +}
     +
     +sub system_or_die {
    @@ git-send-email.perl: sub validate_patch {
     -			$hook_error = "rejected by sendemail-validate hook"
     -				if system($validate_hook, $target);
     +			if (my $msg = system_or_msg([$validate_hook, $target])) {
    -+				# TODO Use $msg and emit exit code on
    -+				# hook failures?
     +				$hook_error = __("rejected by sendemail-validate hook");
     +			}
      			chdir($cwd_save) or die("chdir: $!");
-:  ----------- > 3:  15b59c226d4 git-send-email: test full --validate output
-:  ----------- > 4:  a1edceb4913 git-send-email: improve --validate error output
-- 
2.31.1.482.g6691c1be520

