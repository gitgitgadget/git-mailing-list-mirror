Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB890C54FCB
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C107C2078C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 01:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NXbRWTq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDUBUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:20:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59350 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDUBUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 21:20:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35FF34BACC;
        Mon, 20 Apr 2020 21:20:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RHCIx9Iw/GA+4mS2/flU0nDKk0c=; b=NXbRWT
        q0+FfLzEqleCQVK23RUgY/5T/Ie7SnMSmDWwk+oS+DLe4SDLHTPJ+wXbff+x8tHm
        fAGRAk3xac/WZVCNncOzo4Vu2ald5wgJ3y9yOlHfd0kdLNpWvCoVzwd013j3WF0z
        bazFy13r89qJfwVtphkmB9S4Pe2u5FpRQn158=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lA4Ujxx9ZG8US4S1fts/ilWFmO4wAyEZ
        zuTTev5kqQv/HVMyawYHBwFxI3y5PiYh/Ej/6gdcpC9B8ymODmMbrhne2vyzNsWf
        OVP7v/a6ajVgU+KR8NU8Ga3daC/WFY1jZR088v/EjUTX3dB/i4BDX3zf4bjKV6dW
        aaH+EPoafKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 841A44BACA;
        Mon, 20 Apr 2020 21:20:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF49A4BAC8;
        Mon, 20 Apr 2020 21:20:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] doc: propose hooks managed by the config
References: <20191210023335.49987-1-emilyshaffer@google.com>
        <20200420235310.94493-1-emilyshaffer@google.com>
        <20200421002248.GC236872@google.com>
Date:   Mon, 20 Apr 2020 18:20:00 -0700
In-Reply-To: <20200421002248.GC236872@google.com> (Emily Shaffer's message of
        "Mon, 20 Apr 2020 17:22:48 -0700")
Message-ID: <xmqqh7xdprcv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39322938-836E-11EA-9E8A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Whoops, just realized this doesn't match the proposal below. Wrote these
> on different days :)

It often is a good idea to attempt writing anything in one sitting
for coherency, and proofread the result on a separate day before
sending it out ;-)
