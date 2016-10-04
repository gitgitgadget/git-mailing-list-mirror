Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B221F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbcJDVmz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:42:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59206 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750873AbcJDVmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:42:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E51D4369F;
        Tue,  4 Oct 2016 17:42:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mji5+AycqEX7KtLHHgMT4Zf3UrM=; b=gc1PEp
        FWz2lU6JpjDKaUv4Q8RM542PlKpo1uUE5aLBkkC5RH4TdEwJmDSXyc5NXRSMj4oJ
        woUDaU9+2Kt33lk+mJ1kUEq44zk6X1NAJvxnFMBYnKqGPNuV8tJVZ7PS5QrPbYtq
        DkO5DbvMR+h+EhPbVjpGkC8rDLCsZZqBxsXfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D/LE2KmwiHBbvnWQjArzgES+QsGTIpmx
        wg60Zw3oCdtwyMFJqkfsnBYX/82p4QpB+ahJ6HDJC40VfWTevfhvpysSq40F19VI
        MkdaoWpecHnDUdGU6oNSCPy72SoO4Y4/5uepblGCcNPBubQW9vxv301ZdhrjokLg
        pQUBCSJQLx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 054224369E;
        Tue,  4 Oct 2016 17:42:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 755624369D;
        Tue,  4 Oct 2016 17:42:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 18/18] alternates: use fspathcmp to detect duplicates
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
        <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 14:42:51 -0700
In-Reply-To: <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 16:36:26 -0400")
Message-ID: <xmqqfuobssdg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81388820-8A7B-11E6-A360-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... but until recently we couldn't use it for comparing against
> other alternates (because their paths were not
> NUL-terminated strings).

;-)  

I should have expected this when reading the "let's have
a separate .path field" conversion.  Nice job.

