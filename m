Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288BDC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B79206B2
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 08:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YQpl0TPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHNIWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:22:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51105 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgHNIWw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 04:22:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6272FE5455;
        Fri, 14 Aug 2020 04:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ML3EhyHptNOuo1+Oox8dwklaXsk=; b=YQpl0T
        PJ6z9DMp6EqEAWN5/RcR979oKUPlrwNIy0kPW3XJvUYaOD+vjfNwbRD+DIfRE4kq
        shV86LlVJqGq+UBQ+khpohPSaO5wpR0RHUEreXdCkN2UcyJ0+fuWNdWiErc9kpUh
        MvqD2FvIDGhdAas4N2UX1j6Icyi6IcDNxIWFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FoRscO4KdaldJSRJXb3Y4sO3ZubI+SFj
        HAeSiwLEzf/rJopMA4dGfeV5OGd5loLgxedrp4NVTecVmVTsnN2WcDEQzo6H6ydJ
        ukkAvEGIU5RD4Ks+oPS857OXST2LR1zvG3rcs8ttbNjdIjgwgMvyuAh8Dmohm7pZ
        weZHHgleVc8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A81DE5454;
        Fri, 14 Aug 2020 04:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A22CAE5453;
        Fri, 14 Aug 2020 04:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
        <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com>
        <xmqqlfihzvhu.fsf@gitster.c.googlers.com>
        <CAPig+cTTr8VdzeaPewktdncvnTWHjieEnEPV+vbD=GVbK7zQNQ@mail.gmail.com>
Date:   Fri, 14 Aug 2020 01:22:45 -0700
In-Reply-To: <CAPig+cTTr8VdzeaPewktdncvnTWHjieEnEPV+vbD=GVbK7zQNQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 14 Aug 2020 00:51:08 -0400")
Message-ID: <xmqqd03tzley.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55F9F89A-DE07-11EA-AB9E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 14, 2020 at 12:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >> N_("Show blank SHA-1 for boundary commits (Default: off)")),
>> >> N_("Blank object names of boundary commits (Default: off)")),
>>
>> You guessed my intention correctly.  By using the word "blank" as a
>> verb (i.e. to fill the space, which should ordinarily contain
>> something meaningful, with whitespace instead), I can shorten "Show
>> blank" to compensate the lengthening of the message caused by
>> replacing "SHA-1" with "object name".
>>
>> A better phrasing to replace it is of course welcome.
>
> Perhaps?
>
>     "suppress object names of boundary commits (default: off)"

I think we want a verb that not just means to "remove" but also to
"replace with the same amount of whitespace so that the overall
alignment is kept".  To "blank out" would mean exactly that; I do
not know about "to suppress", though.

Thanks.
