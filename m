Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15476C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 15:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDJPG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJPG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 11:06:56 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB34C02
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 08:06:52 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1842e8a8825so6205596fac.13
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681139211; x=1683731211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ubkkwIOQqImEvcTOctX+UeV1xP1nxBLmfZ8MxZEjfE=;
        b=FXbQI9PAebgg9wiwmDStdNtbefqzX2GLMqsIeHSNc5TZA8Hn8DzI2ScDHoByv+gOnB
         aQ/PWoa2OwdNSdfIETUyOZG6lsL8Dp+8Ow66Wh5e2ooW4abTNqBsT52h8CmuKXXX/AgA
         2NmAnJ0FnkkYUCtsnJVbEQu58LNwQKknub9RemynZjqTn4uRmcsfmNC8RigEq5m6GwOS
         xVMNd30ZhH4DTLmkv5XTsexVEWtP9MMZ+C4h2XrpkITfunFZCH0Ub2IHFx9CYxF1X9Ee
         gj/hKLJ76VUcf1gF4Pg0L9sfVbZD9u40liPwRnGBlk4xFLotgTXXYbJssEL779wBfajl
         37TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681139211; x=1683731211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ubkkwIOQqImEvcTOctX+UeV1xP1nxBLmfZ8MxZEjfE=;
        b=AZAuNc9z8xde1GmA/oa37hVuhdXcRS32vyVAhjwlbkt4utNlyaLlZ020ZU30kzAG1W
         IkLBsZ0QjJZFkUSc6n24kI2Tb23275IbF4MWdmQsISQ8M0rhjsnrweU2xLLnA9OV6VUV
         TFlA1XNhrHfqrBXWQDBYaYBvsYkcerHsrhNnn1pqrACh3A4PS6sTaazgpd1DV6UuLv8+
         bBQEsj7wX0y8BuATvwfvynI47XKrBd2yW4zVlI5BAzEVRl/JPLTcusg2jOIyY+1dgBgY
         DXIoloKPoaWrqR5EL53M9hBt6DskUBaeX6CS6+9i2ZEmIJquIdUKOOqSaVncYrCk2oxq
         FjcQ==
X-Gm-Message-State: AAQBX9fyc7BX4VoNV/ebOagtkkcNxktb5vci/xLxU4U3NZhpwNmzpw4H
        G3RdMFc5MnuOPUtRdvECKAyF
X-Google-Smtp-Source: AKy350YF/YFoaFcSS8Boa4K37yk8TGRmn5wjaSYOPgoFSX73YU9+y3HySosxu46boXl+PUzAwKheOw==
X-Received: by 2002:a05:6871:148:b0:17a:b060:7b0c with SMTP id z8-20020a056871014800b0017ab0607b0cmr4448995oab.41.1681139211314;
        Mon, 10 Apr 2023 08:06:51 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id qz11-20020a05687160cb00b001718e65a5d0sm4050172oab.57.2023.04.10.08.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:06:50 -0700 (PDT)
Message-ID: <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
Date:   Mon, 10 Apr 2023 11:06:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local> <ZC0eY8q6ushpfkrQ@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZC0eY8q6ushpfkrQ@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2023 3:08 AM, Patrick Steinhardt wrote:
> On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
>> On Tue, Apr 04, 2023 at 01:08:33PM +0200, Patrick Steinhardt wrote:
>>> Both issues have the same underlying root cause, which is that geometric
>>> repacks don't honor whether packfiles are local or not. As a result,
>>> they will try to include packs part of the alternate object directory
>>> and then at a later point fail to locate them as they do not exist in
>>> the object directory of the repository we're about to repack.
>>
>> Interesting. This fix does make sense, but I wonder if it is doing the
>> right thing.
>>
>> When we have an alternated repository and do 'git repack -ad' in the
>> "member" repository, we'll end up creating a new pack containing all
>> objects in that repository, including ones from the alternate.
...
>> I think we reasonably could do something like ignoring non-local packs
>> in `init_pack_geometry()` only when `-l` is given. That still runs into
>> problems when trying to write a MIDX or MIDX bitmaps, so we should
>> likely declare the combination "-l --write-midx --write-bitmap-index" as
>> unsupported. For backwards compatibility, I think it would make sense to
>> have "--no-local" be the default when `--geometric` is given (which is
>> already the case, since po_args is zero-initialized).
> 
> Okay, I agree that it's not all that sensible to allow writing bitmaps
> in a geometric repack that spans across multiple repositories. These
> bitmaps would immediately break once the shared repository performs a
> repack that removes a subset of packfiles that the bitmap depends on,
> which would make it non-obvious for how to even do repacks in such a
> shared repository at all.

