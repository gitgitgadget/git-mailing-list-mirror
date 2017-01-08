Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722A120756
	for <e@80x24.org>; Sun,  8 Jan 2017 01:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936787AbdAHB6C (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 20:58:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55528 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933164AbdAHB6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 20:58:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E21A5D523;
        Sat,  7 Jan 2017 20:57:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5nZSo36J8nn53xaOB6texhft+Sg=; b=SJPYIJ
        q8IxtbyTf+Jscnnq3+Fl2VQQx5SfRTYoC4ScD0+NDa2q6OjHz92lfSpChtZaInAj
        hwNzvZ6tu2Kh7F7A24WgyJKQ91Kmz++ty+9aCvOuCIIEURsTZYzdGXwZQurLkONZ
        zAKTEYzuyfI98J4OUOpxzOb/kEypjGnlyrTKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SvXzXi8y2eQU1Kh6e8hWvn58KlCk2ab6
        X7GOMaGd6XQ+m5xZASGTNWipI8+5erisT6VXsY3RB+aMfSXKMKg5nHl4L6IVXoEO
        TLY4hID27A+qqWm6yzRAxATP/W/WpdDxKMVWfcm5pVVc+eJ5wkQ4dmdHQbBM+nvy
        PtnPi8EKNr4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 051B65D521;
        Sat,  7 Jan 2017 20:57:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6893A5D520;
        Sat,  7 Jan 2017 20:57:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 05/34] sequencer (rebase -i): learn about the 'verbose' mode
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de>
        <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701021610590.3469@virtualbox>
        <xmqqk2a635it.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 07 Jan 2017 17:57:57 -0800
In-Reply-To: <xmqqk2a635it.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 07 Jan 2017 13:48:58 -0800")
Message-ID: <xmqq37gu2tzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0EC807C-D545-11E6-A8BB-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> ...
>>
>> I guess my only defence is that I tried to be a little lazy.
>
> I actually was alluding to going the other way around, spawning
> "diff-tree -p" in the other codepath like this one does.

Pre-emptively, because I expect it will take a while for me to clear
the backlog to get to your reroll already on the mailing list, I do
not mean to say that you must rewrite the other one to spawn to
match this one.  I meant that I wouldn't have minded if the series
were done that way, as this kind of being "little lazy" would reduce
the chance of regression by reducing the number of exchanged parts
and it is not necessarily a bad thing.
