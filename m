Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD09C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A99020776
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Imxkz0ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWUIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:08:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59786 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWUIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:08:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C3364C85D;
        Thu, 23 Apr 2020 16:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fk6a+Q2Jsm8Q
        1ZdZi6dVHuQxlhE=; b=Imxkz0efNMuAJ56pc+OHG4pwYm3a/xiXhkMAa69/ehUH
        1Xr2hqc0N1C2w3y4Tpkk5GXBkhFqN5qWCYKjG/vF7RrlsW77Ree1wtegD/U7WIRH
        orXNr3VmU8UYiKL4yDJ4/zUBmQtkmDnFFjtySOgy0CnAjofYEDhTcfwXJY7Y5Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a1dQ/V
        I2ml1YTPr+ZzRhb1mIn+Ir4+hSIUvlSiTX9JvDFJI3tPXfRHWDwr293sILxRYn2q
        BP5SVDuFawumZzUOpF3NVnNF0ylL2gpZcM6BxSrlFQovmVBYdSjjh3sY8OZ7ebNw
        CNrBLH3HftZMcqQnpndtUz+TTkZ430n9YxMcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 842794C85C;
        Thu, 23 Apr 2020 16:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F5474C85A;
        Thu, 23 Apr 2020 16:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/4] date.c: s/is_date/set_date/
References: <cover.1586856398.git.congdanhqx@gmail.com>
        <cover.1587644889.git.congdanhqx@gmail.com>
        <1fe69008fc79e6a74e8613011504bc7e342291ab.1587644889.git.congdanhqx@gmail.com>
Date:   Thu, 23 Apr 2020 13:08:39 -0700
In-Reply-To: <1fe69008fc79e6a74e8613011504bc7e342291ab.1587644889.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 23 Apr
 2020 20:52:38 +0700")
Message-ID: <xmqq5zdqge2g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 394B62F4-859E-11EA-AE72-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> The function is_date, confusingly also set tm_year. tm_mon, and tm_mday
> after validating input.
>
> Rename to set_date to reflect its real usage.

Yup, I think I can agree with the reasoning here.  It is a good
clean-up regardless of the remainder of the series.

