Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB5C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B361B61206
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhEQGK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 02:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhEQGKU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 02:10:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D34C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 23:08:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k5-20020a05600c4785b0290174b7945d7eso2423422wmo.2
        for <git@vger.kernel.org>; Sun, 16 May 2021 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FZveDAOHGZDDgMejYMMFVRZQfru9K3rUVYUQgvWIY/w=;
        b=LSNC0fOXpKYbTfWqoJJXKJqhu4hfwjJpfVt2hRj3VH1MYKZb7SfILrd+A61HN2NIuY
         3zYlAFBgx96I5ZWyVJ0hys8rejOnbog42CYTzpzI8qWrKylezWECg5iydW7WLtMwqq+5
         jblKOH1D0x/7A7R1QIeQx0hD5soT9bdAe5jUfOBSuEXrpKGYLfYcg8y6qjhg4HXvLJLk
         ayxahVJWIiru+pbd7DxKSwJRzzhT2P0EWBMwo08WWqal3PAx5Uihzw4rxJF/LwzS5DOJ
         JUSuY4Ky+/41yFufiCkynBn41bFX6U3io93yNor3MVsYnzFgzfgPYxKpaPERJRB6d8+j
         RDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FZveDAOHGZDDgMejYMMFVRZQfru9K3rUVYUQgvWIY/w=;
        b=EvROuA5E96aF9v6ZjolsBlcmaM6l68XWiOx4gzlWLKoT6ZM4z5/9ybhzq0pwgCaLoL
         6XOxpuCyytRCqMsDIE12NxNXDl3mGf/IXnrRo//ljmJHSI3VxJQOUrIIHJcagBCG7D+6
         pT/3gSDgBo1ITpZoElPmcADHA1Nsk5v7+ZVPV2KE2y3eTAwLblB0kIqRcpcWqyrTnFT+
         DEJTL1nP2We8ayKbsaE/u2fJU5WhkKzDCGTdfg99ZOqp5oR1c83Uj6rSvqhwREVLWtgK
         6+EuyRS64ejlbCh6Vq4FVZWUYa6nr9hOjn5KuYcF5lTlLCASGB+J1PJ8YTlscYUsJgQ6
         fwow==
X-Gm-Message-State: AOAM532YI2HBwesPjzDVyYYukk8MCYJkFBGqClo6awjNFSZvD4Jqpk68
        kT4XeR9xMUUw4AQ0CJ/7N4LK3V/cgKw=
X-Google-Smtp-Source: ABdhPJxgQAeIzphhV0edvZgWslzzz9DVwcvgWZ3oo5odGh9xBntIrWhVQgUVwwg3Hexglx1ercJT+w==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr14610629wmj.176.1621231725164;
        Sun, 16 May 2021 23:08:45 -0700 (PDT)
Received: from Inspiron (2a01cb04010c42001d97d57b11f780ca.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1d97:d57b:11f7:80ca])
        by smtp.gmail.com with ESMTPSA id a129sm2639472wmh.20.2021.05.16.23.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 23:08:44 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] t: use test_config whenever possible
In-Reply-To: <xmqqbl9b6zla.fsf@gitster.g>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210515152721.885728-1-firminmartin24@gmail.com>
 <20210515152721.885728-3-firminmartin24@gmail.com>
 <xmqqbl9b6zla.fsf@gitster.g>
Date:   Mon, 17 May 2021 08:08:42 +0200
Message-ID: <87fsylgadx.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano <gitster@pobox.com> writes:

> Use of test_config to replace #1 below is a correctness improvement,
> and use of test_config to replace #2 below is a readability thing.
>
>     t: use more test_config for correctness and readability
>
> perhaps?
OK.

> Adding "because this form fails to unset the config if an earlier
> step fails." would be helpful to the readers to clarify that this is
> a correctness "fix".
Will do.

