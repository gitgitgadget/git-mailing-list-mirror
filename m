Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01DF1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755427AbcH2Rwd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:52:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51593 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755136AbcH2Rwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:52:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFD443AA9D;
        Mon, 29 Aug 2016 13:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPexYEsfeNU3/Tld9D79XH0dUqA=; b=H0w63o
        dp97sJbqi2joK9/1yXUosQfiA/hDhSGjkWqnebf68wt5ApLZX2wehrI13gVNxp3x
        7fWPYzPD0H8yeqvDmxhLZUzC+lAeCyC6dDu32GuHGeRdm4/lKUs2KqsaFa0hUc6d
        the42HNeXzROonC/2qWOSjdMLL7IZocztTs10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=st8Cws9aRByXJdnEP4LMErCLTfnqQdAV
        niSEq/E5tDROmmqS53ki7RtH+/oDHYA3pOi0y51zvC/h35c8tnqyk+iI5tPKZ6sh
        7+LwHhBvMJLd6xVkpschl4FnETKqiuPBKSr6c5SJSCj1FyHWla8IhBhflIqcAyTZ
        uxdx8lciuKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B82F83AA9C;
        Mon, 29 Aug 2016 13:52:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46EA63AA9B;
        Mon, 29 Aug 2016 13:52:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-11-larsxschneider@gmail.com>
        <CAGZ79kZ5utc+0iXKPh=tu4rD9H6+AKZmc08_jLxQhgiuFUA+Yw@mail.gmail.com>
        <E574E25A-F87F-416C-88E5-E3CE1F6B54D0@gmail.com>
Date:   Mon, 29 Aug 2016 10:52:29 -0700
In-Reply-To: <E574E25A-F87F-416C-88E5-E3CE1F6B54D0@gmail.com> (Lars
        Schneider's message of "Thu, 25 Aug 2016 21:54:36 +0200")
Message-ID: <xmqq37lncvj6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BB7DE06-6E11-11E6-B19E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 25 Aug 2016, at 21:17, Stefan Beller <sbeller@google.com> wrote:
>> 
>>> On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Generate more interesting large test files
>> 
>> How are the large test files more interesting?
>> (interesting in the notion of covering more potential bugs?
>> easier to debug? better to maintain, or just a pleasant read?)
>
> The old large test file was 1MB of zeros and 1 byte with a one, repeated 2048 times.
>
> Since the filter uses 64k packets we would test a large number of equally looking packets.
>
> That's why I thought the pseudo random content is more interesting.

I guess my real question is why it is not just a single invocation
of test-genrandom that gives you the whole test file; if you are
using 20MB, the simplest would be to grab 20MB out of test-genrandom.
With that hopefully you won't see large number of equally looking
packets, no?
