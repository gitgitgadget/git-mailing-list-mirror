Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A151F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfG3Ttm (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:49:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60449 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG3Ttm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:49:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 817EE165F0E;
        Tue, 30 Jul 2019 15:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=5u89lFcjIc3RUlVo2lryOQ3gQkc=; b=s9tZNqt
        lwLN+vOUDSahA2U6K6dUmcxcm7uYCT5pj3BVkudnGR66r3DylNez2n9BzWoV2Il8
        oEaLRwkz2BHys2F7Jd85wOCHzH8H1B5cdG2nIfzuaeO0R1w5m+ev46QFufsbv9YS
        c8C5Ci/iDwmsxYiXb9a7I1RXNhwBHRn/aUaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=shiFIepbKgGtYVXlQD9CKgBuFLYy4P/sm
        U/FJwkkjKd42r9fyCvNrS4DB3Jef1a7WpAb7Su3alJU3W0019FrxIZjrziADh48p
        qqB7JHl+Yg9AV41cqIQVbh7SMFG5GZ8XXEmjEUua8bZ2lVx8oIKIabTO/MSOJ6DT
        75g0crDQD0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79064165F0D;
        Tue, 30 Jul 2019 15:49:40 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4041165F0C;
        Tue, 30 Jul 2019 15:49:39 -0400 (EDT)
Date:   Tue, 30 Jul 2019 15:49:38 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190730194938.GZ4545@pobox.com>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 2B0E7366-B303-11E9-9A98-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[added Christian, SZEDER, and Jeff to Cc as author and
helpers on the newly-added t0016-oidmap]

Randall S. Becker wrote:
> A preview of the situation with testing 2.23.0.rc0 on
> NonStop is not great. We have had some new failures right
> off the bat on our NonStop platforms. This is a preview of
> what we find within the first bit of testing. The tests
> run a long time, so more to come.
> 
> t0016: oidmap
> 
> Subtest 6 had an ordering issue. We do not know whether
> the problem is the code or the test result not keeping up
> with the code changes.
>
> --- expect      2019-07-30 16:56:36 +0000
> +++ actual      2019-07-30 16:56:36 +0000
> @@ -1,6 +1,6 @@
>  NULL
>  NULL
>  NULL
> +7c7cd714e262561f73f3079dfca4e8724682ac21 3
>  139b20d8e6c5b496de61f033f642d0e3dbff528d 2
>  d79ce1670bdcb76e6d1da2ae095e890ccb326ae9 1
> -7c7cd714e262561f73f3079dfca4e8724682ac21 3

I hit the same failure while building for Fedora on the
s390x architecture.  I have not dug into it much yet, but
perhaps this is an endianess issue?

-- 
Todd
