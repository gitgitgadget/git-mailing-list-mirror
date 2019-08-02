Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646731F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbfHBQXx (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:23:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61539 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbfHBQXx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:23:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E78815B9F6;
        Fri,  2 Aug 2019 12:23:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKAl+wd+wnFZhNXR97y80vv6iVk=; b=bOV4s4
        oyjFgdNOp9rKLwGhyDGoWKr1NfS03R/Gb6dZS3BzEAUqdn9uqAbEjfyj9ksgT34y
        8imIqgD2n/iGYHStvfuP7WOBPHQpQh9K6CKbJHHiCvTeiBjA6SoKC9OmfuXbiwac
        qG8098v3c6U8FjUIKYWhUD33A5hZx2/9gjMmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=smB4QCPjAY/s6wmNqU58/+zMwB9qshI7
        ceJ5ybkp3d72zect5CP7ZOLOnpbupmdve1x2Pm6sgn1K+jytE6CfRF9vRtAgqpmv
        y5Xwv9MHSSkOTO5tDr/Q3LHRSgBFeFy50ViQiKSXXbrq3islBCUjOWXNVlBRQnzH
        N0zncqjJdSM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 363D015B9F5;
        Fri,  2 Aug 2019 12:23:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FD0D15B9F4;
        Fri,  2 Aug 2019 12:23:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2019, #01; Thu, 1)
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
        <20190801214247.GB30522@sigill.intra.peff.net>
Date:   Fri, 02 Aug 2019 09:23:46 -0700
In-Reply-To: <20190801214247.GB30522@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 1 Aug 2019 17:42:48 -0400")
Message-ID: <xmqqsgqjlenh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7B99604-B541-11E9-950E-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 01, 2019 at 01:05:12PM -0700, Junio C Hamano wrote:
>
>> [Graduated to "master"]
>> [...]
>> * jk/repack-silence-auto-bitmap-warning (2019-07-31) 3 commits
>>   (merged to 'next' on 2019-07-31 at 3aa218347c)
>>  + repack: simplify handling of auto-bitmaps and .keep files
>>  + repack: silence warnings when auto-enabled bitmaps cannot be built
>>  + t7700: clean up .keep file in bitmap-writing test
>> 
>>  Squelch unneeded and misleading warnings from "repack" when the
>>  command attempts to generate pack bitmaps without explicitly asked
>>  for by the user.
>
> After your "I need to digest this third one" comment in the thread, I
> was surprised to see this merged so soon. :) I think it's fine, and I'd
> be happy to see it in the upcoming release, but I just wanted to double
> check that it was intentional.

Yes, thanks for the simplification.  It just took me a while to
refresh my memory on the role '--honor-pack-keep' option and
ignore_packed_keep_on_disk setting play in builtin/pack-objects.c,
which is dense code.

>> * jk/tree-walk-overflow (2019-07-31) 6 commits
> ...
>>  Will merge to 'next'.
> 
> Thanks. Stolee noted a minor typo fix in the commit message:
>
>   https://public-inbox.org/git/b99561c9-cd7c-aca0-c7dd-a9916b7bd429@gmail.com/
>
> if it's not too late / too much trouble to fix.

Thanks, both.  I think I caught it before yesterday's integration
run.

>> * js/early-config-with-onbranch (2019-07-31) 1 commit
>>   (merged to 'next' on 2019-08-01 at 26b713c824)
>>  + config: work around bug with includeif:onbranch and early config
>> 
>>  The recently added [includeif "onbranch:branch"] feature does not
>>  work well with an early config mechanism, as it attempts to find
>>  out what branch we are on before we even haven't located the git
>>  repository.  The inclusion during early config scan is ignored to
>>  work around this issue.
>> 
>>  Will merge to 'master'.
>
> I had some open comments here on how the "do we have a repo" check is
> done, but I think what is committed here is functionally equivalent. I
> can pursue the NULL the_repository cleanups separately.

Yeah, I think Dscho's one is good enough for the upcoming release.

Thanks.
