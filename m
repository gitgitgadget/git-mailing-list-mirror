Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABBC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiARP5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiARP5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:57:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E11C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:57:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so81508738edd.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1mo4A3JoFqbYceK+Ij85bsFBKkC925ALwVaDVRUzX0E=;
        b=DqaiJ6bn+a/kna6dQQTFt+FcjAOP79xsrHxXg97h1IE0/WBugdeToD+DEy84MH0T/5
         wEn1hjfJ/hYVCtyS+Vr/3FRv6SCk/9CyQVZ3TKCoRn7ax/M3PNSrwBbCGJxCb8Yte/7i
         z+MoGexKAlwwPISMkFq7QixtpD0y2XDHW7YiVWbugMkWmM2WfMSuK8ci8nS5kiPPHgg4
         DFVDFmqvz9XJt0MWfUKEbx46HM4UeLZNkv9a5VrJmzdqD2tWF/skCmWo/rNMttF7B6Pg
         PH6ulbNguFRZWbWtEzWJmypRszTKSPIysuSpWTN0wLhl+ay1YwZxNwopiAcGrSO25HQa
         WYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1mo4A3JoFqbYceK+Ij85bsFBKkC925ALwVaDVRUzX0E=;
        b=bjECYQXhwWm7az3ILLKaca/7DZJvR/VLE9Dl6x+gbemwe5U0gPoi8dS7/f5ChKMXTq
         UsNLW5dpyhOFGnHIlidkKKGDeEP9vh9e60KK+u1Ww06ZXiuNgiL2hZKLKt7caGZNV/a5
         HpZi+73b5/b2TMCqvYfHlfhE2MApsSg88lQLOshipew+blXYNcd8MdVwfs91YJujPl8j
         m2of0fPqKbp9ImZIffFYRMlXZJK5dFwJ4s7zfK+PpqZ1YiPj03w4Y+lkNGMVKOUSZSiZ
         5Ib65caYIWHGnlQkmb8b65YJwTqM0MRjIUfOZV6wioVfH13RbdtnR3gifnfp5r7Q9udk
         QJUA==
X-Gm-Message-State: AOAM531bqbBEFABReSh4DIdygwMJSknAV+aJkk2BPtQbMoL2rsPh9cMA
        J3mQxi8tKjsItBlar5leoWAJ3BYf/H2wug==
X-Google-Smtp-Source: ABdhPJzzB6HlRaGbS9tb4eT3GDrJ4+1bEH10Py7uM2gZ7yaaekZKYZMwTdllM8bfG5ruAl8r7DnmEA==
X-Received: by 2002:a17:907:7206:: with SMTP id dr6mr3950170ejc.146.1642521468605;
        Tue, 18 Jan 2022 07:57:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i26sm55208edq.28.2022.01.18.07.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:57:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9qrj-001eJp-NF;
        Tue, 18 Jan 2022 16:57:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/grep-patterntype (was: What's cooking in git.git (Jan 2022, #04;
 Fri, 14))
Date:   Tue, 18 Jan 2022 16:56:02 +0100
References: <xmqqy23h4nss.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqy23h4nss.fsf@gitster.g>
Message-ID: <220118.86ee55ox38.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> * ab/grep-patterntype (2021-12-27) 7 commits
>  - grep API: call grep_config() after grep_init()
>  - grep.c: don't pass along NULL callback value
>  - built-ins: trust the "prefix" from run_builtin()
>  - fixup! grep tests: add missing "grep.patternType" config tests
>  - grep tests: add missing "grep.patternType" config tests
>  - log tests: check if grep_config() is called by "log"-like cmds
>  - grep.h: remove unused "regex_t regexp" from grep_opt
>
>  Some code clean-up in the "git grep" machinery.
>
>  Reroll exists.
>  source: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>

That v7 you hadn't picked up had a merge conflict with "master", which I
submitted a v8 for just now:
https://lore.kernel.org/git/cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com/

Obviously not for v2.35.0, but submitting it now anyway in case queuing
it helps to have topics ready for the post-release. I think in its
current form it should be ready to merge down in one of the first
batches post-release.
