Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7341F453
	for <e@80x24.org>; Mon, 29 Oct 2018 07:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeJ2QpW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 12:45:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46001 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2QpV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 12:45:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id n5-v6so7496268wrw.12
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tZt0D+aWJvqzosrcjWBt9iwnrDmmq8otHM+3vxpsW28=;
        b=ci/mVlqZiAu6uaNFFROeZBDRNASWcWyMKq3UDUwuGjuN9WxaAdKlyZQLwLMRO2weYZ
         ZqJd9qRneBDkbGYNCAr78Htfv4M4GZ2Jn3cgUYgCdoD8okBiUCE2OatHIuCCRADy6E0F
         ozan7eSmHt8Vck5m4qzehSWHqf3U5CQy0b/FgCY0j+YmvsjMsPcHXzA3yq1fwhoUIxId
         i088nnvhOLtXe0SFuc128daKbsLxxI8TO8SebY47zgOwUu0WeKj0WNhH3PI6uDqUkgOA
         lYTTOqfUYZmrkgT9SSg6brYwT6E68EapxISAkMghJXvUDtWuyHoX3+amj1yAYDx0990b
         X3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tZt0D+aWJvqzosrcjWBt9iwnrDmmq8otHM+3vxpsW28=;
        b=LYfziw9C2HZyHfM2kkP7bp95wMxeV1E9wR1Kijz3BBFZaDd9KcDM7Ph5TBPp6bgVTz
         /jH//YM24mexm/xbUMZjh/PgGFA15Q0PSf3R85t6GcjeChrnR4zyiFMYZQj/GyuaJXJW
         E4EClQv+8ZKscNo1Uq9pBxOzQ/P0nCk6O2kLY0UKjISsiTh8E3BrBTTcPs04LWwLU9Xf
         qMW187X0DtkGwX965zIuL9fl9Pnqy0iB5bjJh/dcztWZPztw6wyJwakXD90azszeDvqq
         jzU+RFycbKBgAfDwV0gI53dAU8ykR2itK7nnoNHUnpX+VOYT7ftV4C3urJRnT6FfjYw6
         e5CQ==
X-Gm-Message-State: AGRZ1gJ8fF2aRYFd3F5/AKWBlauPFTkhoo6YV+2BVuUuylldct64AcuQ
        pJR6BfIXEq90xEWUoIMNrc3J2sGws3w=
X-Google-Smtp-Source: AJdET5eeWfEZyCLhf0pKKa/BKv7zaTyHac73ttlInhyRD1xwtygVRkOnMqy1NFTK3LMEqtgVEAeSyg==
X-Received: by 2002:adf:e206:: with SMTP id j6-v6mr13476829wri.205.1540799869188;
        Mon, 29 Oct 2018 00:57:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l10-v6sm2108210wru.13.2018.10.29.00.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 00:57:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-8-avarab@gmail.com>
        <xmqq7ei144gn.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 29 Oct 2018 16:57:47 +0900
In-Reply-To: <xmqq7ei144gn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 29 Oct 2018 16:06:16 +0900")
Message-ID: <xmqqy3ah2nic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> This is the first use of the %N$<fmt> style of printf format in
>> the *.[ch] files in our codebase. It's supported by POSIX[2] and
>> there's existing uses for it in po/*.po files,...
>
> For now, I'll eject this from 'pu', as I had spent way too much time
> trying to make it and other topics work there.
>
>     CC remote.o
> remote.c: In function 'show_push_unqualified_ref_name_error':
> remote.c:1035:2: error: $ operand number used after format without operand number [-Werror=format=]
>   error(_("The destination you provided is not a full refname (i.e.,\n"
>   ^~~~~
> cc1: all warnings being treated as errors
> Makefile:2323: recipe for target 'remote.o' failed
> make: *** [remote.o] Error 1

I'll redo 'pu' with the following fix-up on top.

 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index c243e3d89e..1927c4b376 100644
--- a/remote.c
+++ b/remote.c
@@ -1035,8 +1035,8 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 	error(_("The destination you provided is not a full refname (i.e.,\n"
 		"starting with \"refs/\"). We tried to guess what you meant by:\n"
 		"\n"
-		"- Looking for a ref that matches '%s' on the remote side.\n"
-		"- Checking if the <src> being pushed ('%s')\n"
+		"- Looking for a ref that matches '%1$s' on the remote side.\n"
+		"- Checking if the <src> being pushed ('%2$s')\n"
 		"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
 		"  refs/{heads,tags}/ prefix on the remote side.\n"
 		"- Checking if the <src> being pushed ('%2$s')\n"
-- 
2.19.1-593-gc670b1f876

