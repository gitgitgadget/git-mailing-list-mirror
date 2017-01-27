Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB7F1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934038AbdA0RqV (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:46:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63921 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934102AbdA0Rpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:45:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7556C62ADA;
        Fri, 27 Jan 2017 12:45:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9GuYoN6xAE8e0b1H7nGoSRI4oZs=; b=gneV9m
        P1lKG0UfuDf7mMHEqB+8hVKOH7p7kVd3b23108PIGg1xr7ocEXUdl5u94n9Vrmqw
        dxKfik14uXLvX5GGuQSM4pGlJdtvMPKj59ed1qYuKhqDCGMJUN/9mwoYWJ4yXPY7
        7W/xWTihUDXfnbTjJzmgIaacyM3Ecie2YVeZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qlh3sALJjf7Q6vQVvY4MKDWHkqGH5xSR
        59vp2NFyrkL1d9kPX/tNuhOWuI0VLqyRXarTxo2io14H3ECOT7GLVV/t7ohMydZX
        wQYvZmsOhhe5m6ZtzahaB8ocZJXIyN1Nz5Jqw2xgxSaVqNE8VXb64aK+sYyEIG6l
        kmmqSMhdc44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C41062AD9;
        Fri, 27 Jan 2017 12:45:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4DEB62AD7;
        Fri, 27 Jan 2017 12:45:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 4/4] urlmatch: allow globbing for the URL host part
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
        <20170125095648.4116-5-patrick.steinhardt@elego.de>
        <20170127062142.GA760@pks-pc>
Date:   Fri, 27 Jan 2017 09:45:41 -0800
In-Reply-To: <20170127062142.GA760@pks-pc> (Patrick Steinhardt's message of
        "Fri, 27 Jan 2017 07:21:42 +0100")
Message-ID: <xmqq1svo1jne.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C95CA26-E4B8-11E6-87EE-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <patrick.steinhardt@elego.de> writes:

>> This is probably a useful improvement.
>> 
>> Having said that, when I mentioned "glob", I meant to also support
>> something like this:
>> 
>> 	https://www[1-4].ibm.com/
>
> The problem with additional extended syntax like proposed by you
> is that we would indeed need an escaping mechanism here.

True.  I think a true shell globbing is overkill (so is regexp) and
just a simple wildcarding with '*' would be a good first step that
is easy to explain and later extend as needed.

Thanks.
