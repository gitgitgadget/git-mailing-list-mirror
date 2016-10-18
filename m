Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65601F4F8
	for <e@80x24.org>; Tue, 18 Oct 2016 01:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934504AbcJRBmj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 21:42:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55339 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934237AbcJRBmh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 21:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE1CB48588;
        Mon, 17 Oct 2016 21:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/S1vtdw25mmLqjtjUIJJlGgkE3c=; b=na3n3F
        FM22UWwyFncpNd7nw/nM/RKw7Se3l4IV77MrrSfp3yqCcC3F28UP6HyEu0mztIKX
        X9D1nxJoqx8mfsq+RBMeCG4v2WYSpedZLzyDZ2vSjcj/PQX2sBYuWhW8G1nwmrIs
        xTVt/8bYVPE5GaZK1A/2jrSg9YYyZoBMJKyr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uBlNcmkzbLpM0Gw1Yp0bkzyUVB8jKYPE
        KPRzxpPG+K5Vl9I01694E84Sjrqn/55pkHUh2zAgeeSewuOhtE6h0V5d9I+KCui4
        mSfCfbKINocQw2zc1u+jXcDS9V3oxJY/BBp5ShWjc02QsQd3wTYcaRxXZieQco/o
        E0D5hyNHVuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3E7448587;
        Mon, 17 Oct 2016 21:42:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65D7C48585;
        Mon, 17 Oct 2016 21:42:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 5/6] trailer: allow non-trailers in trailer block
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476466609.git.jonathantanmy@google.com>
        <1b3fe84e4b6126884a801e721d0a93c41fcb4184.1476466609.git.jonathantanmy@google.com>
        <CAGZ79kYLq1qA4_Qg2x5Fiu5AmGBZdozm4zk6K7LkU+uJ1LNUTw@mail.gmail.com>
Date:   Mon, 17 Oct 2016 18:42:33 -0700
In-Reply-To: <CAGZ79kYLq1qA4_Qg2x5Fiu5AmGBZdozm4zk6K7LkU+uJ1LNUTw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 17 Oct 2016 17:49:19 -0700")
Message-ID: <xmqq7f96sa9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24E4CD6E-94D4-11E6-B0A2-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Oct 14, 2016 at 10:38 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>>  Existing trailers are extracted from the input message by looking for
>> -a group of one or more lines that contain a colon (by default), where
>> +a group of one or more lines in which at least one line contains a
>> +colon (by default), where
>
> Please see commit
> 578e6021c0819d7be1179e05e7ce0e6fdb2a01b7
> for an example where I think this is overly broad.

Hmph.  That's a merge.

    Merge branch 'rs/c-auto-resets-attributes'

    When "%C(auto)" appears at the very beginning of the pretty format
    string, it did not need to issue the reset sequence, but it did.

    * rs/c-auto-resets-attributes:
      pretty: avoid adding reset for %C(auto) if output is empty

And neither of the two colon containing line remotely resembles how
a typical RFC-822 header is formatted.  So that may serve as a hint
to how we can tighten it without introducing false negative.

> Another made up example, that I'd want to feed
> in commit -s eventually:
>
> --8<--
> demonstrate colons in Java
>
> First paragraph is not interesting.
>
> Also if using another Language such as Java, where I point out
> Class::function() to be problematic
> --8<--
>
> This would lack the white space between the last paragraph and
> the Sign off ?
>
> So for this patch I am mostly concerned about false positives hidden
> in actual text.

Yes.  

These are exactly why I mentioned "if certian number or percentage"
in my earlier suggestion.

I think in practice, "A paragraph with at least one Signed-off-by:
line, and has no more than 3/4 of the (logical) lines that do not
resemble how a typical RFC-822 header is formatted" or something
along that line would give us a reasonable safety.  

Your Java example will fail the criteria in two ways, so we'd be
safe ;-)
