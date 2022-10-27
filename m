Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B48DECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 17:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiJ0Rdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiJ0Rde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 13:33:34 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE11A5B14
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:33:33 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k16-20020a635a50000000b0042986056df6so1118501pgm.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KNEFdHccwzkuh2YebQBM7q/dlp0HVXGNHx1jg+rovU=;
        b=P794Zkf3FEVoBhRZsjI7lz+vl6SghwLGNpTkJdUrf2MIYjv5IaFzkz5Dld0OH5TLDo
         wB5KYxS2iEfuwJbNLmAuPoBn0gOgpgSFmm03x2MRGSRe4hMable0gsCMt6szHZadVIGE
         gx5MRSRVttDwyoJBOKhL7KCNr8ExuvfCR77Ba3ap19DRlbSS9mCleozX06W2MdcN3xCI
         vU0U+B7ZRoNVK8gm2H08VE+pA18btMewCpopryLhq8iDOlrjv7qOExloF8PjtH6ijAog
         g4WnNAqCUQdIy4wn5jZLaOpbv72OqifQWABDXXLc9uFT0ZIITpHHuXV5JoOeFKCcxyg4
         WqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KNEFdHccwzkuh2YebQBM7q/dlp0HVXGNHx1jg+rovU=;
        b=zyR5y0CD57GFCFKGaAOluCjRAY1YLmMhPTyLC9RdTx9bTAjp2XnvmTPVHIjc0CZV2i
         iDoHNsTt1kkDRhEUQCIjFTfWEveNSWL4y5JCMoDuap5nM0BtuBr7f18N6CdM8BQDkACE
         HSJNooX1BxARBwElnFFDrO/Nz8TOw7oDej2+uOXDjRjib0M2WlqK/0+YIHf6to4dnjUO
         gs+AGAYX42rV3rC8smbQX79zokgTVWyqhhUT+9rhDeKAu2McBlp6LRBIcFXs8qqU61AD
         lVIS/e/eEfEDAYBQh1+HcAi8OtvlRdEQ+h+pxjYfQ2Hy8B4UqJOwHxkt5ztagTuZCZRa
         ktAg==
X-Gm-Message-State: ACrzQf2VYNpCmx+MiVUUj88o1tmKmEKKRLsIXn04xRrbNeS2vpoqgpMN
        TxozDDJI/EzsCuviOevQ40o1jDgKLd5hKQ==
X-Google-Smtp-Source: AMsMyM6hgDIc39s/WLXoecgAqHr4WMQ2WVR7Eo0fOWtWww7tiwq0TkWeliE1jxYP0ED8tmDa46SvwAKwjjEzGw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e593:b0:212:f0e8:46ca with SMTP
 id g19-20020a17090ae59300b00212f0e846camr11386517pjz.144.1666892013391; Thu,
 27 Oct 2022 10:33:33 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:33:31 -0700
In-Reply-To: <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
 <kl6lh6zqqhvm.fsf@chooglen-macbookpro.roam.corp.google.com> <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Message-ID: <kl6l8rl1qihg.fsf@chooglen-macbookpro.roam.corp.google.com>
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
