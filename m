Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F3D1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758267AbcLAWWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:22:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754235AbcLAWWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:22:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A612A53B54;
        Thu,  1 Dec 2016 17:22:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fpenMasL7unIiHxGQ+dF44bRhlA=; b=PfACXg
        zdwjRHWfoHy9cZGcaw2WCplVLw5WfNBaVwEjCkPcBNOuNpYdNgt7HkBBrCCW7qvT
        3b29MZXhPtTjRmCA3Run9mounFUzR6fvMjOvEBzTV2dYwYBofoKL4UrVOqrz2vKv
        URMg2H5rgUM+aNb5ficrlUyrKENppVC9AGoJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T7ekvnvNUgbhu7PJQD4aPNRWsAUAvZH2
        Hl58wJPiFfNdWNTVGmloGSGHhBv84nibH1OmRiUg04iApErQmLLvvcXsQmbw6H4l
        0kxixRvDYCCds2pT3zrsBxeu9y2/ILyrHLPYOBLf8TYXwPwbUYdQV7tAMHqbyH+t
        0yEVHTjxKZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E3C653B53;
        Thu,  1 Dec 2016 17:22:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1310753B52;
        Thu,  1 Dec 2016 17:22:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
        <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
        <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net>
        <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com>
        <20161201213019.qfkqd324ommikym2@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 14:22:47 -0800
In-Reply-To: <20161201213019.qfkqd324ommikym2@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 16:30:20 -0500")
Message-ID: <xmqqtwan70i0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B111D6AC-B814-11E6-A111-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> It took me a while to dig it up because the topic is so old, but
>> 
>> https://public-inbox.org/git/Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org/
>> 
>> is the thread I had in mind.  The idea of rename detection followed
>> soon afterwards.
>
> Thanks for an interesting read. Your diff-tree-helper patch is very
> similar to what I wrote.
>
> I do think the right decision was made back then. The single-process
> model is much more efficient, and it was over 10 years until somebody
> actually wanted to expose the functionality to a script (and even now,
> I'm not convinced enough people want it to even merit inclusion).

Well, 10 years ago the person in the thread who argued "who cares
about producing patches?  each step in plumbing should do one thing
and one thing only and do so well" was Linus, so your coming up with
the diff-tree-helper again may indicate that we may want to step
back and retry the experiment again, perhaps?

