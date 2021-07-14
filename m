Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF26C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A987613C8
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGNTfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhGNTfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:35:15 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A6C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:32:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j10-20020a056a00174ab029031e1e93e88dso2509520pfc.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nfoUUhml6N8bcZ16eex5YM/Y5D6/xYmNYCw40yQAOAc=;
        b=Unb+xPdjGjlldU4A/g31b/Rp+NCCqtycoBK73pz2nzDKceYYSl2tt0pqhBt3jF6tA0
         AXksYN1nDY0IzMEVGuqF7V0Co4mWX0JCVp83+LKZ0yuzQCbWID6ncf3rHPvpYU24nB1H
         OoM7m9USheA5qMukluE72IQCt0oKED5TAUcf/YBfnWL/vxxzn8J9B9jNd88NsMWF3U3D
         dZcfQj3+XALA6xC3+7LYfbMENeEI4nAuavGpHXVY3J4ct3NuLxc6IMS9ZHlrwXriQW5j
         H5syUl1kyzNNJRN/OpZg3B8NFBkTgA3NMO+kuAK7Qd5g6dxObohgFPqhG00bm7T1/8rM
         YU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nfoUUhml6N8bcZ16eex5YM/Y5D6/xYmNYCw40yQAOAc=;
        b=s10+1Ohq3L4huD66OR4Jvywb5AT20YmfqFu82HWEhkbdwJWc7IdAiXiRHIbBG84/Uu
         ej6bAE/yXZLtKbwDOWdYPyoLOCllWU+G9vatM4zQvRSoga+cCAUEBcBPEFT5CYQ7wj5R
         NceedFu5Fd9DXtHD4Lu/rCsSF0YW30VuKXfKFEHounwpv4wleTkjol0HrMJtWuHFzLFq
         Icwt9hDbe4zZ45zx0Iqxq1NGdOc8vc0/3pPCH0im+sQ4N7X0eahzH9acxf/FeQ9ira7s
         MNWoswpuo6YIJXHDQMZsVZU5m93qGGbUbUNGDrHi3BQjkQnL5/mO2MM8I16P1m9m9qXI
         VlCA==
X-Gm-Message-State: AOAM531y4ewkwfGS1Pw7IC3+B/EXMaXCevfZJsnycWLJp3v7N5703IwS
        1x+bMGkys7kqpztKBhvDi09QQ1yYMtj83vhpKuh1
X-Google-Smtp-Source: ABdhPJyqtFsrShb9/ZUzbLS3Y0uHnl/DVgK5gKdphi9cUvQmsOWUpKyVelUsbfY0kwWw6HUQQaLHm+z4PmC0MfVaGyV0
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bc44:b029:12b:415:57bf with
 SMTP id t4-20020a170902bc44b029012b041557bfmr8574673plz.33.1626291143000;
 Wed, 14 Jul 2021 12:32:23 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:32:20 -0700
In-Reply-To: <87bl753i2p.fsf@evledraar.gmail.com>
Message-Id: <20210714193220.4083070-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87bl753i2p.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: Re: [PATCH 1/3] send-pack: fix push.negotiate with remote helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +test_expect_success 'http push with negotiation' '
> > +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> > +	URI="$HTTPD_URL/smart/server" &&
> > +
> > +	rm -rf client &&
> 
> Nothing in this test file has created a "client" directory at this
> point, so we shouldn't have this to remove it.
> 
> I think the real reason for this is that you're just copy/pasting this
> from elsewhere. I've got an unsubmitted series where I fixed various
> callsites in these t/t*http* tests to use test_when_finished instead.
> 
> This pattern of having the next test clean up after you leads to bad
> inter-dependencies, there were a few things broken e.g. if earlier tests
> were skipped. Let's not continue that pattern.

OK - I have changed it so that each test is independent and cleans up after
itself.

> 
> > +	git init client &&
> > +	test_commit -C client first_commit &&
> > +	test_commit -C client second_commit &&
> > +
> > +	# Without negotiation
> > +	test_create_repo "$SERVER" &&
> 
> s/test_create_repo/git init/g

Done.

> 
> > +	test_config -C "$SERVER" http.receivepack true &&
> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> > +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
> > +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
> > +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> > +
> > +	# Same commands, but with negotiation
> > +	rm event &&
> > +	rm -rf "$SERVER" &&
> 
> Ditto test_when_finished, or actually:
> 
> > +	test_create_repo "$SERVER" &&
> > +	test_config -C "$SERVER" http.receivepack true &&

