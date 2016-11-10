Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8DA20229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965150AbcKJVt4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:49:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58945 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932341AbcKJVt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 16:49:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 031A34C23C;
        Thu, 10 Nov 2016 16:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W/D7f1Z5MJp/iamIUoXZcIC2HyA=; b=dxxcSv
        V6AqmFHtO41OeYfgnBzoNCD163kxHgtq6JS0hRHsgd/cNlxYDKRAVwLKyCog9L7C
        /eBR+iVBI/oeV66bNF2frujrcXT/RGmhszBplMQm9b1mlTJEGzFy/bKQf0ghPMru
        huPjHJkPMjxeWLWW37cA6H0Lln8OBfBzoor+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jjxyGus9X+x1DuhYUmGlMOiDWSa+4pnX
        NhNRRTfTdP/E3md0bY+0Djs7hXtznWYqJctilRh6ZzwFezf0A/53+oa1+Ll3Vgdr
        Pf8m8neMOS9H3tWmIdxKEul1YDiW14FbGR2LJ5ZxqobpAObbswIzsfewb1pH0TBo
        9OAoTxVDvXg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE2624C23B;
        Thu, 10 Nov 2016 16:49:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 717654C23A;
        Thu, 10 Nov 2016 16:49:54 -0500 (EST)
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
        <xmqq1syj6mvq.fsf@gitster.mtv.corp.google.com>
        <20161110214345.cau5i4eybqdv74k3@sigill.intra.peff.net>
Date:   Thu, 10 Nov 2016 13:49:52 -0800
In-Reply-To: <20161110214345.cau5i4eybqdv74k3@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Nov 2016 16:43:45 -0500")
Message-ID: <xmqqk2cb57jz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D6E48F0-A78F-11E6-AA79-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I however do not know what the universally available simplest dummy
>> HTTP server would be.  There probably are better alternative than
>> Apache with distro-customized ways of configuration that we have to
>> adjust.  
>> 
>> A solution around HTTP::Server::Simple sounds attractive but is it
>> a realistic alternative or too much effort required?  I dunno.
>
> I'm less concerned about the amount of effort (though I agree it may be
> a blocker) than about the fact that it may not behave similarly to real
> servers.

I was wondering if it takes too much effort to make it behave
similarly to real servers, so I guess we are on the same page.  

Yes, I recall the IIS one raised and discussed at least twice on the
list in the past, and it sounded that we want some solution to that.

>   3. What happens when you ask for "foo.git/info/refs" and "foo.git" is
>      a bundle file (Apache gives you a 404, lighttpd serves the bundle).

That's a bad one.  Do we want a client-side "I am connecting to a
site that knows how to talk smart-http" option or something to work
it around?
