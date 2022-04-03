Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88807C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356418AbiDCN7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiDCN7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:59:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7CD366BA
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:57:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id yy13so14986286ejb.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gMnJeTewaJZjx47FqFVK9aqpgyNmoVQ0mlW2zIaW/ro=;
        b=qO8fNgKsd4pzuM4fdPFbW/guLsH81W6u/CvGZwABkUqVRNr1c1pekrCw++d5jC6THu
         Ow/0OHYo1STEj4Wio5qfbHTGgdpmK0oOKFym21UZk8BXYzIfOdP2Btrww/DDeSF4ETu1
         njynWZSS7rcKecOxoXPZ8uueSCUBYDj3x8WVG/wZ+jWOS3+etIIQA1gcg6Sbs35jUndT
         hgtfzrcSDhGQUG1wAjtE+t2fjkbges68rfCNcSzS9YFqGWLsyy3SN8G0acgAlO9RBl4C
         bg7MZmG/cjJ7t7at6Wpj7ecKPuZ0hhKOXO+AZ8JElNRR0ecESjxQADlHP55onqQrHZFl
         A5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gMnJeTewaJZjx47FqFVK9aqpgyNmoVQ0mlW2zIaW/ro=;
        b=O0ywJVZF81sa3BENdRPUMkmaYtriw9+vALYi9uTxXdeyTjXSpoAsXtDlkmwza5cFJu
         vZM2OTF2AInImu96GASiNuEZO6AXVxRteZ1zWcnKLRzONBbbbYhcE6v57uhaTFc5j0+n
         NPWQeCSmfda66SZcBkumFL7j4TBrfKIUIsOknglYWf/defUaEqpEZfKEdOdu5ew6iJ2M
         DMrwBjVi6HSUU0oOtRB3K0huXJpJ3NnclaL1wu6msNJ7JeQUIioOayui+mTa+5iB/5TU
         sYJRH6KCIwRAXBObxNcItlNssRO+wWLLibMEPQayvku7gVALRkHut8zmhqxjr2VjD8GE
         IEbQ==
X-Gm-Message-State: AOAM531Uf15hcu65lyoTCo1eCDEe2NpXi3UvIMXdujMjEvxDMY3ELg1p
        Mc9CKoXbvmc2gc5RLjztAR6hu04f0pw=
X-Google-Smtp-Source: ABdhPJzrdklPxTKidtk4rl/WqRUCXh72jP/7u143NbdEyljpbKiz6u+98ZuUWnTpYB3ez2X6P7emLA==
X-Received: by 2002:a17:907:970e:b0:6df:9b6f:8a52 with SMTP id jg14-20020a170907970e00b006df9b6f8a52mr7059433ejc.761.1648994228270;
        Sun, 03 Apr 2022 06:57:08 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe680dbfcsm3279874ejc.43.2022.04.03.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:57:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb0j4-002Df3-HT;
        Sun, 03 Apr 2022 15:57:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 14/27] revisions API users: use release_revisions()
 with UNLEAK()
Date:   Sun, 03 Apr 2022 15:55:10 +0200
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-14.27-ddc7402b054-20220402T102002Z-avarab@gmail.com>
 <2e75adb7-e52d-62a9-0304-4076816f82e1@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2e75adb7-e52d-62a9-0304-4076816f82e1@gmail.com>
Message-ID: <220403.86mth2mfrh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> [continuing with v5 from where I left off with v4]
>
> On 02/04/2022 11:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Use a release_revisions() with those "struct rev_list" users which
>> already "UNLEAK" the struct. It may seem odd to simultaneously attempt
>> to free() memory, but also to explicitly ignore whether we have memory
>> leaks in the same.
>> As explained in preceding commits this is being done to use the
>> built-in commands as a guinea pig for whether the release_revisions()
>> function works as expected, we'd like to test e.g. whether we segfault
>> as we change it. In subsequent commits we'll then remove these
>> UNLEAK() as the function is made to free the memory that caused us to
>> add them in the first place.
>
> I'm a bit confused by this, the previous commit argued in favor of
> removing UNLEAK() so would could see the leaks and fix them, this is=20
> saying we should hide the leaks.

..until the UNLEAK() is removed later in the sier.s

All commits in this series pass with the SANITIZE=3Dleak CI check. In this
case it would result in too much churn to remove the UNLEAK() before we
have this solving some of the more meaningful leaks, and if we do this
later we don't have all codepaths that can use release_revisions() using
it as we free things one at a time.

> Best Wishes
>
> Phillip
>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   builtin/diff-index.c | 4 +++-
>>   builtin/diff.c       | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
>> index 5fd23ab5b6c..3a83183c312 100644
>> --- a/builtin/diff-index.c
>> +++ b/builtin/diff-index.c
>> @@ -71,5 +71,7 @@ int cmd_diff_index(int argc, const char **argv, const =
char *prefix)
>>   	}
>>   	result =3D run_diff_index(&rev, option);
>>   	UNLEAK(rev);
>> -	return diff_result_code(&rev.diffopt, result);
>> +	result =3D diff_result_code(&rev.diffopt, result);
>> +	release_revisions(&rev);
>> +	return result;
>>   }
>> diff --git a/builtin/diff.c b/builtin/diff.c
>> index bb7fafca618..dd48336da56 100644
>> --- a/builtin/diff.c
>> +++ b/builtin/diff.c
>> @@ -595,6 +595,7 @@ int cmd_diff(int argc, const char **argv, const char=
 *prefix)
>>   	if (1 < rev.diffopt.skip_stat_unmatch)
>>   		refresh_index_quietly();
>>   	UNLEAK(rev);
>> +	release_revisions(&rev);
>>   	UNLEAK(ent);
>>   	UNLEAK(blob);
>>   	return result;

