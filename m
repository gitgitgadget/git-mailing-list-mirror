Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D65C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 07:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiDYHhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 03:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiDYHhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 03:37:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16FBF7C
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 00:33:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 17-20020a05600c021100b00393a19f8f98so5995212wmi.4
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:autocrypt:organization:subject:in-reply-to;
        bh=ZRaCUGOcGTGEPGcLdhq4sinaCdPR+YHP742DiL5aWPw=;
        b=4o8dkoKZ8dqSb9BOBC/RrNj1CIsOJsm2HlQnRx21MvHO4LLH7y95meuiii77Lj3df7
         BeKb5e6qBax7hvNtMicCVjF5MkqgiiSNaNNil1Vl7jBEcH9WTAvsS6KpOUAF8VpkNB1T
         +yPorF/pZWt+6i2S5VmtcQJvk6JKQK17Q5DUpDdiXAwDNlmtHbc3UllauIVfExys5TsO
         a7uRXdsk23LI4kwHTNDrtxTU8WDBJILXPsy7mOA9ZdkI16H/02Qd+BwPhbH3YNkBvcJl
         AOLGt8KhJaNo5FlQ8DYuWafkhJf/a0ByThlKIjJnFF4js4XJemkuODj2Oc0riM/rAYsa
         RYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:autocrypt:organization
         :subject:in-reply-to;
        bh=ZRaCUGOcGTGEPGcLdhq4sinaCdPR+YHP742DiL5aWPw=;
        b=HMdy253cmY8JrsRWBN4KciN7QtR9t7i3ySLFOpwIuqdMIEGbR6kHs6bgO3jAKqN+9u
         EpPhfELT7/kvvWO53iw90OTNEe5yO2q/wjo80XDu9YFVQW1BvzeV2HtOZDETaF0v7VGi
         Gkov56FcnPwZhJfx3uM/Y3FRcrCQ/bakJxTMZZEvOvLehLn6iwLPzL4F6+Uqc7oWjnbV
         Nm0NsHFr1MBEvC5mMLg7j+QFSQ4dt1O+WhVNRy8nMbUwhQTlYB7Zf4bl1pSv1mhf1ZWg
         xnXFnnO77Z6fRvhkx+ItLQfrl5e0gSlpg9br9nOTuHzJQ08EJIvUWXcdEv2Wbtou9wu1
         y/lg==
X-Gm-Message-State: AOAM5323R0XXjjyl0g19JAsPaopTkkDkxc6TZ8tRVuIbkZc/4sKQxqFI
        PWEt6UMRtzP9IOB7OIb2bIAM6A==
X-Google-Smtp-Source: ABdhPJwfCIHYYlnmfxiTC1iW0vywxHpler969fU+GBwOh8nFVqwFp2Lmp/8r3uTHhaTCWctgSN9kZw==
X-Received: by 2002:a05:600c:3553:b0:393:ef28:7aba with SMTP id i19-20020a05600c355300b00393ef287abamr837904wmq.159.1650872035760;
        Mon, 25 Apr 2022 00:33:55 -0700 (PDT)
Received: from [192.168.1.9] (19.33.130.77.rev.sfr.net. [77.130.33.19])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c1c8e00b00393e9293064sm3520437wms.35.2022.04.25.00.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:33:55 -0700 (PDT)
Message-ID: <0c9f8841-eb36-05a2-988f-929ab46dc6a5@p1sec.com>
Date:   Mon, 25 Apr 2022 07:33:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        gdd via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1222.git.1650634704191.gitgitgadget@gmail.com>
 <xmqqv8v19ght.fsf@gitster.g>
From:   Gregory David <gregory.david@p1sec.com>
Autocrypt: addr=gregory.david@p1sec.com; keydata=
 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
 v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=
Organization: P1 security
Subject: Re: [PATCH] show-branch: fix SEGFAULT on both --current & --reflog
In-Reply-To: <xmqqv8v19ght.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j6mqXMYmGEZCG091QuSxJjmV"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j6mqXMYmGEZCG091QuSxJjmV
Content-Type: multipart/mixed; boundary="------------x4xlNvg60W6h9b4nDR0SgBzH";
 protected-headers="v1"
From: Gregory David <gregory.david@p1sec.com>
To: Junio C Hamano <gitster@pobox.com>,
 gdd via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=
 <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0c9f8841-eb36-05a2-988f-929ab46dc6a5@p1sec.com>
Subject: Re: [PATCH] show-branch: fix SEGFAULT on both --current & --reflog
References: <pull.1222.git.1650634704191.gitgitgadget@gmail.com>
 <xmqqv8v19ght.fsf@gitster.g>
In-Reply-To: <xmqqv8v19ght.fsf@gitster.g>

--------------x4xlNvg60W6h9b4nDR0SgBzH
Content-Type: multipart/mixed; boundary="------------nU0GCyPDhF2Io2FhuIQ7xFLR"

--------------nU0GCyPDhF2Io2FhuIQ7xFLR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

You are right Junio! They are mutually exclusives and your last
suggestion's patch is totally coherent, instead of mine.

