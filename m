Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE9AC433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CC164EF9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhCLXhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:37:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60652 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbhCLXg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:36:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C35AAFCAC;
        Fri, 12 Mar 2021 18:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Flx2oUHtm0rquXWNQdU6OV7vI0=; b=C+e9hQ
        eujkZASpvSblOY35/F+v2b4fhNTjSi4VS/vjnXD5ht5j/Jtc1CoAA9V8WoM/kWV/
        NMv8n2vusXIo97GSAs2X8hrP+qcjsso9TbhR7QxMXkZfQPTSa2GkMXIlrF03mTo5
        MTv1Mh5oveIxR0OqVIanfOPD0cwx2lgXxuf00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PIe5Tbr5a2gTQnIthj1/qBIacAccmBDw
        mTmONcOXB9lxf54HZSahVkXIKSiXAVftlNbWNdrwqRrox2fIlVr5kHcGCGk/Aw99
        /Y/do/BFtW9IMR+/Of2P2tgn1P0cJ/zWDIDCEnoVdqFN46KlcJ2OWQVpjprP0QJ2
        11IZMduva2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6321CAFCAB;
        Fri, 12 Mar 2021 18:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1C6DAFCA8;
        Fri, 12 Mar 2021 18:36:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH] mergetool: do not enable hideResolved by default
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
        <20210209200712.156540-2-seth@eseth.com> <YEbdj27CmjNKSWf4@google.com>
        <xmqqmtvbjuvl.fsf@gitster.g> <xmqqzgzafo5o.fsf@gitster.g>
        <xmqqlfas55mk.fsf@gitster.g> <YEv5d0pGvEVpepoY@google.com>
Date:   Fri, 12 Mar 2021 15:36:55 -0800
In-Reply-To: <YEv5d0pGvEVpepoY@google.com> (Jonathan Nieder's message of "Fri,
        12 Mar 2021 15:29:59 -0800")
Message-ID: <xmqqh7lg54h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4D64E96-838B-11EB-869A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Any progress here?
>
> Sorry for the delay.  I should be able to send out an improved log
> message (more concise and summarizing the supporting info from this
> thread) later this afternoon.

Thanks.  I think this is the last known regression in the -rc, and
an update before the final happens on coming Monday is very much
appreciated.
