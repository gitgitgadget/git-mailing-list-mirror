Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A578C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326AD2076B
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jX0dfD8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHKTUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:20:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50308 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKTUz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:20:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39167F5017;
        Tue, 11 Aug 2020 15:20:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dwiu+WJYh0c41QfqAPelTL+84JY=; b=jX0dfD
        8kBtMqFwhVzYYADqbzs8DsD0Zky1PjbKW0CxZuixLWg5VeExpIlqcFWhQKlBgGhm
        CS/k7L7SlApGO3b8xkk7sculaNo9WkM6mabUp29OBtJM0mAUyzfQfAfB9ixNS6U/
        es8p+pfdnooNjCAPe5VfCjl95OTw0kobnZTIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SArI286t+6rh6amwAx3z6w0jH7xeZhBW
        8WMu2vt2n5dm0CYvur0Igx0gCsgELR/n+DZYIXZB6mM2q0fj7W/9uXD6LUC61Fq2
        O2OkyHn1QB4htSQddWkV0XSGMfNVW4hWp/D1TRzwumPbQOscdRvnOgNwU7PSUvSo
        jYWXKw/xFMk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BA6CF5016;
        Tue, 11 Aug 2020 15:20:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 760AFF5013;
        Tue, 11 Aug 2020 15:20:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <CAHd-oW7Wd8oSaMhPFeRcEeKTJ-k_hC7b6e28efhXT5LFu1E_Uw@mail.gmail.com>
Date:   Tue, 11 Aug 2020 12:20:48 -0700
In-Reply-To: <CAHd-oW7Wd8oSaMhPFeRcEeKTJ-k_hC7b6e28efhXT5LFu1E_Uw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 11 Aug 2020 11:27:04
        -0300")
Message-ID: <xmqqbljh9egf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C454C4AC-DC07-11EA-AB6B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hi, Junio
>
> On Mon, Aug 10, 2020 at 4:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
>>  - hex: make hash_to_hex_algop() and friends thread-safe
>>  - compat/win32/pthread: add pthread_once()
>>
>>  hash_to_hex() used a set of rotating static buffers, which was not
>>  safe to use in a threaded environment.  This has been made safer by
>>  using thread-local storage.
>>
>>  Expecting a reroll.
>>  cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>
>
> I think we can drop this one.

OK.  Thanks.
