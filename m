Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03757C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 14:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiBGO2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390862AbiBGOBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 09:01:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F72C0401C2
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 06:01:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso14423501wmh.4
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 06:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zxBoS4vySYsGyHJRVAzaESvpY2vGcSdGOmSRhJ8aAxw=;
        b=HuJyjQPFBjHJRgp7YwTQkkQ1XKtINcTNd5hSFrDSMpbZvvJtayx2567z3tuXImGBFr
         LpZTo6Z5hjGR3iP9ikXrwWWM1XOhe8MN94lI2aBYpBdrIeYifKJ4WfTTLKdFmkrbIK+3
         mSEpBGXx6tCokUxOBUv3A6zajyQrXJuF3SZ28OQP3J7dKTub5hjt/13wKD5ZflHfNQLf
         Ln3T6SiMII8vTSaOc1CHJkbEp0QOPjJNSpN0WoiGU9buh0YhsfaHpqdtgUlTS4RvYOyz
         hLCPRK1NHGVRySgAC/PFsvX5hrPzGS44BSS3hBanRUe3h3V2v1wFDPIx7GtHuTwMsyPN
         kTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zxBoS4vySYsGyHJRVAzaESvpY2vGcSdGOmSRhJ8aAxw=;
        b=afH4GPbfbB5gU3cjVwlcIDPUtfMt76MSw0CuLU+uYlESCjUsUXjysXbPWPWJ9qucT5
         rw8xi+9+dSXM3GisCZUhYMT+MIbscMByuLtuhjZ/1cPYFAmHQ14yBinio1A46K1UDWbk
         ztPu3NxvGO6C8s+YD+jkstkHQpVInkzlCuTL5heO/cImSTnMYGZrsaZuSMJJI7us+dF1
         4kciEuA/MsrFaFeFJ88Pc7kOTvXg5Tv4yGcOTK9eFdN4mICsEt0upurlocXwWf6GxohT
         nu7aJDwQ270RS2OZIyFAzna1Ti5IYxJXaWCq8BsZ0DgrXUkJzXtyhUesmE7ViA/2ZWlp
         7t7g==
X-Gm-Message-State: AOAM530dxHWS9v6Au6ZCMp+lNN1btCNxxw2s7YzyCWu73cfY8h4tq9gr
        K6hdHIHiLg8b0+oc+oBz8bQz4L9MT+k=
X-Google-Smtp-Source: ABdhPJxHMwSI3470v8r08kbt718h95EUgwDn7yXrYagqxuE9lFbIDa0caaJk7HGn61ZuP+QZuz7jCg==
X-Received: by 2002:a1c:29c3:: with SMTP id p186mr14574843wmp.22.1644242487784;
        Mon, 07 Feb 2022 06:01:27 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id f16sm10712754wmg.28.2022.02.07.06.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:01:27 -0800 (PST)
Message-ID: <bb0532ca-f718-15d1-7328-fd0e062eae06@gmail.com>
Date:   Mon, 7 Feb 2022 14:01:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-checkout doesn't seem to respect config from include.path
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Greg Hurrell <greg@hurrell.net>, git@vger.kernel.org,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
 <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com> <xmqq1r0jx1qm.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1r0jx1qm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 03/02/2022 18:07, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... What we really want in this case is to
>> store the string value for each config option as we read each config
>> source and then parse those values at the end, unfortunately I think
>> that would break multi-valued config keys.
> 
> Thanks for raising, and looking into, the issue.
> 
> While the original "callback functions are called for each and every
> configuration item defined in the files and it is the responsibility
> for these callback functions to implement the semantics like the
> last one wins" design that uses git_config() makes it harder, but I
> think we are already halfway there, with the more recent API update
> in 2014 (!) that allows config_get_value() to go directly get a
> value given a key without writing callback functions.
> 
> I think builtin/add.c predates the configset API work (of course, it
> is natural that we can "git add" way before 2014), and mostly uses
> git_config(add_config) callback as a way to parse its configuration,
> because it needs to tell other subsystems (like diff, merge, etc.)
> that are even older to pay attention to the configuration variables
> they care about.
> 
> So it may be a major surgery to switch to the newer
> config_get_value() API.
> 
> For a "last one wins" variable, config_get_value() will only look at
> the last item, so any garbage value Git does not recognize would not
> trigger a fatal error.
> 
> Such an update is both good and bad.  Surely it makes the scenario
> that triggered this discussion more pleasant by not dying, but it
> makes it too pleasant by not even giving the user a chance to notice
> a possible typo.
> 
> A incremental improvement that we can immediately make is probably
> to teach the current xdiff-interface.c::git_xmerge_config() parser
> to react to an unknown value differently.  It should not die() but
> just ignore the unknown value, and issue a warning.  This should be
> doable with minimum impact to the code.

I think that would be worthwhile, the warning is potentially confusing 
though if a bad value is followed by a good value then we will warn 
about the bad value but use the good one.

Best Wishes

Phillip

> Completely untested.  The first test that would be interesting to
> run is how many tests this changes breaks to gauge how good test
> coverage we have ;-)
> 
>   xdiff-interface.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git c/xdiff-interface.c w/xdiff-interface.c
> index 2e3a5a2943..523b04960a 100644
> --- c/xdiff-interface.c
> +++ w/xdiff-interface.c
> @@ -322,8 +322,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
>   		 * git-completion.bash when you add new merge config
>   		 */
>   		else
> -			die("unknown style '%s' given for '%s'",
> -			    value, var);
> +			warning("ignored unknown style '%s' given for '%s'",
> +				value, var);
>   		return 0;
>   	}
>   	return git_default_config(var, value, cb);

