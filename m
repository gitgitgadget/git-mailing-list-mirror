Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC9E202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 14:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934114AbdKPO5f (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 09:57:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58306 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932459AbdKPO5e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 09:57:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A11B4BE1E6;
        Thu, 16 Nov 2017 09:57:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4oT5WLExIhAa3TSmrGN/wJ5VuCY=; b=dJ4KYQ
        FUGfW6gaFPExKGQA264j8TjLawghAp+CDXtaAruqYMpaTc5cnVGBiShHapVAZSXA
        5JDUtMpKVa1vTjcBgeCY6FlREMt3gkmolIwZ12bccAC7NR3bA89j0SCFUHTreQ7k
        JniqVHXBaYAVYb++SOOi0qIsWzZ4D/mAdHGOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VpwGJlSkeorBrUplBpR7zOFhkerjVqUX
        tz3y9N0o/Rbt89B628nebWEvYVw7ts/eDzAmlQFDallJzDTFiqok1j7iBqUJOTTI
        Po1b8S0ZnDIS5Q0PJ/WvPENNYBSqOvf1dcnOu08ra+cny9X0Zy9rXJ+krOkpgz/P
        FgIAcqoK/tY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99DBDBE1E5;
        Thu, 16 Nov 2017 09:57:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1856CBE1E4;
        Thu, 16 Nov 2017 09:57:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] branch: correctly reject refs/heads/{-dash,HEAD}
References: <20171013051132.3973-1-gitster@pobox.com>
        <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
        <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
        <xmqq375g3nkf.fsf@gitster.mtv.corp.google.com>
        <bb3485d0-71bc-452e-e4b9-8a7d767753a5@gmail.com>
        <xmqqpo8jyyti.fsf_-_@gitster.mtv.corp.google.com>
        <471c7b6e-d3a0-4aee-8f80-282ff0b8d972@gmail.com>
Date:   Thu, 16 Nov 2017 23:57:31 +0900
In-Reply-To: <471c7b6e-d3a0-4aee-8f80-282ff0b8d972@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 16 Nov 2017 18:41:10 +0530")
Message-ID: <xmqqlgj6uv8k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79AEF464-CADE-11E7-8FFC-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> I guess this series is not yet ready for 'next'. When I tried to apply
> this patch it doesn't seem to be applying cleanly. I get some
> conflicts in 'sha1_name.c' possibly as a consequence of the changes to
> the file that aren't accounted by the patch.

Oh, it is totally expected that this patch (and others) may not
apply on 'next' without conflict resolution, as this topic, as all
the other topics, are designed to apply cleanly to either 'master'
or 'maint' or one of the older 'maint-*' series, if it is a bugfix
topic.  A patch series that only applies cleanly to 'next' would be
useless---it would mean all the topics that are already in 'next'
that interacts with it must graduate first before it can go in.
Make it a habit to build on 'master' or older and then merge to
higher integration branches to make sure it fits with others.

What you could do is to inspect origin/pu branch after you fetch,
and look at the commit that merges this topic to learn how the
conflicts are resolved (the contrib/rerere-train.sh script may help
this process).

Your inability to resolve merge conflicts does not have much to do
with the readiness of a topic, as long as somebody else can resolve
them ;-)

>> +	if (*name == '-' ||
>> +	    !strcmp(sb->buf, "refs/heads/HEAD"))
>
> I guess this check should be made more consistent. Possibly either of,

Among these two, this one

> 	if (starts_with(sb->buf, "refs/heads/-") ||
> 	    !strcmp(sb->buf, "refs/heads/HEAD"))

has more chance to be correct.  Also, if we were to check the result
of expansion in sb->buf[], I would think that we should keep a
separate variable that points at &sb->buf[11] and compare the
remainder against fixed strings, as we already know sb->buf[] starts
with "refs/heads/" due to our splicing in the fixed string.

Because the point of using strbuf_branchname() is to allow us expand
funny notations like @{-1} to refs/heads/foo, and the result of
expansion is what eventually matters, checking name[] is wrong, I
would think, even though I haven't thought things through.  

In any case, I would say thinking this part through should be left
as a theme for a follow-on patch, and not within the scope of this
one.  After all, checking *name against '-' was part of the original
code, so it is safer to keep the thing we are not touching bug-to-bug
compatible and fixing things one step at a time (the one fix we made
with this patch is to make sure we store refs/heads/-dash in sb when
we reject name=="-dash").

