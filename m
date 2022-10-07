Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C890EC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 13:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJGN1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJGN1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 09:27:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F461726
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 06:27:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so7281132wrp.10
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpIiBn7E1N032TAm+3E/fSlWDbFS4Tq0hsaSk8spDck=;
        b=TbZGPNTGMHyY84jcODAjhwbdh83oDuYLflR1CuaUeiLPtq8zkkNzITsG7BUc1n7Voq
         OVcmMy4qYM2DA9Y4OBZtgci2LoL53W5rc8pbVTpS0CLZS2fBPfh0snUEYtcQ8KgXXixR
         +GpDDfLQLh4eX46dIaL3WVZLCBYG+j2BDMO54sRGxkOKiDSs+JZWp6mjCxqz0uxYGCc7
         e+CJJ5Qqgt/KR7zDgRER5aUieEVNXknlWPXftUU2AhUjDzWcETWigqmi15xGjn1YiUaM
         zGYiOHQiuref/L2PPWxsri9YXwURJWOIg3r1PYMqu4ZmTRurMIqBz8j6YG4NuVrNXVOf
         kiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpIiBn7E1N032TAm+3E/fSlWDbFS4Tq0hsaSk8spDck=;
        b=NzXw6Gf1QpyMK1URxo+SoRfVudF5t2Sp5IRvMS4iE7zT/EkA4iDYNoZz07exZupLr6
         SOajN605lIo21+8R+cF2Lk2KeU4vNKy8Z2bM8+BgTjyYML7jQFj74IUh0pOdm9XVu5I6
         I1ROZJlGnzvW1gHhQ+yD/szN4nD2Y1vx0xWlFQCxBOW5kxNRdE49cMDqCHCFAQUKajaU
         uOaoE3T1AKlxkEbXuG3BrcQbtymaMp1D3Tz5uX1sFw/LKTPnuAKM9zb/hYeY5DijT3xH
         G+vtSfOs6ztExDeuPe5bd+rZEajAByQJLfEBG/gTpJt4CweAjOKMaFyzPY+xgHdjedX0
         pfQw==
X-Gm-Message-State: ACrzQf3SxxNXqCn8zAWHQLmf/00NK2VogoRjUXHSV4sEIF26o5JjhKk8
        UWKRrC0RcxEJU7g7pU1Xb1qsVs1bpoE=
X-Google-Smtp-Source: AMsMyM5j2eXXDABdpZqyNISBh/oyNjgfw0THIvtquk8KYrRoCvLFQYQGOMTYnk7dYjsOj5r+BBbkng==
X-Received: by 2002:adf:dc41:0:b0:22e:3dac:b066 with SMTP id m1-20020adfdc41000000b0022e3dacb066mr3275939wrj.344.1665149220728;
        Fri, 07 Oct 2022 06:27:00 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id r5-20020adfe685000000b0022e6f0d0d7csm2771103wrm.18.2022.10.07.06.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 06:27:00 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8df2260c-7a35-5b50-7273-fbd9894a614c@dunelm.org.uk>
Date:   Fri, 7 Oct 2022 14:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] [RFC] tests: add test_todo() for known failures
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <221006.86v8owr986.gmgdl@evledraar.gmail.com>
In-Reply-To: <221006.86v8owr986.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/10/2022 20:28, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:
> 
>> test_todo() is intended as a fine grained alternative to
>> test_expect_failure(). Rather than marking the whole test as failing
>> test_todo() is used to mark individual failing commands within a test. This
>> approach to writing failing tests allows us to detect unexpected failures
>> that are hidden by test_expect_failure().
>>
>> This series attempts to keep most of the benefits test_expect_todo()
>> previously proposed by Ævar[1] while being simpler to use.
>>
>> [1]
>> https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/
> 
> I like the interface you've got here much better than the one I
> submitted in [1], so much that it's what I tried to write at first :)
> 
> But as you noted in 1/3:
> 
> 	test_todo cannot be used in a subshell.
> 
> Anyway, the core difference between the APIs we proposed for this is
> that you'd do:
> 
> 	test_expect_success 'desc' 'test_todo false'
> 
> Whereas I suggested:
> 
> 	test_expect_todo 'desc' '! false'
> 
> Now, let's pick apart the differences:
> 
>   1. With "test_expect_todo" we're declaring "this is a TODO test" for
>      the test as a whole.
 >
