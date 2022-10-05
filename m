Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0EC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 16:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJEQps (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJEQpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 12:45:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87178645A
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 09:45:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n7so15879059plp.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmpXA5UgAZ5ZAsiLl6DlvyW+6TOZ4Etp/9tD87Kc1yQ=;
        b=d7AWhUFE8Nun8ZkFk7TBYbICnl1zTN0mzHhzp8P4Z1z+hzEmoxG3M6iZy2c+np5Myz
         +QgF8yaQqQtJmZH6ydDiYTSZOSWMOgHaYnMkvBe4OYz6jfZ135PYKy0fMh+EaCKXdcax
         05AXhT5Rf9G2zVv4ErEsSuG2adCWa1aWkno2vs/4kmdyjFYsLv4lIcuZmTNWeqC8/UR9
         VygTPWtCnSTc9SWmLFFbN2wjKg/lXY9Nowsyykmz5juin0u9ljynZG9iTiQ6B9lEjRGq
         IqkR6Hp7hbRIpa+EKG0DoKAfCOy3PF8clmrEtAGqYH2AO5kLPf59LN2YrzDrXZiOiKcq
         A8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmpXA5UgAZ5ZAsiLl6DlvyW+6TOZ4Etp/9tD87Kc1yQ=;
        b=nU/Wlb9/DsNCO7Er3cIEgiaC+2M82EEBMpAa2N8VqTZJYT88xat3nEG5GShKdfsMOI
         pUX0Ti/aB9l3wnHZYB/QqeACAuMDYQAuS6khZKBivSw5DgZ4QO+uXv/bkMapr+LIeyfA
         RfBKRnlt1pmLDQcJYvvQUVhaycFx6Y9YPkSZBQP8+7lzsvwel9jkJD/l3dGQQNHcQCcD
         TD9ND5jE8mHrKAKU9ylxhSZO9jPJNEIMT+k9o16/K5/XditAzLKmAR2FdIJsM57Ci6af
         2YPE6qpgAgVsh9j2Z5TB+N9sIEfHl46V0Yi4PzC/KctPDXR73xoDRegVpb1G+zl3kzSe
         y1CQ==
X-Gm-Message-State: ACrzQf3RQK0dcLO2fO/wflNnG21YNa4VXpIIXeqJ2szp+k2DoIu7yeix
        ffe3h3rF8Ev0D2qA5qH4USY=
X-Google-Smtp-Source: AMsMyM56umHSHCsZ6s4LV5SVuIQEkwhpMTN+F7P9tHBWo2gfBV3/xQy9D0Pon+yByo8W6SshqUfMvQ==
X-Received: by 2002:a17:902:bd45:b0:17f:6b19:bf6f with SMTP id b5-20020a170902bd4500b0017f6b19bf6fmr551436plx.73.1664988344773;
        Wed, 05 Oct 2022 09:45:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 124-20020a621782000000b0053e42167a33sm11054337pfx.53.2022.10.05.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:45:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] t3404-rebase-interactive: mark a test with REFFILES
 prereq
References: <20220930140948.80367-1-szeder.dev@gmail.com>
        <20220930140948.80367-3-szeder.dev@gmail.com>
        <220930.86ill4vman.gmgdl@evledraar.gmail.com>
Date:   Wed, 05 Oct 2022 09:45:43 -0700
In-Reply-To: <220930.86ill4vman.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 30 Sep 2022 18:46:49 +0200")
Message-ID: <xmqqwn9eqkw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Sep 30 2022, SZEDER Gábor wrote:
>
>> The test '--update-refs: check failed ref update' added in b3b1a21d1a
>> (sequencer: rewrite update-refs as user edits todo list, 2022-07-19)
>> directly modifies the contents of a ref file, so mark this test with
>> the REFFILES prereq.
>> ...
>  	# At this point, the values of first, second, and third are
>  	# recorded in the update-refs file. We will force-update the
>  	# "second" ref, but "git branch -f" will not work because of
> -	# the lock in the update-refs file.
> -	git rev-parse third >.git/refs/heads/second &&
> +	# the lock in the update-refs file, so we need to use
> +	# "update-ref".
> +	git update-ref refs/heads/second third &&
>  
>  	test_must_fail git rebase --continue 2>err &&
>  	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
>
> As the comment notes if you try that with "git branch" you'll get an
> error, even with --force, but update-ref works just fine...

Ah, I had exactly the same thought but was stopped from sending the
suggestion to use "git update-ref" right away by "because of the
lock in the update-refs file" that did not immediately click.  What
is happening is "git branch" and any Porcelain commands that call
the now slightly misnamed branch_checked_out() function to see if an
operation is allowed to touch a branch would refrain from touching
this ref, but "update-ref" as a plumbing is deliberately designed to
be usable to bypass the check [*].  The --update-refs series added
code to branch_checked_out() to consider any refs being rewritten
as "checked out hence no touch".

Even though being listed in the update-refs file may count as a
moral equivalent to having a "lock in the update-refs file", because
write_update_refs_state() mentions no "lock", the proposed log
message was confusing and I think that was why it did not
"immediately click" at least for me.

If this works with the update-ref plumbing, we should do so instead
of adding REFFILES prerequisite.


[Footnote]

 * Allowing more flexibility to the plumbing is OK, but those
   scripting around plumbing commands should get the same support as
   those writing built-in and making internal calls to functions
   like branch_checked_out(), in order for them to be able to write
   their Porcelain and offer the same safety to their users.  The
   function certainly should be exposed to plumbing users, and
   possibly many other internal-only features.

   The trend in the past ten or so years has been "Porcelain first"
   and then "Porcelain only", which sadly made the composability of
   Git plumbing commands much less useful than pre-made Porcelain
   commands.
