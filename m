Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C4CA0ECE
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 07:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjILHhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjILHhS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 03:37:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E3E79
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 00:37:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso8714535e87.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694504231; x=1695109031; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwvoRGxW8N6+jOHTuH6nIlOSZMGzurEaM3fk8wptu8c=;
        b=fEJZYpkg00cWZmyin5zgQuJcZ1sqms0+usErnymvsTBb7Y2/1kRzrFM/rJ5nN1Dhu9
         lNa03wX39v47WZCwtCry1vuoNcm3pYZcTLMIg4+Wp8P12NCPBKjtRCTd0sw5PDF/ynup
         7Ou+UM8iLdoy29p7GoofeZ1fMOpQefpn0mK6toPysjo3EjhClHbyRPuy0yyFyZoREzr0
         a0CbvnOAzGc7CSwPSUI1dych4FzXWg1mSupyRwdoulapXAREZEl8mH5ZpgeTowNSQtZD
         KLDT0b4IyjlGBXbWGBdkJLUWacoTK3s4cu2ZwQ5UiqLqQywdm5Vw9aE/+ECQNY0PP6En
         RKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504231; x=1695109031;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwvoRGxW8N6+jOHTuH6nIlOSZMGzurEaM3fk8wptu8c=;
        b=QWrLCpy2CdKDX37URfMDza0JLICK1J/R+FNC1q3L2GHAvk2YOBT3VF/k4DOJfPMMbm
         4E+WIBhKoX/RiAssltiz68JM9GNRVtHvOT9PoZi4r5ioiUsn4v0WsRNuIIIUxzu/ycnO
         V0SY6hZ0aBkXmzUp75tBcQX+36+Gd/0LzbAh1oAxRwMk3XDScESFaC3RBiprlo7a9imi
         vDmis4hIsWI/z4PJ43rdmXmJgMRDk5wSbyKQFYCwxT5swqPSDPImF1VrqK4xaS6ydUd7
         Bdto+NxcvAwlRO0o0/tVwDS9ApEdeUbU1EYAfOWVrM7u2ULQn8CrUYwJub+SR2t+hSkV
         yPaA==
X-Gm-Message-State: AOJu0Ywkmu5ADJLBI+oszY11cfiH3ES9raqL4UJZ77zuIIF9c6dpY9z/
        NDZzl6TOTS6lh4erxFzTIFrk4xkOWOI=
X-Google-Smtp-Source: AGHT+IF3ioxbTl/pGaMkegGrDIUq7xSharrCWF/rOyVgE+SIbo9fr5OThWxFTSnc2IXh7ClTQIl7rQ==
X-Received: by 2002:a05:6512:3602:b0:500:ba68:2344 with SMTP id f2-20020a056512360200b00500ba682344mr8474668lfs.20.1694504230774;
        Tue, 12 Sep 2023 00:37:10 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d15-20020ac24c8f000000b00501c022163dsm1639911lfl.222.2023.09.12.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:37:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff-merges: improve --diff-merges documentation
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-2-sorganov@gmail.com>
        <xmqqfs3ktnvo.fsf@gitster.g>
Date:   Tue, 12 Sep 2023 10:37:09 +0300
In-Reply-To: <xmqqfs3ktnvo.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        11 Sep 2023 14:12:59 -0700")
Message-ID: <87ttrzhmfu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>  ifdef::git-log[]
>> ---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
>> +-m::
>> +	Show diffs for merge commits in the default format. This is
>> +	similar to '--diff-merges=on' (which see) except `-m` will
>> +	produce no output unless `-p` is given as well.
>> ++
>> +Note: This option not implying `-p` is legacy feature that is
>> +preserved for the sake of backward compatibility.
>
> It is more like that `-p` does not imply `-m` (which used to mean
> "consider showing the comparison between parent(s) and the child,
> even for merge commits"), even though newer options like `-c`,
> `--cc` and others do imply `-m` (simply because they do not make
> much sense if they are not allowed to work on merges) that may make
> new people confused.

No, neither --cc nor -c imply -m.

-m is documented to produce very specific output that is neither -c nor
--cc, and it's indeed how it works.

-c and --cc imply -p, not -m, and it has been documented for ages
already, and it's indeed how it works, and that's what corresponding
commits that added the features claim.

Overall, --cc, -c, and --remerge-diff all imply -p, whereas -m does not.
This is simple fact.

So I feel we need to document why -m doesn't imply -p as other similar
options do.

> If `-p` implied `-m` (or if `-m` implied
> `-p`), it would also have been utterly confusing and useless for
> human consumption.

Fortunately, -p does not imply -m, but if -m implied -p, similar to --cc
and -c, it'd be rather very natural, and thus people keep asking why
it's not the case.

> In either case, unless the reason why `-p` does not imply `-m`
> unlike others is explained, I do not think the note adds that much
> value.  I'd suggest dropping it.

-p does not imply others. It's others (--cc, etc.) that imply -p.

The problem being solved is that we periodically get (valid) questions
why -m does not behave similar to -c and --cc, and now --remerge-diff.

>
>>  --no-diff-merges::
>> +	Synonym for '--diff-merges=off'.
>> +
>> +--diff-merges=<format>::
>>  	Specify diff format to be used for merge commits. Default is
>> -	{diff-merges-default} unless `--first-parent` is in use, in which case
>> -	`first-parent` is the default.
>> +	{diff-merges-default} unless `--first-parent` is in use, in
>> +	which case `first-parent` is the default.
>>  +
>> +The following formats are supported:
>> ++
>> +--
>> +off, none::
>>  	Disable output of diffs for merge commits. Useful to override
>>  	implied value.
>>  +
>> +on, m::
>> +	Make diff output for merge commits to be shown in the default
>> +	format. The default format could be changed using
>>  	`log.diffMerges` configuration parameter, which default value
>>  	is `separate`.
>>  +
>> +first-parent, 1::
>> +	Show full diff with respect to first parent. This is the same
>> +	format as `--patch` produces for non-merge commits.
>>  +
>> +separate::
>> +	Show full diff with respect to each of parents.
>> +	Separate log entry and diff is generated for each parent.
>>  +
>> +remerge, r::
>> +	Remerge two-parent merge commits to create a temporary tree
>> +	object--potentially containing files with conflict markers
>> +	and such.  A diff is then shown between that temporary tree
>> +	and the actual merge commit.
>>  +
>>  The output emitted when this option is used is subject to change, and
>>  so is its interaction with other options (unless explicitly
>>  documented).
>>  +
>> +combined, c::
>> +	Show differences from each of the parents to the merge
>> +	result simultaneously instead of showing pairwise diff between
>> +	a parent and the result one at a time. Furthermore, it lists
>> +	only files which were modified from all parents.
>>  +
>> +dense-combined, cc::
>> +	Further compress output produced by `--diff-merges=combined`
>> +	by omitting uninteresting hunks whose contents in the parents
>> +	have only two variants and the merge result picks one of them
>> +	without modification.
>> +--
>
> Looks reasonable, even though I didn't quite see much problem with
> the original.

The original --diff-merge=... line was so long it didn't fit, especially
after "remerge" has been added, and also was hard to grok.

> If we were shuffling the sections like this patch, I
> wonder if moving combined/dense-combined a bit higher (perhaps
> before the "remerge") may make more sense, though (the ordering
> would simply become "simpler to more involved").

I kept original order, but I agree combined/dense-combined fit better
above remerge.

I'll change the order in re-roll.

Thanks,
-- Sergey Organov
