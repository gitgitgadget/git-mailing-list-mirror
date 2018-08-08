Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4A51F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeHHVdM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:33:12 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53164 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHVdM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:33:12 -0400
Received: by mail-wm0-f46.google.com with SMTP id o11-v6so3816418wmh.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e1VD1zsoy39SXZXv7shKAZUS0teNWiXy+/TU2jDJPiI=;
        b=AgE4mNZYKziBlA83/VRYoBifyLzWeXsxh4FImvg/724IDm5HQd8WXHAIi1L25FWqe7
         tV2cWXMjEvR4dtyX//OZIWesQXWHoYU/64Ow4UqRmR8eYV7KfVgXSMJgEDxHR8NBRQ4W
         kf/viu3aKFyc6Suk6BF2zgLC/OR/Csqi8d+QOBjqr2mK0+FWjuc2exfWuZA+PaF0ZAtp
         +htgpxalYkEQ0u4W55IFKHp8PmI7NWRE2xrR+qO3fPiJ+oss3HrivNwGwSYSWzuriI2k
         WSgyW3l9O2waUgy/Jo3PZmRNSGqjHL26SP1MNrcuBBLsDNnA52fTYpFk1bHb5FwK9/Y+
         gF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e1VD1zsoy39SXZXv7shKAZUS0teNWiXy+/TU2jDJPiI=;
        b=KK0hpVN727aPzFzhMdN/6KjoL629SDWiVixhpPayCm4DxV1UnjLJ/IzvcTeITBy8wX
         1Co3i+M6nKZw9Dp8pbNjgm84jqssEUzmesnp9Z6G5kp1ouqKiQ4zsJ6BjSyFDrtv4xZu
         pH2dB1UNrNFTV33E55SLclfXBhWoFM7Ent+M8S0AFcBuiqybG8yf01knWepfKMbDk6CK
         92V/tdlomX41z4R0YkYMkQFJiuZq/cGRPIWoglYykCqKZL8ingGut+XOIqDaffG2NvI3
         tfb4QwmCKYJBbIjaQ5siOdS+6OOC/yYvUyBTtD/Orhkyj/YSV6yctaEMDGu7bsnwSVVK
         VVIg==
X-Gm-Message-State: AOUpUlF2jFUfOkccLyyAIlwOpZfdspk5HUdw5ZEsrGE4VtMwELwp8ppD
        fr+BJK1alf1mMEypJfgWxt0=
X-Google-Smtp-Source: AA+uWPwonTYVNWEqXHtVT3n2Z6jF2jRRIhZA5yv7R+78bfw82gqqyXZKqzmO/5xsUf1f70hCeprEjw==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189-v6mr2555571wmf.12.1533755527200;
        Wed, 08 Aug 2018 12:12:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k12-v6sm4965541wru.38.2018.08.08.12.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 12:12:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH 02/11] builtin rebase: support `git rebase --onto A...B`
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <20180808134830.19949-3-predatoramigo@gmail.com>
Date:   Wed, 08 Aug 2018 12:12:06 -0700
In-Reply-To: <20180808134830.19949-3-predatoramigo@gmail.com> (Pratik Karki's
        message of "Wed, 8 Aug 2018 19:33:21 +0545")
Message-ID: <xmqq1sb8hdvd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> This commit implements support for an --onto argument that is actually a
> "symmetric range" i.e. `<rev1>...<rev2>`.
>
> The equivalent shell script version of the code offers two different
> error messages for the cases where there is no merge base vs more than
> one merge base. Though following the similar approach would be nice,
> this would create more complexity than it is of current. Currently, for

Sorry, but it is unclear what you mean by "than it is of current."
Do you mean we leave it broken at this step in the series for now
for expediency, with the intention to later revisit and fix it, or
do you mean something else?

> simple convenience, the `get_oid_mb()` function is used whose return
> value does not discern between those two error conditions.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ...
> @@ -387,7 +389,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	if (!options.onto_name)
>  		options.onto_name = options.upstream_name;
>  	if (strstr(options.onto_name, "...")) {
> -		die("TODO");
> +		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> +			die(_("'%s': need exactly one merge base"),
> +			    options.onto_name);
> +		options.onto = lookup_commit_or_die(&merge_base,
> +						    options.onto_name);

The original is slightly sloppy in that it will misparse

	rebase --onto 'master^{/log ... message}'

and this shares the same, which I think is probably OK.  When this
actually becomes problematic, the original can easily be salvaged by
making it to fall back to the same peel_committish in its else
clause; I am not sure if this C rewrite is as easily be fixed the
same way, though.

>  	} else {
>  		options.onto = peel_committish(options.onto_name);
>  		if (!options.onto)
