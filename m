Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA811F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeAWSh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:37:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59473 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeAWShz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:37:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3855B7539;
        Tue, 23 Jan 2018 13:37:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7KI8ewIO3ASWZ1TDkgsKE+sHZl4=; b=KGVP+P
        Gw8RnNUX8K7oRJLdUnhHcuOFNERxG0NlpsacZSISonrOTCikVVVi7hBv+rBDnPXQ
        kyYk2Ixoo+c/R6Ny6gX/dzPQ5+Fr+2PZFg/IJ876ksGxFRx8iR0V706j+7QeyQew
        +wiiMQ5gBnNKf4mfhin/qvC+BJ2dxZBeZR8sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kJS83E4frOQGH7tDce7k/yHzgdsPKuxm
        xYZ84FAA5mpGp8cOOS91M7zIw3a7JkDYsFmnU638aFUy/DMm9BeV3ze0DLnVhSgK
        RYAKck0F8ZdKKlgcBnT2nxcQmkFdD02FIGPOyK8tL6NR81reu3ZQBULwTEsI7ZbU
        +Gr2QmC6taw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9BFFB7538;
        Tue, 23 Jan 2018 13:37:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 633F6B7535;
        Tue, 23 Jan 2018 13:37:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Aleksey Bykov <aleksey.bykov@gmail.com>, git@vger.kernel.org
Subject: Re: The original file that was split in 2 other files, is there a way in git to see what went where?
References: <CAMAMitCV3xvaSr00H574Pww=r_c3=0NqT1Ge13kc=gWJqDJ3Ug@mail.gmail.com>
        <CAMAMitC-iyH_YOAsJcPpLcUbmX-Zun4MCL89Pxn2rr7Lu_m2cQ@mail.gmail.com>
        <20180123165545.GI13068@sigill.intra.peff.net>
Date:   Tue, 23 Jan 2018 10:37:53 -0800
In-Reply-To: <20180123165545.GI13068@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jan 2018 11:55:45 -0500")
Message-ID: <xmqq8tcoifpa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 864902F0-006C-11E8-83B3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jan 22, 2018 at 10:22:21PM -0500, Aleksey Bykov wrote:
>
>> I am a code reviewer, I have a situation in GIT:
>> 
>> - before: a.txt
>> 
>> Then a developer decided to split the content of a.txt into 2 files
>> and add a few changes all in one commit:
>> 
>> - after: b.txt + few changes and c.txt + few changes
>> ...
> For seeing which line came from where, you might try "git blame -C",
> which will cross file boundaries looking for the source of lines.
> ...
> And finally, if you're going to do a lot with "git blame", I'd look into
> the "tig" tool as a prettier interface. You should be able to do "tig
> blame -C ..." in the same way.

All excellent guides.  "blame" is good at explaining where things
came from, but not as good at explaining, starting from an old
state, where things went.  "blame --reverse" does a decent job
within the constraints its output format has, but not quite ideal.

