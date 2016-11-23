Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8EAA1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 20:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756331AbcKWUFi (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 15:05:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53841 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755032AbcKWUFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 15:05:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A9A25098B;
        Wed, 23 Nov 2016 15:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/1OlsLrCLOxMa9VwQdgGtXLmDj0=; b=H25zdi
        vwvz0sO9eiNJnK7qR5ZnhrswoP4sBdTMvVVvz14y8blxMNDz2l7PgBYPqtypaXkH
        X91m8gANufNRWBhunnG/xpC0B8by26pkXFF9Hc+R56nv8RgCvVCJVHVI7RPtLb5g
        MhJ2CxK5YSS2WhAnfCnSwiTsbsF5/XWeg1JDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqJkPga18IFl8de0Nte8HiwkSCBKYOLk
        QiLW9TO097+tPJLi+Oexg3ZSvHr0TIL38+DUxeRk1C9BFsKGSL35V/zwflp1pt18
        bXWAovUBc6eMhQjWwGGh8Bxw9Zxno/s4YiyNqfUBcXxxbLk78lqptJGqb2VxJ9xL
        sinQMv2eAsY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04B5350989;
        Wed, 23 Nov 2016 15:05:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72F9650987;
        Wed, 23 Nov 2016 15:05:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pat Thoyts <patthoyts@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: pass the branch name to git merge
References: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org>
        <xmqqvavfpbph.fsf@gitster.mtv.corp.google.com>
        <1dc28731-9000-c3bf-fbed-0cb17c230d8b@kdbg.org>
        <5baaf25b-6f15-8002-97ea-97c5c6a4b4e4@kdbg.org>
Date:   Wed, 23 Nov 2016 12:05:34 -0800
In-Reply-To: <5baaf25b-6f15-8002-97ea-97c5c6a4b4e4@kdbg.org> (Johannes Sixt's
        message of "Wed, 23 Nov 2016 20:23:53 +0100")
Message-ID: <xmqq4m2ym06p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32268C0A-B1B8-11E6-8740-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.11.2016 um 21:40 schrieb Johannes Sixt:
>> Am 22.11.2016 um 20:16 schrieb Junio C Hamano:
>>> Can't this be handled on the "git merge FETCH_HEAD" codepath
>>> instead?
>>
>> Absolutely. Any takers? ;)
>
> I attempted to fix git merge FETCH_HEAD, but I do not see a trivial
> solution.
>
> But on second thought, we have an excuse to pick my proposed git-gui
> change anyway: Without that change and a fix in git-merge only, there
> is still a regression for all users who use the latest git-gui but
> some git version between 2.5.0 and the fixed git-merge...

I'll leave it up to Pat, as I do not read tcl very well ;-)
