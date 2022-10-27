Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4580FFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 17:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiJ0Raw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiJ0Rau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 13:30:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B659199899
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:30:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c10-20020a170902d48a00b001825736b382so1468684plg.15
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KNEFdHccwzkuh2YebQBM7q/dlp0HVXGNHx1jg+rovU=;
        b=Nhbkl7KCxz8rSqvYViwzaEkeFjZkPHMQjcLnjrPejMd4GUqb5OGG0hKtTom35KJUcz
         syMUiAvmQtdGrpLWK+NwR0Ofbc5L9mLPRuRhsQhAJ3IABpE1uUqvp4W/Iaa4fPgGI2WI
         FSYFjOAafHtZgM/6voxHq5dt7CVqcZnuZX9FkNcg43k2mVcxdVEpRgz3nSgRbKB1VGrA
         kkOHA5l9Cx9ZSk7PoH0zFl+Hkoz+z3Eg1KKlfP4bUtB/R2GDxusGUHnvh4l5XMMiW9P6
         s2BHkC8TrFzBPr32LPDIbEekmk4Ocb+XGY+OsgEtbXVUEBB5IWJveevba+CI1LTClPbf
         ucEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KNEFdHccwzkuh2YebQBM7q/dlp0HVXGNHx1jg+rovU=;
        b=agiuYw2Fjm1l7X+jFMosjKdcgPiLP2KZrZstU1dIyrmMdFfqn/WmN3Fv90I6Dr4olI
         BpFgzMN3N5cZvhvoLqCZm9HEHr/va0MIPPcS1Nf5cHTE54GucDLcotYFyAcg8+6r2Yzs
         XC/JYHyCOt+yjbbAs9Ymqc/gfSFvTZo1Vq2WyDFG8WvscV8T+jr4JJcZ5nWmk2cDKG7w
         EhoDqVoltI1hWpGAkNjXjKw8vy5ns9fCRvPKjAqEfrx0jZkGK3AHN9tMe3HkTUWXE7s7
         LmHwcPtfbgbve/T7jl7SatqpcZrz05AVHAwQ4hrxdiI1ZKDn2NMHvk2ImQ7fo4awr4OG
         gv5Q==
X-Gm-Message-State: ACrzQf0nTOSw6HFI+swdsyHSut92iw/QhMvCtXjEp8VfFK1XYeJdYXZV
        IiJO83ZclZs6qnzvfleJl2e0zoQ5cYKctA==
X-Google-Smtp-Source: AMsMyM73VF9yHa5ZXO6oR1zgDB6VMNs0WiHFP7oUTd7rgrEY2FwvIkKut0xaQ8k05eME6vnGVShlWSd7vyxXXQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:6e4c:b0:213:2058:f456 with SMTP
 id s12-20020a17090a6e4c00b002132058f456mr11425014pjm.186.1666891848803; Thu,
 27 Oct 2022 10:30:48 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:30:46 -0700
In-Reply-To: <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
 <kl6lh6zqqhvm.fsf@chooglen-macbookpro.roam.corp.google.com> <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Message-ID: <kl6lbkpxqim1.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/9] archive: add --recurse-submodules to git-archive command
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 27.10.22 um 01:34 schrieb Glen Choo:
>> "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> index 34549d849f1..f81ef741487 100644
>>> --- a/archive.c
>>> +++ b/archive.c
>>> @@ -213,6 +214,25 @@ static void queue_directory(const struct object_id=
 *oid,
>>>  	oidcpy(&d->oid, oid);
>>>  }
>>>
>>> +static void queue_submodule(
>>> +		struct repository *superproject,
>>> +		const struct object_id *oid,
>>> +		struct strbuf *base, const char *filename,
>>> +		unsigned mode, struct archiver_context *c)
>>> +{
>>> +	struct repository subrepo;
>>> +
>>> +	if (repo_submodule_init(&subrepo, superproject, filename, null_oid())=
)
>>> +		return;
>>> +
>>> +	if (repo_read_index(&subrepo) < 0)
>>> +		die("index file corrupt");
>>> +
>>> +    queue_directory(oid, base, filename, mode, c);
>>> +
>>> +	repo_clear(&subrepo);
>>> +}
>>> +
>
>> What's much more surprising is that you can delete the entire function
>> body (even queue_directory()!) and the tests still pass! The tests are
>> definitely testing what they say they are (I've also checked the
>> tarballs), so I'm not sure what's going on.
>>
>> I commented out queue_directory() in the S_ISDIR case, and the only test
>> failures I saw were:
>>
>> - t5000.68, which uses a glob in its pathspec. I tried using a glob for
>>   in the archive submodule tests, but I couldn't reproduce the failure.
>> - t5004.11, which is a really big test case that I didn't bother looking
>>   deeply into.
>>
>> So I'm at a loss as to what queue_directory() actually does.
> An archive doesn't strictly need directory entries.  If it contains a
> file with a deeply nested path then extractors will create the parent
> directory hierarchy regardless.  diff(1) won't notice any difference.
> Directory entries are mainly included to specify the permission bits.

Thanks. In that case, we should probably also test the case where there
are empty directories (e.g. when a file is excluded by a pathspec), and
we should also check the permission bits.

>
> t5000.68 checks for the directory entries in the output given by the
> option --verbose of git archive.  t5004.11 checks the number of archive
> entries (including directories) using "zipinfo -h".
>
> Ren=C3=A9
