Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C0E20899
	for <e@80x24.org>; Mon, 14 Aug 2017 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdHNTiH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 15:38:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57428 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751030AbdHNTh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 15:37:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BC44ADFAF;
        Mon, 14 Aug 2017 15:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aP2Huwz8bSjjD1/t/7Xh7Kp5S7M=; b=WPiTnQ
        sCGblbAw7ac0oOcoDREj6A1FBOb+5f3eqj7JQBFCatD0ufXG4g46TVBWPb1bzNgO
        PhhuJfkOoMMOHI6g0FtTDHyQhUHA0wBe6CR+dOnnGIWaTUtBE2vJYOgQRTUFf/9d
        OMAi0nmDg4VMOOqrydET3iHx2CBJ8KaDJ8F8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QMuDCrrwd6UKkoEFuifjhn1D7sNhqPRq
        k1sEGZMJtcRR2l1B6N1EQdy6B5CxuHRgWTAF8LhHFpPPnMahR8f+4AmQv7i5Uz1s
        MpHtBXfFT2kCoJp+MWolIGaaL6UV1nYOszqal6dfslHJwi/Dl4w0Xq9Qh4oDKHRy
        lDO+TyzaZvE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24459ADFAE;
        Mon, 14 Aug 2017 15:37:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A8D6ADFA9;
        Mon, 14 Aug 2017 15:37:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
References: <cover.1502491372.git.jonathantanmy@google.com>
        <xmqqk229y5zd.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kadqx3PcchM6h_U5U6nsMVf3wHSUHt1XpD_XWxYdoYudg@mail.gmail.com>
Date:   Mon, 14 Aug 2017 12:37:50 -0700
In-Reply-To: <CAGZ79kadqx3PcchM6h_U5U6nsMVf3wHSUHt1XpD_XWxYdoYudg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 14 Aug 2017 10:29:07 -0700")
Message-ID: <xmqqbmniuei9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F70C154-8128-11E7-AEF3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 11, 2017 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> My preference however is to keep sb/diff-color-move topic as-is
>> without replacing and fixing it with incremental updates like these
>> patches.
>
> I would have hoped to not need to reroll that topic.
> Though I do find patches 1&2 valuable either on top or squashed
> into "[PATCH] diff.c: color moved lines differently" and
> "[PATCH] diff.c: color moved lines differently, plain mode"
> respectively.
>
> So I'd ask to pick at least patches 1&2 on top of that series, please?

Yeah, that is exactly what I did before reading this message but
after reading your comments on the patches ;-)

> (I am missing the context for *why* you preference is to not do
> exactly this).

I see what I wrote can be misread, especially due to its lack of
",instead", that I want to keep the broken one as-is, with neither
reroll nor fixup.  That is not what I meant.

 - If you choose to squash so that the resulting history after the
   series graduates to 'master' will be simpler to read (due to lack
   of "oops, that was a mistake"), I do not mind a reroll.  

 - On the other hand, as the topic has been in 'next' for some time
   and presumably people tried it in their real daily work when
   needed, keeping what is queued as-is has a value---we have a
   fixed reference point that we can go back to to compare the code
   with and without the fix.

I do not have a strong preference, but if I were asked to choose,
I'd choose the latter.

Thanks.
