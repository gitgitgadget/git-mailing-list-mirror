Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB43820281
	for <e@80x24.org>; Wed, 27 Sep 2017 03:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031637AbdI0DVd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 23:21:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33761 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031618AbdI0DVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 23:21:32 -0400
Received: by mail-pg0-f68.google.com with SMTP id i130so7907385pgc.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 20:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FcSNuW8kIpx53zxvaIw0BvU0MEedP4bz7DLc5hELns4=;
        b=CL1GhyTF3GMgdwqWeKLy8inggA7P0Glmw8ZlyNPyw/K+5nAXmo9Q9oPnduZuywztvb
         MbeFb6wM9K2NzHkKN5r5kdVz+eEl7pO2TjnhcYoYnd7IQ2r1P+NNoIXqe9DHnetRU4yz
         /isHxh2v83UfNseHUYvTdeOzUNoAcciucHjgcBXTwe84O0SAAb0++ABWl7hOfu/sHu5a
         EHenvsKzTLFfJCcriZbsf009VEJBLZiR73wOBneDIuWhN/Z9kFxOuoDmDkUJ7O2RjUZg
         HB2gvtQBHPRAQm6SZfy4ZcZAI9W2+4rJp7lDSpxP/W1NnKQqSUykhHW2sE65j0xf4YtM
         35vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FcSNuW8kIpx53zxvaIw0BvU0MEedP4bz7DLc5hELns4=;
        b=fdxuCCEz3tC8CRrXVCM20Z91hlRGSGITpNWYIJwW8Nsstl3ANJ+LAM4Zc4djFd8XI0
         MmL0b591VZEIDfhSvtzclQAC10ECGKQsfQdeXAN0ZAsF+R+n77oelln01wtQC2UaDrEc
         ++YN7FWtRzewohts5izFaQbdvCerGDnOTggjmLwe6lIJtiVl19cjgq8QZ7ZQN83tPl1t
         Ii5T4LUtQwKLYyXZbHDoU55PbEe+znFx/mYnHcIORYrc3f52hy5rSauZtNPpZ3U5lOh2
         3X0TNuf0+4lmx96ahrUBtLl4DBrCxELyPO/Kv9URf+NobYflmPhp5APvhZzsfapeEmPJ
         GKog==
X-Gm-Message-State: AHPjjUi/7yV/H2bRWmT+ZWZLOrc7tJqomOcr70azVaSCC1Esh3LPaqps
        w2vOev0+/BhWHdj2YCbW79Q=
X-Google-Smtp-Source: AOwi7QCP7R21s6QQDzA44GmWf9z+i4PKI4pTEZ27iO7r73yWhXL6HOiJTQQOxxiJFlkaf4QT23IU2Q==
X-Received: by 10.84.229.78 with SMTP id d14mr12411545pln.415.1506482491311;
        Tue, 26 Sep 2017 20:21:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id j14sm16998973pff.59.2017.09.26.20.21.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 20:21:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] t7406: submodule.<name>.update command must not be run from .gitmodules
References: <0b69c0b0-6246-2428-b4b0-bb3ef3cb5ae7@kdbg.org>
        <20170926195413.3916-1-sbeller@google.com>
Date:   Wed, 27 Sep 2017 12:21:27 +0900
In-Reply-To: <20170926195413.3916-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 26 Sep 2017 12:54:13 -0700")
Message-ID: <xmqqr2us7rns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> submodule.<name>.update can be assigned an arbitrary command via setting
> it to "!command". When this command is found in the regular config, Git
> ought to just run that command instead of other update mechanisms.
>
> However if that command is just found in the .gitmodules file, it is
> potentially untrusted, which is why we do not run it.  Add a test
> confirming the behavior.
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Earlier, we saw:

    Ideally we want this test to be super robust: e.g. if it runs the
    command but from a different directory, we still want the test to fail,
    and if it runs the command but using exec instead of a shell, we still
    want the test to fail.

and this one (i.e. signal that it is a command by prefixing with
'!', and then have a single command that would fail whether it is
run via run_command() with or without shell) would satisfy that
criteria, I would think.

>> This test for a missing file is certainly a remnant from the
>> previous iteration, isn't it?
>
> Yes. This is a good indicator I need some vacation.

Or just take a deep breath before making a knee-jerk reaction public
and instead double-check before sending things out ;-)

Will queue.  Thanks.

>
> Thanks,
> Stefan
>
>  t/t7406-submodule-update.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 034914a14f..6f083c4d68 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -406,6 +406,14 @@ test_expect_success 'submodule update - command in .git/config' '
>  	)
>  '
>  
> +test_expect_success 'submodule update - command in .gitmodules is ignored' '
> +	test_when_finished "git -C super reset --hard HEAD^" &&
> +	git -C super config -f .gitmodules submodule.submodule.update "!false" &&
> +	git -C super commit -a -m "add command to .gitmodules file" &&
> +	git -C super/submodule reset --hard $submodulesha1^ &&
> +	git -C super submodule update submodule
> +'
> +
>  cat << EOF >expect
>  Execution of 'false $submodulesha1' failed in submodule path 'submodule'
>  EOF
