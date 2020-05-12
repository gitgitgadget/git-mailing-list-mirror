Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9DC2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A86220740
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kD2N61LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgELVak (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:30:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgELVak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 17:30:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7553FBD22D;
        Tue, 12 May 2020 17:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GNJ7WufR/5XAjy9ioWcQEeMVvOY=; b=kD2N61
        LDGfdVsS83QY0EMKUH2HclrYMUJm2YJ8IyoekZISJBpixbbuamRGVpCNVsLuT0tb
        L6vurmCccfrFL1JQUlZWoGFij8xSld+NapAJVCorGsLg5TL+ualRlS3YxncVgBIc
        qrw0WBzK9bLZDRHsGF58rJD6P1ncQqZDrEdhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i4uT5fuqOHo10KKKFk/+ZRa2ipN9d4vA
        8IEc7uriX5oW40Ni4i6vNCPfeIhUHnjfpG65mWZUqVLWh+t+t7NIkFwmrN48iOnm
        LmDA6WSXT5AsJkDSRmWYt/rIhPmL4wXeqCQu+RH6GBLZb9gCGzS8hA8aD9GUB1k5
        9vhZmAPNUu4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CA6FBD22C;
        Tue, 12 May 2020 17:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9671BD22B;
        Tue, 12 May 2020 17:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     George Brown <321.george@gmail.com>, git@vger.kernel.org
Subject: Re: Re* [PATCH] contrib/git-jump: cat output when not a terminal
References: <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
        <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
        <20200511143157.GA1415@coredump.intra.peff.net>
        <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
        <20200511154226.GC1415@coredump.intra.peff.net>
        <xmqqy2pyqv11.fsf_-_@gitster.c.googlers.com>
        <20200512192323.GC54565@coredump.intra.peff.net>
Date:   Tue, 12 May 2020 14:30:34 -0700
In-Reply-To: <20200512192323.GC54565@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 12 May 2020 15:23:23 -0400")
Message-ID: <xmqqy2pwalj9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1162558-9497-11EA-9C46-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 11, 2020 at 09:46:34AM -0700, Junio C Hamano wrote:
>
>> Lest we all forget...
>> 
>> -- >8 --
>> Subject: git-jump: just show the list with the "--no-editor" option
>
> Thanks for tying this up. It seems to work as advertised. A few nits:
>
>> +edit=yes
>> +
>> +while	case "$#,$1" in
>
> Tab between "while" and "case"?

Yup.  Just to align case and its arms.

>> +	0,*) break ;;
>> +	*,--no-editor) edit=no ;;
>> +	*,--*) usage >&2; exit 1 ;;
>> +	*) break ;;
>> +	esac
>> +do
>> +	shift
>> +done
>
> I found the use of "case" in the loop conditional a little unusual.

It's pretty-much personal preference, I think.  I could replace
s/break/false/ if you find it easier to understand.

> It probably doesn't matter much, but we could skip the tempfile entirely
> in no-editor mode. I.e.:
>
>   if test "$edit" = "no"
>   then
>     "mode_$mode" "$@"
>   fi
>
>   # otherwise set up trap, mktemp, etc

Makes a lot of sense to me.

