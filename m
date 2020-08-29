Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA0C433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E892075B
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 18:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EiixucOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgH2S2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:28:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53523 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2S2T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 14:28:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3256CE107C;
        Sat, 29 Aug 2020 14:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QUCIOo34oJrm5n+v40Yg9/Avvpo=; b=Eiixuc
        OqR7RR+id9dnaTKb21gfYPRVdrwRAh0jnvpT4dFQebLfy1DUsze/HfkOPgoMNcLP
        pvrJb9SWsTgepriw/GaGp06yLqkc8Qi1gkR119fhvLsS+vNqZHUBlsHJpoyOW3rT
        lKoXhoaP4morIKSC3qy952/T6zyH5lAdmFXgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b2RaPo1fy7Mq/5UEellWo3oeBx9Z6P05
        ozggQn6QahYaUT2RKD5VuuASLMfJcbG40mqzc0+LBaivQIT3VBiWGdDo0oTjVv8/
        tTDZ+ChxoUxESziVb6hhP6R9UzXM+Ckopefilcaj66j+t7i69HWfPOCKPrPvPUsE
        N6UBNGrn6GU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A6E6E1079;
        Sat, 29 Aug 2020 14:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69A6EE1077;
        Sat, 29 Aug 2020 14:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
        <CA+CkUQ-SsxrJk+7e-ygm8FfCto6XZt2Ts9UcTMpgkmAQWZkLhA@mail.gmail.com>
Date:   Sat, 29 Aug 2020 11:28:09 -0700
In-Reply-To: <CA+CkUQ-SsxrJk+7e-ygm8FfCto6XZt2Ts9UcTMpgkmAQWZkLhA@mail.gmail.com>
        (Hariom verma's message of "Sat, 29 Aug 2020 15:43:13 +0530")
Message-ID: <xmqq1rjpjohy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64D358DC-EA25-11EA-8473-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> writes:

> On Fri, Aug 28, 2020 at 3:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> [Cooking]
>>
>> * hv/ref-filter-trailers-atom-parsing-fix (2020-08-21) 2 commits
>>   (merged to 'next' on 2020-08-24 at 79b27f3263)
>>  + ref-filter: 'contents:trailers' show error if `:` is missing
>>  + t6300: unify %(trailers) and %(contents:trailers) tests
>> ...
>
> After a discussion, we agreed on keeping the helper function instead
> on duplicating code in "ref-filter: 'contents:trailers' show error if
> `:` is missing"
> There is a high possibility we might want to reuse helper in other places too.
> Especially in the case of newly added "%(subject:sanitize)", if we
> also want "%(contents:subject:sanitize)" to work.
>
> Full discussion:
> https://public-inbox.org/git/CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com/
>
> I'm about to send the updated patch series soon.

Days after the topic got merged to 'next' is not a time to send any
updated patch series.  It should come in the form of incremental
update on top of what is already there.

IIRC, the code in question is good for the purpose of what already
exists and is easier to follow without helper.  When we need to make
the code more elaborabed and/or when we actually have the second
callsite would be the ideal time to introduce such a helper as a
preliminay clean-up patch early in such a follow-on series that
would happen after the "fix" in question graduates, I would think.

To be honest, I am not sure if we even need an incremental on top
right now, unless we want to delay the two patches to fix real
breakage above and make them wait for patches that adds features
that require to call the same helper from elsewhere.

Thanks.
