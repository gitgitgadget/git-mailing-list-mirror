Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1876F20958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdDASKA (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:10:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751841AbdDASJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:09:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3CDE6B31F;
        Sat,  1 Apr 2017 14:09:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HO4+K8uQAsh6lF9iwFfxGencAbg=; b=rbKmcK
        jq9Zk0SkSaqWSv6RmjGXTrih8t+4dgiB/WFrY/bktVtufte55j0ASUx2QfXtR/cC
        JOYrsXMJ+NrM+1LhiQCA6EMzWQilG1WZVjRVk02dqALZDdsQj0g/dzDR8BEZ8Hkh
        qvU55QTCMs/qKUmc0gvOZ2RVWnQVXwgYQLNIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n5e0dEUVYeoiiNx7ZubqeCQH9kamcIgi
        LJwRTXuzyQ5XRAphA17f/Gd2H9M44j7oa0taMlOhkuvZ56/CkbmCHHxpCm2RfzhY
        bE41BxoOSGHNTWTV0fCMI3RM0p3eoj1yXwGugwRcMXGq5F+RuNQiBx+dKawlTIAT
        453nb6nfpgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBE296B31E;
        Sat,  1 Apr 2017 14:09:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 188D56B319;
        Sat,  1 Apr 2017 14:09:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] http.postbuffer: allow full range of ssize_t values
References: <20170331172631.12024-1-dturner@twosigma.com>
        <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
Date:   Sat, 01 Apr 2017 11:09:56 -0700
In-Reply-To: <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 1 Apr 2017 02:01:16 -0400")
Message-ID: <xmqqo9wguhhn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A71535C-1706-11E7-800C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 31, 2017 at 01:26:31PM -0400, David Turner wrote:
>
>> Unfortunately, in order to push some large repos, the http postbuffer
>> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
>> we just malloc a larger buffer.
>
> I'm still not sure why a 2GB post-buffer is necessary. It sounds like
> something is broken in your setup. Large pushes should be sent chunked.
>
> I know broken setups are a fact of life, but this feels like a really
> hacky work-around.

Yeah, I tend to share that "Huh? We do not want to do this, but what
forces us to?" puzzlement.

Tentatively demoted to 'pu' (out of 'jch'--candidates to go to 'next').