To be honest, I'm completely lost in the remaining of your reply (in
fact, I suspect that you misread the diff, cf. the end of the email). 
I copy here the full test with line number to make sure that we are in
the same page.

>  415 test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config" '
>  416     (
>  417         cd downstream &&
>  418         git fetch --recurse-submodules
>  419     ) &&
>  420     add_upstream_commit &&
>  421     git config --global fetch.recurseSubmodules false &&
>  422     head1=$(git rev-parse --short HEAD) &&
>  423     git add submodule &&
>  424     git commit -m "new submodule" &&
>  425     head2=$(git rev-parse --short HEAD) &&
>  426     echo "From $pwd/." > expect.err.2 &&
>  427     echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
>  428     head -3 expect.err >> expect.err.2 &&
>  429     (
>  430         cd downstream &&
>  431         git config fetch.recurseSubmodules on-demand &&
>  432         git fetch >../actual.out 2>../actual.err
>  433     ) &&
>  434     git config --global --unset fetch.recurseSubmodules &&
>  435     (
>  436         cd downstream &&
>  437         git config --unset fetch.recurseSubmodules
>  438     ) &&
>  439     test_must_be_empty actual.out &&
>  440     test_cmp expect.err.2 actual.err


> The original seems to be making sure that the config set in
> "downstream" repository is used successfully before it is unset from
> the global configuration
OK. 
> and then the same fetch in the downstream will work even when the
What do you mean by "the same fetch"? the one of line 432 or any
instance of "git -C downstream fetch" in later tests? 
> configuration is removed from the global configuration.

> The squashing of the two tests into one
Same question as above, I don't understand "the second test" you are
referring to (specifically, which lines?).

> would change what is being tested, wouldn't it?
I agree that the semantic isn't the same (as test_config_global will
unset global config after unsetting the "downstream" config), but since
there is *not* another git-fetch after the global unset and before the
"downstream" unset I thought that it is fine.

> Surely, the actual.out and actual.err in the first invocation *was*
> overwritten without being looked at, but the exit status of that
Aren't they considered in the end of the test ? (lines 439-440).
> fetch (i.e. fetch before global config gets unset) was still checked
> in the original.  So I'd call this a "simplification"
>
>>  	(
>>  		cd downstream &&
>>  		git config fetch.recurseSubmodules on-demand &&
>> -		git fetch >../actual.out 2>../actual.err
>> +		git fetch
>> 	) &&
>> 	git config --global --unset fetch.recurseSubmodules &&

> I.e. these redirected output files were not used and the next fetch
> will overwrite them.
Same question as above.

> The patch I am responding to claims that 
>
>  - "make sure it succeeds with global set, and then without global
>    set, make sure it still works" is not worth testing.
In this test, there is no "make sure it still works without global set"
(i.e. I didn't see any git-fetch invocation after the global
configuration unset). Are you referring later tests?
>
>  - it is OK to replace it with a single "it succeeds without
>    unsetting the global config".
At this point, I have the feeling that you have misread the diff
(do correct me If I'm wrong) and saw ...
>  (
>      cd downstream &&
>      git config fetch.recurseSubmodules on-demand &&
>      git fetch >../actual.out 2>../actual.err
>  ) &&
>  git config --global --unset fetch.recurseSubmodules &&
>  (
>      cd downstream &&
>      git fetch >../actual.out 2>../actual.err
>      git config --unset fetch.recurseSubmodules
>  ) &&
(note the second extra git-fetch)

... instead of

>  429     (
>  430         cd downstream &&
>  431         git config fetch.recurseSubmodules on-demand &&
>  432         git fetch >../actual.out 2>../actual.err
>  433     ) &&
>  434     git config --global --unset fetch.recurseSubmodules &&
>  435     (
>  436         cd downstream &&
>  437         git config --unset fetch.recurseSubmodules
>  438     ) &&

In this case, what you said (e.g. simplification etc.) makes perfect sense.

Thanks,

Firmin
