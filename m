Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82217CCA473
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 15:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354089AbiFAPDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiFAPDG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 11:03:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B03ED3A
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 08:03:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so1256473wmz.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W9r7bmOuLC3snhqvNbJ45RjzouQIa0buIhPBpOqVqxo=;
        b=PpBi0URbZhHrbGdZ2nz92Otuk2bycGZGuwDXaubNI03156ltWjBCt5T8PNwL1w4X40
         ZhHTEZkmQfkYNrOydKUqCfOzwmNTHfnW1XGqSIw1VWTFDlqAf/GvbBr/1eKNaCkX69l9
         evcYlRiWCLhtGUE5rogJWXrEEeVyOITp0j2Qa1PRD/dQRa24HWT+3/BUFossrNxxX6Zj
         o2IjQkd4HeObfMU/VwCY2BuuutiR2dmlye7yVq7GrLJTiBT2pFFnIBYRpNTF0r4E/T1A
         7ebAKan1+/9kgilCQrDgSoRjtVPn3U20FCPuoapwJUo/TFgpqfcXWK3A0GGwIFi64mvw
         Rg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W9r7bmOuLC3snhqvNbJ45RjzouQIa0buIhPBpOqVqxo=;
        b=Cn6Q39s0+VAP8qKfzGYxkDnIUs9Nz4rETAIVvVU4gom0kKKj+M59eVUZQU3WGbqZuX
         XUUfO0uQY/GkubSbIqaBFO0KVksnJdlQTZqGqATVg+pSwUCgE8JTaI/+C3nvFhb4Z/hU
         MZFC821fdNLkO84/CFECaFZXFmb6ubV+AMHawJ4JDKL0C0TTfcOpvlqN4ykstML41Sop
         Ok3vuYPgaEOT+1I0bYR0uqZYdiKaO8qKPmogQ5HFsP9b+ZmZicr7KgNjZpnnjJ5JWqC8
         AYt7wi6rFcyJ0bPwMEaVjEfrWOUKmIIK11isbTYrV+E1f6H6FR2Cnmv+R4vcFLf+BWMY
         Rj+g==
X-Gm-Message-State: AOAM532wz8KDH92y7X0sqqk6Sv7i+0j1+E05SUY+ytUheo75sVi07lIG
        J/EPL06R7BDZvD4t8CV6Hg0=
X-Google-Smtp-Source: ABdhPJwDlrZ5ko7bmADv2mI8y5FVK3OTeRDKLiypo96PxseJhpYYXnrR4w7ky6w0uI5nuaW2/dLVCA==
X-Received: by 2002:a05:600c:1ca9:b0:397:55d1:de81 with SMTP id k41-20020a05600c1ca900b0039755d1de81mr29230475wms.175.1654095783160;
        Wed, 01 Jun 2022 08:03:03 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d4f87000000b0020ffa2799f4sm1743680wru.73.2022.06.01.08.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 08:03:02 -0700 (PDT)
Message-ID: <c0635170-5a52-c426-8231-d7291a79fa2c@gmail.com>
Date:   Wed, 1 Jun 2022 16:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] revert: optionally refer to commit in the "reference"
 format
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqsfp2b30k.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205231507350.352@tvgsbejvaqbjf.bet>
 <xmqq35gzn9vk.fsf@gitster.g> <xmqq8rqn7buk.fsf_-_@gitster.g>
 <479d97af-eef1-ce86-19f7-afcc0e6ecf30@gmail.com> <xmqqfskpuh2w.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqfskpuh2w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/06/2022 05:45, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I think the changes to the template message are good. We're still
>> adding "--reference" as a valid option to cherry-pick though which I
>> don't think is a good idea (though in the future we may want to allow
>> "cherry-pick -x --reference")
> 
> I love when people notice mistakes that the original author and
> other people missed, many eyes making all bugs shallow.
> 
> I am inclined to apply the following on top.  How does it look?

It looks good to me.

Best Wishes

Phillip

> Thanks.
> 
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] revert: --reference should apply only to 'revert', not 'cherry-pick'
> 
> As 'revert' and 'cherry-pick' share a lot of code, it is easy to
> modify the behaviour of one command and inadvertently affect the
> other.  An earlier change to teach the '--reference' option and the
> 'revert.reference' configuration variable to the former was not
> careful enough and 'cherry-pick --reference' wasn't rejected as an
> error.
> 
> It is possible to think 'cherry-pick -x' might benefit from the
> '--reference' option, but it is fundamentally different from
> 'revert' in at least two ways to make it questionable:
> 
>   - 'revert' names a commit that is ancestor of the resulting commit,
>     so an abbreviated object name with human readable title is
>     sufficient to identify the named commit uniquely without using
>     the full object name.  On the other hand, 'cherry-pick'
>     usually [*] picks a commit that is not an ancestor.  It might be
>     even picking a private commit that never becomes part of the
>     public history.
> 
>   - The whole commit message of 'cherry-pick' is a copy of the
>     original commit, and there is nothing gained to repeat only the
>     title part on 'cherry-picked from' message.
> 
> [*] well, you could revert and then you can pick the original that
>      was reverted to get back to where you were, but then you can
>      revert the revert to do the same thing.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   builtin/revert.c              | 9 +++++++--
>   sequencer.c                   | 2 +-
>   t/t3501-revert-cherry-pick.sh | 6 ++++++
>   3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index ada51e46b9..f84c253f4c 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -116,8 +116,6 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   			N_("option for merge strategy"), option_parse_x),
>   		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>   		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> -		OPT_BOOL(0, "reference", &opts->commit_use_reference,
> -			 N_("use the 'reference' format to refer to commits")),
>   		OPT_END()
>   	};
>   	struct option *options = base_options;
> @@ -132,6 +130,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>   			OPT_END(),
>   		};
>   		options = parse_options_concat(options, cp_extra);
> +	} else if (opts->action == REPLAY_REVERT) {
> +		struct option cp_extra[] = {
> +			OPT_BOOL(0, "reference", &opts->commit_use_reference,
> +				 N_("use the 'reference' format to refer to commits")),
> +			OPT_END(),
> +		};
> +		options = parse_options_concat(options, cp_extra);
>   	}
>   
>   	argc = parse_options(argc, argv, NULL, options, usage_str,
> diff --git a/sequencer.c b/sequencer.c
> index 96fec6ef6d..4b66a1f79c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -221,7 +221,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   		return ret;
>   	}
>   
> -	if (!strcmp(k, "revert.reference"))
> +	if (opts->action == REPLAY_REVERT && !strcmp(k, "revert.reference"))
>   		opts->commit_use_reference = git_config_bool(k, v);
>   
>   	status = git_gpg_config(k, v, NULL);
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index a386ae9e88..fb4466599b 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -205,4 +205,10 @@ test_expect_success 'identification of reverted commit (revert.reference)' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'cherry-pick is unaware of --reference (for now)' '
> +	test_when_finished "git reset --hard" &&
> +	test_must_fail git cherry-pick --reference HEAD 2>actual &&
> +	grep "^usage: git cherry-pick" actual
> +'
> +
>   test_done
