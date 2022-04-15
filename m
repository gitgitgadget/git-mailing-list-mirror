Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCBC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 23:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356592AbiDOXsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356586AbiDOXsG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 19:48:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D082D20
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:45:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q13-20020a638c4d000000b003821725ad66so4724308pgn.23
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rHvgJ1mgeJRIWuY4qZ+UGoyNZkStCNkeneHDeH4piVg=;
        b=PomNltDikaPV4CHmgl/ZkUY8bswLzeAGOSEpSJ5f0qxzLntLP8fdLNQIUq5V+C14Zw
         m8A75N/j1qtB7LnBvOduEKSoDpHgx83YnGX1/cSTSV4fgDRHPn3NyJFRndRSvM40OKbO
         yFDO8BSn66998fLgsDnHOTDx8bZzmBOilRokzGn5NWFCBZjZHxjeO+2vWpOJPwoJQ5Zi
         ni2nT+iiDG/YXI4OcJYvezBLpfI2S7J1ZURkY1cXyX8Gs0Qn7lhYvaWbcTjc63972DWM
         a4osp4zjid9iK9R6C77Q9rwMjqSLTxVt2fCglateuhFZU4Vjw7GNYixbNbmYsP/emz29
         pOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rHvgJ1mgeJRIWuY4qZ+UGoyNZkStCNkeneHDeH4piVg=;
        b=DrsIxtJDSyART1Zt1Bw8j4TgQfj1aELWVxxQzvopcQSZMtwVYtfj1jVqK0HKujrzof
         +uVa41jrjSab/ZmEpHCRl0TRMycff8dpPblaB2MWgPukPnIIopMhGCFCq+iA0M1b5raN
         NVAPN+3WeIg4JF3I960IBr94K89Ah28gj48YfTwcVhS2u4x6BrKdraLUipGvturnWeLV
         PhgSMxDPcDKqIgB64VL+QVQe9z4pMq34Yx+e2zfofwO910yv4sIie5kOiIgt382yELP+
         cjWWbgfzIvyKUdSfd+UB9yy44tMqoIVpcuVRaiENPL/LnM0LSUnxMPBLaymUAjk/DjER
         YTDA==
X-Gm-Message-State: AOAM5323ts26eBhiD/P3yl5fk1kodF09jiBOGSjj0YQc3vhmHscRUuBQ
        Z1SW/djcyo7JxR8lGz61kBorCdBxN/esNQ==
X-Google-Smtp-Source: ABdhPJyYbGRD8xTwL32cqcGeXEHMHIu+qgMOEiY3HwnLGkO112vssKWIE4ClZ3Z2tgEJhg33D3jHMX/m24hL2Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP
 id h1-20020a170902b94100b0014daf723f23mr1328959pls.6.1650066334336; Fri, 15
 Apr 2022 16:45:34 -0700 (PDT)
Date:   Fri, 15 Apr 2022 16:45:32 -0700
In-Reply-To: <xmqqh76ucdg6.fsf@gitster.g>
Message-Id: <kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqwnfs4kud.fsf@gitster.g> <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqh76ucdg6.fsf@gitster.g>
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
>>
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
> So, I was doing a bit of experiment.  The change to the set-up
> essentially means that working in either a bare repository or in the
> .git/ subdirectory of a non-bare repository that you used to be able
> to do with
>
>     cd bare.git && git cmd
>     cd .git/ && git cmd
>
> is now forbidden, unless you explicitly say which directory you want
> to use as the GIT_DIR, i.e.
>
>     cd bare.git && GIT_DIR=. git cmd
>     cd .git/ && GIT_DIR=. git cmd
>
> The required change to the code is surprisingly small, but the
> fallout is very big.  Partial patches to two tests are attached with
> some commentary at the end.

Thanks for running the experiment and the thorough writeup! Within the
Google Git team, there was quite a bit of interest in this approach
because of how simple it is, but the projected impact on users is
potentially very high; this experiment is a great starting heuristic.

