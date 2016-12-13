Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8E3203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbcLMSxH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:53:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753095AbcLMSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:53:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 648B2570D6;
        Tue, 13 Dec 2016 13:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gBYQdwfh+KifvmK/Zukhen7QbW8=; b=rXEMrZ
        5mvE85twHLlPbcdQJnU6JclaVFdFU+jFmhNF1P+u61XRcqsm6FYwGZOjsKhaEL7C
        lxzwMTPiCeKwl80qkz9e2PE6C7fnAqCNincv/IoPJkEB7XrQZ2WVl6yDxgrnlsGh
        FOhwJ50E0lJF5KSYAl8ofjbj1tSmqN1x4rWLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u0hSPly0qP4ABhk27A7HA9JaMy7QETie
        PCiQYZHtaboRclDVFLY8tr1VmGw+Wx2ZKopxJlZgN39bJtGSYUdRQZQzXdkZSMwp
        pwZdZvRmX21LniUymPMszU0adsCVtHU1TKgipVrBWz9aVbfdZ3lUcv1wB+/MHfCj
        Mw78w4MnOCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 585B4570D5;
        Tue, 13 Dec 2016 13:53:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5013570D3;
        Tue, 13 Dec 2016 13:53:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
References: <20161213014055.14268-1-sbeller@google.com>
        <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
Date:   Tue, 13 Dec 2016 10:53:02 -0800
In-Reply-To: <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Dec 2016 09:55:37 -0800")
Message-ID: <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 608CF1D0-C165-11E6-8A7D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Dec 12, 2016 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The "checkout --recurse-submodules" series got too large to comfortably send
>>> it out for review, so I had to break it up into smaller series'; this is the
>>> first subseries, but it makes sense on its own.
>>>
>>> This series teaches git-rm to absorb the git directory of a submodule instead
>>> of failing and complaining about the git directory preventing deletion.
>>>
>>> It applies on origin/sb/submodule-embed-gitdir.
>>
>> Thanks.  I probably should rename the topic again with s/embed/absorb/;
>
> I mostly renamed it in the hope to settle our dispute what embedding means. ;)

I do not think there is no dispute about what embedding means.  A
submodule whose .git is inside its working tree has its repository
embedded.

What we had trouble settling on was what to call the operation to
undo the embedding, unentangling its repository out of the working
tree.  I'd still vote for unembed if you want a name to be nominated.

> Note that sb/t3600-cleanup is part of this series now,
> (The first commit of that series is in patch 6/6 of this series, and patch 5 is
> the modernization effort.)

Well, "t3600: remove useless redirect" has been in 'next' already;
do you mean that you want me to queue this series on top of that
topic?


