Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E096202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 03:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756181AbdKQDCz (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 22:02:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51307 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756137AbdKQDCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 22:02:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E06AA0065;
        Thu, 16 Nov 2017 22:02:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCxwmasJL8C3C9uyHUYC6EObL3c=; b=cmxDMh
        cZFNDSZwUFF5H8rzpELq6d3pBX6bE2Lv/1ZEAy5yGNohguJVxry3NXg+sXxKAMiK
        ElDMmJoOjZITJ6xgCzdv6M9I/Qy4OGXIAQ5qq7esqgLYH1l14GYZRTTNCFwn2nNi
        MuHO+kkUKxerQNn2SQdNGdXLB2ZUmuUJ4qlk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CZ7Pr8Dpo6vhA52vaJSPuHt0mCXRg/OK
        e40mBIBxfuVALMJPCEI+L+u0cBOsO6CRqvA0cPBgWnhlKU/vxWtCthgxEcZkZtxz
        gTMv6Vrs6XyOnIIqXO4N2603aRkqBATpNIlF4GBdwsPG9kKaLUKYYmBOWdyP8Zyi
        TX5cFfzjQP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15257A0064;
        Thu, 16 Nov 2017 22:02:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7301AA0063;
        Thu, 16 Nov 2017 22:02:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] branch doc: remove --set-upstream from synopsis
References: <20171116074643.19614-1-tmz@pobox.com>
        <xmqqzi7lu2h8.fsf@gitster.mtv.corp.google.com>
        <20171117013642.GL3693@zaya.teonanacatl.net>
Date:   Fri, 17 Nov 2017 12:02:51 +0900
In-Reply-To: <20171117013642.GL3693@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Thu, 16 Nov 2017 20:36:42 -0500")
Message-ID: <xmqq8tf5txno.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD4032E0-CB43-11E7-86C8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Seeing that the error output when using it tells the user to "use
> '--track' or '--set-upstream-to' instead," should we perhaps also
> remove the --set-upstream entry entirely?  That's reads:
>
>    --set-upstream::
>            As this option had confusing syntax, it is no longer supported.
>            Please use `--track` or `--set-upstream-to` instead.
>
> I don't have a strong opinion either way, but perhaps the error
> message is all that's needed now?  Only users who have a long memory
> or are reading old documentation will call --set-upstream.  I can
> imagine someone coming along in a few months suggesting to remove the
> remaining reference to --set-upstream from the git branch
> documentation for consistency.

Perhaps.  But that must happen after we can safely remove the hidden
option that is there only to issue an error message.  I suspect that
we may not quite ready yet (the entry is there to ensure that an
"branch --set-upstream $rest" coming from an existing script and
trained fingers does not silently use --set-upstream-to thanks to
the helpful parse-options UI).
