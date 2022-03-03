Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFCC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 19:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiCCTNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 14:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiCCTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 14:13:49 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD1413D56D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 11:12:59 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s6so2137886qtc.4
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9QxLZwNsX1b8z/acQu/yns4ae0M6mf8+/5V/Wb2SPI=;
        b=Q5EH2DVKEbiNzdCKaRBmOrrN8PbvVRLW/SjD6yAyo9CkLJXIPliR9P2dCDkCfWTT41
         p1DizymvZ4LSqrawbKsuLI6L7vWc3iSMEaILKuJitu+4Hw8CqDTcFxcqcqjWB9NreAHl
         3/S7Uai2XWuRJTHxeRtZODnCF5lf4Veo/0SHcYiena1zx2WwZz/aEV5KDfPxovrC1RtJ
         YtGTJ76xihRp6uRPA3SpLNjrPpfNbnUlxT9yCsZFEQgms6JR6K4O9T0T5EDVcNCARS6y
         8ECay7KZBUOK99ly4rpCZ1o0XpSBE1f0h+sTafgbSmpcnNOa93/ejBjGnryYxf9hiYfc
         vS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9QxLZwNsX1b8z/acQu/yns4ae0M6mf8+/5V/Wb2SPI=;
        b=XhnmT/zR7TvMYLDq6Z86+pSzyeseTnjU+Wwn8u4y3YR+6YOiqsjKwhFNm3m1zddeWe
         lRe7ra8uXPtg4uzaw4ohuSTT/fu8SohnlW3hcaqHlOnwml00otOF8m4lv4cD/oXxjQ5H
         9z8WZfP9VnfhiJwiU+PQZJ1MMPXSE32d/y2bNejpkNNn6VHnGG2cjBvdjs6hte+zZ+Rr
         vzfQCjPsJbZ6hA9vciA/R7pCZMFSuTenRmjYvAJ4Fn1qw/yKhfxRKAlWTxGcEAvw6H8V
         QG6drElcFhILjpsdIeZEBixfS+WelSNQ/Ungk90G4y/tDYT7IdzIwoNjzsO/JfTHSXG4
         TQsQ==
X-Gm-Message-State: AOAM530wVDD6sICuTEQZWWerVTY/ZqxXXxpsx++NSR7USUEX6RbqQlzV
        6+clScIdEVSSkHz0P/8Hmscw+zn5xZg=
X-Google-Smtp-Source: ABdhPJz1ATNlwJ1/FG9Am3+6CW6AblmdxFaFpCF2ZrmuQF4Ytwhqy+gMW1Ji6LlOeq7DaTQ6rX92ng==
X-Received: by 2002:a05:622a:15cc:b0:2de:8dbd:8b3 with SMTP id d12-20020a05622a15cc00b002de8dbd08b3mr28821859qty.524.1646334778769;
        Thu, 03 Mar 2022 11:12:58 -0800 (PST)
Received: from [10.37.129.2] (ool-ad03998c.dyn.optonline.net. [173.3.153.140])
        by smtp.gmail.com with ESMTPSA id de18-20020a05620a371200b00662cf4b5631sm1466636qkb.23.2022.03.03.11.12.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 11:12:58 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite --updatref behavior
Date:   Thu, 03 Mar 2022 14:12:57 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <F383C357-FEC3-4E1E-A0B7-97EDE05035FD@gmail.com>
In-Reply-To: <d73db784-c09b-a889-3d19-d41be7748e66@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g> <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
 <220303.86a6e72d1g.gmgdl@evledraar.gmail.com>
 <d73db784-c09b-a889-3d19-d41be7748e66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 3 Mar 2022, at 12:28, Phillip Wood wrote:

> On 03/03/2022 16:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Thu, Mar 03 2022, Phillip Wood wrote:
>>
>>> On 02/03/2022 23:32, Junio C Hamano wrote:
>>>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> [...]
>>>>> +test_expect_success REFFILES 'drop stash reflog updates refs/stash=
 with rewrite' '
>>>>> +	git init repo &&
>>>>> +	(
>>>>> +		cd repo &&
>>>>> +		setup_stash
>>>>> +	) &&
>>>> Hmph, so this is done inside the subdirectory.  The implementation
>>>> of the helper in this iteration does look cleaner than in the
>>>> previous iteration.
>>>> But these many references to "repo/" and "-C repo" we see below
>>>> makes me wonder why we do not put the whole thing inside the
>>>> subshell we started earlier.
>>>> i.e.
>>>> 	git init repo &&
>>>> 	(
>>>> 		cd repo &&
>>>> 		setup_stash_test &&
>>>> 		echo 9 >file &&
>>>> 		old=3D$(git rev-parse stash@{0}) &&
>>>> 		git stash &&
>>>> 		new=3D$(git rev-parse stash@{0}) &&
>>>> 		...
>>>> 		test_cmp expect actual
>>>> 	)
>>>>
>>>
>>> I wonder if we could avoid the subshell entirely and avoid relying on=

>>> REFFILES (assuming we're not trying to test the implementation detail=
s
>>> of that refs backend) by doing something like
>>>
>>> test_expect_success 'drop stash reflog updates refs/stash with rewrit=
e' '
>>> 	old=3D$(git rev-parse stash@{0}) &&
>>> 	setup_stash_test &&
>>> 	git rev-list -g stash >tmp &&
>>> 	sed /$old/d tmp >expect &&
>>> 	git rev-list -g stash >actual &&
>>> 	test_cmp expect actual
>>> '
>>
>> Unless I'm missing something that "rev-list -g" will emit only the RHS=

>> of the stash logs, i.e. no "0000..." etc.
>>
>> And if we only look at that the difference with specifying the flag
>> isn't visible, no?
>
> Maybe I'm missing what this test is actually needs to do. I thought it =
just needed to check that the deleted stash is removed from the reflog an=
d the others are unchanged. You're right that it wont show the LHS and if=
 that is important then you need to read the log file directly.

We had discussed this briefly in [1], but the --rewrite option for reflog=
 delete will rewrite the LHS, which is not visible to normal ref API user=
s. So the only way to test that this happened is to reach inside of the f=
ile.

1. https://lore.kernel.org/git/xmqqczjdp2g8.fsf@gitster.g/
>
> Best Wishes
>
> Phillip

thanks,
John

>
>
>>>>> +	echo 9 >repo/file &&
>>>>> +
>>>>> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>>>>> +	git -C repo stash &&
>>>>> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>>>>> +
>>>>> +	cat >expect <<-EOF &&
>>>>> +	$(test_oid zero) $old_oid
>>>>> +	$old_oid $new_oid
>>>>> +	EOF
>>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>>> +	test_cmp expect actual &&
>>>>> +
>>>>> +	git -C repo stash drop stash@{1} &&
>>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>>> +	cat >expect <<-EOF &&
>>>>> +	$(test_oid zero) $new_oid
>>>>> +	EOF
>>>>> +	test_cmp expect actual
>>>>> +'
>>>>> +
>>>>>    test_expect_success 'stash pop' '
>>>>>    	git reset --hard &&
>>>>>    	git stash pop &&
>>
