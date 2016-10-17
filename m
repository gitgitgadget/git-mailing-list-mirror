Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECDB1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030269AbcJQRJE (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:09:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64163 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938556AbcJQRDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:03:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE5A8463D6;
        Mon, 17 Oct 2016 13:03:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Um9pnN6saMTCs000IOJuNI+0bWE=; b=Z8XigP
        z1xMxbpRgQxowbDOuLU+e19NK6dfdhDLsppzyOCvsH3omXDreNx1MOLa2Gi74s37
        Ft0eYMO7Uj/12zW4fw78DKMJsUWH3H4Fka7gdDRuc7IcVVY4qgHOE2ISykTLOgqv
        C5OHj8uAXgGc+oNC8oddpFO20Ic3uHNxZXrJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e0IfKQ/IcMnODXHOztnJ0aCjxSGnptO/
        sRtNYWAM/AFGuwPXtRgZ/LRXJpco8NPoaJy6z5Dji8JlnPOarGBgSjHPa3S3xfCj
        YjrkBueUNB8DzIssUxfaQYxUpRR+vyXmNV503798tTVC4mL8vKO0GUJ+2Bk7SmtP
        +2bE7LYL8fM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D692C463D5;
        Mon, 17 Oct 2016 13:03:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55B68463D4;
        Mon, 17 Oct 2016 13:03:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>
        <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610131439400.197091@virtualbox>
        <xmqqzim6zzc7.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610151020480.197091@virtualbox>
Date:   Mon, 17 Oct 2016 10:03:31 -0700
In-Reply-To: <alpine.DEB.2.20.1610151020480.197091@virtualbox> (Johannes
        Schindelin's message of "Sun, 16 Oct 2016 10:31:45 +0200 (CEST)")
Message-ID: <xmqq7f96ykkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2C6AD2C-948B-11E6-92E5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I'll mark it as "wait for follow-up fix" in whats-cooking.txt (on
>> 'todo' branch) to remind myself not to merge it yet.
>
> May I request your guidance as to your preference how to proceed?
> ...

I guess I didn't see this before I sent my response to the review
thread, which was in my pile of "these need more thought than others
before responding" topics.  

> Here are the options I see:
>
> A) remove the tests in question
>
> B) mark them as !MINGW instead
>
> C) change just those two tests from using `$PWD` (pseudo-Unix path) to
>   `$(pwd)` (native path)
>
> I would like to hear your feedback about your preference, but not without
> priming you a little bit by detailing my current opinion on the matter:
>
> While I think B) would be the easiest to read, C) would document the
> expected behavior better. A) would feel to me like shrugging, i.e. the
> lazy, wrong thing to do.
>
> What do you think?

As to my preference on tests, I guess what I suggested was a cross
between your B and C below, and I can go with either one as an
abbreviated version of my preference ;-) 

I am still wondering if the test is expecting the right behaviour,
though.  If some codepaths rely on a question "please resolve '../.'
relative to 'path/to/dir/.'" being answered as "that's path/to/dir
itself", it smells to me that the downstream of the dataflow that
expects such an answer, as well as the machinery that produces such
an answer, are acting as two wrongs that happen to cancel each
other.  Am I grossly misunderstanding what that test is doing?

