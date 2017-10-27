Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84AE2055E
	for <e@80x24.org>; Fri, 27 Oct 2017 07:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdJ0HMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 03:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751068AbdJ0HMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 03:12:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D8FFB17B4;
        Fri, 27 Oct 2017 03:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9fQR05itFKoM
        SXO38ifVTEgUriQ=; b=kV5T1aQYFDhKMvGJPpK4Ja7V/akaPW0N4TZRZu/ZLfM/
        bQPG+qkx/W8vsa/cxCzza/2ioGU9+6A4883wrcAjl1VAeg4mV5QyW1OJ8p54BW40
        +7/0kDmJOUIqylPMPzVGwCaeNZ5OsC9S+j53Dj/o94ogx7sWPzMVwaJK1wHnNrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YnMla1
        crfyEHpFAcbUR0BWKFd1pzwYI9r2B88doe4ieNSRtfDOeKcaIXFhwR2osDOYQlCZ
        X3sAFnPDvrlc5vmsfolJzj4U9AyUd2xLb2nmD/SILvOWJasyJ/p1Gmz534IzHhvX
        Cd4mDQtpOxDErnPc3Ysw3sKhGExxs3+H1oUpg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04465B17B3;
        Fri, 27 Oct 2017 03:12:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A809B17B2;
        Fri, 27 Oct 2017 03:12:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH 1/2] xdiff-interface: export comparing and hashing strings
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
        <20171025184912.21657-1-sbeller@google.com>
        <20171025184912.21657-2-sbeller@google.com>
        <3f656948-273f-e01d-ad52-e460059571da@web.de>
Date:   Fri, 27 Oct 2017 16:12:11 +0900
In-Reply-To: <3f656948-273f-e01d-ad52-e460059571da@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 Oct 2017 19:12:15 +0200")
Message-ID: <xmqqefppcbec.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 277291C2-BAE6-11E7-9134-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 25.10.2017 um 20:49 schrieb Stefan Beller:
>> +/*
>> + * Compare the strings l1 with l2 which are of size s1 and s2 respect=
ively.
>> + * Returns 1 if the strings are deemed equal, 0 otherwise.
>> + * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spac=
es
>> + * are treated for the comparision.
>> + */
>> +extern int xdiff_compare_lines(const char *l1, long s1,
>> +			       const char *l2, long s2, long flags);
>
> With the added comment it's OK here.
>
> Still, I find the tendency in libxdiff to use the shortest possible
> variable names to be hard on the eyes.  That math-like notation may hav=
e
> its place in that external library, but I think we should be careful
> lest it spreads.

Yeah, I tend to agree.  The xdiff-interface is at the (surprise!)
interface layer, so we could make it follow the style of either one,
but we seem to have picked up the convention of the lower layer,
so...

By the way, I was looking at the code around this area while
reviewing the cr-at-eol thing, and noticed a couple of things:


 * combine-diff.c special cases only IGNORE_WHITESPACE and
   IGNORE_WHITESPACE_CHANGE but no other IGNORE_WHITESPACE things; I
   have a suspicion that this is not because IGNORE_WHITESPACE_AT_EOL
   does not have to special cased by the codepath, but only because
   the combine-diff.c refactoring predates the introduction of
   ws-at-eol thing?

   The machinery uses its own match_string_spaces() helper; it may
   make sense to use the same xdiff_compare_lines() in its callers
   and get rid of this helper function.

 * diff_setup_done() sets DIFF_FROM_CONTENTS when any of the
   IGNORE_WHITESPACE bits is true, to allow "git diff -q
   --ignore-something" would do the right thing.  We do not however
   give a similar special case to XDF_IGNORE_BLANK_LINES.

   $ echo >>Makefile && git diff $option --ignore-blank-lines Makefile

   exits with 1 when option=3D--exit-code and it exits with 0 when
   option=3D-q


For now I'll leve these as #leftoverbits, but I may come back to the
latter soonish.  I won't come back to the former until Stefan's
refactor hits 'master', though.

