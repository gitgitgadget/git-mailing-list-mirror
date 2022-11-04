Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKDRIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKDRIK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 13:08:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F34430F62
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 10:08:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id bq6-20020a056a000e0600b0056bcbc6720fso2755980pfb.22
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rTl+5Glzjlxk7/OmeV6xZeH40WdJMB0NDZ6nXVKWA4=;
        b=s+HvDlqXveQX0+PT03MsHffDJZXmTO56mCLRKzf6aCTTBeZelP4nW4mQ71JFr54Cvu
         +RVB9/ZE1nmAfbYhT+paoxgBu8ipWPsYY7MEXp/F47Vf3J6TNVsrH/0VScliAJXKka0Y
         WRc+s6jw1N7iq7AF53jMx681QPD2BICRrK7X1cxMAr3iuNLV70BwbmE9nKO0xFjAx7QX
         6ok7HlrcBdL8kUmKcayt2xFMD436VWBodnMwbT7zuNk9EOsI0gcRVUxMk6XUokyQ2yjN
         I1q760H1TISoNHqf56+HnTJGQckvFjrXTMazhH/Y9aEKsS2eWsnFfQxdtXCyD3exGRP5
         TyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2rTl+5Glzjlxk7/OmeV6xZeH40WdJMB0NDZ6nXVKWA4=;
        b=P3BuSDIcEw7UGxjNK/1XFK++iOilri/oSxmjHO5CU6MB2GausavONtGGvLfEgPgQX7
         2J60kf0MkE7zmPaD94v9nXBHYbYpM43Tex02/CXvZ1FNWeeW5O7McluICGXh83yNEXm6
         0HJee2/hd2rtM5UOuKvKsSGhKD0ZTIwqvZd/PfiE/ye67f5hxZWkZzFXhgi7BgNZD6Gm
         e7xb3TBta8PSHfr92YeGkwYAn/mR0vr9KHk4bWvApMytIC6JRTF61Jdty+coImJKiIIB
         1SHvXftEGSUb5pG5RaWRyM0WCf9TqxpgHPSArGi/kwehOrrRqfZpvh+g9xm08IorjIXK
         j7/w==
X-Gm-Message-State: ACrzQf1pXnN3E1S5ESChZXGQy2pKlfTKWZOhZNRxXZVAaG+daBZT5xU4
        4Rq7FfHdCRZjpIa0PmKnIE0FjqRLXeJnkg==
X-Google-Smtp-Source: AMsMyM5QNtolzECWMswVwk+dbLMHd7YNFXVwv+9cW6qft52YamMU2+MYD+evkgi3c7u7MPrgrt2+JrTubVYcVA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:2643:b0:205:bd0d:bdff with SMTP
 id pa3-20020a17090b264300b00205bd0dbdffmr36392833pjb.99.1667581688941; Fri,
 04 Nov 2022 10:08:08 -0700 (PDT)
Date:   Fri, 04 Nov 2022 10:08:07 -0700
In-Reply-To: <221104.86fsezze6p.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-5.8-2b8afd73b9b-20221102T074148Z-avarab@gmail.com> <kl6la657odjz.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221104.86fsezze6p.gmgdl@evledraar.gmail.com>
Message-ID: <kl6l5yfuy7ew.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 5/8] submodule API & "absorbgitdirs": remove
 "----recursive" option
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Nov 03 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> Remove the "----recursive" option to "git submodule--helper
>>> absorbgitdirs" (yes, with 4 dashes, not 2).
>>
>> o.O
>>
>> At least this makes it pretty easy to grep for usage, and it makes sense
>> that we've never used it (otherwise this would've been caught).
>>
>>> diff --git a/submodule.c b/submodule.c
>>> index fe1e3f03905..8fa2ad457b2 100644
>>> --- a/submodule.c
>>> +++ b/submodule.c
>>> @@ -2332,8 +2331,7 @@ static void absorb_git_dir_into_superproject_recu=
rse(const char *path)
>>>   * having its git directory within the working tree to the git dir nes=
ted
>>>   * in its superprojects git dir under modules/.
>>>   */
>>> -void absorb_git_dir_into_superproject(const char *path,
>>> -				      unsigned flags)
>>> +void absorb_git_dir_into_superproject(const char *path)
>>>  {
>>>  	int err_code;
>>>  	const char *sub_git_dir;
>>> @@ -2382,12 +2380,7 @@ void absorb_git_dir_into_superproject(const char=
 *path,
>>>  	}
>>>  	strbuf_release(&gitdir);
>>> =20
>>> -	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
>>> -		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
>>> -			BUG("we don't know how to pass the flags down?");
>>> -
>>> -		absorb_git_dir_into_superproject_recurse(path);
>>> -	}
>>> +	absorb_git_dir_into_superproject_recurse(path);
>>>  }
>>
>> Maybe I'm misreading, but I don't follow this change.
>>
>> Before, we recursed into the submodule only if the
>> ABSORB_GITDIR_RECURSE_SUBMODULES flag is set (which we now know is
>> never), but now we unconditionally recurse into the submodule.
>
> No, it's always set. I.e. ----recursive did nothing, but the default was
> to always set ABSORB_GITDIR_RECURSE_SUBMODULES, so it was never not-set
> (and there was no --no---recursive user).
>
> So we should be unconditionally going on this recursive path.

Ah, because we initialize flags to ABSORB_GITDIR_RECURSE_SUBMODULES. I
see that this is also covered by t/t7412-submodule-absorbgitdirs.sh,
which has a few nested submodules tests. Thanks!

Since it's clear that recursing should be unconditional, I think we
don't need the previous patch, but I'm fine either way.
