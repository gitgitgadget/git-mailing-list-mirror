Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173AC20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeLMORY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 09:17:24 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38814 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbeLMORX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 09:17:23 -0500
Received: by mail-wm1-f48.google.com with SMTP id m22so2563665wml.3
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GlXAhsi2FcS4Epkx8AfAv0nwyh+9M8GEGiqHHfXwomw=;
        b=DV6r0NiOSBxR7YT/JJ4vFYR7VzAWUm3QIMEaIFfASpWyEUp5T3O0wQWCsstFndm8Do
         oQ9C+Q93uMhChI9Gpc60wE+0KuVjD4wrXx+AdSd9n7+72N+z/tb7qoOefosx9SDmyN4Z
         7R62v9HS4yHoHlDOtyiaajaNFi3YxRppFTJiqbfCRVGb3vfal3kEVJFMliHXSc/PAlyN
         QFxPfjkOGzcdIh+1qcsQrjbg+JnIRSrgS+/GxbyjKJ2JpIhz+kyIBLY6PnGW2P43nHzb
         FBqew4dq5eg2D13dtX0BfkjuvyQUWbvFYO4KUlyD68WNLhq1QaOhOIEdyU9QBRSX6BzA
         YYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GlXAhsi2FcS4Epkx8AfAv0nwyh+9M8GEGiqHHfXwomw=;
        b=nkabPS5rW45F5szpO9R2VRA8Tb/MowKdhzp0I2Id1TYhN0fjVQtvTaiHqrrzoiiDmI
         0SIv7f6fhBZPYkV5n/fEubGPmfYhZ19jtuXCzdyRk02hcLstnBRXC8nB/KC8Td77f3hJ
         wS2wNmr4mQcoCNP4mLPL8NQAOtm5bM3oJfmJKPbVB1hLTWR+FIRd11e21jvMd0ObXasZ
         bJPU5+3+KG1CKNW9MJS0T4LuLkCq9KN+Z804ZqNcV9+U9b8BhM/q5mPeKA8FZqjVVIEa
         1ObUayE5Cm6PaYPYpA0E0+smVrMfH8iE9YwAIHDiDr/YJ92DxYvmUUVBbNVN9bx5rjfH
         +r9A==
X-Gm-Message-State: AA+aEWb57jyuAHekG5Zyyi3372CwlMfJVv4ATubqMp38RYeJNZ4z4ON1
        LEFgrM9aQ2eXNtHtmxJNtlo=
X-Google-Smtp-Source: AFSGD/VJgO9GqS0xEFimeAK98jN8ns5/FPoVdgVWaJbFIaA41/itqQ1ysOkeUdQSG/DaNUqTnhzrMg==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr9639961wmc.96.1544710641283;
        Thu, 13 Dec 2018 06:17:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n5sm1310361wrr.94.2018.12.13.06.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:17:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Sjon Hortensius <sjon@parse.nl>
Subject: Re: 2.20.0 - Undocumented change in submodule update wrt # parallel jobs
References: <CAHef355RQt9gN-7QjuAAT8mZsNFKfCo4hOYi2+bkp-0Av7W=Qw@mail.gmail.com>
Date:   Thu, 13 Dec 2018 23:17:20 +0900
In-Reply-To: <CAHef355RQt9gN-7QjuAAT8mZsNFKfCo4hOYi2+bkp-0Av7W=Qw@mail.gmail.com>
        (Sjon Hortensius's message of "Thu, 13 Dec 2018 10:15:52 +0100")
Message-ID: <xmqqva3xecjz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sjon Hortensius <sjon@parse.nl> writes:

> When switching to 2.20 our `git submodule update' (which clones
> through ssh) broke because our ssh-server rejected the ~20
> simultaneous connections the git-client makes. This seems to be caused
> by a (possibly unintended) change in
> https://github.com/git/git/commit/90efe595c53f4bb1851371344c35eff71f604d2b
> which removed the default of max_jobs=1
>
> While this can easily be fixed by configuring submodule.fetchJobs I
> think this change should be documented - or reverted back to it's
> previous default of 1

The commit in question does not look like it _wanted_ to change the
default; rather, it appears to me that it wanted to be bug-to-bug
compatible with the original, and any such change of behaviour is
entirely unintended.

I think the attached may be sufficient to change the default
max_jobs back to 1.

By the way, is there a place where we document that the default
value for fetchjobs, when unconfigured, is 1?  If we are not making
such a concrete promise, then I would think it is OK to update the
default without any fanfare, as long as we have good reasons to do
so.  For this particular one, however, as I already said, I do not
think we wanted to change the default to unlimited or anything like
that, so...

 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 789d00d87d..e8cdf84f1c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1552,7 +1552,7 @@ struct submodule_update_clone {
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
 	NULL, NULL, NULL, \
-	NULL, 0, 0, 0, NULL, 0, 0, 0}
+	NULL, 0, 0, 0, NULL, 0, 0, 1}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
