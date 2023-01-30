Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA937C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjA3VVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjA3VVb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 16:21:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717733669A
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 13:21:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z1so5495624plg.6
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfBPpDxegS0B+WY4WibHkD/xt0iNtNYZR971X+xQWuU=;
        b=FoNv6/gXZQewy08yCUyCxQzW1tv6Lp5EJL056qdu2mYmSDzXYEdKRDxWlX29nmx4TC
         SlJd8P22BIXiTd6sQL85k4N9Ngb2VZhBCEAgLMYZxjV9FVrzSP7JFevYX5pPs3bnnx0s
         BCnWPlTVlSteYmiEqObceUKquec01rjIOLm3J6gymX/HzQNMep0rqIWT/FcsbsTs5on7
         vD+/QSO6wVmPcafFVVauolb8RRLTiBv9n1R+hXVgsBMeW3AbS1lHdyNIRaJ75PRby5TP
         QEuqBDJYsAi0hELpmG05VqIrUP8ER1snr7K7xCC5yS0hZGG+qarvDEED6jmuKJ1LE7rS
         6Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bfBPpDxegS0B+WY4WibHkD/xt0iNtNYZR971X+xQWuU=;
        b=UimiJ+aXJEkf/OEmKVGbW0M67MV8U2UJEfZjVU1IhsoOqcIWkTFxZNW8UB1Bb0+jio
         EB0Lb4S1whfj7frSMOn1krF0UJSgw1AzvJ/k325SrlCjIezuRQrb21aUXs5pmb+67vMM
         k/7eSxZJiPik4GIfyb4p+PreK5rYnd9zoqzsgGySfA5+1nOe+Ws5XVHnYKXPucOC6zWq
         94qPZ0x0i6bmNmeJ6B/rMm/ie7tRDKVWuyg3s114VU6dKyW5iMKw0GSPdYL96ojsm7nw
         p05L4B3olN64N6doDWEUW2zZZ9uWkHmgA0nDIoAGTNivH0Rso4OENi0/DdqQJBHbKEm7
         h/LA==
X-Gm-Message-State: AO0yUKUKOOVY1Hzfbf8BmKrfIc1R6x3AXABhKKg8E0YOznWzVc/cEw48
        oEM7lhGe5D9YKVZMlUZw/TM=
X-Google-Smtp-Source: AK7set8TnYAF3yuXO/QBQOMQjWMHd/bNzcBOLJOCeVZNq9UcCTEdM05+ILX1mDIgVX6r4CyhV0jErg==
X-Received: by 2002:a17:902:f38d:b0:192:751c:6e8d with SMTP id f13-20020a170902f38d00b00192751c6e8dmr7980831ple.58.1675113689859;
        Mon, 30 Jan 2023 13:21:29 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709026a8c00b0019603cb63d4sm8199884plk.280.2023.01.30.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:21:29 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
        <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
        <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
Date:   Mon, 30 Jan 2023 13:21:29 -0800
In-Reply-To: <xmqqlelj3hvk.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Jan 2023 12:08:31 -0800")
Message-ID: <xmqqk0131zxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Having said all that, I do not mind queuing v2 if the "use *NO_JIT
> to disable" is added to the message to help users who are forced to
> redo the query.

In the meantime, here is what I plan to apply on top of v2 while
queuing it.  The message given to die() should lack the terminating
LF, and the overlong line can and should be split at operator
boundary.

Thanks.

 grep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git c/grep.c w/grep.c
index 59afc3f07f..42f184bd09 100644
--- c/grep.c
+++ w/grep.c
@@ -357,7 +357,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			p->pcre2_jit_on = 0;
 			return;
 		} else if (jitret) {
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'%s",
+			    p->pattern, jitret,
+			    pcre2_jit_functional() 
+			    ? "\nPerhaps prefix (*NO_GIT) to your pattern?" 
+			    : "");
 		}
 
 		/*