In my current version, I have changed everything to "git init". Should I
use "test_create_repo" instead?

> 
> If we're entirely setting up the server again shouldn't this just be
> another test_expect_success block?

I only made one block at first because the test without negotiation is
there just for comparing object counts, but OK, I have split it up into
2 blocks.

> 
> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> > +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
> > +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
> > +	grep_wrote 3 event # 1 commit, 1 tree, 1 blob
> > +'
> > +
> > +test_expect_success 'http push with negotiation proceeds anyway even if negotiation fails' '
> > +	rm event &&
> > +	rm -rf "$SERVER" &&
> > +	test_create_repo "$SERVER" &&
> > +	test_config -C "$SERVER" http.receivepack true &&
> > +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> > +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> > +	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
> > +		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&
> > +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> > +	test_i18ngrep "push negotiation failed" err
> 
> s/test_i18ngrep/grep/, or actually better yet is there a reason not to
> do test_cmp here? I'm pretty sure there's not.
> 
> The reason I've got that unsubmitted series is because I found a bug
> that was cleverly hidden away by an earlier such 'grep the output'
> code/test you'd added recently.
> 
> There *are* cases where we e.g. get STDERR output from the OS itself
> about bad connections, or races, but we should at least:
> 
>     grep error: <stderr >error-lines.actual &&
>     test_cmp error-lines.expect error-lines.actual
> 
> To check that we get the errors we expected, and *only* those.

I didn't want to make the test prescribe unnecessary details, but good
point about hiding bugs. I have switched it to what you describe.

> 
> > +'
> > +
> > +# DO NOT add non-httpd-specific tests here, because the last part of this
> > +# test script is only executed when httpd is available and enabled.
> > +
> >  test_done
> 
> Also, instead of this comment let's just create another
> t*-fetch-push-http.sh test. Because:
> 
>  * This test is already really slow, it takes me 13s to run it now. I
>    haven't tested, but setting up apache will make it even slower.
> 
>  * It's also an anti-pattern to switch midway to needing an external
>    daemon v.s. doing it in a dedicated test.
> 
>    E.g. if you have the relevant GIT_* settings to run http:// tests,
>    but not git:// tests we'll skip the former entirely in
>    t5700-protocol-v1.sh, because we'll "skip all" as soon as we see we
>    can't start the git-daemon.
> 
>    That specifically isn't an issue here, but better to avoid setting up
>    the pattern.

I think this is a pattern that we need, though. Sometimes there are
closely related fetch/push tests (as in here, and as in t5700) that want
to test similar things across different protocols.

> 
>  * What *is* an issue with it here is that the "skip all" in TAP is only
>    handled before you run any tests, e.g. compare:
>        
>        $ prove ./t5700-protocol-v1.sh
>        ./t5700-protocol-v1.sh .. ok    
>        All tests successful.
>        Files=1, Tests=21,  2 wallclock secs ( 0.02 usr  0.00 sys +  0.80 cusr  0.80 csys =  1.62 CPU)
>        Result: PASS
>        
>        $ GIT_TEST_GIT_DAEMON=false GIT_TEST_HTTPD=false prove ./t5700-protocol-v1.sh
>        ./t5700-protocol-v1.sh .. skipped: git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)
>        Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.02 cusr  0.00 csys =  0.03 CPU)
>        Result: NOTESTS
>        
>        $ GIT_TEST_GIT_DAEMON=true GIT_TEST_HTTPD=false prove ./t5700-protocol-v1.sh
>        ./t5700-protocol-v1.sh .. ok    
>        All tests successful.
>        Files=1, Tests=16,  1 wallclock secs ( 0.01 usr  0.00 sys +  0.63 cusr  0.59 csys =  1.23 CPU)
>        Result: PASS
>    
>    I.e. if you stick an inclusion of lib-httpd.sh this late in a test
>    file we won't get a prominent notice saying we're categorically
>    skipping certain types of tests based on an external dependency.
> 
>    If you had your own dedicated test instead you'd get:
>        
>        $ GIT_TEST_HTTPD=false  prove ./t5705-protocol-v2-http.sh 
>        ./t5705-protocol-v2-http.sh .. skipped: Network testing disabled (unset GIT_TEST_HTTPD to enable)
>        Files=1, Tests=0,  0 wallclock secs ( 0.01 usr  0.01 sys +  0.02 cusr  0.01 csys =  0.05 CPU)
>        Result: NOTESTS

Is it useful to know the count of tests that are skipped? (The user
presumably already knows that some are skipped because they set the
environment variable in the first place.)
