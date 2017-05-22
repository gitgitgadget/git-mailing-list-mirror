Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315061FF30
	for <e@80x24.org>; Mon, 22 May 2017 02:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757022AbdEVCO1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 22:14:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33351 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbdEVCO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 22:14:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so16488596pfe.0
        for <git@vger.kernel.org>; Sun, 21 May 2017 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UROOt90Mq0OcX0dSPNK3otYjvy4690xVo6EEl1t2faM=;
        b=h/IAG6ApdNjbZ8Ohv+hM4UFrw4eo6gPqxKNEQzzsAyXXCVDQKA2b2vMAeYhLGEN+RU
         JFqWkBHGm4oQgOmWXFE1LKBJq4rXgxknoOmAKofzYVUZAr0tPGb/qiyR3F99q4obwBIa
         NZSuRMuiUCVMFmdiLU1ItCUvVYgkGgJlidheC1lfVE6qoMF+KztQnlXZCyzK90BvGmxK
         t+4df6l86v4eagPrxIs0gsqVobkqHSgkZEuGwjvijq5eerxujacfUjxwLc6k9aPRSBT/
         y2sttw1JiyFGQ0D79Wau15+oYDJhZONpOEvdxMFCEyz39qg6aPra4jsoJOU4IQ4CR6rk
         NaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UROOt90Mq0OcX0dSPNK3otYjvy4690xVo6EEl1t2faM=;
        b=ll8osFO/hW+koqIqWxxFZqH8POXhBduGbpdcchtP/Y3ukKF+VJqbxUlcRiiNexwmFZ
         b/XqHqh1SUh65MmGbuTtfxdlmIRqNkWakt2HhM86PZ7Jo+AYpWq0PYgHSGHe9qW2sxDu
         jIRrbqb9bhIX0LSYncwnjyilIReNgu0B9kWe88N6izb7LdFeXPRNJCD1/LWwmUYcp4eR
         08YcJwI3R60B1fOoafaXdDIPQR6ko3rQ2Kcedg9yZVTgDZ2GBr5Gx6MbFeHNvieotBqO
         xwDBF2VyTA7QqQIJDUPo7/RxQ4W2uF6uL2mqWKOW2clV77ICjcZWmnHCNkHSBAIRJcV6
         S+2A==
X-Gm-Message-State: AODbwcDQKjPT3W1P2fky7KLigsfrmlVsYddVhekDVLuoa45LfA3x5Ig8
        NehwMZVSdvSLaA==
X-Received: by 10.99.112.29 with SMTP id l29mr23114402pgc.111.1495419265511;
        Sun, 21 May 2017 19:14:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id e124sm27300589pfc.64.2017.05.21.19.14.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 19:14:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v5] send-email: --batch-size to work around some SMTP server limit
References: <20170521125950.5524-1-zxq_yx_007@163.com>
Date:   Mon, 22 May 2017 11:14:24 +0900
In-Reply-To: <20170521125950.5524-1-zxq_yx_007@163.com> (xiaoqiang zhao's
        message of "Sun, 21 May 2017 20:59:50 +0800")
Message-ID: <xmqqlgpppri7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this is almost perfect.

I'd propose squashing the patch below to

 - Add cross reference between config and option

 - Spell configuration variables in camelCase to mimic other
   sendemail.* variables

 - Spell SMTP in all caps to mimic other parts of the manual

 - Suggest use of credential helper in the document to help the end
   users, not in the proposed log message.

If you are fine with all of these changes, there is no need to
resend (you can say so and I can locally squash these in).  Of
course, anyone is very welcome to point out documentation bugs I may
be introducing with this patch.

Thanks.

-- >8 --
Subject: fixup! send-email: --batch-size to work around some SMTP server limit

Some email servers (e.g. smtp.163.com) limit the number emails to be
sent per session (connection) and this will lead to a faliure when
sending many messages.

Teach send-email to disconnect after sending a number of messages
(configurable via the --batch-size=<num> option), wait for a few
seconds (configurable via the --relogin-delay=<seconds> option) and
reconnect, to work around such a limit.

Also add two configuration variables to give these options the default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt         |  8 +++++---
 Documentation/git-send-email.txt | 12 ++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a13315ed69..ee4a111878 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2914,13 +2914,15 @@ sendemail.xmailer::
 sendemail.signedoffcc (deprecated)::
 	Deprecated alias for `sendemail.signedoffbycc`.
 
-sendemail.smtpbatchsize::
+sendemail.smtpBatchSize::
 	Number of messages to be sent per connection, after that a relogin
-	will happen. if the value is 0 or undefined, send all messages in
+	will happen.  If the value is 0 or undefined, send all messages in
 	one connection.
+	See also the `--batch-size` option of linkgit:git-send-email[1].
 
-sendemail.smtprelogindelay::
+sendemail.smtpReloginDelay::
 	Seconds wait before reconnecting to smtp server.
+	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 5380d8c956..79b418bfa5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -250,14 +250,18 @@ must be used for each option.
 
 --batch-size=<num>::
 	Some email servers (e.g. smtp.163.com) limit the number emails to be
-	sent per session(connection) and this will lead to a faliure when
+	sent per session (connection) and this will lead to a faliure when
 	sending many messages.  With this option, send-email will disconnect after
 	sending $<num> messages and wait for a few seconds (see --relogin-delay)
-	and reconnect, to work around such a limit.
+	and reconnect, to work around such a limit.  You may want to
+	use some form of credential helper to avoid having to retype
+	your password every time this happens.  Defaults to the
+	`sendemail.smtpBatchSize` configuration variable.
 
 --relogin-delay=<int>::
-	Waiting $<int> seconds before reconnecting to smtp server. Used together
-	with --batch-size option.
+	Waiting $<int> seconds before reconnecting to SMTP server. Used together
+	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	configuration variable.
 
 Automating
 ~~~~~~~~~~
-- 
2.13.0-440-g3ce6d2d5b8

