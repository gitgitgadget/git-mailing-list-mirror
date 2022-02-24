Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A9C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiBXJRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiBXJRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:17:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E4366B2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:16:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so1911859edd.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=f1hBYI7KFyOZhTNPA61nNXIH8Hfm0WGE0DleuLXdSn4=;
        b=WZEnbWYwd0DR+IkdmkmH8g/UsbPhYlGLna4mNzrBkFmhAEMUtK871HIikElw+blQUo
         gORQZab5/wWpnhe9UNr+wy5WCgAKLoh0BhXX7pGh3sF8r3/vWfEAcOwiffSFH+BKUKnz
         egx0UlJgN4tMTNoLnRvArNmI+PvwzRejY0XJSVveNJIfH9daB4axppF26FD2yDfpqC93
         WVTHOaeiIIaO/TuanXZLGuHITBDnKtQlj7F+gSLEFPIG4yZh/2FInreAR3O6gOFCQl3I
         ogfvBqoz4c0CR3ZLq2SnxJl/lYwGZ3YQhsm1ljH0mJRJZUPJAN8v2czd1UfBTfee+3g0
         XbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=f1hBYI7KFyOZhTNPA61nNXIH8Hfm0WGE0DleuLXdSn4=;
        b=InGckOGC00uCBbrKh8kESzyFLCeAzCJKmfnBWl6l62rDUOriJAXxf2a911SoLbfE+q
         aKGuCewNoqZduBcC39X+RIwqSw/XAToqzEL6QVLw3k11OHNsd4qVWRyvJRFcrPVwJ1TB
         nm952JD5952gieYt9SQfbbVPDn/Mn+uHEZeh5AgGbVvAiM75LGZL4IQKbqsvHIcmXGUI
         P3SqYAR/cnkS1FgskTKr0v2yFZQNe4BEB8QShQ9T0sKKpsw0+YAymcalpMHWhu5GQzvO
         8asEQCewp7u2HmRzSOgaxXbkn/DbfZHpwk4JNdvMnTsyeuSgycuyKAQ9NLOBz1u82wdA
         c0kw==
X-Gm-Message-State: AOAM533QfWyqh1wLL8XWdmfuIT/cLRQRR0kNquVaUjUxjT70c0sTvKxt
        0UXZM88JmWF2MtZ6ubJVBdbPyZ+fhls=
X-Google-Smtp-Source: ABdhPJw/hKCCQWpX8DioSTpywHZYeZtI/y9cmKomfIHdKaG96KB1caMral8knOAF3i1q2x5IvITjkw==
X-Received: by 2002:a05:6402:350e:b0:412:d02f:9004 with SMTP id b14-20020a056402350e00b00412d02f9004mr1429681edd.59.1645694202031;
        Thu, 24 Feb 2022 01:16:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nc40sm1027239ejc.127.2022.02.24.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:16:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNAEq-000DIN-VI;
        Thu, 24 Feb 2022 10:16:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Thu, 24 Feb 2022 10:14:51 +0100
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <patch-v3-3.4-b03ae29fc92-20220221T155656Z-avarab@gmail.com>
 <YhPL+wSxtI0KIz07@nand.local>
 <220221.868ru4avw6.gmgdl@evledraar.gmail.com> <xmqqee3vwepd.fsf@gitster.g>
 <220222.86o82z8als.gmgdl@evledraar.gmail.com> <xmqq4k4puyn9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k4puyn9.fsf@gitster.g>
Message-ID: <220224.86bkywaakn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Feb 21 2022, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>>> Sorry to notice this so late, but this hunk caught my eye. What happe=
ns
>>>>> if `TEST_DIRECTORY` is provided by the user (and doesn't end in "/t")?
>>>>
>>>> I think that the preceding 2/4 should cover your concern here, i.e. I
>>>> think that's not possible.
>>>>
>>>>> Before this change, we would have set GIT_BUILD_DIR to the parent of
>>>>> whatever TEST_DIRECTORY is, whether or not it ended in "/t". We'll st=
ill
>>>>> do the same thing with this patch if TEST_DIRECTORY ends in "/t". But=
 if
>>>>> it doesn't, then we'll set GIT_BUILD_DIR to be the same as
>>>>> TEST_DIRECTORY, which is a behavior change.
>>>>
>>>> Indeed, but I believe (again see 2/4) that can't happen.
>>>
>>> It is not like "can't happen", but "whoever wrote the TEST_DIRECTORY
>>> override logic did not mean to support such a use case".
>>
>> To clarify with "can't happen" I mean (and should have said) that "can't
>> work", i.e. it would error out anyway.
>>
>> E.g. try in a git.git checkout:
>>=20=20=20=20=20
>>     (
>>         mv t t2 &&
>>         cd t &&
>>         ./t0001-init.sh
>>     )
>>
>> It will die with:
>>=20=20=20=20=20
>>     You need to build test-tool:
>>     Run "make t/helper/test-tool" in the source (toplevel) directory
>>     FATAL: Unexpected exit with code 1
>>
>> And if you were to manually patch test-lib.sh to get past that error it
>> would start erroring on e.g.:
>>
>>     sed: couldn't open file /home/avar/g/git/t2/../t/chainlint.sed: No s=
uch file or directory
>>
>> And if you "fix" that it'll error out on something else.
>>
>> I.e. we'll have discovered that $(pwd)/.. must be our build directory,
>> and we then construct paths by adding the string "/t/[...]" to that.
>>
>>> I am perfectly fine if we declared that we do not to support the use
>>> of that override mechanism by anybody but the "subtest" thing we do
>>> ourselves.  If we can catch a workflow that misuses the mechansim
>>> cheaply enough (e.g. perhaps erroring out if TEST_DIRECTORY is set
>>> and it does not end in "/t"), we should do so, I would think, instead
>>> of doing the "go up and do pwd", which will make things worse.
>>
>> What I was going for in 2/4 in
>> http://lore.kernel.org/git/patch-v3-2.4-33a628e9c3a-20220221T155656Z-ava=
rab@gmail.com
>> is that we've already declared that. I.e. test-lib.sh has various
>> assumptions about appending "/t/..." to the build directory being a
>> valid way to get paths to various test-lib.sh-adjacent code.
>>
>> So trimming off "/t" here with a string operation v.s. $(cd .. && pwd)
>> is being consistent with that code.
>>
>> It would be odd to make the bit at the top very generic, only to have
>> the reader keep reading and wonder how that generic mechanism and the
>> subsequent hardcoding of "/t/[...]" are supposed to work together.
>
> Correct.  That is why I said $(... pwd) to pretend that we can take
> anything would make it worse in a separate message.
>
> If we have to strip off /t anyway, piggy-backing on that part to
> detect and abort when somebody misused the mechanism would be a good
> idea---which is what I said in the message you are responding to and
> not responding to.

So you're OK with the assumption/method being used here, but would
prefer if we also added an explicit check/"exit 1"? E.g.:
=09
	if test "$TEST_DIRECTORY" =3D "${TEST_DIRECTORY%/t}"
	then
	        echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'=
?" >&2
	        exit 1
	fi

?
