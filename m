Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CF7C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF160FE9
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFPRk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFPRkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 13:40:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F8C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:38:49 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u13so126599qvt.7
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9jeE1qJaszaTrohjEUWXmQHJL2oOBBa3AKK9+Bz71Bk=;
        b=eOHNaawnjfR9m1WTtQdBoNincAKeqOb7ExitkGCkH1iCEW8zZVn2HvutfonuiEG5vz
         MvdKuJfrcI8Cwyv6nceKzdwrvpVGHp6+DogKYz3YS8gPZErCpk/JJ0+r65G5M41JhTfX
         jLkQMGT5jnKKeIcjgUN/uoOWvfT55ukM90qOUt1Cox0Rh9ZYyGqqXaKHw1H7SdFbbLY6
         mE+vzFXfWuc8JGZ9oP1WTIafkPa+bEZ9Q3fAYWPDvbuJ2wMHv8/0RMyu/Et7N1x9D/P9
         5seKxc7tvQdXad7xiNpsN/80RNzpuoBdBmWyXMFizIuyHzjtmdtGKU2VzAuy2fVy7/hh
         rqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jeE1qJaszaTrohjEUWXmQHJL2oOBBa3AKK9+Bz71Bk=;
        b=ZFYy4IKHZPKF/PJeMLV4WSlpcUyYrp5XChrmSBOlt3+qhfW/BwkdlnO91BPUjaZkSj
         vjp3PFM878UkRbLsB66wnhXc3wU8gjc1quz3yt9XvBiVEWbR/T8CLmB4xOrzzKUGZnry
         X3HY0QpNlaclF0x6DfJs8kJR4Lnarj+soYGSDkaYBv6rSGhwRSV3SJ1n6oEqXgiIImUy
         npuzQMegyu//XvUezj5xlMNoLF9IjHJ4UU52zBA6aOnKY2lI6qT9lPptwrQlsHHfcj4T
         mCNldonYNWApbxlnLEoPnoqX3vZVjlOR+dVq74s2Un1Y1NGHzeswX4nSO9oAznG6S8Ug
         oxyg==
X-Gm-Message-State: AOAM532Naz+DaMJu+JB8dMyK/ew9AuLIAu7MrpIcIgB+3LiXpLkKoN7m
        ILzDNTiDz0eicRp3QVIP+OY=
X-Google-Smtp-Source: ABdhPJyrlgFz/wQqTsOpZuhQp4WCWfSAusp9pjcg0Rx0vngJwP6lk95flaRA1yw7J+vZdVLKFPNVPA==
X-Received: by 2002:a05:6214:334:: with SMTP id j20mr1203240qvu.7.1623865128324;
        Wed, 16 Jun 2021 10:38:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4142:2009:c909:559c? ([2600:1700:e72:80a0:4142:2009:c909:559c])
        by smtp.gmail.com with ESMTPSA id u123sm2074700qkh.83.2021.06.16.10.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 10:38:47 -0700 (PDT)
Subject: Re: [PATCH] doc: builtin add -i is enabled by feature.experimental
To:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210615164522.1079951-1-tmz@pobox.com>
 <xmqq4kdyturm.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <545a93c8-3135-6cc5-6b14-1597a2658b9d@gmail.com>
Date:   Wed, 16 Jun 2021 13:38:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kdyturm.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2021 10:20 PM, Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Note that add.interactive.useBuiltin is enabled by feature.experimental.
>> It was added in 2df2d81ddd (add -i: use the built-in version when
>> feature.experimental is set, 2020-09-08).

Thank you for noticing that there is discrepancy in the docs.

> So together with the fetch.negotiationAlgorithm only two knobs are
> affected by feature.experimental?  Or is this patch only about add-i
> because that is the only thing you found out about?
> 
> Explicitly state that these are the only two that are affected by
> this bit in the log message so that readers of "git log" do not have
> to ask the question.
> 
> The other configuration feature.experimental controls is described
> in Documentation/config/fetch.txt like this:
> 
>     fetch.negotiationAlgorithm::
>             Control how information about the commits in the local repository is
>             sent when negotiating the contents of the packfile to be sent by the
>             ...
>             The default is "default" which instructs Git to use the default algorithm
>             that never skips commits (unless the server has acknowledged it or one
>             of its descendants). If `feature.experimental` is enabled, then this
>             setting defaults to "skipping".
>             Unknown values will cause 'git fetch' to error out.

This was my intention at first: create pointers in both directions:

* The docs for 'feature.experimental' should indicate which options
  are modified when this config is enabled. Users can then navigate to
  those options for ideas of what specifically they mean.

* The options for individual config values (such as
  fetch.negotiationAlgorithm) also mention that their defaults are
  modified by feature.experimental, so users can understand why the
  behavior might have changed.

> Alternatively, we can 
> 
>  - Remove the description of other configuration variables affected
>    by feature.experimental from the description of the experimental
>    bit in Documentation/config/feature.txt, and replace it with "The
>    default values for configuration variables marked with
>    '[EXPERIMENTAL]' are affected by setting this bit", and

This provides a nice way to satisfy the need to know "what changes
when feature.experimental is enabled?" without needing to change the
text with every update.

The issue I have is that it's not as simple as things being enabled
or disabled, because sometimes its a more nuanced change.

>  - Start the description of fetch.negotiationAlgorithm with
>    [EXPERIMENTAL] like this one does, and remove the sentence about
>    the experimental bit from there.

I think we still want to indicate something about feature.experimental
in the affected values. We can establish a clean format for this, such
as stating the option with [EXPERIMENTAL] but then also saying:

	If `feature.experimental` is enabled, then the default changes
	from `default` to `skipping`.

The [EXPERIMENTAL] tag provides an easy way to search, but this
added description can provide context to someone who navigated to
the config without knowing about feature.experimental.

We should explain these possible values separately from this
sentence. Here is a possible modification of the entire description
(format adapted from diff.dirstat):


fetch.negotiationAlgorithm::
	[EXPERIMENTAL] Control how information about the commits in the local
	repository is sent when negotiating the contents of the packfile to be
	sent by the server. The following values are supported:
+
--
`default`;;
	Git will never skips commits, unless the server has acknowledged it or
	one of its descendants.
`skipping`;;
	Git will use an algorithm that skips commits in an effort to converge
	faster,	but may result in a larger-than-necessary packfile.
`noop`;;
	Do not send any information at all, which will almost certainly result
	in a larger-than-necessary packfile, but will skip the negotiation step.
--
+
If `feature.experimental` is enabled, then the default value changes from
`default` to `skipping`. See also the `--negotiation-tip` option for
linkgit:git-fetch[1].


And the docs for `add.interactive.useBuiltin` could be:


add.interactive.useBuiltin::
	[EXPERIMENTAL] Enable this value to use the experimental built-in
	implementation of the interactive version of linkgit:git-add[1]
	instead of the Perl script version. If `feature.experimental` is
	enabled, then the default changes from `false` to `true`.


I'm not pushing hard for this direction, but it is one that makes sense
to me. It allows us to update the individual config values when they are
added or removed from the feature.experimental setting without needing
to also update the feature.experimental setting.

Thanks,
-Stolee
