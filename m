Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F2720229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbcKAVYc (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:24:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51630 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932267AbcKAVYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:24:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEAA24A209;
        Tue,  1 Nov 2016 17:24:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LnLW+H4WxBsNurWh6SU4S5Np8qs=; b=g4wffE
        IYZnQvgDQu00dLyIuz0M+qqwTeeeJDt4qo3d/Dmo3rAE80FRseQno/6jZVNSXOIq
        /qxgki62yvc+axm9ESPbnSzt0ExgoUpWBZ4oMWjDiSztUb2LDHfpqeNG6sn79Xge
        LYae44izoldRKOqGZ1dHWqU2NyoeRkgxvQAZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nWaYoyaQqHtXh49wepqxZRzSfmauuWsc
        DAOi1ZTeDQJ7ncVRsTlpEtzlUqwCMu8nBdAyRx7eK/RL7DfhpaU0JNViJFB1Lc3/
        hKY+zW4xu/k/YC9kwhjxVnGASnfIvJmDpAmss5cSo63Gvf8RWg47C/FLqjAq3ZyF
        aJbPbEjUvPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8709E4A206;
        Tue,  1 Nov 2016 17:24:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A490B4A204;
        Tue,  1 Nov 2016 17:24:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        "Halde\, Faiz" <fhalde@paypal.com>, git@vger.kernel.org
Subject: Re: Git issue
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
        <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net>
        <7CE3166CFD244DAABF554451E8B0800F@PhilipOakley>
        <20161101210310.sqrhvviry7iyyjrm@sigill.intra.peff.net>
Date:   Tue, 01 Nov 2016 14:23:59 -0700
In-Reply-To: <20161101210310.sqrhvviry7iyyjrm@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 1 Nov 2016 17:03:10 -0400")
Message-ID: <xmqq8tt2opw0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8195A91A-A079-11E6-B7BB-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 01, 2016 at 08:50:23PM -0000, Philip Oakley wrote:
>
>> > From "git help update-index":
>> > 
>> >      --[no-]assume-unchanged
>> >    When this flag is specified, the object names recorded for
>> >    the paths are not updated. Instead, this option sets/unsets
>> >    the "assume unchanged" bit for the paths. ...
>
> I think the "Instead" is "we are not doing the usual update-index thing
> of reading the new data from disk; instead, we are _just_ setting the
> bit". Perhaps that can be spelled out more clearly, but I think just
> dropping "Instead" is a step backwards.

I tend to agree; the biggest problem with this part of the
description I think is that it starts by saying what it does not do,
which may help people who expect the command to do its usual thing
but otherwise is a secondary information.  How about ripping it out
and moving it after the primary description, i.e.

	Set or unset the "assume unchanged" bit for the paths,
	without changing the object names recorded for them, in the
	index.

>> Given the number of misrepresentations (on the web) of what the bit does,
>> and the ongoing misunderstandings of users it does feel like the man page
>> article could be refreshed to be more assertive about the users promise, and
>> Git's cautions.
>
> I dunno. I know this has long been a source of confusion, but I
> specifically dug in the docs to see what we had, and I thought what I
> quoted above was pretty clear. That has "only" been around for about 2
> years, and is fighting against other mis-advice on the Internet, though.
> So I'm not sure if it is badly worded, or if people simply do not see
> it.

I share the same reaction, and I find that the update in ccadb25f73
("doc: make clear --assume-unchanged's user contract", 2014-12-06)
that introduced the "the user promises not to change and allows Git
to assume" is sufficiently clear.