> Interestingly, many breakages in tests are not due to "clone"
> failing to operate in "the other side".  For example, this one tries
> to inspect a bare repository that was created by a clone operation,
> and we need to tell "git" where the GIT_DIR is, even after we chdir
> to it.  I do not think this is so common but with our popularity,
> not-so-common population is still an absolute large number of users
> that we do not want to hurt.
>
> diff --git c/t/t5601-clone.sh w/t/t5601-clone.sh
> index 4a61f2c901..822ee3164a 100755
> --- c/t/t5601-clone.sh
> +++ w/t/t5601-clone.sh
> @@ -111,9 +111,9 @@ test_expect_success 'clone --mirror' '
>  	git clone --mirror src mirror &&
>  	test -f mirror/HEAD &&
>  	test ! -f mirror/file &&
> -	FETCH="$(cd mirror && git config remote.origin.fetch)" &&
> +	FETCH="$(cd mirror && GIT_DIR=. git config remote.origin.fetch)" &&
>  	test "+refs/*:refs/*" = "$FETCH" &&
> -	MIRROR="$(cd mirror && git config --bool remote.origin.mirror)" &&
> +	MIRROR="$(cd mirror && GIT_DIR=. git config --bool remote.origin.mirror)" &&
>  	test "$MIRROR" = true
>  
>  '
> @@ -151,7 +151,7 @@ test_expect_success 'clone --mirror does not repeat tags' '
>  	 git tag some-tag HEAD) &&
>  	git clone --mirror src mirror2 &&
>  	(cd mirror2 &&
> -	 git show-ref 2> clone.err > clone.out) &&
> +	 GIT_DIR=. git show-ref 2>clone.err >clone.out) &&
>  	! grep Duplicate mirror2/clone.err &&
>  	grep some-tag mirror2/clone.out

The assumption when I made this proposal is that --git-dir is a
sufficient workaround when we don't detect bare repos. As such, I'm of
the opinion that this is the "expected" result of such a change - we
really do expect that `git clone --bare` no longer works without
--git-dir.

I don't think this case (by itself) means that we can ignore bare repos.

> The next example is "init" test, which seems to reveal that refusing
> to discover a bare repository is not exactly an approach that is
> workable.
>
> The first two hunks just show the same pattern as above.  The
> check_config helper is given a directory, under which 'config' and
> 'refs' should exist (in other words, the first part of the helper
> emulates setup.c::is_git_directory()).  Then it tries to read from
> the configuration file found in that directory.  Be it a bare
> repository or .git/ subdirectory of a non-bare repository the caller
> has given us, we need to do the same GIT_DIR=. dance as the above.
>
> The last hunk does not really fix.  The scenario is this:
>
>     * A bare repository bare-ancestor-aliased.git is prepared
>
>     * Its config file says "[alias] aliasedinit=init" in it
>
>     * In that bare repository (next to 'refs', 'config'), we create
>       a subdirectory 'plain-nested'.
>
>     * We go to that bare-ancestor-aliased.git/plain-nested/
>       directory and say "git aliasedinit".
>
> This wants to be able to create a subdirectory in this bare
> repository and make that subdirectory an independent repository (it
> happens to be a non-bare repository, but a bare repository should
> also work---think of .git/modules/name/ bare repository that is
> designed to be pointed at with gitfile: link from a submodule
> working tree).
>
> Now, in order for the last step to be able to even _use_ the alias,
> it has to treat the bare-ancestor-aliased.git directory as a bare
> repository and read its configuration.  But by explicitly setting
> GIT_DIR to that location, the behaviour of "git init" itself is
> changed.  It no longer initializes the current directory,
> i.e. plain-nested subdirectory of the bare-ancestor-aliased.git;
> GIT_DIR tells us to (re)initialize it instead.

However, this case shows that --git-dir won't work at all with "git
init", and I wouldn't be surprised if there are other breakages hiding
just out of plain sight. This worries me a lot more, and I think
disabling bare repo detection wholesale might be a nonstarter.

I wonder if all we need to do is make setup.c a little smarter - we
recognize bare repos, but *only* if they are contained in a directory
named `.git/`. This should fix "git init" I think, because even though
we'd ignore "./ (bare)", we'd recognize `../.git/` and we get the right
behavior again.

I haven't tested it yet, but this proposal sounds like it has quite a
few merits to me:

- Easy to explain.
- Easy rationalization ("We used to be quite cavalier about detecting
  bare repos, but now we're being more strict by default").
- Fixes the embedded bare repo problem (since we don't allow .git).
- No-op and neglible performance hit for non-bare repo users, even if
  they occasionally run "git" inside ".git".

As with the original proposal of "ignore bare repos altogether", this
will still be a headache for bare repo users (unless they don't mind
renaming their bare repo directory to ".git"), so this behavior needs to
be configurable, but perhaps the fallout is small enough that this
could be a safe default.

> This fundamentally does not work.
>
> It is a separate matter if it makes sense to allow creating a new
> repository inside a bare repository (it does---that is what the
> modern submodule layout uses), or to allow an alias to help doing so
> defined in the top-level bare repository (it probably does---the
> end-user may want to have a handy way to customize how submodules
> are configured).  But it seems to tell us that with today's external
> interface we have for "git init", we cannot take configuration from
> a shallower level and use it to drive "git init" to create a new
> repository at a deeper level.
>  '
