Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33638C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A44C20758
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qO4wPPu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390231AbgHQSDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:03:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50278 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390219AbgHQSDD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:03:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B3E8DA8C5;
        Mon, 17 Aug 2020 14:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vc4TsuRAKexFuJvr97jS8zLsXsI=; b=qO4wPP
        u3K2E5ERzNEo/7URqcqPjRWzera02Dox9Pz5U86kVqZKj8XSKCpU+dzGR834LfKt
        IhY9VTw795NohWEnpr++9f5Awp3iFYfNa5azi7ATCn78ebGU5hrkbfd8YweqIs7k
        Fxw0TzhIkgF6cerNXhNGVzuFpYV8W2S6Z17Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g/qg16d3A6oXghV6ThXzMHgw2x/wtotW
        drIwv9oegWLpXnjib2Ss9IRkdIOvil9CLfLBoFNqDrIarwnYLG4WVVT4Iqg5wbxs
        NNV/Uz9NUcU4MhSNcjv9fnpv7fgR2Ux72aS/4roSZaI5VWC6vy6oSmoz6+24IUtq
        cZlpf1spOK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7390ADA8C4;
        Mon, 17 Aug 2020 14:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE7CFDA8C2;
        Mon, 17 Aug 2020 14:02:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Optionally skip linking/copying the built-ins
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet>
Date:   Mon, 17 Aug 2020 11:02:51 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008170653440.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 17 Aug 2020 06:55:40 +0200 (CEST)")
Message-ID: <xmqqblj92lro.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEAE1DFC-E0B3-11EA-BCFF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This addresses https://github.com/gitgitgadget/git/issues/406
>
> Please note that this GitGitGadget run did not work as intended. The
> intention of https://github.com/gitgitgadget/gitgitgadget/pull/296 was to
> use the actual author in the `From:` headers of the sent emails, with
> GitGitGadget mentioned in the `Sender:` header, but apparently this did
> not work, and I will be reverting that PR for the time being.

It is close ;-) 

The author name is correctly on "From:" but not the address.

