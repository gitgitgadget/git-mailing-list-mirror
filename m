Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C34F203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 21:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbcKKV1a (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 16:27:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60963 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936646AbcKKV13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 16:27:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08F494ECE8;
        Fri, 11 Nov 2016 16:27:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VfBbForh8CAGPo/mSn+/4/yQBak=; b=LjdMov
        iP9NSqYyMdL+HKKMR3po25NDoDXwOAAy/nCfjFGNkSWbnqDmRURzY6SFeXrYlI7H
        CxRDptPuI4/gAkGejQnooFusZq7vRjOf5ULidOnFkTMBndl6tve3BlN1Z1cwBnM9
        07Qva/OEM979vvNOOUdYo0lS7dUUzwZjfOO8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ImR/zpD5Ob0rSRejnwweeMXl0c317CO4
        8IYB97A4OrhyveNkOKC71NFWo4718SzfxGONg8WZi6HqvoddkHotEjRqJFttyk8v
        umj+KtKyIGattBqexb/nd0OHpN0rBt9/FIJRFLG4h2UK14dYsoykMZCjmf1wXSuX
        E2inBUsUZ6M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 015DF4ECE7;
        Fri, 11 Nov 2016 16:27:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AB724ECE6;
        Fri, 11 Nov 2016 16:27:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
Date:   Fri, 11 Nov 2016 13:27:26 -0800
In-Reply-To: <20161111201958.2175-1-dennis@kaarsemaker.net> (Dennis
        Kaarsemaker's message of "Fri, 11 Nov 2016 21:19:56 +0100")
Message-ID: <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4F4A03A-A855-11E6-AF3D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> No tests or documentation updates yet, and I'm not sure whether
> --follow-symlinks in other modes than --no-index should be supported, ignored
> (as it is now) or cause an error, but I'm leaning towards the third option.

My knee-jerk reaction is:

 * The --no-index mode should default to your --follow-symlinks
   behaviour, without any option to turn it on or off.

 * If normal "diff" that follows symlinks by default has an option
   to disable it, then it is OK to also add --no-follow-symlinks
   that is only valid in the --no-index mode, so that we can mimick
   it better (I do not think this is the case, though).

 * Other modes should not follow symbolic links ever, no need for a
   new option.

In any case, I'd advise you not to reroll this too quickly and
frequently until the end of this cycle.  During a feature freeze, I
won't take new topics in 'pu' as that would add more things I need
to worry about, and if you reroll in too quick succession, it will
become harder to identify the latest set and queue after the
release.

Thanks.
