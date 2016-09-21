Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18741F935
	for <e@80x24.org>; Wed, 21 Sep 2016 15:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964817AbcIUPkW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 11:40:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51654 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964814AbcIUPkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 11:40:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B4DA3EB41;
        Wed, 21 Sep 2016 11:40:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMCjKdbz/hJ8HP+sJzJ4W6MnXyQ=; b=xAKjAk
        GBT4kc8aNjibCvt9zXkGHgvxVaIdw7Kc6K2RoQccEliV5YpIiAhqujG/eVbWYEao
        tqZpFUcNZqWRpHpgcp5MEJ7QVkoGgjB8Qd9Fo4M8hBL9UnselgFhUAMbZIukXlN6
        pqWFdx+SfuLpVxCPTpHusxOcqn/yoOunFMW5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tIOhAA2jJht3TqQn6B8pQ2ttdcaS2I1v
        +0N4d5uTV34M7B3Qr3JhFAKm9OdtJ6oCpnPpbjjN4+MJFd4Fjgn8c4KL3WAhJHmn
        K13yN1f04FRT6I7BU2r+bDWW/dm72Cwr4UPTjnh8KQ7PJhDQLieMhTEUrn+J1dFL
        SaU3lUbR0gM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42BA13EB40;
        Wed, 21 Sep 2016 11:40:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B148B3EB3F;
        Wed, 21 Sep 2016 11:40:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609202349260.129229@virtualbox>
Date:   Wed, 21 Sep 2016 08:40:17 -0700
In-Reply-To: <alpine.DEB.2.20.1609202349260.129229@virtualbox> (Johannes
        Schindelin's message of "Tue, 20 Sep 2016 23:50:01 +0200 (CEST)")
Message-ID: <xmqq8tulclcu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B399CF28-8011-11E6-AB24-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * jk/rebase-i-drop-ident-check (2016-07-29) 1 commit
>>   (merged to 'next' on 2016-08-14 at 6891bcd)
>>  + rebase-interactive: drop early check for valid ident
>> 
>>  Even when "git pull --rebase=preserve" (and the underlying "git
>>  rebase --preserve") can complete without creating any new commit
>>  (i.e. fast-forwards), it still insisted on having a usable ident
>>  information (read: user.email is set correctly), which was less
>>  than nice.  As the underlying commands used inside "git rebase"
>>  would fail with a more meaningful error message and advice text
>>  when the bogus ident matters, this extra check was removed.
>> 
>>  Will hold to see if people scream.
>>  cf. <20160729224944.GA23242@sigill.intra.peff.net>
>
> Let's do this.

We have already been doing it (i.e. "hold to see if people scream")
for some time.

Does it conflict with your effort to reimplement "rebase -i" in C to
keep this in 'next'?  Do you want it to move to 'master'?  I was
under the impression that it would not make a difference to have or
not have this patch once your reimplementation gets merged (meaning:
the removal of the three lines will be done by wholesale removal of
git-rebase--interactive.sh done the endgame of your series), so...

