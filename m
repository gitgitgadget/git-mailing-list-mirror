Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17FBC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356105AbiDOVgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355444AbiDOVgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 17:36:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C8B3DCC
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 14:33:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l10-20020a17090a72ca00b001cd46918af5so5230882pjk.8
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RgCFxaHjNCqK06Kp8PQiraIjdLYD2vZXyC+IKHSdFoo=;
        b=a1/YcYootoCmmUG7r2pP2u0WxlqoumgRZdJa3CERIeKz0WaxCzyP25B7kMo5ZUPFCj
         v13a2q4CF252YhCUHsRnRJmYCZRSK3wKmMGWIGI4yLFE6+fh5Jyg07+I0UtvNhQru5yZ
         Cugdv47fqNcHX/3BqWM/PbONUrpfmsXJFix1+PFvBN2GvCxWDDh5DQiLcLnlAD4kixgY
         LAI0xKL1Fhf7pI10dyWEQmS5V3MbRO/TX/dmh9fWF+2f0sFxBxiPPbJ0mHVxEKmLjsMG
         /hedvxFV9uxeqnoinriKhxAiaRI3+iKsC9xQQY9RTHLF08LzTTC0a/Y1qTGEG0fBlThs
         T19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RgCFxaHjNCqK06Kp8PQiraIjdLYD2vZXyC+IKHSdFoo=;
        b=K56v3KkLZaoFtkwN2R5P1yrN52nrVCizgyvnJpYxialKRHHGsUw2fZEscubA1V5vhm
         06283YevO9c0bBFim1BFWAtLnLq0pQuNXan419cYI3wPxrtalpduZZlSYk1/KuD49G+M
         fKLordD+xWvkuV7foXjL0AOqtWiG84txwDoT3Fs2TtEF9g9K53QvTMW483lG2D6fvBf/
         X5/R4b8/rMMbtYWUQB2FpvWhC3/GCoDwLzVd1RBmQ00Pc6i/zQlK8KBrzYAJareIAzuY
         1zGC/aT9jOmfkF6V/TRYhTKgdItKObojvFu1w6vbgIWMvZ1kKKqJTwM4+FYirsRnfruR
         6DqQ==
X-Gm-Message-State: AOAM530YSZLFPMUm6LjKj2J7/20z3vI4CTSZ3t0yqYMAjjFI8z/8Hm2U
        BW3atZQjq05bxilbST6j50BLQh7dX7Ij8g==
X-Google-Smtp-Source: ABdhPJz8VPDNw2yIsRytibG3pQsUH6f8mCzBOl8LinEYn1JRt5KFjdJIJqztJ4HScBHq6GNQaXHHpwlc48Q1Fw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:23d2:b0:4fa:f262:719 with SMTP
 id g18-20020a056a0023d200b004faf2620719mr872610pfc.4.1650058410675; Fri, 15
 Apr 2022 14:33:30 -0700 (PDT)
Date:   Fri, 15 Apr 2022 14:33:21 -0700
In-Reply-To: <xmqqbkx31sc0.fsf@gitster.g>
Message-Id: <kl6lbkx2821q.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnfs4kud.fsf@gitster.g> <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqbkx31sc0.fsf@gitster.g>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Yes, I mean that even the current directory will be ignored when
>> discovery is disabled.
>
> OK.
>
>>>                                                I am not sure that
>>> is realistically feasible (I am thinking of cases like "git fetch"
>>> going to the remote repository on the local disk that is bare to run
>>> "git upload-pack"), but if the fallout is not too bad, it may be a
>>> good heuristics.
>>
>> Good detail - I hadn't considered the impact on our own child processes.
>> I suspect this might be a huge undertaking. Unless there is significant
>> interest in this option, I probably won't pursue it further.
>
> I do not necessarily think so.  The entry points to transport on the
> server side are quite limited (and the client side is dealing with
> your own repositories anyway), and they already know which directory
> in the server filesystem to hand to the upload-pack and friends, so
> it would be a matter of passing GIT_DIR=$there when they call into the
> run_command() API, if they are not already doing so.

FWIW I experimented with turning off bare repo recognition altogether
and seeing what breaks.

CI Run: https://github.com/chooglen/git/runs/6042600953?check_suite_focus=true

AFAICT, most of the test failures are what we'd expect if we stopped
recognizing bare repos altogether. One stands out to me in particular
though - in t5550-http-fetch-dumb.sh, 

    git clone $HTTPD_URL/dumb/repo.git clone-tmpl

yields 

    ++ git clone http://127.0.0.1:5550/dumb/repo.git clone-tmpl
    Cloning into 'clone-tmpl'...
    fatal: repository 'http://127.0.0.1:5550/dumb/repo.git/' not found

This sounds to me like Git isn't recognizing the static http files as a
remote Git repo, and if so, --git-dir doesn't sound like it'll save us.
But I'm not that familiar with the transport code so I don't know if
this is a big deal or just a quirk with our httpd tests.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

diff --git a/setup.c b/setup.c
index 2600548776..794d9624d5 100644
--- a/setup.c
+++ b/setup.c
@@ -1196,10 +1196,10 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 			return GIT_DIR_DISCOVERED;
 		}
 
-		if (is_git_directory(dir->buf)) {
-			strbuf_addstr(gitdir, ".");
-			return GIT_DIR_BARE;
-		}
+		/* if (is_git_directory(dir->buf)) { */
+		/* 	strbuf_addstr(gitdir, "."); */
+		/* 	return GIT_DIR_BARE; */
+		/* } */
 
 		if (offset <= min_offset)
 			return GIT_DIR_HIT_CEILING;