We have mechanisms for avoiding writing bitmaps for packs that are not
closed under reachability. We should have some protection against writing
them for multi-pack-indexes that are not closed under reachability, if
only as a check during bitmap_writer_build().

> But I'm not yet sure whether I understand why `-l --write-midx` should
> be prohibited like you summarized in the follow-up mail:
> 
> On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
>> TL;DR: I think that this is a (much) more complicated problem than
>> originally anticipated, but the easiest thing to do is to assume that
>> git repack --geometric=<d> means git repack --geometric=<d> --no-local
>> unless otherwise specified, and declare --geometric=<d> --local
>> unsupported when used in conjunction with --write-midx or
>> --write-bitmap-index.
> 
> The newly written MIDX would of course only span over the local
> packfiles, but is that even a problem? Ideally, Git would know to handle
> multiple MIDX files, and in that case it would make sense both for the
> shared and for the member repository to have one.

Yes, each odb is allowed a multi-pack-index, and they chain the same way
pack-files do. I agree that this restriction isn't necessary.

>> I suspect in practice that nobody cares about what happens when you run
>> "git repack --geometric=<d> --local", but in case they do, I think the
>> above is probably the most reasonable behavior that I can quickly come
>> up with.
> 
> Well, I do as we use alternates to implement fork networks at GitLab and
> we're in the process of adopting geometric repacking. So what I want to
> have is that I can perform geometric repacks both in the shared and in
> the member repository that includes only the local packfiles.
> 
> And yes, I agree that the above is the most reasonable behaviour, with
> the exception of disallowing MIDXs when doing a local geometric repack.

I think the recommended

	if (po_args.local && !p->local)
		continue;

approach is a nice _performance improvement_ for the --local case, since
it avoids adding a list of objects to be packed (and then thrown away,
because those objects exist in an alternate). Of course, we are currently
blocked on that part working because of the non-local packs being a
problem.

> But that raises the question: what do we do about the currently-broken
> behaviour when executing `git repack --geometric=<d> --no-local` in a
> alternated repository?

Much like "git repack -a --no-local" in an alternated repository, I
don't think this is something good for users to do, but I agree that it
not working is a problem we should fix.

Your original message includes error messages like "could not find pack"
and "unknown preferred pack" which makes me think the _real_ problem is
that we are not respecting the full path name of the pack-file and are
somehow localizing packs to the local object dir.

The basic reason is that write_midx_included_packs() takes all of the
pack-files from the geometry, but does not strip out the pack-files
that are not in the same object directory.

Perhaps this method could include a step to create a new, "local"
geometry containing only the packs within the local object dir. We can
then skip the --preferred-pack option and bitmap if this is different
than the original geometry (perhaps with a warning message to help
users who did this accidentally).

> I'd personally be fine to start honoring the `po_args.local` flag so
> that we skip over any non-local packfiles there while ignoring the
> larger problem of non-local geometric repacks breaking in certain
> scenarios. It would at least improve the status quo as users now have a
> way out in case they ever happen to hit that error. And it allows us to
> use geometric repacks in alternated repositories. But are we okay with
> punting on the larger issue for the time being?

I think the real bug is isolated in write_midx_included_packs() in how
it may specify packs that the multi-pack-index cannot track. It should
be worth the time exploring if there is an easy fix there, and then the
po_args.local version can be used as a backup/performance tweak on top
of that.

Thanks,
-Stolee
