Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA44EC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B04206E9
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PHBysnq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgDCTx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:53:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55941 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgDCTx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:53:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92DFFB2DD6;
        Fri,  3 Apr 2020 15:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AyKVWW0w9xuze6qqPPP4gpO9Z2k=; b=PHBysn
        q6zk/hm9urW+rpgjtyxH8zLdcgPgBuu9Nfp6apNoqEU4NN/a7drMgSFs2ibFA5S4
        2iHmORs1J8bwsHb3m7pz3nLfhPWqhdTtbVwcaWIKfbPONCKhgVimLLHZN+tIpCCN
        7rgXtRRUo/sqvpFoFU1yYlEyqUcLQY7ZtNdh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SzfbtUPEhOsMIhdZ3zafQGncL3h3Opf0
        dujtpYu5IVxehVNS5OlC/SA7BoSHOZvvVUsQnkpY+uMFDUL8d+9uttp5bc6GVyMD
        boSKjqEqG4pJiPvFkpn+ur6pw9BDH5Hj109c9iNT6Xb1qlJWw+JmZ9ZUcOTsszmS
        o5xGRI7xcWU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89FB1B2DD4;
        Fri,  3 Apr 2020 15:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD59CB2DD3;
        Fri,  3 Apr 2020 15:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Josep Torra <n770galaxy@gmail.com>, git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
        <20200403185804.GA659704@coredump.intra.peff.net>
        <20200403193644.GA662633@coredump.intra.peff.net>
Date:   Fri, 03 Apr 2020 12:53:50 -0700
In-Reply-To: <20200403193644.GA662633@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 3 Apr 2020 15:36:44 -0400")
Message-ID: <xmqq8sjcz6pd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D79278B8-75E4-11EA-AB4B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I guess it's this:
>
>   https://code.launchpad.net/launchpad
>
> but I can't find any trace of the "Parameters must have values" error
> message in there. It looks like it builds on dulwich, but I can't find
> the message there either. So I'm at a loss.

Let me apologize in advance for a totally useless distraction, but
nevertheless I found it funny.  My search engine found

    https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19780010630.pdf

when I asked

    launchpad "parameters must have values"

https://www.google.com/search?q=launchpad+%22parameters+must+have+values%22

;-)
