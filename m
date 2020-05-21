Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C78C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426BC206F6
	for <git@archiver.kernel.org>; Thu, 21 May 2020 22:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Acu+OFiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgEUWI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 18:08:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58361 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgEUWI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 18:08:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B7E552946;
        Thu, 21 May 2020 18:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=61tx5VyoJGQlBMQcLRetTyoQvb8=; b=Acu+OF
        iyHUlhO4ABFRQGgcXpnKKXLBGCUxt6jYlsS9wAuD4banvTq0cuC6YIwjxwSSC1nP
        j3O89hY8AW0kyEOfIN+Z1dh8v5u47+X/aYg9WNAonpuGwRb1WXRl8p0ho4ujr2lG
        0e+pTwJfZXiznabKiv7VmEhHMJk/tSPep2azQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WlfssyBrL9v3CxAZvt1DrtWjv3aEBOd0
        GPwwDwNCjjec+WasWi738AEAzSAVx1uRcHt3ISFgn/4FDMINsjf4lLyVHdUQtnas
        X7kCPaJCHS7SCF71AxS4wAD4S1aPchjLiYRvsD7ScVAnVzorD8j4kBL+IfjS/Lrt
        a9Q8KDu7ia8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 034E952945;
        Thu, 21 May 2020 18:08:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B7AB52944;
        Thu, 21 May 2020 18:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] sparse: allow '{ 0 }' to be used without warnings
References: <20200521214544.8784-1-luc.vanoostenryck@gmail.com>
        <CAPig+cQsYSE30ab9qQO7V+CzAdUodpw64sCnZH+1s3oD-P6msg@mail.gmail.com>
Date:   Thu, 21 May 2020 15:08:25 -0700
In-Reply-To: <CAPig+cQsYSE30ab9qQO7V+CzAdUodpw64sCnZH+1s3oD-P6msg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 21 May 2020 17:50:28 -0400")
Message-ID: <xmqq4ks9rleu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9850C614-9BAF-11EA-8699-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Do you have a reference to the commit or Sparse release notes which
> mention this new option? It might be nice to include it here in the
> commit message. Also, should this minimum Sparse version be mentioned
> somewhere in documentation so that people invoking the "sparse"
> makefile target aren't greeted with an error about
> -Wno-universal-initializer being an unrecognized option (assuming that
> older Sparse would complain about it)?

Both sensible considerations.  Thanks for bringing them up.

>
>> [1] https://lore.kernel.org/r/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com
>> [2] https://lore.kernel.org/r/xmqqd07xem9l.fsf@gitster.c.googlers.com
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
