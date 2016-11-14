Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4591F40E
	for <e@80x24.org>; Mon, 14 Nov 2016 03:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933581AbcKNDOu (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 22:14:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941062AbcKNDOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 22:14:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2538E4F45E;
        Sun, 13 Nov 2016 22:14:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ulpu7Wo8rY2DgWCC6yeTCDYo4h8=; b=fFYqmr
        hltoNHiVqMa+xP7WWWOkMYSbp95JW4T/4zkQ6CYcoHLFy1LPkHF+wVDxQkM0qmf9
        VFdO+abo57WbT6oIGfJNuqFaFiMdYSZdeA3sw8LcCdsTE3f5p8cREIpSIgJML3ly
        oky4uWXa44O+ueEXSAfh67mFFdR2Brd0Sivq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=guQDcaNJ3S2jKo8rVcNNTH9isO8u561O
        jP0uTWnxHWS6i3hAEG2yRGseNhFKMcXxuZMZglP18fJ46XCQJ49nfoS1s7pmpPqx
        IUm8KITZ8sx+fNtH8jmadLoWX4suCIZpY86I84q06ezK3BCROH58JWSKqFjTRHQ7
        RJ6dzy6tuwg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB9E4F45D;
        Sun, 13 Nov 2016 22:14:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CCA64F45A;
        Sun, 13 Nov 2016 22:14:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
        <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
        <alpine.DEB.2.20.1611121106110.3746@virtualbox>
Date:   Sun, 13 Nov 2016 19:14:44 -0800
In-Reply-To: <alpine.DEB.2.20.1611121106110.3746@virtualbox> (Johannes
        Schindelin's message of "Sat, 12 Nov 2016 11:08:58 +0100 (CET)")
Message-ID: <xmqqwpg6ycpn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E4822E4-AA18-11E6-B6AE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 11 Nov 2016, Jacob Keller wrote:
>
>> On Fri, Nov 11, 2016 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> >
>> >> No tests or documentation updates yet, and I'm not sure whether
>> >> --follow-symlinks in other modes than --no-index should be supported, ignored
>> >> (as it is now) or cause an error, but I'm leaning towards the third option.
>> >
>> > My knee-jerk reaction is:
>> >
>> >  * The --no-index mode should default to your --follow-symlinks
>> >    behaviour, without any option to turn it on or off.
>> >
>> 
>> I agree. We shouldn't have to specify this for no-index.
>
> Ummm. *My* idea of --no-index was for it to behave as similar to the
> --index version as possible. For example when comparing directories
> containing symlinks. You seem intent on breaking this scenario.

Perhaps a viable compromise between the two is to only always
dereference at the top-level (i.e. the trees to be compared) under
"--no-index" mode and not changing anything else?

The original use case by Dennis is not even about doing a recursive
two-directories-in-a-filesystem comparison and encountering a
symbolic link (it was to compare two BLOBs, which happen to be
output from two commands).
