Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E51FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 17:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiJ0R3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiJ0R3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 13:29:47 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A51A3AC
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:29:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c10-20020a170902d48a00b001825736b382so1466774plg.15
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KNEFdHccwzkuh2YebQBM7q/dlp0HVXGNHx1jg+rovU=;
        b=drFfLDp7sq44OyRnTXbLDB++u3NUjgxMnvYYT9Cr9jwPKwfv5ZLvNOUAIbnWMrlvTe
         sDJqg07Ba1Q3fFFSBWjg8vejs3JiJpt+kvTS+9a5OXLHicqMayizC/05ZBsHrKmtPWpj
         rdWQJSP+tsVcIuCgIhqvDPGKRhTdfdkoAnoR6T3RTINA+zhK5GTyTMcKhiydQHLLp80e
         WsXGB7ggqyDY5FluIROF0tw5+ChuMH5gXuj6DWtdqmNV81G2taXZ8kMKYGKSkntXdLwH
         tp7RLN+bI1YEGi9K9K6w2dWPgeEmJT/+u5oyhJ2DS5MEA0MBLZvd4Rrix4FaKC6s4O31
         83rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KNEFdHccwzkuh2YebQBM7q/dlp0HVXGNHx1jg+rovU=;
        b=pB+2xQ3If5ECL5HNtZzkadfLVYz5ED0WeviekdpShtpdoNVtskbCNcI4pB/UcoF7Bx
         P7n3/gIG6ITwSduaqZKQPusSHDRoPF5r9nHSFTAnbowmQIYCjX/0H3MwdkWfJcswxURG
         /uEHhTxP1RQCltGaJj0eiyaChwVGQrpD2w3AaR5BLaxIlT8oWTR6/mxvoEW/Vi+AqqAt
         d6id/kvJrlTG1sPQ8sz1SkZVCb6p8QQRH4j0NakCfW906RKizezf2cA4DT5pGvH7DYH8
         yxhvXyX3sfsjfwx7Atg3ZLUAb83JW2wS3zZan7pp9qaRjZf2NILxrEOF/wz0VwRAzDJb
         6f1w==
X-Gm-Message-State: ACrzQf1d/QFB3bvl0iJZ2hOVUqK3yP8YuGM81k8MTYi4Vy2zq1zUzhoK
        59bQHzcdzlBwLqfQUmCrfStMaUgruAAK7Q==
X-Google-Smtp-Source: AMsMyM55EIV6sfCp/4ncvALSRF1TgyEFTrqh8KKxfStpU5yKvUI4paCr5Z1fXArLfh2yjUKb8d97zQTlAIIoiQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ce86:b0:186:d804:7cb0 with SMTP
 id f6-20020a170902ce8600b00186d8047cb0mr12517145plg.104.1666891785429; Thu,
 27 Oct 2022 10:29:45 -0700 (PDT)
Date:   Thu, 27 Oct 2022 10:29:43 -0700
In-Reply-To: <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Mime-Version: 1.0
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
 <kl6lh6zqqhvm.fsf@chooglen-macbookpro.roam.corp.google.com> <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Message-ID: <kl6lczadqins.fsf@chooglen-macbookpro.roam.corp.google.com>
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
