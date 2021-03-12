Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07908C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9D964FEA
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhCLLMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhCLLMF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 06:12:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068C5C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:12:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so1545853wro.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 03:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l9pEkncgNrfMuAsUmQ1grOlnpmJ+MNpVX/GCZxEc4Vs=;
        b=TbeG2QxSqnrpVGvs1YAPzpVEmD19zoQKSoVunclJNiB//j3sWcqnUFgsRrY2KpROt5
         xQkLaIBxT7XN9MhwebQ/ET43teBXKqhovpWD3TMtNBpR5xNZTvnbjV/5CRrg2MH4XB0q
         Xa0Nl3N0X81FBunEykEWvXr8a5vDTmxZHyxczv7uJgDd5+GZaWaWnbTIc1Aaa4qe7sPQ
         iDFKbCY171xe8NV+NFTSmhaF18uol0l94Vj8nTVcEhUKS9pkneEHGk95ulhQA6o2HBRL
         ifMjMaNdTxXrU06k+4DsJS79ZROiwxSvsKsyodkm2e3EuVWMwY/t0kr4opSAfzfDEftU
         +1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9pEkncgNrfMuAsUmQ1grOlnpmJ+MNpVX/GCZxEc4Vs=;
        b=tTBF4PDVq5yGswkjpIGyrD9HzawyU2chBL9LY57hrQbMztlAqfEu8X4d7I5BDHMi3h
         gaF38GFbbRFbK+GrmZxqIT3UZ+lNqRdqmf/UPSfH2AiV5X8eOgYnonfGpinP3Ij9RFwu
         OEgDNpokwQTbpxym8AJ7OqZQoosCk6CiyoyM7iTIisihqpBaV0IHaO5aoXqJYBqVu9LA
         rdngQ5CHjNZ9vXCOqWrN3lyXeiP9Js7PBcICyI1cC59np8PgPlc41L01oxSOQ0l3KhR8
         h7jb5JO8aghN7C/W4/oxB6QEW45+fniDY0pfkIpRhiVSJfl+KpbF5/P03NuY6cv2ChG6
         8XIQ==
X-Gm-Message-State: AOAM5308NVNzsh8/ufQgVjRpDWKDw5v4D9BMRNqrN1QzlKu/dpxOu+be
        iHNcIWxzXkFl8BVnfiEselQZgbYaghA=
X-Google-Smtp-Source: ABdhPJx6GMDOJZ0wKERza8G1ZpSzWslR7S0DSrk6twrm8Aby6pkxHVgQsyt6FbYh9uJaA0s5eV7sdg==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr13764699wrx.97.1615547523774;
        Fri, 12 Mar 2021 03:12:03 -0800 (PST)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id k11sm1835361wmj.1.2021.03.12.03.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:12:03 -0800 (PST)
Subject: Re: [PATCH 2/2] [WIP] sequencer.c: carry forward notes on HEAD across
 "rebase -x"
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8s6tcuxc.fsf@gitster.g>
 <20210312030107.1849942-1-gitster@pobox.com>
 <20210312030107.1849942-3-gitster@pobox.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8f5010fa-cafe-779e-b555-f018bf15c7ee@gmail.com>
Date:   Fri, 12 Mar 2021 11:12:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210312030107.1849942-3-gitster@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2021 03:01, Junio C Hamano wrote:
> When the external command invoked by "rebase -x" replaces the HEAD,
> we seem to lose the notes attached to the original HEAD, which is
> why we have been losing the amlog mappings in the git core project.
> 
> Here is a half-successful attempt to fix it.  For whatever reason,
> when the external command is "git commit --amend --no-edit", the
> updated code carries notes forward correctly, but when the command
> is changed to "git commit --amend -m tweak", it fails to do so, and
> I do not have more time to work on this, so I'd stop here with an
> expected failure in the test.
> 
> Help is appreciated.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   sequencer.c                   | 10 +++++++++-
>   t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 92a4871997..e0bdc39e4d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3276,7 +3276,10 @@ static int do_exec(struct repository *r, const char *command_line)
>   {
>   	struct strvec child_env = STRVEC_INIT;
>   	const char *child_argv[] = { NULL, NULL };
> -	int dirty, status;
> +	int dirty, status, bad_head;
> +	struct object_id old_head_oid, new_head_oid;
> +
> +	bad_head = get_oid("HEAD", &old_head_oid);
>   
>   	fprintf(stderr, _("Executing: %s\n"), command_line);
>   	child_argv[0] = command_line;
> @@ -3286,6 +3289,11 @@ static int do_exec(struct repository *r, const char *command_line)
>   	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
>   					  child_env.v);
>   
> +	bad_head |= get_oid("HEAD", &new_head_oid);
> +
> +	if (!bad_head && !oideq(&old_head_oid, &new_head_oid))
> +		commit_post_rewrite(r, &old_head_oid, &new_head_oid);

If HEAD has changed then we copy the notes - but we never copied the 
notes from the original commit to the rewritten commit before running 
the exec command so this does not do what we want. I think this is why 
the second test below fails. I think the first test passes because the 
author and committer identities and dates of the amended commit are 
unchanged from the rebased commit so we end up copying the notes at the 
end of the rebase because the oid is unchanged.

Blindly copying the notes here would mean that the notes would be copied 
if an exec command created a new commit on top of HEAD rather than 
amending HEAD which is not what we want.

Best Wishes

Phillip

>   	/* force re-reading of the cache */
>   	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
>   		return error(_("could not read index"));
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 66bcbbf952..3222c594ab 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -155,6 +155,8 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>   	git rebase --continue
>   '
>   
> +# NEEDSWORK: Fix c762aada1ab3a2c428c with s/@/HEAD/;
> +
>   test_expect_success 'rebase -x with empty command fails' '
>   	test_when_finished "git rebase --abort ||:" &&
>   	test_must_fail env git rebase -x "" @ 2>actual &&
> @@ -867,6 +869,22 @@ test_expect_success 'rebase -i can copy notes over a fixup' '
>   	test_cmp expect output
>   '
>   
> +test_expect_success 'notes are copied even rebase -x changes HEAD' '
> +	git reset --hard n3 &&
> +	git rebase -x "git commit --amend --no-edit" n1^1 &&
> +	git log --format="%s <%N>" n1^1..n3 >expect &&
> +	git log --format="%s <%N>" n1^1..HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'notes are copied even rebase -x changes HEAD' '
> +	git reset --hard n3 &&
> +	git rebase -x "git commit --amend -m tweak" n1^1 &&
> +	git log --format="tweak <%N>" n1^1..n3 >expect &&
> +	git log --format="%s <%N>" n1^1..HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'rebase while detaching HEAD' '
>   	git symbolic-ref HEAD &&
>   	grandparent=$(git rev-parse HEAD~2) &&
> 

