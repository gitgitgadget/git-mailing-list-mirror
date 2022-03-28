Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55BCC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 12:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbiC1Mas (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbiC1Maq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 08:30:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2BF4D241
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 05:29:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w25so16690713edi.11
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SeFhWwnlOjgxtgvEEMhhhmRxSTk2mu2qsSsA924dfls=;
        b=Hs7qqhssl4wLDLa/HCKjEzfdUFaPGVqlK/UzXAjZxiUqJwKjLfmPvSGgPvqJ4eTczP
         tfJbUNealb+0bH7d983dK2veP8JewaSqtUqd93GRg7b2rRZV2RDCU11kstRNvRs7LYCl
         nadrEWhNrC8b81XVU3lpCzJfqAy9iVVERJRuiR3HVela6m6nPH8tIhc/RdhmCOlLB0o+
         m294FTwvz1nSCPCDs7lUepb806Hu0ki/NYfia0jL952YNIrPy4Ys3h1dxj7aWdjgQKzL
         T1I+TAyjLBF0p6MeinLps547L54ZLKXRrN+HpyGu0UVynNSdNMpr9hf6XboHFxp+bICj
         X6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SeFhWwnlOjgxtgvEEMhhhmRxSTk2mu2qsSsA924dfls=;
        b=CIY7NKf+JHm+HijBcJZ9b1QMZeUQzXl6d3YghpTdEJeWonDCE2AVtWmKiWaVY1H8AY
         sw72YyTSRczOO2x3bBgo3sV0U7sPcPf9C8efL88FIEGivnAUZewi6c1xteihXc4Fs7zx
         AfmzKOdjWjsrFHOaDrmvCi8dRX1dRxKcYFkXHoYo6gxQ61RJpoOuZWlqb4RTFU7fiNcE
         h2JQqvJwcIQjtwWZC6X1Px5RRz9FmXD/DIxHJeItYOytSxGVIpaIAZjggH1P5L+dfmao
         P5WWyc6CtFvrhtDgJapYbwDeOcDTL8eJQ0T6OaKEctAZ2vKPPn/PAmquI6r3DR3jzv+U
         MZQQ==
X-Gm-Message-State: AOAM532RvMbmWR0BeyMiPZglqREfnRjxm0WZi7hc7PVseaGa+ovld0Mq
        +NkNv4OyPxkYTt3g7iswkVHRhPPJ2gzUTA==
X-Google-Smtp-Source: ABdhPJyvDLmSJRhj9sE8wZ4Tc2OKtB7vtfM1rGFZUUfQ6j8S+xni/wiIwBmdgjea+nrcLQ47+ouGhA==
X-Received: by 2002:a05:6402:1d4e:b0:419:5a50:75f6 with SMTP id dz14-20020a0564021d4e00b004195a5075f6mr16015540edb.403.1648470542693;
        Mon, 28 Mar 2022 05:29:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o17-20020a056402439100b0041938757232sm7013477edc.17.2022.03.28.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:29:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYoUW-003EEj-N8;
        Mon, 28 Mar 2022 14:29:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Date:   Mon, 28 Mar 2022 14:16:21 +0200
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
        <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
        <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
        <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
        <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
Message-ID: <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Johannes Sixt wrote:

> Am 27.03.22 um 13:15 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>=20
>> On Sun, Mar 27 2022, Johannes Sixt wrote:
>>=20
>>> Am 26.03.22 um 18:14 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
>>>> translation, 2016-06-17).
>>>>
>>>> These strings are no longer used in-tree, and we shouldn't be wasting
>>>> translator time on them for the benefit of a hypothetical out-of-tree
>>>> user of git-sh-setup.sh.
>>>
>>> There is public documentation for these functions. Hence, you must
>>> assume that they are used in scripts outside of Git. Castrating their
>>> functionality like this patch does is unacceptable.
>>=20
>> For require_clean_work_tree() the public documentation for this function
>> states that it will emit a specific error message in English, and you're
>> expected to Lego-interpolate a string that we'll concatenate with it:
>>=20
>> 	[...]It emits an error message of the form `Cannot
>>         <action>: <reason>. <hint>`, and dies.  Example:
>> 	+
>> 	----------------
>> 	require_clean_work_tree rebase "Please commit or stash them."
>>=20
>> So I think that marking it for translation like this as d323c6b6410 was
>> always broken in that it broke that documented promise.
>
> I can buy this argument. But then this must be a separate commit with
> this justification.

Sure, I can elaborate on that point & split it up.

>> But that's just an argument for keeping the require_clean_work_tree()
>> part of this patch, not require_work_tree_exists().
>>=20
>> For that one and others in git-sh-setup we've never said that we'd
>> provide these translated (and to the extent we've implied anything about
>> the rest, have strongly implied the opposite with
>> require_clean_work_tree()'s docs).
>>=20
>> Nothing will break for out-of-tree users as a result of this
>> change. When we added these functions and their documentation their
>> output wouldn't be translated, then sometimes it was, now it's not
>> again.
>
> This does not sound convincing at all, but rather like "I want the code
> to be so, and here is some handwaving to justify it". What is wrong with
> the status quo?

The larger context for why I was looking at this again is that I'm
trying to slowly get us to the point where we can remove the
i18n-in-shellscript entirtely.

But I thought that was a rather large digression for the commit message,
and that these being both unused, and not something the "public" API
affected ever promised it would do was sufficient.

>> We need also need to be mindful of translator time, it's a *lot* of
>> strings to go through, and e.g. I've commented in the past on patches
>> that marked stuff in t/helper/ for translation.
>
> Translator's time is your concern? No translator sifts through 5000
> strings on every release. There are tools that show only new strings to
> translate.

Yes, I'm the person who added this entire i18n infrastructure to git, I
know how it works :)

> A text is translated once and then it lies under the radar
> until someone changes it. Don't tell me that is time-consuming.

Yes, individual orphaned strings aren't, but they add up.

Just like having that "USE_PIC" comment in configure.ac isn't much of a
big deal, but it makes sense to clean up unused code, just as we're
adding new code.

I will say that your implicit proposal of keeping this forever instead
is assuming that we won't have more translations for git, and every new
translator will look at this.

Context is critical for translators, so even if it's one string it's a
string you'll quickly grep for and find ... no uses for, and then likely
go hunting around for where it's used only to (hopefully, in that case)
find this thread. Better not to have it.

> On the other hand, there is a lot of *reviewer* time that you are
> spending with changes like this. *That* should be your concern.

I'd think most of the that time, if any, will be spent on this
sub-thread you started, so ... :)

Which isn't to say it shouldn't have been brought up, but from my
perspective I was (and still am) making a rather small change that I
think won't harm anyone in practice, and gives us some incremental
tidyness & contributes to an eventual large "git rm git-sh-i18n.sh" et
al.

But on reflection I don't think it's worth worrying about, and we can
just do this change.

