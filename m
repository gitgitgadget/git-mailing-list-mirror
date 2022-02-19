Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C73CC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 10:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiBSKre (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 05:47:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiBSKrc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 05:47:32 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D5C54BD4
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:47:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so19720412edt.6
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 02:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DRXQJJ7yaeLkCzNWxaDZk6ROn7Zv+nuJv0VA1wR/9wo=;
        b=WnC/D/6KJ5Lh2zr8fyaWCICakNP9qoNHDzZ2nxCE3WfWivgHQTr5Yo70EsXiOuDG+s
         BJh5Yam+BfmAJFlThR/SWtiVCMzsX1KNwRDbHwBYwu7xutQkHC7qePJWWrRqxAzqwrWL
         mgka3OK+crMzMO/THKmzL6HM/yBdCI//vq5XYDhCDPsqqdgtz6ov3GQ5ATMbxcXM4gfB
         7Cftnvzzvfb1qcJMYP8Lfk1Yg0i1ujbmilG5wPtnO4x4dMCszjI7YoVYz+eEEi7bkHEn
         2xfb9Eh1KqaAzhWZ/3w2ATzAhcUcVS8urk5FWtpMU7fOjP2/fe/Kb+Mh3JPzhe6Zo2KV
         n31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DRXQJJ7yaeLkCzNWxaDZk6ROn7Zv+nuJv0VA1wR/9wo=;
        b=hhZxsukQNDC44IwmdgF97SxJX93EwOFPvmJOJZ5IfajL+BvgvWYEDyohr5SRqSp9lT
         EiiFNvQ7Ze01M5XAJFQ99LVzuvhRCId9QG88K3Nbuv4nT5/qM4cLTmlKDpyWEhHqfDtR
         FuyxTbSU8HhRfyXrJGJULB+pJPbCbSEKfbR8Ex0P8vJ6Hm2+Eit0Izf5WPSqhZkseHSQ
         locWOk5nKM4pK4YfgsvLy8YiHSaN8x3u2cMByVrtAojSwXCRABJl5grBXVjGexG8VDsH
         L6X7UymvGPBaXDssoC+HmEw+emXffcqZ6JDBgsBNCb+UORpH0Sp6KXdMDdg++8tuWRfx
         r+3Q==
X-Gm-Message-State: AOAM531kR8ysPZ67vz/BcPTxIu+mO6HuUkruZHkwCR1yUw25CgCA6zbU
        g3xdRNstwYKxizLppWu+wl4=
X-Google-Smtp-Source: ABdhPJy0DH1D29GmBND0CvvjT99TcVt/n3NfmotzGrFC4MZrmzh2PYKvBtjDfC0cYFHd9RLG+Hsk5A==
X-Received: by 2002:a05:6402:796:b0:410:7b10:c951 with SMTP id d22-20020a056402079600b004107b10c951mr12155213edy.317.1645267631466;
        Sat, 19 Feb 2022 02:47:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bn15sm3120422ejb.93.2022.02.19.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:47:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLNGf-004sYd-RT;
        Sat, 19 Feb 2022 11:47:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 2/2] hooks: fix a TOCTOU in "did we run a hook?" heuristic
Date:   Sat, 19 Feb 2022 11:46:33 +0100
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
 <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
 <YhBtI6PY5s/nC8og@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhBtI6PY5s/nC8og@nand.local>
Message-ID: <220219.861qzzdtg2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Taylor Blau wrote:

> On Fri, Feb 18, 2022 at 09:43:52PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index b9ed0374e30..bc5d34bc31f 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -725,11 +725,13 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
>>  	int clean_message_contents =3D (cleanup_mode !=3D COMMIT_MSG_CLEANUP_N=
ONE);
>>  	int old_display_comment_prefix;
>>  	int merge_contains_scissors =3D 0;
>> +	int invoked_hook;
>>
>>  	/* This checks and barfs if author is badly specified */
>>  	determine_author_info(author_ident);
>>
>> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit"=
, NULL))
>> +	if (!no_verify && run_commit_hook(use_editor, index_file, &invoked_hoo=
k,
>> +					  "pre-commit", NULL))
>>  		return 0;
>>
>>  	if (squash_message) {
>> @@ -1052,10 +1054,10 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>>  		return 0;
>>  	}
>>
>> -	if (!no_verify && hook_exists("pre-commit")) {
>> +	if (!no_verify && invoked_hook) {
>>  		/*
>> -		 * Re-read the index as pre-commit hook could have updated it,
>> -		 * and write it out as a tree.  We must do this before we invoke
>> +		 * Re-read the index as the pre-commit-commit hook was invoked
>> +		 * and could have updated it. We must do this before we invoke
>>  		 * the editor and after we invoke run_status above.
>>  		 */
>>  		discard_cache();
>
> Sanity checking my own understating of this race: if we ran the
> pre-commit hook and it modified the index, but hook_exists() returns
> false later on (e.g., because the hook itself went away, the directory
> became unreadable, etc.), then we won't call discard_cache() when we
> should have?

Yes, it's that obscure.

> If so, OK. This definitely seems like a pretty niche race, but
> independent of that I think the change here is an improvement in
> readability, and makes it clearer that calling discard_cache() depends
> on whether or not we *ran* the pre-commit hook, not whether we (still)
> *have* a pre-commit hook.

Yeah, that's the main reason to do it. I found this really hard to
follow before, why didn't we just remember if we have/ran the thing? Now
we do.
