Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F6C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiKHPVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKHPVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 10:21:08 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E7CD0
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 07:21:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so39522897ejc.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QpW+HzrHY35T3ET3dv93Nm5101K9THFwqoCp5/k4R0o=;
        b=BKGLSY5bKMvlr6Vqk5NXHrx3W8QC5W6+tZ60w75bULoK7Z4Ecwg+k+nZq7Q/hOvvai
         jvqTjHR/O0u4x0h22x6cm0MhYcvQV37S2o+lggIh/DTqNmpJD7dveiSyyS4dtlZ7PO6K
         Vjhgntlh2wenchRD2tZixpH2Lv9j8u+5amEVCLFWajsZTKccZFFauq6KzqRmWGWcZklb
         Et/5ysPWl8AwCkyGaDtFlANXBUIdAtriIfwIZ+uQOlwcglK0JMBvszXkGK4C2SqPNZHR
         mqswLQSreJikICbOchNhTS1Ah/vE0fNU3EHjIArWD/hXBS0To+3PZcno4VgqrwtD29uQ
         XnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpW+HzrHY35T3ET3dv93Nm5101K9THFwqoCp5/k4R0o=;
        b=xmaFg6mkTuyYh4jbYawih/MWBUZ9NG4N/5A8nXbvDjnfvIUwWq3t/hugJRLQY18nAs
         4dbkoQC4mT7u7vBdTXfjQpmcBS5mRjRHa6A3zPt0d1iNeANtLHcz7DkyaMcLw09IQS7K
         ZW9FDxkjNTc7SUkOEfm6FhradaUgEPfNOM/1KENhyVKm7sco0y+6OIdtCgT/VdMVQTXh
         x1evfXO3k3C+LfOhWB0mTWvcOA0QrLSWROlom8UsgRiEWDMfAsTsAI6PcXSaVznEyhUe
         CAmTmubUlxReaD/IjqU8sERlCaEr169aSwX9eLGUJeiR5Aj1JVIGJDvEAOjWpjWl8U8N
         uT9Q==
X-Gm-Message-State: ACrzQf3RKqhuv2lOwIMm9Pt6ZHWWzLBpwO7c821OggqO8xo9X7hnFJ8U
        wxfXTk7PzDDhBM4cxi7O+MM=
X-Google-Smtp-Source: AMsMyM7yD68OyMqeWMmftI2+Y3VLtXg00QSMcIOi5/puIKfQeCZZldKEGBvmEgOV3Bkk13IY0nCbyQ==
X-Received: by 2002:a17:907:b16:b0:7ad:855b:c08c with SMTP id h22-20020a1709070b1600b007ad855bc08cmr54243919ejl.667.1667920865527;
        Tue, 08 Nov 2022 07:21:05 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fd25-20020a056402389900b0045b910b0542sm5623450edb.15.2022.11.08.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:21:04 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osQPQ-000bje-0p;
        Tue, 08 Nov 2022 16:21:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] sequencer: stop exporting GIT_REFLOG_ACTION
Date:   Tue, 08 Nov 2022 15:51:08 +0100
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <e9c3f5ac5c6b7a01ee9e43730889d8066a270271.1667575142.git.gitgitgadget@gmail.com>
 <221107.86iljqvhzf.gmgdl@evledraar.gmail.com>
 <03cd4cdb-5f6b-11b9-1959-d58d5b544565@dunelm.org.uk>
 <16baa0cd-0797-4427-3e39-e5ffd2dca544@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <16baa0cd-0797-4427-3e39-e5ffd2dca544@dunelm.org.uk>
