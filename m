Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E257EB64DD
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 15:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGPPe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPPe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 11:34:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55018E5A
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 08:34:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so32566245e9.2
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689521695; x=1692113695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Symce6/muDTzXjsj82BETOR4rxDOiBeQMB9860IQUUE=;
        b=OgB+NwFDjjZtofGAvRAi7eU6Zd2mmQgmaREffOwyGGyBpNAndQvecxUMSy/jQnQwce
         /Nni/gIWkQrsPjbpnLzhW5QYmZxysODLZvGWYHb1hNTjEBrFoQORnzpQi5cJpv3CeeqY
         4NmlZl4kxxfz9nauhjkqfxkj+jDfNewGD6q47TiOENRpnRAftsJraR9gynS0tjONrlyr
         koPAU+9cG/yfx7AL6P2VHZplTZ0EJlF5/M4zAzYVeomIKnUG0FOdDG6zWTYkHgsFzvrS
         WJaUZMWpjfXcYONFCwkR8rlzeyNyql9phgeds20vhI2xWiuoHf0dVt/f0C15ysg4Q0Sg
         sn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689521695; x=1692113695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Symce6/muDTzXjsj82BETOR4rxDOiBeQMB9860IQUUE=;
        b=fnjEu3e7eUue0UNg8P9TjSAQU1+ZxsuOsoSwXJyWnKOSY3zSKPFTy96pjYXmlbD5qo
         PgueEv9CKHK1o3VY3yFeKAIgkDuo+cfJWz6BfjV4irsxDwXAiZKxJQEVXf3tA38C/zpc
         YwwkVZKgOCq/l++YmBy0U5bDDTaAPpfjIcHpRDP+gju2/68eFPfzTpLAoroYUsxlcwnQ
         fC+tMUFSNA3yP/oxnBifQ7Gc54Q162BV3mgvs+tgrtMsXAFIzlBOSzIqmY5LfB7jq425
         QxT1ahazfmAfXYx3bdiTpp6TpIAzG2yvfV5xtDRWWeLMAWd3G4pWZE1j9VH9J1BdRozQ
         kYXg==
X-Gm-Message-State: ABy/qLZwIyKs+TlAkOqx+rHqUD13Lx9ycfHYqoLzXlxj7wB059Qr4Blb
        qay2p9KpAZvIPdxL1jVXaQA=
X-Google-Smtp-Source: APBJJlFCV/4D/GHtgUKzJvXu1I7g8ooSdrl0i7PMIHCOifa08v8juKBlHXjvTf9vzYB9clql3/flcg==
X-Received: by 2002:a7b:c411:0:b0:3fb:adc0:609b with SMTP id k17-20020a7bc411000000b003fbadc0609bmr8261975wmi.13.1689521694431;
        Sun, 16 Jul 2023 08:34:54 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id t19-20020a7bc3d3000000b003fc16ee2864sm5916036wmj.48.2023.07.16.08.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 08:34:54 -0700 (PDT)
Message-ID: <3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.com>
Date:   Sun, 16 Jul 2023 16:34:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
 <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
 <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

On 16/07/2023 00:15, Jacob Abel wrote:
> On 23/07/15 09:59AM, Phillip Wood wrote:
>> Hi Jocab
>>
>> On 15/07/2023 03:55, Jacob Abel wrote:
>>> [...]
>>
>> Thanks for working on this fix. Having looked at the changes I think it
>> would be better just be using a space character in a lot of these
>> expressions - see below.

One thing I forgot to mention was that I think it would be better to 
explain in the commit message that "\s" etc. are not part of POSIX EREs 
and that is why they do not work.

>>> [...]
>>>
>>> -			grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" actual
>>> +			grep -E "^hint:[[:space:]]+git worktree add --orphan -b [^[:space:]]+ [^[:space:]]+[[:space:]]*$" actual
>>
>> We know that "hint:" is followed by a single space and all we're really
>> interested in is that we print something after the "-b " so we can
>> simplify this to
>>
>> 	grep "^hint: git worktree add --orphan -b [^ ]"
>>
>> I think the same applies to most of the other expressions changed in
>> this patch.
> 
> This wouldn't work as it's `hint: ` followed by a `\t` as the command
> is indented in the text block.

Oh so we need to search for a space followed by a tab after "hint:" 
then. As an aside we often just use four spaces to indent commands in 
advice messages (see the output of git -C .. grep '"    git' \*.c)

> So I just went with `[[:space:]]+` as I
> didn't want to have to worry about whether some platforms expand the
> tab to spaces or how many spaces.

Is that a thing?

> I'll make the rest of the suggested
> changes though.
> 
>>> [...]
>>> @@ -998,8 +998,8 @@ test_dwim_orphan () {
>>>    					headpath=$(git $dashc_args rev-parse --sq --path-format=absolute --git-path HEAD) &&
>>
>> I'm a bit confused by the --sq here - why does it need to be shell
>> quoted when it is always used inside double quotes?
> 
> To be honest I can't remember if this specifically needs to be in
> quotes or not however I had a lot of trouble during the development of
> that patchset with things escaping quotes and causing breakages in the
> tests so if it isn't currently harmful I'd personally prefer to leave
> it as is.
> 
>> Also when the reftable backend is used I'm not sure that HEAD is
>> actually a file in $GIT_DIR anymore (that's less of an issue at the
>> moment as that backend is not is use yet).
> 
> If there is documentation (or discussions) on how to use this backend
> properly I'd appreciate a link and I can try workshopping a better
> solution then. The warning included in the original patchset reads
> from that HEAD file as well so it would also need to be adapted.

I'm afraid I don't have anything specific, there were some patches a 
while ago such as dd8468ef00 (t5601: read HEAD using rev-parse, 
2021-05-31) that stopped reading HEAD from the filesystem.

> The reason I did it this way is because I didn't see any easy way to
> get the raw contents of the HEAD when it was invalid. If there is a
> cleaner/safer/more portable way to view those contents when HEAD
> points to an invalid or unborn reference, I'd be willing to work on a
> followup patch down the line.

I think it might be better to just diagnose if HEAD is a dangling 
symbolic-ref or contains an invalid oid and leave it at that. See the 
documentation in refs.h for refs_resolve_ref_unsafe() for how to check 
if HEAD is a dangling symbolic ref - if rego_get_oid(repo, "HEAD") fails 
and it is not a dangling symbolic ref then it contains an invalid oid.

Best Wishes

Phillip

>>> [...]
>>
>> Using grep like this makes it harder to debug test failures as one has
>> to run the test with "-x" in order to try and figure out which grep
>> actually failed. I think here we can replace the sequence of "grep"s
>> with "test_cmp"
>>
>> 	cat >expect <<-EOF &&
>> 	HEAD points to an invalid (or orphaned) reference
>> 	HEAD path: $headpath
>> 	HEAD contents: $headcontents
>> 	EOF
>>
>> 	test_cmp expect actual
> 
> I'll make these changes.
> 
>> [...]
> 
