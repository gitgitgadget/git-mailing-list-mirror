Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B2C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 19:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377639AbiFVTEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351124AbiFVTEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 15:04:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E13CFE8
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:04:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w191-20020a6382c8000000b0040c9dc669ccso5700928pgd.16
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Q51gTgdGECjAlNSr49r79JE08GHawJSQVWM4qya2UyI=;
        b=AdAjwGmu7ZvqXKONsRj9NU64TugDDIVgvrK967RzQGrNBMvXv9LejfcCmSg3lKA4fO
         Pjz0RiucVZ+pcDdNMOpUaO9sfz/hDpxffzOk0gn7wIvU63jyKztte8lj+BgVijVVaHO5
         LHGZjtk8n6osfzYb2Nf8P8JSunqYfZH6w1RqsAK/BndNmGHysr/IsLMHrRZxTaw94skf
         wTExdyHvxTTa80PgXnCl+l4O3n6hDzOzigc4NQkdYb0AvRiObZYZY6ZHT4z8OTd35RNC
         G+rPRUU5HHlv558qlxeAB5hJD8sCAMzkkD6WrC3ivwrN52OVIs4g3hT5U/2HP0NfAhhb
         i4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Q51gTgdGECjAlNSr49r79JE08GHawJSQVWM4qya2UyI=;
        b=WPpYI2/ZDSWMeV5dch3zXZp8P/DP/azzUa/7AZhsh/OmTf1dkxs3hzXsICk7YnHHO4
         eU/BbiV/OieT2PMQPyvLWOHn9kfR9Z1VvdJ1fLIY7EABlyPj4p7600A+vh4B2J1JcYK6
         CbZ4aF3OU2omKj+VBMK7fOkhaPIhaW3qG3aQiCOdbyex276MEB0s+XA8OOs+IARUWhGt
         MhJoKar799PqXRcWumcyVl54OnSaiA3ZB5OIIWWnRTK+6m0U4oYM4aqq1SkzH/7yuhHP
         LqshMWO7NFeJE6SqB4AavDKuNEL+MsdGHPK40nfYp7jjjFnfq4cwstQhIPE2qNfXDrZp
         ekFQ==
X-Gm-Message-State: AJIora9Tes26Kh2byKVN68LFqTZ+oZmcJVkvXXgGXSriBq3MBpf4bxyD
        Z2CcGOGajBb/f7P6fYzlN0NNN3oVUIo0XA==
X-Google-Smtp-Source: AGRyM1vm448f7vFZerXKCbyH/Tlrbj7f4fpKg0d8y64ixqk36cY8JMbtSWXNHKfOB2wHptdtftDB3OHvcQvFGw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7105:b0:168:dfe3:66e0 with SMTP
 id a5-20020a170902710500b00168dfe366e0mr34169073pll.88.1655924669158; Wed, 22
 Jun 2022 12:04:29 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:04:27 -0700
In-Reply-To: <kl6lzgi4il0z.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lwnd8ikp0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
 <patch-v3-09.12-e251fc115e1-20220622T142012Z-avarab@gmail.com> <kl6lzgi4il0z.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 09/12] submodule--helper: understand --checkout,
 --merge and --rebase synonyms
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> As you noted in your cover letter, this version of 09-10/12 is a lot
> cleaner and more obviously correct.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> @@ -40,7 +40,9 @@ require_init=3D
>>  files=3D
>>  remote=3D
>>  nofetch=3D
>> -update=3D
>> +rebase=3D
>> +merge=3D
>> +checkout=3D
>>  custom_name=3D
>>  depth=3D
>>  progress=3D
>> @@ -260,7 +262,7 @@ cmd_update()
>>       force=3D$1
>>       ;;
>>     -r|--rebase)
>> -			update=3D"rebase"
>> +			rebase=3D1
>>       ;;
>>     --reference)
>>       case "$2" in '') usage ;; esac
>> @@ -274,13 +276,13 @@ cmd_update()
>>       dissociate=3D1
>>       ;;
>>     -m|--merge)
>> -			update=3D"merge"
>> +			merge=3D1
>>       ;;
>>     --recursive)
>>       recursive=3D1
>>       ;;
>>     --checkout)
>> -			update=3D"checkout"
>> +			checkout=3D1
>>       ;;
>>     --recommend-shallow)
>>       recommend_shallow=3D"--recommend-shallow"
>> @@ -341,7 +343,9 @@ cmd_update()
>>     ${init:+--init} \
>>     ${nofetch:+--no-fetch} \
>>     ${wt_prefix:+--prefix "$wt_prefix"} \
>> -		${update:+--update "$update"} \
>> +		${rebase:+--rebase} \
>> +		${merge:+--merge} \
>> +		${checkout:+--checkout} \
>>     ${reference:+"$reference"} \
>>     ${dissociate:+"--dissociate"} \
>>     ${depth:+"$depth"} \
>
> A small inelegance is that a user could theoretically pass both
> "--update=3D{checkout,rebase,merge}" and "--{checkout,rebase,merge}",
> where one option ends of clobbering the other (Is it last one wins?).
>
> Ideally we'd check for this kind of invalid usage and die, but maybe
> it's not worth the effort since we fix this in the next patch already?
>
> This wouldn't happen if we squashed 09-10/12 together like I initially
> suggested, but then the patches would no longer be as obviously correct.
>
> Neither seems obviously better than the other, so I'm ok with this
> either way.

Scratch that, I got confused. A user can't invoke "git submodule update
--update=3Dfoo" because that's not allowed by git-submodule.sh.

So this version doesn't actually introduce any user-facing oddity
unless they're invoking "git submodule--helper update" (which they
really shouldn't, and we introduced it very recently anyway), and I
think this makes it better to keep these patches separate instead of
squashing them.
