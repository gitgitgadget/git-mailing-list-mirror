Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A331FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 19:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964978AbeAKTCI (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 14:02:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55720 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933141AbeAKTCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 14:02:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21246C8B3F;
        Thu, 11 Jan 2018 14:02:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yksiGce8gn7rJHi1weBFdJ7602k=; b=q/+63+
        i22p3lvEIpz9JwR1Tbnn13x+HcgyrP99+sIcUb2NJJw8U+xyWPfC1z67K2r7Swmd
        TgXyI6Q222USDHN4evHB3t92szyvQrKbMuWgxvXC4Pbsbyuzd3iIbjXnz5LB/1yR
        xXuNrJpCZ85OriqCnHASpARUyWsYK7/+ByzMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NE/5YLxcGSsAU3q/8SdvJ0mhIpnQLQPv
        ELibcX4WdtNee5CpTX3jQ0qoq3kmHWdvlkpU7AMHnRWjN0PQ9Z/+9fazeChc0q+g
        c9hWNz+CZLIbDgKCQfJwH9fuS6/H+9wtJCol7fbkwtGDG7QS9NSO5T3CSfO8OaNm
        +EF1nTSSz1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1573AC8B3E;
        Thu, 11 Jan 2018 14:02:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7803AC8B3D;
        Thu, 11 Jan 2018 14:02:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Andreas G. Schacker" <andreas.schacker@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc/read-tree: remove obsolete remark
References: <20180109153034.22970-1-andreas.schacker@gmail.com>
        <20180111104914.GA5897@sigill.intra.peff.net>
Date:   Thu, 11 Jan 2018 11:02:04 -0800
In-Reply-To: <20180111104914.GA5897@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 11 Jan 2018 05:49:14 -0500")
Message-ID: <xmqqbmi0z0b7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA3E651C-F701-11E7-A0C5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 09, 2018 at 04:30:34PM +0100, Andreas G. Schacker wrote:
>
>> Earlier versions of `git read-tree` required the `--prefix` option value
>> to end with a slash. This restriction was eventually lifted without a
>> corresponding amendment to the documentation.
>
> Makes sense.
>
>> ---prefix=<prefix>/::
>> +--prefix=<prefix>::
>>  	Keep the current index contents, and read the contents
>>  	of the named tree-ish under the directory at `<prefix>`.
>>  	The command will refuse to overwrite entries that already
>> -	existed in the original index file. Note that the `<prefix>/`
>> -	value must end with a slash.
>> +	existed in the original index file.
>
> Is it worth mentioning in the new world order that the slash is not
> implied? I.e., that you probably do want to say "--prefix=foo/" if you
> want the subdirectory "foo", but do not want to match "foobar"?

Doesn't "git read-tree --prefix=previous HEAD^" add paths like
"previous/Documentation/Makefile" to the index, i.e. instead of
forcing you to have the required slash at the end, we give one for
free when it is missing?
