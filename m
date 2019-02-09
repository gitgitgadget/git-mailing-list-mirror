Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B231D1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfBISZa (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:25:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53461 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBISZa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 13:25:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so9462533wmb.3
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SfO1m4hZTuDru9nixNaihz8VtFbfnwpC3c4MhV4ksyQ=;
        b=aGjgpfv3lovH3dwJNz2y3JGixQMyet7lqwzQ5opUH8yp+2UO8ns7CgQQR1hDeXGE5l
         kocN4+W7ofsWxbiBQo9+1mUgutTfzzZW9h7R+fbsBqFHyWK5Fqd7cUttQtCZbqk278Wp
         O3DRcfLvyHQ5hpIhfdxcfr4/XlBDAyevhBtcalXf2AZXEKN4YBmT0jUh75Bw2dYW+PTR
         408x7s3EdHx+cb5fVJKb+xTC1PTE9mldnKfpE7k4ixXQ0g2vZwy5jB4ff0LTvzU0pgFg
         fIvO5ibDg7dGqCNxtwRcmEnfk/XHatA3IRHnvJA6dzpaTB9wHZO6wHLWykBz1wsQ647P
         Ux9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SfO1m4hZTuDru9nixNaihz8VtFbfnwpC3c4MhV4ksyQ=;
        b=ObSSSD/hdEk9NmOZ3s+Od3qqGhuyXTTXS/kKNYBQRL3Cg8p2Y7/BrmYhkpxG5Xoifo
         beFJvOWh72/AUXlJe7xZn127TX8dvd2cSk9+XvUUL6SOLHHytno7sDpePJFtYcx1Mhjb
         eMNdJkv/jw3oHs0dlXglUa7yzzrMyPMNbOMF2NGPxCndz0aM4anGbnSftT9U0SoILCpB
         rf5md2I4QmXH0UNR0Q4HQu8jM9D16DU26HHDxN/OjfV49q8HzJlGqxen5ZCa8jbOm3DX
         umqZLLMVscKzdeVqr5bqTsgiMF/KepCnSpIxJLmb6L6mCYCvL7+qnVvv3lbpzykp36vX
         CHkQ==
X-Gm-Message-State: AHQUAuYpGXmhTiEv+ZPUQTjIs26IIyCv91tS2kX2yT85GC4VJJA79hJo
        60Y0F2efP85f6jf4WyKo4VQ=
X-Google-Smtp-Source: AHgI3IalOtlAeHbPr6f/zR1nDgXIXva478ZgCtKf1D31ZEv8W478O5BQ4o6YoZDpnrkK09aBz45j/Q==
X-Received: by 2002:adf:dd4b:: with SMTP id u11mr10859082wrm.307.1549736727635;
        Sat, 09 Feb 2019 10:25:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i20sm5087786wml.9.2019.02.09.10.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 10:25:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Fix v2] t5562: remove dependency on /dev/zero
References: <20190208220751.9936-1-randall.s.becker@rogers.com>
        <f01141d4-e77e-24ba-2354-e7aebc2c3c57@kdbg.org>
Date:   Sat, 09 Feb 2019 10:25:26 -0800
In-Reply-To: <f01141d4-e77e-24ba-2354-e7aebc2c3c57@kdbg.org> (Johannes Sixt's
        message of "Sat, 9 Feb 2019 09:46:12 +0100")
Message-ID: <xmqqwom8izu1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> How many bytes are needed here? yes() in test-lib.sh generates only 99
> 'y', if I am not mistaken.

I think we will not use "yes" in the end for this topic, which makes
this comment totally irrelevant to the thread, but I wonder why we
have the limit of 99 there?  It cannot be "we do not want to worry
about sigpipe" affecting the end result of the test (after all the
reader may stop reading from after reading just one, and the status
of the upstream process that would die with sigpipe is lost anyway).

It turns out it is about sigpipe ;-) but in somewhat a different
way.  To prevent others from wasting their time wondering about
this, probably we want to have something like the attached?

 t/README      | 9 +++++++++
 t/test-lib.sh | 6 +++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 1326fd7505..f4e1a82657 100644
--- a/t/README
+++ b/t/README
@@ -927,6 +927,15 @@ library for your script to use.
    test_oid_init or test_oid_cache.  Providing an unknown key is an
    error.
 
+ - yes [<string>]
+
+   This is often seen in modern UNIX but some platforms lack it, so
+   the test harness overrides the platform implementation with a
+   more limited one.  Use this only when feeding a handful lines of
+   output to the downstream---unlike the real version, it generates
+   only up to 99 lines.
+
+
 Prerequisites
 -------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 42b1a0aa7f..541a37f4c0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1313,7 +1313,11 @@ then
 	fi
 fi
 
-# Provide an implementation of the 'yes' utility
+# Provide an implementation of the 'yes' utility; the upper bound
+# limit is there to help Windows that cannot stop this loop from
+# wasting cycles when the downstream stops reading, so do not be
+# tempted to turn it into an infinite loop. cf. 6129c930 ("test-lib:
+# limit the output of the yes utility", 2016-02-02)
 yes () {
 	if test $# = 0
 	then
