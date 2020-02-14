Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8EC3B1A4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8D52082F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MznG0qjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393970AbgBNQ5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:57:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60382 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394035AbgBNQ5g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 11:57:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2BB1AC3841;
        Fri, 14 Feb 2020 11:57:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t1V1b7VkbHPaAVFEpXfkNsLvIIU=; b=MznG0q
        jkPejrI/bwgp+Rx15m/z7MWoIYl/AM8tmGzWMIGdf3H+ruIeR6Wy/woqZoSbJTqk
        jD7ZtbSuHn5z+NODsSw34nJbWJsZBUZofXI28p2BQ8RGqohUa/wyzmQ/l0qro703
        dk4bztM9ABd9lBBOP94jeRB9/WAfb353WYrIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oG4lwa14Le4h0uj0tJBdK4s2cIB0l33M
        BTINrirqPfWqxN5F24u1jU4hCDv/iIo+Unkutos8wncZzjkPTkouhIq4Selb4IN5
        g/4YEumAGduO1C7XRTXQBoGu7tDScpj1H+6jhOE3O+N3Rt+MoPz5wm7icimagmuX
        zdg02oSKA8w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EF1DC3840;
        Fri, 14 Feb 2020 11:57:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A395C383F;
        Fri, 14 Feb 2020 11:57:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Roland Hieber <rhi@pengutronix.de>, git <git@vger.kernel.org>
Subject: Re: git-describe --tags warning: 'X' is really 'Y' here
References: <20200205141332.lov2f2fvinehcd3a@pengutronix.de>
        <CAHd-oW6p-zs-SZnQsJNWPGE8-Ls3vXvf_HOeO+W=1PsQ_oihZA@mail.gmail.com>
        <20200214065352.GG605125@coredump.intra.peff.net>
Date:   Fri, 14 Feb 2020 08:57:29 -0800
In-Reply-To: <20200214065352.GG605125@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Feb 2020 01:53:52 -0500")
Message-ID: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1765287A-4F4B-11EA-88E9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >     gcc (master) $ git describe --tags --abbrev=0
>> >     warning: tag 'gcc_9_2_0_release' is really 'releases/gcc-9.2.0' here
>> >     gcc_9_2_0_release
>> >
>> > It took me a while to find out what the warning means, because
>> > 'gcc_9_2_0_release' is not in $(git tag -l), and it cannot be used as a
>> > ref either:
>> [...]
>> It seems that the commit which added the output message you got is
>> 212945d ("Teach git-describe to verify annotated tag names before
>> output", 2008-02-28) [1]. As the commit message states, the warning is
>> emitted when a tag is locally stored under a different name from the
>> one it was originally created (being the former the one you will want
>> to use at `git show`).
>
> Yeah, I think that is what's going on with that warning, but there's a
> weird thing about the actual stdout output. We see a tag object whose
> name doesn't match the ref. What's the "real" name of that tag? Is it
> the name in the object, and the ref is wrong? Or is the ref correct, and
> the object is wrong?
>
> You could get pretty philosophical there, I think, but it seems slightly
> annoying that we print the name from the object to stdout, when one
> cannot then use that name to access the tag in any way.
>
> I.e., I think it might be reasonable to issue that warning but then
> print "releases/gcc-9.2.0" instead.

I agree.  What the tag creator, whom you treat as more authoritative
than yourself, called "gcc_9_2_0_release", is stored at a wrong
place by you and you have to call it "releases/gcc-9.2.0".  So the
right way (at least philosophically) to phrase the warning message
should reflect that a bit better, perhaps

  warning: tag 'releases/gcc-9.2.0' is externally known as 'gcc_9_2_0_release'
  releases/gcc-9.2.0

to hint that 'releases/gcc-9.2.0' is merely how you name it and the
real name of the tag itself is gcc_9_2_0_release, although in
practice everybody would be calling the tag with the same wrong
name, as that is how cloning and fetching of tags work ;-).


