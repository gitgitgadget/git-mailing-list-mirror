Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1EA2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbdCURyK (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:54:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932676AbdCURxh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:53:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30C3B6E5F1;
        Tue, 21 Mar 2017 13:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NeNaLxFIP1CxgjrDdA3ylVtBpQo=; b=onrAI6
        9FZrFbfSocLiPhAuXK9f/6jR44eZmrN1AFjvTprtsrIo2hc/gbGHxjpRCJ/VPLZk
        /Gf+xMWU8LvWAm2gnL4BWrfJXcfb51xPA63xuJIpCFWHejvUac+w4USIKJl1d3Sm
        /s8h4CHqveE+qFmkRgCoOEqorsowZU4GA5bDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fGC4stfGNlpF0LTgYoDIei4GIVGNiB5A
        O1xnPOVfiheo0DN72YNzOcC4/xDXY3fEAiUx1VZIKlMzMXGHdNcHUg/wbPMTfuxk
        DDQxKEsSHauNtU0ASQTv/JBwwXIDa7lcB1sjR7ugQOF5zujOXhU6p7HVC05aSdmA
        oLULR7Me1no=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 280CC6E5F0;
        Tue, 21 Mar 2017 13:53:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FA026E5EF;
        Tue, 21 Mar 2017 13:53:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] prefix_filename cleanups
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Date:   Tue, 21 Mar 2017 10:53:33 -0700
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Mar 2017 21:18:38 -0400")
Message-ID: <xmqq4lymsehu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E32DFF8-0E5F-11E7-922D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I noticed a spot in builtin/bundle.c that would benefit from using
> prefix_filename(). But when I tried to use it, I noticed its interface
> was a little error-prone (because it returns a static buffer). And
> indeed, a little digging found a bug in hash-object related to this.
>
> So here's the fix for the hash-object bug, some cleanups to make such
> bugs less likely, and then finally the bundle conversion. The bundle
> thing does fix some minor bugs. It _could_ come before the cleanups if
> we wanted to float the fixes to the top, but the function is much more
> pleasant to call after the cleanups. :)

Thanks.  They all looked sensible.