Message-ID: <221108.864jv9sc9r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 07/11/2022 19:35, Phillip Wood wrote:
>>>> @@ -5116,7 +5121,7 @@ static int single_pick(struct repository *r,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 TODO_PICK : TODO_REVERT;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item.commit =3D cmit;
>>>> -=C2=A0=C2=A0=C2=A0 setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>>> +=C2=A0=C2=A0=C2=A0 opts->reflog_message =3D sequencer_reflog_action(o=
pts);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return do_pick_commit(r, &item, opts, 0=
, &check_todo);
>>>
>>> Here you're adding a new memory leak, which you can see if you run
>>> e.g. the 1st test of ./t1013-read-tree-submodule.sh before & after this
>>> change.
>
> What's a read-tree test using rebase for? I find the submodule tests
> completely incomprehensible. It is calling=20
> test_submodule_switch_recursing_with_args() which does not call rebase
> directly but who knows what is going on in all the helper functions.=20

I don't know, I just worked by way backwards from the leak logs, so...

> Have you got a simple example of a test which shows a new leak?

...yes, e.g. (after make SANITIZE=3Dleak):

	./t3425-rebase-topology-merges.sh -vixd

Will, on "master", emit:
=09
	Direct leak of 1408 byte(s) in 1 object(s) allocated from:
	    #0 0x7ff891b5f545 in __interceptor_malloc ../../../../src/libsanitizer=
/lsan/lsan_interceptors.cpp:75
	    #1 0x6c45e8 in do_xmalloc wrapper.c:51
	    #2 0x6c4670 in xmalloc wrapper.c:72
	    #3 0x6037e2 in parse_options_concat parse-options-cb.c:188
	    #4 0x4c547c in run_sequencer builtin/revert.c:140
	    #5 0x4c5a4c in cmd_revert builtin/revert.c:247
	    #6 0x407a32 in run_builtin git.c:466
	    #7 0x407e0a in handle_builtin git.c:721
	    #8 0x40803d in run_argv git.c:788
	    #9 0x40850f in cmd_main git.c:923
	    #10 0x4eed6f in main common-main.c:57
	    #11 0x7ff8918b9209 in __libc_start_call_main ../sysdeps/nptl/libc_star=
t_call_main.h:58
	    #12 0x7ff8918b92bb in __libc_start_main_impl ../csu/libc-start.c:389
	    #13 0x405fd0 in _start (git+0x405fd0)
=09
	Direct leak of 4 byte(s) in 1 object(s) allocated from:
	    #0 0x7ff891b5f545 in __interceptor_malloc ../../../../src/libsanitizer=
/lsan/lsan_interceptors.cpp:75
	    #1 0x7ff891929caa in __GI___strdup string/strdup.c:42
	    #2 0x6c4591 in xstrdup wrapper.c:39
	    #3 0x4c58f8 in run_sequencer builtin/revert.c:223
	    #4 0x4c5a4c in cmd_revert builtin/revert.c:247
	    #5 0x407a32 in run_builtin git.c:466
	    #6 0x407e0a in handle_builtin git.c:721
	    #7 0x40803d in run_argv git.c:788
	    #8 0x40850f in cmd_main git.c:923
	    #9 0x4eed6f in main common-main.c:57
	    #10 0x7ff8918b9209 in __libc_start_call_main ../sysdeps/nptl/libc_star=
t_call_main.h:58
	    #11 0x7ff8918b92bb in __libc_start_main_impl ../csu/libc-start.c:389
	    #12 0x405fd0 in _start (git+0x405fd0)

After we still have the first leak (which is unrelated), and the second,
but have added this one:
=09
	Direct leak of 7 byte(s) in 1 object(s) allocated from:
	    #0 0x7f7cc51e5545 in __interceptor_malloc ../../../../src/libsanitizer=
/lsan/lsan_interceptors.cpp:75
	    #1 0x7f7cc4fafcaa in __GI___strdup string/strdup.c:42
	    #2 0x6c460b in xstrdup wrapper.c:39
	    #3 0x66df91 in sequencer_reflog_action sequencer.c:3685
	    #4 0x6725ad in single_pick sequencer.c:5124
	    #5 0x6728dd in sequencer_pick_revisions sequencer.c:5178
	    #6 0x4c5a17 in run_sequencer builtin/revert.c:237
	    #7 0x4c5aa9 in cmd_revert builtin/revert.c:247
	    #8 0x407a32 in run_builtin git.c:466
	    #9 0x407e0a in handle_builtin git.c:721
	    #10 0x40803d in run_argv git.c:788
	    #11 0x40850f in cmd_main git.c:923
	    #12 0x4eedcc in main common-main.c:57
	    #13 0x7f7cc4f3f209 in __libc_start_call_main ../sysdeps/nptl/libc_star=
t_call_main.h:58
	    #14 0x7f7cc4f3f2bb in __libc_start_main_impl ../csu/libc-start.c:389
	    #15 0x405fd0 in _start (git+0x405fd0)

But more to the point, if you run the test suite with e.g.:

	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue

You can find these raw reports in:

	grep -r sequencer test-results/*.leak

Or, from my github.com/avar/git.git use this nice script/alias to
summarize it (I haven't upstreamed this yet):

	$ git help scan-leaks-top
	'scan-leaks-top' is aliased to '!f() { cd t && git cat-file blob avar/add-=
new-sanitize-leak-test-modes-follow-up:t/aggregate-leaks.perl | perl - | le=
ss -S; }; f'

>> I'm not sure how, opts->reflog_message will be a copy of
>> opts->reflog_action which is freed at the end of the rebase. I'll
>> have a proper look tomorrow to see if I'm missing something.
>
> So it is possible this is showing up because I think we only free the
> heap allocated members of opts in sequencer_remove_state() and that is=20
> not called when we stop for a conflict resolution, a break command, a
> failed exec or a rescheduled pick/reset etc. The way to fix that would=20
> be to refactor sequencer_remove_state() to create
> replay_opts_release() and call that from builtin/{revert,rebase}.c

Yes, I think that's probably the root cause. I have a leak-fixing topic
as a follow-up to my current one, which among other things tried to
address this: https://github.com/avar/git/commit/7a150d1b7e2

I'd just forgot about it. That link currently says committed <24hrs ago,
but I was just rebasing the topic for something unrelated, I hacked this
up in mid-August.

> As that is unrelated to removing the setenv() calls which is the focus
> of this series I will not be doing that in this series.

I'm fine with us leaving this for now, and saying that it's OK that
we're adding some new leaks, if we're addressing the setenv/getenv
issue, and that we can fix the root cause of the current leaks later.

But let's be clear: It's not unrelated to your refactoring in this
topic, we didn't have this leak before, and now we have it. These two
patches are the cause of some new leaks we didn't have before.

And, if we run this on my topic which narrowly attempted to fix these
leaks e.g. that "t3425-rebase-topology-merges.sh" test will have just 1
leak in that failing test, v.s. 3 leaks with this topic (the "4 byte(s)
in 1 object(s)" above).

It's just a nice coincidence that our memory leaks are currently in such
a sorry state overall that this isn't failing e.g. the linux-leaks CI,
because the new leaks are being masked by tests that area already
failing due to other pre-existing leaks.

But all that being said I think the right move is for this topic to
proceed, perhaps with an updated commit message noting some of this.

It's really just running into the existing problem of
replay_opts_release(). If that destructor isn't reliable (which it
isn't) we can still make new use of it, and then fix how we call it
later for all its callers.

Which I've just tested: I cherry-pick that 7a150d1b7e2 and the few
preceding commits it needs (dcc104aef89..7a150d1b7e2), and then apply
this on top:
=09
	diff --git a/builtin/revert.c b/builtin/revert.c
	index ee32c714a76..0abd805beed 100644
	--- a/builtin/revert.c
	+++ b/builtin/revert.c
	@@ -250,6 +250,7 @@ int cmd_revert(int argc, const char **argv, const char=
 *prefix)
	 	if (opts.revs)
	 		release_revisions(opts.revs);
	 	free(opts.revs);
	+	replay_opts_release(&opts);
	 	return res;
	 }

The leaks above are down to just the unrelated parse_options_concat()
leak. I.e. this really is just a case of us missing the destructor due
to a more general issue.

1. https://lore.kernel.org/git/8eec228d-d392-523d-2415-149b946f642e@dunelm.=
org.uk/
