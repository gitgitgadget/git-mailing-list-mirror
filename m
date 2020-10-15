Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDA8C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C5B22268
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sTqaLYQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbgJORPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:15:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64990 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390469AbgJORPq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:15:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E52988835;
        Thu, 15 Oct 2020 13:15:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o4lCNZrvqlovFFBx+q4eboKW+bI=; b=sTqaLY
        QW8qrVkueO+f/mSc47FzUuKJB7UyAk/7xJXqKbqXG+AzK+mQDXdJdGriGwlVEldI
        Q3ZcFt5kJpRwnxITNN8jOPHXUuy+tT64DQddLPKf0Ff9CsdlcHgnj0ZDq8XAJhu+
        jZB2nwNPdtGkA5WrcoGGdgDCgsTC0SOFMMmjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k+A5CdZxNHkQFrfqvx6WgrXvt5qehd1i
        xyObyomnjtHZghxFChwr7pB58ciUGctJAk5JXlt1s62mYuNCJlaBlb/jds9nusmb
        909Yq6DznCj1yAOt3ELqzq3v/IVZ3mZ8ZoHouRMOSyKyWNCl91yopRO997QsNxpW
        /2Wt/2JpiLA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DD4888834;
        Thu, 15 Oct 2020 13:15:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D441888833;
        Thu, 15 Oct 2020 13:15:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
        <20201009015505.GB1314@generichostname>
        <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
        <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
        <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
        <20201009195701.GA967869@coredump.intra.peff.net>
        <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
        <20201015013607.GA388244@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 10:15:42 -0700
In-Reply-To: <20201015013607.GA388244@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 14 Oct 2020 21:36:07 -0400")
Message-ID: <xmqq8sc7h0ld.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E4BA53C-0F0A-11EB-BD62-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 09, 2020 at 01:33:39PM -0700, Junio C Hamano wrote:
>
>> >> [...]By doing so, we would also prevent a
>> >> mistake of not writing "extern" when we need to (i.e. decls of data
>> >> items, that are not functions) when less experienced developers try
>> >> to mimic how the existing surrounding declarations are written.
>> >
>> > but to my recollection that has not been a big problem. And it's one
>> > that's usually easily caught by the compiler. A missing "extern" on a
>> > variable will usually get you a multiple-definition warning at
>> > link-time (if you manage to also omit the actual definition you won't
>> > see that, though "make sparse" will warn that your variable ought to be
>> > static).
>> 
>> Not really, that is where the "common" extension comes in, to help
>> us with it hurt others without it, unknowingly X-<.
>
> As others noted, gcc 10 actually does complain about this. And we can
> easily stick -fno-common into the DEVELOPER knobs, if it's something we
> want to catch (I had actually forgotten it wasn't the default).

Yup, that is a good thing to do regardless.  I am mostly interested
in seeing "extern" in front of all extern decls (not defns) from
human readers' point of view, though.

> I see you picked up my patch as jk/report-fn-typedef, but applied it
> directly on v2.28, and not on top of your "drop these extra externs"
> patch. That makes sense if we're not going to remove them, but then your
> conflict resolution shows my patch as removing them. :)

I think the patch rearranged that way shows why the new typedef
shines.

It makes it immediately recognisable that set_die_routine() and
friends are functions, not pointers to functions, and because the
reason why "extern" was in front of them was because the last person
who "cleaned up" the header failed to recoginise that they are
functions without the help from this new typedef.

All of that depends on the fact that everybody understands that the
current rule is not to write "extern" in front of external
declaration of functions, so perhaps we may want to update the log
message to mention why "extern" were removed from these two.

Thanks.