My attempt about this combination was driven by a missunderstanding of
the command and the goal to find all ancestors' branches, sorted
reverse-chronologicaly, for a given commit.

I'm happy to have contributed to the git project by discovering the
segfault. Happy, also, that together, we achieve a better fix than I done=
=2E

Hope this would help all of us, as it will ensure a more stable use in
our devs.

Sincerely.

On 22/04/2022 17:26, Junio C Hamano wrote:
> "gdd via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Gregory DAVID <gregory.david@p1sec.com>
>>
>> If run `show-branch` with `--current` and `--reflog` simultaneously, a=

>> SEGFAULT appears.
>=20
> Thanks for noticing.  As I said elsewhere, "--current" was invented
> for the sole purpose of being used together with branches and
> individual commits, not in "--reflog" or "--merge-base" modes.
>=20
> And as I also said elsewhere, I do not think of a good reason why a
> user would want to use these two together.
>=20
> Can you tell us a bit more about what you were trying to achieve
> when you used them together?
>=20
> While waiting for your (and others) valid use cases I probably have
> missed (I said "do not think of" above, not "I think there cannot
> be"), let's speculate what sensible meaning the combination could
> have.
>=20
> As is clear from an existing error when two branches are given:
>=20
>     $ git show-branch --reflog master maint
>     fatal: --reflog option needs one branch name
>=20
> the "--reflog" mode is not even prepared to work with more than one
> branch.  It is to show reflog entries taken from one branch (it
> could be HEAD)'s reflog.
>=20
> But "--current" is about "Among the branches I listed on the command
> line, the current branch may or may not be included. If not, please
> pretend as if I had the current branch there, too".
>=20
> So, if we said
>=20
>     $ git show-branch --reflog --current maint
>=20
> while we are on 'master' branch, that is the same as saying
>=20
>     $ git show-branch --reflog master maint
>=20
> which should get a usage error, and if we are on 'maint' branch,
> then maint is already there, so there is no point in giving
> '--current' to begin with.
>=20
> Because
>=20
>     $ git show-branch --reflog
>=20
> defaults to showing the reflog entries from current branch,
>=20
>     $ git show-branch --reflog --current=20
>=20
> hoping that it would show the reflog entries of the current branch
> is indeed a plausible interpretation, but even in this case, it is
> not necessary to give "--current".
>=20
> So, unless there is a reason why it makes sense to enumerate recent
> reflog entries from a branch *and* the tip of the current branch at
> the same time, I am very much inclined to make it clear that
> "--reflog" and "--current" are mutually incompatible by making it an
> error to give both.
>=20
> In addition, we _could_ allow a command line with "--reflog --current"
> and nothing else on it, and ignore "--current" only in that case, to
> "support" the "plausible interpretation" above, but I do not think
> it is worth it.
>=20
>> It seems that it has been introduced in: Commit 1aa68d6735
>> (show-branch: --current includes the current branch., 2006-01-11)
>=20
> Yes, the commit should have noticed the invalid combination of
> options were given and errored out.  Since omission of such a check
> lead to a segfaulting bug without producing any useful output, it
> is safe to make it an error to give these options at the same time.
>=20
> Thanks.

--=20
Gregory David
Security Engineer
https://www.p1sec.com
--------------nU0GCyPDhF2Io2FhuIQ7xFLR
Content-Type: application/pgp-keys; name="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=3D
=3Du6yb
-----END PGP PUBLIC KEY BLOCK-----

--------------nU0GCyPDhF2Io2FhuIQ7xFLR--

--------------x4xlNvg60W6h9b4nDR0SgBzH--

--------------j6mqXMYmGEZCG091QuSxJjmV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmJmTuIFAwAAAAAACgkQpt83aS5d4vfR
TAv/dRf7I7usMg4oCPuCJfTBKxYgEjypLd9gbmu1utsAoKvRhDlHl4xHGhU20XeUYsf21ZLQtik5
9AcTOGpzr+lGFWlT6BmmlKvBm1CgDyvXtrRG/yBry5pkOUwSml51hjA25sZtPP5j/OKCLOIUE/1r
+qN+jWIbqVWr00eFvx8+XrEW33aXCzj62WYX+yo7UGS6xxFn1YvN4WLsqwZpt0297Yca45YQXVbn
SXvxDb1W8V+Etir+pYO0Tj1YagWC1FxhVP8m05RXSBvB6fAdSIChkp0oreUFCkEUiN8a6RYYM47S
vINt8auEMxmV1qP0TpulzrUYOu9lkDX3DUnsys2NVxpMI20BoLXL1WzQycziC/9xf/EQz9UonMjp
+UCh9u5bSYwKt3aqtD+TMZ05xqaAp+j896TS9xCx/NIgdCH3yej6DvwK0MtO3IxVZVPQSw2M7uCy
KZNu60FP9NopbcmPxTkLqjyiSLUqGD+eCN1atzlNmAk76LYT9zhHlV1lTXQr
=ra0M
-----END PGP SIGNATURE-----

--------------j6mqXMYmGEZCG091QuSxJjmV--
