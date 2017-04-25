Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C936207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 06:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980488AbdDYGFT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 02:05:19 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33639 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979354AbdDYGFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 02:05:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id 63so8711639pgh.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ag6sbKVpgM66EUuwl6NUQvOwaibwy5TJ8FQ3WAVgkAQ=;
        b=udEQ7cDh3obv2qD8BV2fNGNKVziwCt4ssXakQyfwldCUN2Ie4n0StBGJlzgKB4INRb
         H5oy7PjEdjjtMEt8eZLS/WvmrgF4jg9l2mA4eL+hi+D5UT0O+NzDslE+dUf+bIlWkAXf
         b3FQ/YM8zzhPKmTMTrGhcnT4bNuu2rS7V463eVFQ/XF5yCC2nNZ+/tSlxqMxAzB1W0T8
         9p5l+86D9igiUVcfEjpDIiP+wZBBs7UfOAnhivnFy58iQEDnaa0py+S+Cs6TKBhAQApN
         ifdU4WefbyPF3rXkGapsMECDwHJfV3+E76LKdF9XnJcpOyKzOMEc9X+9QsC+3PgeOSpu
         ba+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ag6sbKVpgM66EUuwl6NUQvOwaibwy5TJ8FQ3WAVgkAQ=;
        b=KbjW9tc2m96MPQL+7fv1G5sIdvBZyWWIPRy67gWTCYr6HYReB48mSMcc2w26hRH/kz
         iq9AYp1wfFqXQeOsHE7/LUm3NzhXBu5txIQchVbmbdJNNTdPAPddTMijFepMMLhPlbRY
         fqklP49DakC9DsKiGGb4yi+ERBK2fHyGK46u1smp7hSqBSnpdLFprLm0CwFMkVAW9thB
         NbSixjJ8bjRdjp2+nAt0binYNIZ7OUbaO937RrDF7QIvMpTRNRnA6+CHGGJ3Zzuw8nnD
         7qtLI3fwaScBQBQ6qVbKleaul5CKgg80cbzQ2BzGtJJiWlKb+qgZdquSvqJMywh9eV38
         eQng==
X-Gm-Message-State: AN3rC/4wdi4dGh03zeAZpeUt7GtPvnFaPVSnNsfjRrpxBSnHyTNUccjJ
        Nzsc1nFS2OksXA==
X-Received: by 10.84.174.197 with SMTP id r63mr36308844plb.67.1493100316631;
        Mon, 24 Apr 2017 23:05:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id s10sm33960002pfe.28.2017.04.24.23.05.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 23:05:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
        <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
        <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
        <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
        <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
        <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
        <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
Date:   Mon, 24 Apr 2017 23:05:15 -0700
In-Reply-To: <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Apr 2017 03:52:42 -0400")
Message-ID: <xmqqmvb5uin8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Good point. There's only one caller, but it does care about being in
> that directory.
>
>> Second try that hopefully is much less damaging

I've been carrying it as a SQUASH??? patch, but I think it is better
to split it as a separate pach, as removal of $remove_trash is an
optional thing.  The main thing, i.e. SZEDER's "abort when trash is
already gone or when we cannot remove" _can_ be (and is) correctly
done with his pach alone.

So here is what I queued on top.

-- >8 --
Subject: [PATCH] test-lib: retire $remove_trash variable

The convention "$remove_trash is set to the trash directory that is
used during the test, so that it will be removed at the end, but
under --debug option we set the varilable to empty string to
preserve the directory" made sense back when it was introduced, as
there was no $TRASH_DIRECTORY variable.  These days, since no tests
looks at the variable, it is obscure and even risks that by mistake
the variable gets used for something else (e.g. remove_trash=yes)
and cause us misbehave.

Rewrite the clean-up sequence in test_done helper to explicitly
check the $debug condition and remove the trash directory using
the $TRASH_DIRECTORY variable.

Note that "go to the directory one level above the trash and then
remove it" is kept and this is deliverate; test_at_end_hook_ will
keep running from the expected location, and also some platforms may
not like a directory that is serving as the $cwd of a still-active
process removed.

We _might_ want to rewrite

    cd "$(dirname "$TRASH_DIRECTORY")"

further to

    cd "$TRASH_DIRECTORY/.."

to lose one extra process, but let's leave it to a later patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cb0766b9ee..976566047d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -760,12 +760,15 @@ test_done () {
 			say "1..$test_count$skip_all"
 		fi
 
-		test -d "$remove_trash" ||
-		error "Tests passed but trash directory already removed before test cleanup; aborting"
+		if test -z "$debug"
+		then
+			test -d "$TRASH_DIRECTORY" ||
+			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
-		cd "$(dirname "$remove_trash")" &&
-		rm -rf "$(basename "$remove_trash")" ||
-		error "Tests passed but test cleanup failed; aborting"
+			cd "$(dirname "$TRASH_DIRECTORY")" &&
+			rm -fr "$TRASH_DIRECTORY" ||
+			error "Tests passed but test cleanup failed; aborting"
+		fi
 
 		test_at_end_hook_
 
@@ -921,7 +924,6 @@ case "$TRASH_DIRECTORY" in
 /*) ;; # absolute path is good
  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
 esac
-test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
2.13.0-rc0-308-g931de5db53

