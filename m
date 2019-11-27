Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC93DC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 01:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727302068E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 01:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N319XI0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfK0Bwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:52:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51932 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfK0Bwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 20:52:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F1FA92C54;
        Tue, 26 Nov 2019 20:52:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bozZis56KkP5x48ksqyuBgzv28w=; b=N319XI
        0Mpn4xHMAqrobzMc4Qy9kLH6P1UckaSOykYcG24T58DnCUMT6itXjA25+gMasxHI
        uG0gYqBKvBvPQ4fGXwJ380VBn/KXHaDPAy5aHh/Gpx1r9EJgOMLF/LelUJdxRIVf
        QEmkSua/7D3r2rN/ySlufleYlh0Cz4Gfp1aBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hWGpMy/u5HWDTSzBbBOdkXgFuc3MrDWP
        0PxteaV/m28ebnTZwb6vsYOBguL92pyvPc8TegBUqZxFmVjE1x0T2++QqY67T0Um
        dCGfdYTVYB7XL/36LP4kZGbRdbK0DY23IFVgLZO1WvVj6L1YTVNpupISZFbrLGK5
        ra0EhiVUfXA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 081D992C53;
        Tue, 26 Nov 2019 20:52:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FA5192BEC;
        Tue, 26 Nov 2019 20:52:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on git/git?
References: <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet>
        <20191113011020.GB20431@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
        <20191114074117.GB17186@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet>
        <20191121105414.GA16238@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
        <20191125143023.GF494@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
        <20191126215648.GA18872@dcvr>
Date:   Wed, 27 Nov 2019 10:52:27 +0900
In-Reply-To: <20191126215648.GA18872@dcvr> (Eric Wong's message of "Tue, 26
        Nov 2019 21:56:48 +0000")
Message-ID: <xmqqa78iw0f8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 924312D6-10B8-11EA-9297-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> (and I'm not going to pay extortionist .org fees to keep
>  public-inbox.org when it comes up for renewal in 2023,
>  maybe everyone can use Tor .onions by then :> )

Just on this tangent.  Would you be willing to keep the domain and
keep the service running, if Git Project Leadership Committee pays
the fee out of the funds we keep at Software Freedom Conservancy?
