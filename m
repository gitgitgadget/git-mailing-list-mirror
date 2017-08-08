Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D0420899
	for <e@80x24.org>; Tue,  8 Aug 2017 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdHHSZt (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 14:25:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752224AbdHHSZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 14:25:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A7139BD9A;
        Tue,  8 Aug 2017 14:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ml8yi4kqoeBlRBGZ051Tgz6OTwQ=; b=fnFoo9
        zZMU/qDUonp8x1Mf5HYK+CE+n/O6WSyan08ueZEKwTmQdXnUI46WnkgBTx4i2LFh
        ll3HAbdIYMquuyWpXuK9ZypF6ptGfCByPdeCRTJ4X4wtI+nPsL2JfTxLOfEswd0B
        wPOzc34TOb2uwv8kPs7jMod6G6d06+e7vRSd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bQvO6ZmqMUxx5QBv8/eOKoqaran3xh0I
        fu3ijDxBsIuTDR4vvJihkv71t38vPPENOgEPZtuN/GDqipyicHph+Bd8Uft7a4KR
        28qFNFj9rCT0oU3kYC5pQcO69yYX2r0mfvQ/aVnEph+2OXE0VikIbjy44xJJImxr
        FCXOU2m79+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 801D09BD99;
        Tue,  8 Aug 2017 14:25:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC8DE9BD97;
        Tue,  8 Aug 2017 14:25:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
        <20170808180317.GA73298@google.com>
Date:   Tue, 08 Aug 2017 11:25:43 -0700
In-Reply-To: <20170808180317.GA73298@google.com> (Brandon Williams's message
        of "Tue, 8 Aug 2017 11:03:17 -0700")
Message-ID: <xmqqy3qtc3x4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE07A510-7C66-11E7-A421-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > +# Add a line break after the return type of top-level functions
>> > +# int
>> > +# foo();
>> > +AlwaysBreakAfterReturnType: TopLevel
>> 
>> We do that?
>
> Haha So generally no we don't do this.  Though there are definitely many
> places in our code base where we do.  Personally this makes it a bit
> easier to read when you end up having long function names.  I also
> worked on a code base which did this and it made it incredible easy to
> grep for the definition of a function.  If you grep for 'foo()' then
> you'd get all the uses of the function including the definition but if
> you grep for '^foo()' you'd get only the definition.
>
> But that's my preference, if we end up using this tool it would probably
> make sense to change this.

Yeah, I even know people who did

		int
	foo(void)

for greppability of "^foo".  It took some effort to get used to that
style.

>> > +# Insert a space after a cast
>> > +# x = (int32) y;    not    x = (int32)y;
>> > +SpaceAfterCStyleCast: true
>> 
>> Hmph, I thought we did the latter, i.e. cast sticks to the casted
>> expression without SP.
>
> I've seen both and I wasn't sure which was the correct form to use.

We do the latter because checkpatch.pl from the kernel project tells
us to, I think.
