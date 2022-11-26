Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B39C4321E
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 14:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiKZOO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZOO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 09:14:58 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79951D30B
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:14:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q21so4724408iod.4
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5XRcwyobnWedtMIp2C37Tkv0VfXVgBwNE4/x7Op5dw=;
        b=lhunWMxvYB0Hea/zZkwDUHWS7rsJJjkcEuGlhP6moZERwcoaVyeiA0dRV1qTvvIzED
         aZGf8P3ivUy5USv4+bKjE3n3Xa3SLuwe4lxFpJuncjBJgbKEFz39FgkfXkEveffl3uez
         a6mbLFn3LVaYte9uaFOd+sJxpVjjZVQbbWo5zcvNXaDDvPqZStjs5NPgX8IVrdy/tYCo
         O5buxPbj+9gyS/mkxxQ0a07+9/kBOFqdhYWcUPWeOUPP+SbjiNPDD53NLBB5Uvc5helS
         N89k035cjUQrAODrj+rq3qDi+ry+prCLoG4WnvkNQQC3fs+WETsA9Y7uEgxl/eT6LA5v
         ZOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j5XRcwyobnWedtMIp2C37Tkv0VfXVgBwNE4/x7Op5dw=;
        b=FLGbYsshA5EsEkCk40oh925p2A9ls9Sb/G1quHYlQ/BpR+nzwu+iZPgIZfAWGjIyog
         eB5yZHvCjYTzX7kEXpxT2s+o3IoX2Dudq/NUxxROtlAltazs/SmocYrGjXrMG/x4Eq/P
         TEUGR30y/TCBUuEUqOsAEUReJ8wC0ItpQRCVNVqwnkfkF/qOYuFkhPh9+YNB84wopW+i
         A8W9lIzqgVXOaKXRa39oDdfpjamuvrYYfRwM0JYnsKbI14ni1Ud65H/Ezj3epBRDKZ4e
         EgVo4VVWLOq2IYW3BN7D3ZLD0Py+fpOLAFraeJwu/mYLO6RbYjAhGqpqad7Ta7lZXt7H
         eegA==
X-Gm-Message-State: ANoB5pnEkjF9tsRuqyt85lzRreF52UWD612oTKBaZpzwU9utSlMhrSZ0
        6ZshvuDtVnYVRIjsuw3cGhk=
X-Google-Smtp-Source: AA0mqf74MjQ8yqLAjDIKolBK452XkrqPzdycQM84NCyY615mcUUhVFwwX/z8+e8joiUMR5G/bBysvA==
X-Received: by 2002:a02:cf18:0:b0:363:c1cc:ce75 with SMTP id q24-20020a02cf18000000b00363c1ccce75mr19830328jar.125.1669472096990;
        Sat, 26 Nov 2022 06:14:56 -0800 (PST)
Received: from stargate ([2620:72:0:a40:5b60:5fdc:536b:b9e4])
        by smtp.gmail.com with ESMTPSA id m4-20020a02a144000000b00389cb050d1bsm873039jah.33.2022.11.26.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 06:14:56 -0800 (PST)
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
 <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
 <427cb7b55ac3fead1651cbad7318b9c0bb454b08.1669395151.git.gitgitgadget@gmail.com>
 <221125.86pmdamyv5.gmgdl@evledraar.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v2 2/2] var: allow GIT_EDITOR to return null
Date:   Sat, 26 Nov 2022 07:54:22 -0600
In-reply-to: <221125.86pmdamyv5.gmgdl@evledraar.gmail.com>
Message-ID: <87fse5ssyo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> Negate git with "test_must_fail", not "!", this would e.g. hide
> segfaults. See t/README's discussion about it.
>
>> +		test_cmp expect actual
>
> Looks like this should be:
>
> 	test_must_fail git ... >out &&
> 	test_must_be_empty out

Nice! I don't know why I didn't look for t/README, but I also found
test_expect_code, which seems to be even more specific as to what is
being expected. I assume it has the same segfault detection.

This has now been incorporated in my branch; I'll submit it in v3 later
today.

>> +test_expect_success 'get GIT_EDITOR with configuration and environment =
variable EDITOR' '
>> +	test_config core.editor foo &&
>> +	(
>> +		sane_unset GIT_EDITOR &&
>> +		sane_unset VISUAL &&
>> +		sane_unset EDITOR &&
>> +		echo foo >expect &&
>> +		EDITOR=3Dbar git var GIT_EDITOR >actual &&
>> +		test_cmp expect actual
>> +	)
>
> Perhaps these can all be factored into a helper to hide this repetition
> in a function, but maybe not. E.g:
>
> 	test_git_var () {
> 		cat >expect &&
> 		(
> 			[...common part of subshell ...]
> 		        "$@" >actual &&
> 			test_cmp expect actual
> 		)
> 	}
>
> (untested)

In all honesty, I think too much abstraction would do more harm than
good here. I definitely share the instinct to factor out the common
pieces, but in other codebases I've worked in, that tends to stifle
future changes in the tests themselves.

That said, I can't realistically imagine a world where a
'sane_unset_all_editors' would stifle code changes -- and I think that
accounts for the lion's share of the repetition. I've incorporated such
a helper in my branch now.

If you're not convinced there should be further abstraction, I'd rather
leave things 'stupid simple' -- but if you think this would block merge,
I'd be happy to take a crack at further factoring out what I can.


--
Sean Allred
