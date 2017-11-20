Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD4B202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 00:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdKTA0q (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 19:26:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751014AbdKTA0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 19:26:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B383CA60BB;
        Sun, 19 Nov 2017 19:26:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9H6Kr5hzmUo352ANHrnZ9P3Zc9Y=; b=LiB88K
        K3JWNqPiKICUVI4RBAB4lCFv6FdIIA5rUhXUY/shJj7lTmJMIUb0p+p3nR0/vES+
        WY7CuXdBE2bcW6eKMFvCU6FxhZXQXY8m0OK4/dvJuOXSAihnjRYZao+0nseee80t
        qNuQED+ovxrXRJ5imiUWDsP14rXSxBXi5jsBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FAECfXTtXRwgOooSImmK09nL83wvAVwL
        eZ8NFMpKtH/pYVw+q1x+byTiZbRLerX3xuJxxOYSuZ2AI7C0BRGuidsizf0ZF6F0
        L1jKrtZo59ZK7aVwMc6sCqkBlsNoi6oy5Tm9A72e4jehw1M+y9uSdBd7EX/4DVdO
        P6ic37lb+nY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8C0A60BA;
        Sun, 19 Nov 2017 19:26:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B07AA60B9;
        Sun, 19 Nov 2017 19:26:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] git-rebase: clean up dashed-usages in messages
References: <20171118161810.16494-1-kaartic.sivaraam@gmail.com>
        <xmqq4lprow2i.fsf@gitster.mtv.corp.google.com>
        <459f9455-5edb-39a2-1511-1590e50d4545@gmail.com>
Date:   Mon, 20 Nov 2017 09:26:42 +0900
In-Reply-To: <459f9455-5edb-39a2-1511-1590e50d4545@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 19 Nov 2017 22:58:40 +0530")
Message-ID: <xmqqmv3hokvx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C8CA3D6-CD89-11E7-8EE4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On Sunday 19 November 2017 07:42 AM, Junio C Hamano wrote:
>>>   test -f "$apply_dir"/applying &&
>>> -	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
>>> +	die "$(gettext "It looks like you are in the middle of an am session. Cannot rebase.")"
>>
>> Probably not, as 'am' alone would be confusing.
>>
>>      "It looks like 'git am' is in progress. Cannot rebase."
>>
>> may be a more sensible improvement.
>
> Let me guess, 'am' alone would be confusing because it follows 'an' in
> the error message.

With a, an or the, or without, 'am' alone, unlike 'status',
'rebase', etc., do not look much like a subcommand name, and that is
why the original chose to say git-am.  The suggestion is to make the
primary change (i.e. remove mention of dashed form) without changing
or breaking what the original wanted to do.
