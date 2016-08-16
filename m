Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23D71F859
	for <e@80x24.org>; Tue, 16 Aug 2016 14:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbcHPO1N (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 10:27:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35712 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcHPO1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 10:27:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so16786031wmg.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 07:27:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e8nIYJvQb8sRjBrwkOsF54IKUQ9Gi0IXkOq7B4cLlRA=;
        b=w++oPh+pEeFeRpf3UYfCJ8WgQki1GZEf1Se9Ok/RF7vZ/dCJy8f3043P5o8Pd/6Ry3
         hDQgqKN4mTxdvRB+JO+LzAzHUEdDX0pImMjy2/f25/dPRDEqPXqxIflgyh2Mzbsjl5ko
         vvOlblCklphsnFVHcTpNeHc8wmqNc8SiLhOHwcGTypyibZLLqyeC4eo5nBL9H3ujX3cA
         AQ5u1sCO+c0LpxlFgrirV9tBX00FPw01HkKsuwJBmNxwg2RpROR2KloyhdEHumEyEAA9
         dr1uhZnoarB2l5BJgZCEQIF/Sw6u1AmsQavvWBab53HHlmlk06tnzuPNV54it2V+pzM0
         K06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e8nIYJvQb8sRjBrwkOsF54IKUQ9Gi0IXkOq7B4cLlRA=;
        b=O/VG7DxvXMWiMM6xjG0STBPrBivqeBLL0ARi61OiR70UxPzDtTVBRougNVjaxatrLK
         MNDh2kFdh7C9wn7spAhWa8/bJGXZ+7btRUeygvIg85BcfA/JbItIEQhqoDuGO96pSkx5
         9ul5NuiiISC2qjdOR3S4zcM2vj+Q/+t64PJuhzF1zumO5npemXZMfVa4Q6EetvHKBtXR
         kXFeJpChFWGrjs3UV4Mov7BcpaDv3p4e8/mqNrHqlqIyRd28aePrGAy6a6G92057MN/b
         ayC7J1oQVY6KzrWLjqnHJlpuGvI7HCHk1Rgdfk7M/Pf+dF5SZ2THOgS4o81Be9bcuJe8
         IzTg==
X-Gm-Message-State: AEkoouu4OebWGl48Z9PU4xBaXjxWQ83adK0Ujq+4Ybv6GANvPHwN4h+HIe/7fp8TQ7QQ/XmVAxTRktEWibFrQA==
X-Received: by 10.194.190.232 with SMTP id gt8mr38429906wjc.141.1471357630747;
 Tue, 16 Aug 2016 07:27:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 16 Aug 2016 07:27:10 -0700 (PDT)
In-Reply-To: <20160816131640.h2zzn3sy5qqdeewc@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
 <20160816081701.29949-4-chriscool@tuxfamily.org> <20160816131640.h2zzn3sy5qqdeewc@sigill.intra.peff.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 16 Aug 2016 16:27:10 +0200
Message-ID: <CAP8UFD2r-Zi757zizRQq-TPp+dO=+=ho=7oOipjPxY4ksmzC=g@mail.gmail.com>
Subject: Re: [PATCH 3/3] receive-pack: allow a maximum input size to be specified
To:	Jeff King <peff@peff.net>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 3:16 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 16, 2016 at 10:17:01AM +0200, Christian Couder wrote:
>>
>> Cleaning up what has already been written to disk is a
>> related problem that is not addressed by this patch.
>>
>> The problem is that git-gc can clean up tmp_pack_* files
>> after their grace time expired, but that may not be
>> enough if someone tries to "git push" in a loop.
>>
>> A simple fix is to call register_tempfile() in
>> open_pack_file(), and just have index-pack clean up the
>> file on its way out.
>>
>> But there are harder cases. For instance, if somebody
>> pushes a 500MB file, and there is a pre-receive hook that
>> says "too big; I won't accept this". And then they push in
>> a loop, the incoming pack has already been accepted into
>> the repository by the time the pre-receive hook runs.
>> It's not possible to just delete it, because we don't know
>> if other simultaneous processes have started to depend on
>> the objects.
>
> IMHO, everything after "not addressed by this patch" doesn't really add
> anything. This commit has value on its own, and the discussion about the
> next steps is already documented on the list (and hopefully will be
> fixed with other patches!).

Ok, I will remove that in the next iteration.

>> +test_expect_success 'create remote repository' '
>> +     git init --bare dest
>> +'
>> +
>> +# Let's run tests with different unpack limits: 1 and 10
>> +# When the limit is 1, `git receive-pack` will call `git index-pack`.
>> +# When the limit is 10, `git receive-pack` will call `git unpack-objects`.
>> +
>> +while read unpacklimit filesize filename
>> +do
>> [...]
>> +done <<\EOF
>> +1 1024 one-k-file
>> +10 2048 two-k-file
>> +EOF
>
> Is there any reason to use different filenames and sizes for the two
> runs? They should behave identically, so it would make more sense to me
> to subject them to identical inputs.

About the sizes, I thought that some people might want to try sizes
closer to the limit and also that it is good anyway in general to add
a bit of "randomness", or at least variability, in the tests.

> I know you need different files and filenames to continue pushing into
> the same "dest", but the problem is easily solved by bumping the "git
> init" into the loop.

I thought that it would be a bit less wasteful to use the same "dest"
and also it would make the test more realistic as people often push in
non empty repos.
