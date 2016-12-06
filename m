Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B071FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbcLFSb6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:31:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58418 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752340AbcLFSb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:31:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB4F2540F0;
        Tue,  6 Dec 2016 13:29:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yulkz1H7nOsw7p/mf11Gyem63RI=; b=hYeb8s
        q5Ro5nwRAx0/eLgbrGcCDVsYyUBKJGskI8rFycrrgKzPIhO8DmnE0jjG588m9TIx
        x+zz7xOpQFM2PhwHR61IZ40tPlfCAX1DopSnRWh0UL67Us5SBV28+iwbh8rRkYIn
        hsQBIcyadGiUBAI/u2im3P7p6YQGrbHgHE8ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZCFIBZV2AKj4FdhndP7MpG9/qqRH6HZb
        1zn1mZYMNQEkLocLyz8VWVYp7SXQzJfp5f0P12sqRr/8Yw5BCXQ6BDhkcf+szeXM
        M2BZMyT45U9TIliEAY0vkQgSfkyd6xhAA4oo//Y6qbB+srco2O7TZ7qVOCql+gdl
        4VU0bG8wy6Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1897540EF;
        Tue,  6 Dec 2016 13:29:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 433DA540ED;
        Tue,  6 Dec 2016 13:29:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] clone,fetch: explain the shallow-clone option a little more clearly
References: <20161204220359.30807-1-alexhenrie24@gmail.com>
        <xmqq37i25iy5.fsf@gitster.mtv.corp.google.com>
        <CACsJy8Cy+iWw4NhR7B_fZhBMMYt2QxdMeFsC=++LLnrTLNWfKw@mail.gmail.com>
Date:   Tue, 06 Dec 2016 10:29:28 -0800
In-Reply-To: <CACsJy8Cy+iWw4NhR7B_fZhBMMYt2QxdMeFsC=++LLnrTLNWfKw@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 6 Dec 2016 16:34:11 +0700")
Message-ID: <xmqqshq029o7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC998618-BBE1-11E6-8CD3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 6, 2016 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I however offhand do not think the feature can be used to make the
>> repository shallower
>
> I'm pretty sure it can,...

I wrote my message after a short local testing, but it is very
possible I botched it and reached a wrong conclusion above.

If we can use the command to make it shallower, then the phrase
"deepen" would probably be what we need to be fixing in this patch:

>  	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
> -			N_("deepen history of shallow clone by excluding rev")),
> +			N_("deepen history of shallow clone, excluding rev")),

Perhaps a shorter version of:

    Adjust the depth of shallow clone so that commits that are
    decendants of the named rev are made available, while commits
    that are ancestors of the named rev are made beyond reach.

or something like that.  Here is my (somewhat botched) attempt:

    Adjust shallow clone's history to be cut at the rev


