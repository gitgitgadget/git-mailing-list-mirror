Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3D720229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935188AbcKJVdd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:33:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61014 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752611AbcKJVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:33:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9E7D4C005;
        Thu, 10 Nov 2016 16:33:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1jskbkO7MW5Qr3jcUi0BGhGUBWQ=; b=uBNxsf
        x5z14/USXvmAUafGn/PDR/k0Z8Ql/wIZKKfYvoF4KYEvaO+/UbifK+5WI5+JrSh4
        Z14NPSBzLz9bbKgoOm/Havo6+hYoda/noFaPUu462kQ0GfRE5OjQbY0cci77Q7cY
        M9AHrJTjtD7qo4X4hNUferklw/T8bo8TOSqa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mzKEkPAycAYN88v3IUATESsCM0EW1YPR
        c9qgVDmpDc+uIpo66+6zCMOdvBnu7uQPO3C5dSplST7yMpYSHTq6Z39spEyH8uYX
        0ua6qcfMBjtnL4llOtUttWSDIyEn72EbC2P5RIFR/tidkrkoNYqI3JZGIAhKrgCA
        z4Fduyw4IkQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0C0F4C003;
        Thu, 10 Nov 2016 16:33:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 561E54C002;
        Thu, 10 Nov 2016 16:33:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6g?= =?utf-8?Q?ershausen?= 
        <tboegi@web.de>, git <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
References: <20161017002550.88782-1-larsxschneider@gmail.com>
        <20161017002550.88782-3-larsxschneider@gmail.com>
        <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
        <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
        <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
        <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
Date:   Thu, 10 Nov 2016 13:33:29 -0800
In-Reply-To: <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Nov 2016 11:10:12 -0500")
Message-ID: <xmqq1syj6mvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5374453A-A78D-11E6-B38A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> IMHO, the value in the http tests is not testing the server side, but
> the client side. Without being able to set up a dummy HTTP server, we do
> not have any way to exercise the client side of git-over-http at all.
> And people on macOS _do_ use that. :)

Amen to that.

I however do not know what the universally available simplest dummy
HTTP server would be.  There probably are better alternative than
Apache with distro-customized ways of configuration that we have to
adjust.  

A solution around HTTP::Server::Simple sounds attractive but is it
a realistic alternative or too much effort required?  I dunno.
