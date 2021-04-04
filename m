Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C3C43460
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B666138C
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 23:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhDDX0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 19:26:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54050 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhDDX03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 19:26:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6CC713CF40;
        Sun,  4 Apr 2021 19:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hiDby7ajkzUNyEz7gaY4580Y9H8=; b=WgW+ga
        0vykmRb9CiktUWP9jsrkdZRGfxnpfHIa+SkOWdvUjpL8cjAqDRX5xxd8u4nD3gVb
        oqZEXArb7729xJ7hwEvg7RX4YfYo4D6LSfMRoAVJylDE7ggJ43A714ug7jQTYqHa
        iAZG6iu7mUsK72asPiSXWkgNiOPhRzrC487ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DNJ25OOnl3Z73eonvofrdJQEvFQBOLvo
        oTEBF6bRitXScMGMaYFFWhULvqervokY/BOLMvAreBLDUMVdEz7bz41qNJu2n1rh
        RvtuixyxJpNidhqGN4UnNYIotnp/4UkSRdM3E1OINlTumqDtsMV54kTTEIZqrg+4
        cAv59hUkVAY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EE8813CF3F;
        Sun,  4 Apr 2021 19:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8C1A13CF3E;
        Sun,  4 Apr 2021 19:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
        <xmqqim544dl4.fsf@gitster.g>
        <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
Date:   Sun, 04 Apr 2021 16:26:18 -0700
In-Reply-To: <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
        (Christian Couder's message of "Sat, 3 Apr 2021 07:51:17 +0200")
Message-ID: <xmqq8s5x7ht1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 293AC228-959D-11EB-A548-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 2, 2021 at 10:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>         ... as if a '<token>=<value>' argument were added at the
>>         beginning of the "git interpret-trailers" command, the
>>         command specified by this configuration variable will be
>>         called with an empty string as the argument.
>>
>> is my attempt,
>
> It looks better to me.
>
>> but I am not still sure what that "as if" part is
>> trying to say.  Does it mean with
>>
>>         [trailer "Foo"] cmd = foo-cmd
>>
>> and the 'input-file' does not have "Foo: <some existing value>"
>> trailer in it, the command "git interpret-trailers input-file"
>> would behave as if this command was run
>>
>>         $ Foo= git interpret-trailers input-file
>
> I would say it would behave as if:
>
> $ git interpret-trailers --trailer Foo= input-file

Hmmm.  That means that the descrition in the original is quite
misleading, no?  If it said

	... as if "--trailer" "<token>=<value>" arguments were given
	to "git interpret-trailers" command near the beginning of
	its command line

then that may be closer description of the command line you are
forming, but as its written (with or without my attempt to clarify
above), it was impossible to infer that you are behaving as if
another --trailer option (with <token>=<value> as its value) was
given.


