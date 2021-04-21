Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A72C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05BD6141D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhDUAJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:09:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59599 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhDUAJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:09:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF8BD1A5C;
        Tue, 20 Apr 2021 20:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qaN9GA7iD0S/TCWmeITUNHcEWm8=; b=HTIn4r
        fkAdPl2gnqppfHO63/HyNqlwJLf2D7k+Jj2zDPX+N2FFS1XEdLBtqShB/JreN/qO
        i/b1vl42RQ9lF312W7u7ZfIgQWVwaifYIo6audI5+b2OgkcCJTQY1SFplb0379u5
        D/GJcAH0JCR5rR8drRxfflkfhw+ik0BJw4wqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HuCdhReC2k6+VF3ijWhIrGcf4Cn56WrG
        XjXQ59Xa9eSCmnbBjgkzNVofbVheLpFcKv/gLXI4PsH+tr9jdKiZEVVms1KyAD10
        u5WbMwit27jQVwU9eqBFcNUBJNElBT90VmeOt1EzFmMRFG2k14yZIWqIXSRZp7Ky
        1t+VjxfzH+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2D2CD1A5B;
        Tue, 20 Apr 2021 20:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B8C2D1A5A;
        Tue, 20 Apr 2021 20:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
        <xmqq5z0kbl8x.fsf@gitster.g>
        <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
Date:   Tue, 20 Apr 2021 17:09:09 -0700
In-Reply-To: <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
        (ZheNing Hu's message of "Sun, 18 Apr 2021 15:47:54 +0800")
Message-ID: <xmqqfszk1ot6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBDA4888-A235-11EB-80EF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> OK, I understand, then I can wait for a while until `trailer_cmd` merge
> to master.
>
>> But let's see what's new in this iteration.
>>
>>
>> >       +#!/bin/sh
>> >      -+test -n "$1" && git shortlog -s --author="$1" HEAD || true
>> >      ++if test "$#" != 1
>> >      ++then
>> >      ++       exit 1
>> >      ++else
>> >      ++       test -n "$1" && git shortlog -s --author="$1" HEAD || true
>> >      ++fi
>>
>> I find this dubious.  Why not
>>
>>         if test "$#" != 1 || test -z "$1"
>>         then
>>                 exit 1
>>         else
>>                 git shortlog -s --author="$1" HEAD
>>         fi
>>
>> That is, if you happened to give an empty string, your version gives
>> "" to <value> and returns success, letting a trailer "cnt:" with
>> empty value.  Is that what we really want?
>
> If it's the user use `--trailer="cnt:"` instread of command implict running,
> I think keep it is right.

No, if you give an empty string, you'd end up running "shortlog"
with --author="" and give whatever random number it comes up with,
which I do not think is what you would want.

That is why --trailer=cnt: without name to match --author can be
rejected with "exit 1" to demonstrate the feature.  The .cmd can
squelch not just the "unasked for extra invocation", but invocation
from the command line whose <value> was bogus, unlike the .runmode
feature we've seen proposed earlier.

>> >      +        if (capture_command(&cp, &buf, 1024)) {
>> >      +-               error(_("running trailer command '%s' failed"), cmd.buf);
>> >      +                strbuf_release(&buf);
>> >      +-               result = xstrdup("");
>> >      ++               if (!conf->cmd || arg) {
>> >      ++                       error(_("running trailer command '%s' failed"), cmd.buf);
>>
>> I am not sure about this part.  If .cmd (the new style) exits with a
>> non-zero status for user-supplied --trailer=<token>:<value> (because
>> it did not like the <value>), is that "running failed"?  The script
>> is expected to express yes/no with its exit status, so I would say it
>> is not failing, but successfully expressed its displeasure and vetoed
>> the particular trailer from getting added.  IOW, "|| arg" part in
>> the condition feels iffy to me.
>
> Well, you mean we can take advantage of non-zero exits instead of
> just removing implicitly executed content. I argee with you, this
> place is worth change.

Yup, that is what I meant.

In any case, let's see how well the base topic fares.

Thanks.
