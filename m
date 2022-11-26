Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F5C43217
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKZN2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKZN2r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 08:28:47 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20C1B1D0
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 05:28:46 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r81so4690012iod.2
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiQO4BtVzI+ps/Z1+QqRzlKVLu3QMrlFUizPMPwvvDw=;
        b=OVv1O9oXCQQKhG8szHWDVZ5qlVev8qjkyJaOf88oMGwn/5FrXZJMhaMmOBTsPjUTMe
         EXvcKd5NVWJMYiwQkZQ6dgMKKKX+aA3EGec4QyVApO9SYi3ctRZN5IjbEAYmMU1l0tx8
         qX2ppRYGky/XxGN7/EJbU0GDOk9rzM7H2MrtKZEkaBNOeiccGffoREJdhYi2yiYzuq6x
         EwMcULdvC7jYC3EtHo7vJU7tX+5eSDoDm7m9OcDp+WjPrUi+iZuI9Ty3Xh2IYVSNMwmn
         9fkzaTDyYhr0czae34CdxHOl79dj5V9WR2bclW2/4sNo98z9FsK5ZeUGXChtjxtdssu7
         g3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BiQO4BtVzI+ps/Z1+QqRzlKVLu3QMrlFUizPMPwvvDw=;
        b=c9YMHArUz9NA54J3Is+6vcM14SRs285L7oSVA8IRKV84oN/qbcNQtJRJoW02CgDMIr
         Y1YDHSH134ef+E2dKJDmOnmm7EpxSvqWppN73BykhDNgXZ67gEsLhwAjuGyDdYwzW3ar
         U0y3pTGnYKMut5yGgCkzXcXbRfMD+QTvRuJShxaI+NvCXMbXM/REDOLh+d9jaWV4trmK
         tILzMrDwpnii0LGSauqEJNsrfkI0cc6SbrRyKDhX5t2mHtw/gW+o4moaLLUn8YXQR8jK
         1WXl2kZLGDmmCbqqnMRo3sl8GYXBaatSN7xu09XT7IVw7Tt+72JDZ4VssnwpvJSdD9Ri
         n7Mw==
X-Gm-Message-State: ANoB5pkoNgjqHs/0MLG4d/GqzFNRyuoMcBKlTjCFyp7AansQ5DrAVQYd
        Nf27hwrPll7g5IlEgwkIOpo=
X-Google-Smtp-Source: AA0mqf4qP81yLin46gdo/vINxa5trTqE6MhRg8F0PcGWhERCMoj17iy4i/mdoG1mZfM/mUe2BvKXOA==
X-Received: by 2002:a5d:97c9:0:b0:6a2:e3df:a40e with SMTP id k9-20020a5d97c9000000b006a2e3dfa40emr19544521ios.113.1669469325983;
        Sat, 26 Nov 2022 05:28:45 -0800 (PST)
Received: from stargate ([2620:72:0:a40:5b60:5fdc:536b:b9e4])
        by smtp.gmail.com with ESMTPSA id f14-20020a056638112e00b00389b36027a6sm1374200jar.92.2022.11.26.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 05:28:45 -0800 (PST)
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
 <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
 <a7ff842a3e8d30cad7f18427bc812f542b998efc.1669395151.git.gitgitgadget@gmail.com>
 <221125.86tu2mmz1e.gmgdl@evledraar.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v2 1/2] var: do not print usage() with a correct invocation
Date:   Sat, 26 Nov 2022 07:19:35 -0600
In-reply-to: <221125.86tu2mmz1e.gmgdl@evledraar.gmail.com>
Message-ID: <87k03hsv3n.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> I honestly don't still don't grok what was different here before/after,
> whatever we are now/should be doing here, a test as part of this change
> asserting the new behavior would be really useful.

Sadly I don't think there are any logical variables that could be tested
for this behavior until the second patch in the series (where quite a
few tests are added). I did some brief testing with GIT_COMMITTER_IDENT
as the most obvious candidate, but it will still die early if
GIT_COMMITTER_NAME is unset, so it's not a good test case.

If you've got a test case that'll work before the second patch, I'd be
happy to include it here.

>>  {
>> +	const struct git_var *git_var =3D NULL;
>
> This assignment to "NULL" can be dropped, i.e....
>
>>  	const char *val =3D NULL;
>>  	if (argc !=3D 2)
>>  		usage(var_usage);
>> @@ -91,10 +89,15 @@ int cmd_var(int argc, const char **argv, const char =
*prefix)
>>  		return 0;
>>  	}
>>  	git_config(git_default_config, NULL);
>> -	val =3D read_var(argv[1]);
>> -	if (!val)
>> +
>> +	git_var =3D get_git_var(argv[1]);
>
> ...we first assign to it here, and if we use it uninit'd before the
> compiler will tell us.

Nice catch! I've removed the premature assignment to both `git_var` and
`val`. I've updated my branch with this change; I'll send out a v3 later
today.

--
Sean Allred
