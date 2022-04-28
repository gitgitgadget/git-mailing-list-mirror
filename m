Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE51C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350740AbiD1SMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350747AbiD1SME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 14:12:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D28B7C64
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:08:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q23so7835166wra.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8oUKO80N3uVrZWAs/r7dDlIrEVj181FhqsDL4lHYoRQ=;
        b=jN7gFZtkMG63EEdw1o5fZ25Bx2Xo7LlFa2NITdRBWXNAE/HZNmYDA+QxkoxJXgdPfE
         ZZ2loeM88vsn3XCXR1CceoEXt7obpcx0o2sKRvcLEGlUwukJiPYq9Oymp7xjXDUVI7n5
         mWXFbyPi8oWjILfftBRAryLjebhizllLqC7I7f1Q3N3AYB85agH/azOubOcVpl4kAhHz
         dhs2RoiIU+OXgUkeAavaHlv8hVlOF3Pn9uhY/KVXgsOiop3HNy/PlmO0BV0GIM4/YnKK
         ndH+mS39WetkVkPSUfObgDr6Dm1nnuxhD9SP13OGh+Sx43CgEgULMseKdBkG3RfSuHdU
         Li2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8oUKO80N3uVrZWAs/r7dDlIrEVj181FhqsDL4lHYoRQ=;
        b=ObzPVfVzBVJjlEaW0FCw/yADAlKAHbPPyo1/aAVAhu/uiijV1KXYR2EXZZ2xzf5RBF
         cTi3KbSVjoUKVoiJYlsZnAw17Fbidy/aVyt/plxSwnRFlWL3IgIV7w9Hvn+kF3ErwPRw
         FXBHjcqMQ0pM40jjVmoazkxc7rsCRaeP+ScMD7YS3cyZzb+rkEbCyJ64kVNGre8wVh9z
         V5jh+cQ6IwLqK/0TDZEWLkPR5Leyls4jllKPtsTVzDEaO9Ib/eYl03aKy9pM//MOzdYG
         4q5/l1mEAsW2602Iz3sFEZ0YbPBi+8trzuyvrqa0j4pa+s8QHJsPpcwdGJfKQj6C6QOh
         6kZg==
X-Gm-Message-State: AOAM530+6MhfwMCtRzKj3K5HgCaR1oBSIvzmsnA4VU2OAXsD2JHFiehv
        LTXy0axtaq5NOQkw/ytFEI9b/bxpGt4=
X-Google-Smtp-Source: ABdhPJxcKB2sCOgvd7bBSnJ3mdTMGfpZ5w/bwOI0DLNTDARWeDkCFAu68AtqN1i7GssLmMuV88QbGg==
X-Received: by 2002:adf:d1e4:0:b0:20a:f21e:2fb2 with SMTP id g4-20020adfd1e4000000b0020af21e2fb2mr6631690wrd.281.1651169327012;
        Thu, 28 Apr 2022 11:08:47 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id g13-20020adfbc8d000000b0020aef8dd9eesm399693wrh.104.2022.04.28.11.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:08:46 -0700 (PDT)
Message-ID: <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com>
Date:   Thu, 28 Apr 2022 19:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with
 sudo
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq7d79du6c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/04/2022 17:55, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
>> +test_description='verify safe.directory checks while running as root'
>> +
>> +. ./test-lib.sh
>> +
>> +if [ "$IKNOWWHATIAMDOING" != "YES" ]; then
> 
> Style.
> 
> 	if test "$IKNOWWHATIAMDOING" != "YES"
> 	then

Also naming - we normally prefix test environment variables with 
GIT_TEST_. IKNOWWHATIAMDOING does not tell us what we are allowing by 
setting the variable. Something like GIT_TEST_ALLOW_SUDO would tell us 
what we're letting ourselves in for by setting it.

