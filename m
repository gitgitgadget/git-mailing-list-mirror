Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F26520248
	for <e@80x24.org>; Sun, 24 Feb 2019 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfBXPyu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 10:54:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32936 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXPyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 10:54:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so12184512wmb.0
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 07:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r7ZTgjUgRTidWqkxUNmR2ccq1FlKOCeJj+Gw0n4e39s=;
        b=cTPeygPIJGWPv8tkEj+JQ6uP5WENdQC0aHinBMHqEhMQKRxKc6JPsKKQ/5M62jDc74
         LPzBwRtHWPZszgPXQAyKjpd3GTf+Yqgv4oJRx8u2brEulusUJ43TE9GAiGqv15qHnROR
         HflPNo19P4fowoFlsigoDAhJhB11hjhvRK1rZqihufyC9wC7L9KDpmUuBvekx25ottsn
         AkY4/c/Be2DGjv5H2iFHeGzYTEA0Xs4JJAueb5BlTv6fXh5OxNqOvYetHuYeWhY8UEyY
         DO/pMB6vBjM98l8/GfuElamH/p43uKi5Pc2vbz/EJNZIgW7fj89yn5U6JQV3AdHEHmBU
         ImaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r7ZTgjUgRTidWqkxUNmR2ccq1FlKOCeJj+Gw0n4e39s=;
        b=G8ws4WOhwbUkmtPdpxParuZFf9SFisNzfzicaeOQ5LTNThoV+buyKaCKD6GJ2bEKtn
         I3jprMTzw5cBiMk5oZkrVLnMXp3A4tBWVQ/hRyvzxPTvlNHhdWMeUgZ7Lmnh4n5lkguV
         0xVHb2gyYKtcuUtOIoQ+/YLBvNCasIIf3XMZFZAe3H9cEB3uzqckX6epFCqUS/0VDU56
         XxUYwETkUlBkQMSpddl9W1imAgRkBc/lvMuIYk4mlC9FrnqQxU9hXVWGSbYaiWASTXAm
         yAdGaT7aA2toxsROqBHZoEdaRcWPjzvtK3n9elxRMInYvsAGr9Yj/Y9ueGlhFSkn1bxM
         OtoA==
X-Gm-Message-State: AHQUAubU+Dem5wnqaFLS2VO1VvYzsOOlXzDJhwhnslRRrVJAeDDLTERR
        pRYEk+viehw3azRfsI11bKk=
X-Google-Smtp-Source: AHgI3IawaR+O+PWB+HMO4tXshX7sgsY7qL0rEic4txMo/RLzlOeRB8MmwpkwJrfeWB1Lsv8wNrAKwA==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr8326366wme.115.1551023687364;
        Sun, 24 Feb 2019 07:54:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d1sm2686494wrs.13.2019.02.24.07.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 07:54:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, christian.couder@gmail.com,
        avarab@gmail.com
Subject: Re: [WIP 7/7] upload-pack: send part of packfile response as uri
References: <cover.1550963965.git.jonathantanmy@google.com>
        <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
Date:   Sun, 24 Feb 2019 07:54:44 -0800
In-Reply-To: <aae0f669627d7be45a967c6df464bf1ecdabce6d.1550963965.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Sat, 23 Feb 2019 15:39:01 -0800")
Message-ID: <xmqqef7xmbaz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index db4ae09f2f..6dbe2e9584 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -656,6 +656,60 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
>  	test_i18ngrep "expected no other sections to be sent after no .ready." err
>  '
>  
> +test_expect_success 'part of packfile response provided as URI' '
> ...
> +		if test "$(grep "^[0-9a-f]\{40\} " out | wc -l)" = 1
> +		then

Against this, test-lint-shell-syntax barks.  You'd have seen it if
you did "make test".

I am not sure hard-coding 40 here is a good idea for longer term, as
we are *not* testing that the output from "verify-pack --verbose"
shows the full object name in SHA-1 hash.

Perhaps squash something like this in ("16" is of course negotiable)?

 t/t5702-protocol-v2.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 6dbe2e9584..e9950f0853 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -694,7 +694,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	for idx in http_child/.git/objects/pack/*.idx
 	do
 		git verify-pack --verbose $idx >out &&
-		if test "$(grep "^[0-9a-f]\{40\} " out | wc -l)" = 1
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 1 out.objectlist
 		then
 			if grep $(cat h) out
 			then
