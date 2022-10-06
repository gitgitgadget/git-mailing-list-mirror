Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28EDC4332F
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiJFQCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiJFQCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:02:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA723B14E4
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:02:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e18so3497050edj.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zirJN/mpn38ug6uxO73k9eUj43twQ2tvLzQcsNVfcXU=;
        b=NfH5/VNXnO3Gxso9v4onYjBqXNVQZHJu9J4IZbfpHIg2w+OuU+A/q1HtaAIFbOgJfv
         0ORva5M7ZjSo5KNjRZR1oTVpdMb0xQxdeDZkklZdsyi0b+pwlqJrWHuuzjZyO+SguPzy
         rvCWp1hoHGxZS1gSHIQDuirUKBoiwv64UvUJBkMR3CUc7eCkRhqYDVChLc/kOuZ/7c1K
         IjMFIezzHIptY/Fu115wJWSZ/Y6CxzNxJouEvcwv76NtCmSKMuPD4WdYb0EKOHWKE6ME
         DPelRXIO/6h9WpzUh36bPH5xbPAe1+biwhlbhfSd6aKMGAYzFsFsHWTCOE3s0gudTpzu
         jEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zirJN/mpn38ug6uxO73k9eUj43twQ2tvLzQcsNVfcXU=;
        b=FUwdNcReTEU6QOkXRGZvDG8jrhZv0Jv3u4FOBYShtKt32NxVrAw04r3nPB1IBzjiaL
         xLYgUK599JgWJGarbYTGi4Bh17+squ3SG2D5gf9VR8Pec7Y9O3SKQiuKobcK8m8k6qGR
         J/5L/S/dg7NCGC3T3kWcP1Ka7cyDpsr6a+p0Do29haXCe/adorujcFl8rz0qUcQP64MA
         zivMpqa+/HVT7P5VL+ngTWMWTkcxnmiCBR7FdRJo+1yGKWiqRwAwFSI7/UTc0MsdDrqy
         jbIu3NQhv0LyW515SD9oy5WwB31cDlwa80sqGb8+WImL9EJ5sELy/KVCwWDIc/3p4aGq
         kSnQ==
X-Gm-Message-State: ACrzQf3nkyJ8dsFPf0oOiW0hdGMxjqw9x2P7b22BYnWmFahaWLIdx+Uj
        o7LYMyXylJYp+BqU6Lrld06K3ausybI=
X-Google-Smtp-Source: AMsMyM5gEB6Tol2BoIdx2qMf+m7/F8wMhWRAhYz14kX+00MwoUti9NOEZxjSC5wO3gDkmofzyxNNlQ==
X-Received: by 2002:a05:6402:d58:b0:458:5eca:a2c9 with SMTP id ec24-20020a0564020d5800b004585ecaa2c9mr472995edb.306.1665072133670;
        Thu, 06 Oct 2022 09:02:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00731582babcasm10549748ejz.71.2022.10.06.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 09:02:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogTK4-002xVx-2w;
        Thu, 06 Oct 2022 18:02:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] [RFC] test_todo: allow [!] grep as the command
Date:   Thu, 06 Oct 2022 17:56:00 +0200
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <645fa2990f79bdb7ee00ff3fd34122676469a783.1665068476.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <645fa2990f79bdb7ee00ff3fd34122676469a783.1665068476.git.gitgitgadget@gmail.com>
Message-ID: <221006.864jwhrldr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Many failing tests use grep, this commit converts a sample to use
> test_todo(). As POSIX specifies that a return code greater than one
> indicates an error rather than a failing match we take care not the
> hide that.

Ah, so on the one hand this gives me second thoughts about my stance
in[1], i.e. if we just allowed any command we wouldn't be forced to add
these sorts of special-cases.

Although, we could also allow any command, and just add smartness for
ones we know about, e.g. "grep".

But I do find doing this to be weirdly inconsistent, i.e. caring about
the difference between these two:

	$ grep blah README.md; echo $?
	1
	$ grep blah README.mdx; echo $?
	grep: README.mdx: No such file or directory
	2

Is basically why I took the approach I did in my [2], i.e. to force us
to positively assert *what* the bad behavior should be.

Which is why I ended up doing my verison of this sort of thing as [3],
i.e. you'd need to assert what specific exit code you expected, or
equivalent.

But at this point in the series:
	
	diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
	index fa7831c0674..086eaf91351 100755
	--- a/t/t3600-rm.sh
	+++ b/t/t3600-rm.sh
	@@ -801,7 +801,7 @@ test_expect_success SYMLINKS 'rm across a symlinked leading path (w/ index)' '
	 	test_todo test_must_fail git rm d/f &&
	 	test_todo git rev-parse --verify :d/f &&
	 	test -h d &&
	-	test_todo test_path_is_file e/f
	+	test_todo test_path_is_file blah
	 '
	 
	 test_expect_success 'setup for testing rm messages' '

So, for our own test_path_* helpers we're not going to care at all, and
any failure will do (including a missing file), but we will care for
grep?

I'm obviously more on the "let's care" side, I just find it odd that
you've picked this halfway point here, but not for other things you're
wrapping.

1. https://lore.kernel.org/git/221006.868rltrltu.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/
3. https://lore.kernel.org/git/patch-5.7-553670da8a9-20220318T002951Z-avarab@gmail.com/
