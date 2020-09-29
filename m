Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EFC4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5A920757
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xBAL/nCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgI2VVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:21:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56936 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgI2VVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 17:21:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E52E187AB6;
        Tue, 29 Sep 2020 17:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z3KS4v6p5nHL9PtucM9s7qzC7sQ=; b=xBAL/n
        CrYfafrKRUQl9gEZq/3mVB07Jo/9D4Kp93vCFIBdkE+ffTbTINm/7iIF/gCDOKYG
        EY0zSghTvo59lDVSjYorfft5dBiWexR7S0/Z1GZsPQm7+Mzm+JIFrxTTv3rvHMbd
        PrciG9ByoPl3XFkLoYAT1cuYDk0VyrJ+WyOss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H/460LWUCBGgAKmMdaYhMl3nvllSv52h
        Ww+FmGFmXAdi2yLkybmnkl720JmcDt77kep3W3CCXD0ZYCrSDWP1fkyKxRvrR0OI
        3LYCId2Sf6C0+r9AyJeUPrDtyppnQ1Ec336e1j8NYpF68zGfhlN0FODIfMQQKr3G
        ClrZziqBRbA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A674887AB5;
        Tue, 29 Sep 2020 17:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E879387AB4;
        Tue, 29 Sep 2020 17:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/1] refspec: add support for negative refspecs
References: <20200925210740.1939450-1-jacob.e.keller@intel.com>
        <20200925210740.1939450-2-jacob.e.keller@intel.com>
Date:   Tue, 29 Sep 2020 14:21:05 -0700
In-Reply-To: <20200925210740.1939450-2-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 25 Sep 2020 14:07:40 -0700")
Message-ID: <xmqq1riki8ji.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B00A1958-0299-11EB-B4F8-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Refspecs today are commutative, meaning that order doesn't expressly
> matter. Rather than forcing an implied order, negative refspecs will
> always be applied last. That is, in order to match, a ref must match at
> least one positive refspec, and match none of the negative refspecs.
> This is similar to how negative pathspecs work.

Looked sensible.  Let's move this forward.