>> +is_root() {
>> +	test -n "$1" && CMD="sudo -n"
>> +	test $($CMD id -u) = $(id -u root)
>> +}
> 
> Style.
> 
> 	is_root () {
> 		... body ..
> 
> But more importantly, why do we need this in the first place?
> SANITY prerequisite checks if the user is running as root or
> non-root---can't we use it here?
> 
> Or perhaps my reading is wrong?  I assumed from its name that it was
> just "see if we are running as user 'root' and return 0 or non-zero
> to answer", but if it does more than that, like priming "sudo", then
> probably it is misnamed.

I'm confused by this as well. Also if $1 is empty we run whatever 
happens to be in $CMD.

Best Wishes

Phillip

>> +test_lazy_prereq SUDO '
>> +	is_root sudo &&
>> +	! sudo grep -E '^[^#].*secure_path' /etc/sudoers
>> +'
> 
> OK.
> 
>> +test_lazy_prereq ROOT '
>> +	is_root
>> +'
>> +
>> +test_expect_success SUDO 'setup' '
>> +	sudo rm -rf root &&
>> +	mkdir -p root/r &&
>> +	sudo chown root root &&
>> +	(
>> +		cd root/r &&
>> +		git init
>> +	)
>> +'
> 
> We have a root-owned directory "root" with a subdirectory "r" owned
> by us.  We want to be able to use our "root/r" directory as a
> repository.  OK.
> 
> The prerequisite allows this test to be started as root, but I do
> not quite see the point.  It may pass when started as root, but it
> is not testing what this test is designed to check (i.e. an ordinary
> user who has repository at root/r can do things there).
> 
>> +test_expect_success SUDO 'sudo git status as original owner' '
>> +	(
>> +		cd root/r &&
>> +		git status &&
>> +		sudo git status
>> +	)
>> +'
> 
> And the directory can be used by the user under "sudo", too.  Good.
> 
> The same "this is allowed to run as root, but why?" question
> applies.  If this was started by 'root', root, root/r and
> root/r/.git all are owned by 'root' and we are checking if 'root'
> can run 'git status' as 'root' (or 'root' via sudo) there.  Such a
> test may well pass, but it is not catching a future regression on
> the code you wrote for this series.
> 
>> +test_expect_success SUDO 'setup root owned repository' '
>> +	sudo mkdir -p root/p &&
>> +	sudo git init root/p
>> +'
> 
> Now we go on to create root owned repository at root/p
> 
>> +test_expect_success SUDO,!ROOT 'can access if owned by root' '
>> +	(
>> +		cd root/p &&
>> +		test_must_fail git status
>> +	)
>> +'
> 
> And as an ordinary user, we fail to access a repository that is
> owned by a wrong person (i.e. root).  !ROOT (or SANITY) prereq
> should be there NOT because the test written here would fail if run
> by root, but because running it as root, even if passed, is totally
> pointless, because we are *not* testing "person A has a repository,
> person B cannot access it" combination.
> 
> The other side of the same coin is that the lack of !ROOT (or
> SANITY) prereq in earlier tests I pointed out above misses the point
> of why we have prerequisite mechanism in the first place.  It is not
> to mark a test that fails when the precondition is not met.  It is
> to avoid running code that would NOT test what we want to test.
> 
> The difference is that a test that passes for a wrong reason
> (e.g. we wanted to see of person A can access a repository of their
> own even when the user identity is tentatively switched to 'root'
> via 'sudo'---if person A is 'root', the access will be granted even
> if the special code to handle 'sudo' situation we have is broken)
> should also be excluded with prerequisite.
> 
>> +test_expect_success SUDO,!ROOT 'can access with sudo' '
>> +	# fail to access using sudo
>> +	(
>> +		# TODO: test_must_fail missing functionality
> 
> Care to explain a bit in the log message or in this comment the
> reason why we do not use test_must_fail but use ! here?  Are we
> over-eager to reject anything non "git" be fed, or something?
> 
>> +		cd root/p &&
>> +		! sudo git status
>> +	)
>> +'
> 
> The repository is owned by 'root', but because of the 'sudo'
> "support", you cannot access the repository with "sudo git".
> 
> The test title needs updating.  We expect that the repository cannot
> be accessed under sudo.
> 
>> +test_expect_success SUDO 'can access with workaround' '
> 
> "workarounds", I think.
> 
>> +	# provide explicit GIT_DIR
>> +	(
>> +		cd root/p &&
>> +		sudo sh -c "
>> +			GIT_DIR=.git GIT_WORK_TREE=. git status
>> +		"
>> +	) &&
>> +	# discard SUDO_UID
>> +	(
>> +		cd root/p &&
>> +		sudo sh -c "
>> +			unset SUDO_UID &&
>> +			git status
>> +		"
>> +	)
>> +'
> 
> Again, this lack !ROOT (or SANITY) because tests pass for a wrong
> reason.
> 
> Overall, I like the simplicity and clarity of "do not start this
> test as 'root'" in the previous round much better.
> 
> But other than that, the test coverage given by this patch looks
> quite sensible.
> 
> Thanks.
> 
>> +
>> +test_expect_success SUDO 'cleanup' '
>> +	sudo rm -rf root
>> +'
>> +
>> +test_done