>   2. With your "test_todo" we're not doing that, instead we proceed as
>      normal, and then we might note "we had a TODO" midway through, then
>      at the end we'll spot that we had a TODO test (but this approach
>      won't work with subshells).

Yes, this series avoids adding test_expect_todo and reuses 
test_expect_success as Junio suggested [1]. By using a new toplevel form 
your series was able to handle test_todo in a subshell because it did 
not need any global state related to whether a test_todo had passed/failed.

The series here uses a variable to check if any test_todo statements 
were present in a test that ran successfully and that does not work if 
the test_todo happens in a subshell because the variable in the parent 
is not updated. First we need to consider whether there is any need for 
supporting test_todo in a subshell. If there is then a possible 
alternative is to store the state in a file. That would add the cost of 
"test -f" to test_expect_success but our tests do so much i/o that a 
single extra stat should not be noticeable. In particular I believe a 
file based approach can be implemented without adding any new processes 
to tests that do not use test_todo.

>   3. Your "test_todo" is basically a "let's let this pass", whereas mine
>      was a helper which exhaustively declared *what* the bad behavior
>      was.
> 
>      (Although some of yours seems to be midway between the two,
>      i.e. https://lore.kernel.org/git/c3f4a79c-2dc6-fbf4-fc61-591ebf417682@dunelm.org.uk/)

The only thing my series tries to assert is that a test_todo command is 
not failing due to a usage error so that it can catch buggy tests. 
Beyond that it does not care what the reason for failure is.

> I think the main critique you and Junio had of my series was to do with
> #3, i.e. that it was a hassle to exhaustively declare what the behavior
> is & should be, as you note in:

That was certainly my main objection, but Junio was not that keen on 
adding test_expect_todo [1]

> https://lore.kernel.org/git/c3f4a79c-2dc6-fbf4-fc61-591ebf417682@dunelm.org.uk/
> 
> 	test_todo \
> 		--want "test_must_fail git" \
> 		--reset "git reset --hard" \
> 		--expect git \
> 		-- \
> 		rm d/f &&
> 
> That's fair enough, maybe that's not worth the effort. The reason I
> initially hacked this up was because I'd noticed a behavior difference
> in a command that was only revealed in a test_expect_failure block, but
> because we didn't assert *what* the behavior was we didn't notice.
> 
> My version (if fully used) would spot that, but that's because of how I
> wrote the "tes_todo", it's orthagonal to #1 and #2 above.
> 
> So I don't see why we wouldn't instead have a "test_expect_todo" and
> just write the helper differently, or have a mode where it's less
> strict, and (if we find it worthwhile) one where it's more strict.

I think there is a question of whether we need a new toplevel 
test_expect_todo - why would we add it if we can just reuse 
test_expect_success? That way when a test failure is fixed all that 
needs to be done is to remove the test_todo calls.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/xmqq8rt77zp7.fsf@gitster.g/


> I rebased my
> https://lore.kernel.org/git/patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com/
> just now and applied the below on top, which seems to me to give you
> pretty much the end result you want, the only difference is that my
> version will also work in subshells (see the t2500 one):
> 
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index de1ec89007d..fe47e503bd1 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -468,7 +468,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
>   	git -C unmerged sparse-checkout disable
>   '
>   
> -test_expect_failure 'sparse-checkout reapply' '
> +test_expect_todo 'sparse-checkout reapply' '
>   	git clone repo tweak &&
>   
>   	echo dirty >tweak/deep/deeper2/a &&
> @@ -502,11 +502,11 @@ test_expect_failure 'sparse-checkout reapply' '
>   
>   	# NEEDSWORK: We are asking to update a file outside of the
>   	# sparse-checkout cone, but this is no longer allowed.
> -	git -C tweak add folder1/a &&
> +	test_todo git -C tweak add folder1/a &&
>   	git -C tweak sparse-checkout reapply 2>err &&
> -	test_must_be_empty err &&
> +	test_todo test_must_be_empty err &&
>   	test_path_is_missing tweak/deep/deeper2/a &&
> -	test_path_is_missing tweak/folder1/a &&
> +	test_todo test_path_is_missing tweak/folder1/a &&
>   
>   	git -C tweak sparse-checkout disable
>   '
> diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
> index 5c0bf4d21fc..db7c72d38d8 100755
> --- a/t/t2500-untracked-overwriting.sh
> +++ b/t/t2500-untracked-overwriting.sh
> @@ -167,7 +167,7 @@ test_expect_success 'git rebase fast forwarding and untracked files' '
>   	)
>   '
>   
> -test_expect_failure 'git rebase --autostash and untracked files' '
> +test_expect_todo 'git rebase --autostash and untracked files' '
>   	test_setup_sequencing rebase_autostash_and_untracked &&
>   	(
>   		cd sequencing_rebase_autostash_and_untracked &&
> @@ -176,7 +176,7 @@ test_expect_failure 'git rebase --autostash and untracked files' '
>   		mkdir filler &&
>   		echo precious >filler/file &&
>   		cp filler/file expect &&
> -		git rebase --autostash init &&
> +		test_todo git rebase --autostash init &&
>   		test_path_is_file filler/file
>   	)
>   '
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 3b0fa66c33d..b31b6b0f7a0 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -577,7 +577,7 @@ test_expect_success '--continue respects -x in first commit in multi-pick' '
>   	grep "cherry picked from.*$picked" msg
>   '
>   
> -test_expect_failure '--signoff is automatically propagated to resolved conflict' '
> +test_expect_todo '--signoff is automatically propagated to resolved conflict' '
>   	pristine_detach initial &&
>   	test_expect_code 1 git cherry-pick --signoff base..anotherpick &&
>   	echo "c" >foo &&
> @@ -591,7 +591,7 @@ test_expect_failure '--signoff is automatically propagated to resolved conflict'
>   	git cat-file commit HEAD~3 >initial_msg &&
>   	! grep "Signed-off-by:" initial_msg &&
>   	grep "Signed-off-by:" unrelatedpick_msg &&
> -	! grep "Signed-off-by:" picked_msg &&
> +	test_todo ! grep "Signed-off-by:" picked_msg &&
>   	grep "Signed-off-by:" anotherpick_msg
>   '
>   
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index e74a318ac33..6c7929f5557 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -790,7 +790,7 @@ test_expect_success SYMLINKS 'rm across a symlinked leading path (no index)' '
>   	test_path_is_file e/f
>   '
>   
> -test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
> +test_expect_todo SYMLINKS 'rm across a symlinked leading path (w/ index)' '
>   	rm -rf d e &&
>   	mkdir d &&
>   	echo content >d/f &&
> @@ -798,10 +798,10 @@ test_expect_failure SYMLINKS 'rm across a symlinked leading path (w/ index)' '
>   	git commit -m "d/f exists" &&
>   	mv d e &&
>   	ln -s e d &&
> -	test_must_fail git rm d/f &&
> -	git rev-parse --verify :d/f &&
> +	test_todo test_must_fail git rm d/f &&
> +	test_todo git rev-parse --verify :d/f &&
>   	test -h d &&
> -	test_path_is_file e/f
> +	test_todo test_path_is_file e/f
>   '
>   
>   test_expect_success 'setup for testing rm messages' '
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index ad5c0292794..a6a5a330180 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -165,12 +165,12 @@ test_expect_success 'additional command line cc (ascii)' '
>   	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
>   '
>   
> -test_expect_failure 'additional command line cc (rfc822)' '
> +test_expect_todo 'additional command line cc (rfc822)' '
>   	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
>   	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout main..side >patch5 &&
>   	sed -e "/^\$/q" patch5 >hdrs5 &&
>   	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
> -	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
> +	test_todo grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
>   '
>   
>   test_expect_success 'command line headers' '
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f342954de11..9d5706454a5 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1049,6 +1049,21 @@ test_must_fail_acceptable () {
>   	esac
>   }
>   
> +test_todo () {
> +	local negate=-ne
> +	local cmp_op=-ne
> +	if test "$1" = "!"
> +	then
> +		negate=t &&
> +		cmp_op=-eq
> +		shift
> +	fi &&
> +	"$@" 2>&7
> +	exit_code=$?
> +	say "test_todo: got $exit_code ${negate:+negated!} from $*"
> +	test "$exit_code" "$cmp_op" 0
> +}
> +
>   # This is not among top-level (test_expect_success | test_expect_failure)
>   # but is a prefix that can be used in the test script, like:
>   #
> 
> 
