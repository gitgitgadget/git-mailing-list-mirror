Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E382A1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 05:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeGMGGC (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 02:06:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45976 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeGMGGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 02:06:02 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so30317190ioh.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 22:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=St4OYxKSVcujcepPUg67DuvMgYu6DTFV2Sp01TLYktY=;
        b=Ype+MK/mPk+NnoTvssPL+/0924aSbN9x4PqLPPd3dDgI+xjCcyVBRPna/gGXvIwpSL
         0Y4Wsr334xezLZTiyHlF16vHx3xalirsJKdSD0rL8bnen8WVFJy4uhn6CHx667iwqFby
         l0HWv58AepIiOq3qfhi0IWqg8FyU7Kck7wacgARocm6pK7CPJhs7bOiITi8e1ymXPAq4
         fGoj3/2xlBV3xveJG4b9xs16K2KioFxd4cT9IzJnQzfCa2z5EyOdxxA3pCyksTBdMDM4
         NU0bZ9cOnRYv8cf5eQAGP+7wcBiNwa4jJjXMJlQwshu99fWoB0GU0XzKnjddpaTbvmar
         5q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=St4OYxKSVcujcepPUg67DuvMgYu6DTFV2Sp01TLYktY=;
        b=Hzr5w7V7MGcYVTRdwIvp6A3qQgDaJXZjAZgIIpeuMbOmYpLQfJuuCdjQxyvsUqQEW5
         cUwCDv2DtC6Mjvdl/pvPuYIbvYTYbIpO21zWc8D1saE4ERoAtFzBXzt36dTJNBSQ6eQB
         Kq70+9tvw3PkP57vFEYY9Szva/9XIwL2ndpQqD1hifqkE7RVTtsxzykjBGxq142okhhC
         Bb2VOPkRwH1CGCAZxiZLyCRmnmXXXrXtjna2OnjpWj6wo8OqGwXIELmjsYb03koDha3U
         sN6HiwdkFSan4fmWqGiDiHIfo1JjSJuKpAAUL0JGsDo9L2gmjfzHaQyXx+o+tz4vs0Cf
         S/6Q==
X-Gm-Message-State: APt69E3zm7kFx82MGBnCExhuOdJpGF5y7Cs0iDRA4auX8v0AvEiDSag3
        dZTXj/plgf8G1yv4m40wGEl8jw==
X-Google-Smtp-Source: AAOMgpfsu7Tqb507yIrUUFbaQMqpBT10niUERcTtq/AOJMipkocOjMxWFdbCjlU39j8Gm65gxFC76Q==
X-Received: by 2002:a5e:cb47:: with SMTP id h7-v6mr17121920iok.178.1531461179529;
        Thu, 12 Jul 2018 22:52:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3138036ioj.22.2018.07.12.22.52.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 22:52:59 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/4] t/check-non-portable-shell: make error messages more compact
Date:   Fri, 13 Jul 2018 01:52:04 -0400
Message-Id: <20180713055205.32351-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e
In-Reply-To: <20180713055205.32351-1-sunshine@sunshineco.com>
References: <20180713055205.32351-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Error messages emitted by this linting script are long and noisy,
consisting of several sections:

    <test-script>:<line#>: error: <explanation>: <failed-shell-text>

The line of failed shell text, usually coming from within a test body,
is often indented by one or two TABs, with the result that the actual
(important) text is separated from <explanation> by a good deal of empty
space. This can make for a difficult read, especially on typical
80-column terminals.

Make the messages more compact and perhaps a bit easier to digest by
folding out the leading whitespace from <failed-shell-text>.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 11028578ff..f6dbe28b19 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -10,6 +10,8 @@
 
 sub err {
 	my $msg = shift;
+	s/^\s+//;
+	s/\s+$//;
 	print "$ARGV:$.: error: $msg: $_\n";
 	$exit_code = 1;
 }
-- 
2.18.0.233.g985f88cf7e

