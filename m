Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333ADC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbiCXRDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbiCXRDp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:03:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE7AB0A6F
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:02:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d10so10422444eje.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PjCF1vRjf2HPqycbOdHHUIYG02qSe2ubIzMJe+wF8RU=;
        b=OUdDkz0nTteBgpUdcjBgr3zDfukt9a1a9tNaicUXMpK5M8auD1f45aLxE+B87L9iIW
         2yVQCq77rkuLsROxZV38qBWxbcWZ9IhDBw5D4YawBbtQamTIYGYxPSgiuL0B5+ikrtzz
         Q/QHATyCY/vgjmcrryq/dXPFoI0I3mYNxp6fmnfEmbpu/wXmNoQB3f6NTGjaZqeRPYKX
         Nlt1Ekm6958Qx7WfXS1CYovI1M2BDnfHxZLgBMQ8YuGJplnkjFR/0HNwXGPzzXRQI12R
         iT+MlgtTmfoLZEBqIxjr3UwoBrwZFhi1bLVqCGLYAvbJXGHZjIDrIDGV0Mwz80H4suuv
         x9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PjCF1vRjf2HPqycbOdHHUIYG02qSe2ubIzMJe+wF8RU=;
        b=0OHGsEbCkcyk56V02BIgC5dzYGieUKMf+FqOo3YNP4hbAOCfOJCm3stfZCB2MKml7K
         aaLTlW7w966vIfocdSkrY6nYCNRkkTa2nuoq7PrWjT4AgtmjyzwMHRDY/BF1k/mNqJks
         2Isx5vGiNMZBn5+OUSLChJTQtz8e9TFN3sNLVRYeG6dtE6Lotkvt2tmByUkTu7BrhQwm
         80iEZLqtYTnlyJS0rPG1bQ8KdAsABHd7SwXpp3SZ6FWtCBQV5uAWmbWX9wwPlvbYLdmu
         ftUIbWlb5+XlwsGD5f3iUX+gm6P+CdA3dhvJiSk3jBDiFBDs+pJndoDnRls/PXcQE+s8
         dF6A==
X-Gm-Message-State: AOAM533SDvym3+pKRTWlV2p2HJPhZsaKcBMcaBTOiFJ+ObMn79oxGe5e
        fJy1L+IpwedIu5N4GikdzW4=
X-Google-Smtp-Source: ABdhPJw77TW1HXBY7ymoxH1Ko9FoFHyHNx51RvjNZCWnyp3wDPlgu1mFVeAacUkAR9SEp3UxjVgy7A==
X-Received: by 2002:a17:906:9e11:b0:6df:a9d8:cbad with SMTP id fp17-20020a1709069e1100b006dfa9d8cbadmr6875550ejc.32.1648141331470;
        Thu, 24 Mar 2022 10:02:11 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm1342912ejc.25.2022.03.24.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:02:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQqf-001jHk-Sa;
        Thu, 24 Mar 2022 18:02:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/27] revision.[ch]: split freeing of revs->commit
 into a function
Date:   Thu, 24 Mar 2022 18:01:22 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <patch-v2-05.27-4c0718b43d7-20220323T203149Z-avarab@gmail.com>
 <xmqqa6dgm0l8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqa6dgm0l8.fsf@gitster.g>
Message-ID: <220324.86h77nmgha.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> +static void release_revisions_commit_list(struct rev_info *revs)
>> +{
>> +	struct commit_list *commits =3D revs->commits;
>> +
>> +	if (!commits)
>> +		return;
>> +	free_commit_list(commits);
>> +	revs->commits =3D NULL;
>> +}
>
> It makes sense to have this as a separate helper, but the original
> implementation this was lifted from is much easier to follow than
> this version with an unnecessary rewrite, I would think.
>
>> @@ -4080,10 +4090,7 @@ static void create_boundary_commit_list(struct re=
v_info *revs)
>>  	 * boundary commits anyway.  (This is what the code has always
>>  	 * done.)
>>  	 */
>> -	if (revs->commits) {
>> -		free_commit_list(revs->commits);
>> -		revs->commits =3D NULL;
>> -	}
>> +	release_revisions_commit_list(revs);
>
> IOW
>
> static void release_revisions_commit_list(struct rev_info *revs)
> {
> 	if (revs->commits) {
> 		free_commit_list(revs->commits);
> 		revs->commits =3D NULL;
> 	}
> }

Sure, will change it.

I think the pre-image is preferrable in context, i.e. to have them all
use the same early abort pattern, but not enough to argue the point :)



