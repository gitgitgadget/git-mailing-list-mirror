Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523BF20437
	for <e@80x24.org>; Fri, 13 Oct 2017 12:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758081AbdJMME7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 08:04:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757670AbdJMME5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 08:04:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B238AFF8A;
        Fri, 13 Oct 2017 08:04:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HdWxjAg5aJoOQ8vckZwrsNlEKY8=; b=Crkt6N
        yFzyuNf3ittbwZFQwaKKP705Lhz9hYeYtWkDJ7O7fYpZrP6sN4xyKuI/exVMTMx3
        Ff793GmbceLk1bsycGZJOyX90Ruon5NsJjIDxwvh6hmsV8uGuiVcYXGgTytAuQj8
        SiQu5RjMV1GSc3LbSKgnIiMl05lKPeYhPCcu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i6AY+GVVxbBDQ3gvAVPGxb40k9kOoCOw
        5T/2XU5FT2ACvI5UtLkDciBNXuDKRS1lI81U+dDbjNKS9SpER1fVbyl8szsOOkmN
        ZIzaC+exWbWH/Wmf5T6VVtQT1Q+CtPDjgXfj6/X9MvpvWROsOUN61q7VmzGJqWEh
        3nE4+vzPC9k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32504AFF89;
        Fri, 13 Oct 2017 08:04:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D9BEAFF87;
        Fri, 13 Oct 2017 08:04:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, Constantine <hi-angel@yandex.ru>,
        git <git@vger.kernel.org>
Subject: Re: git-clone causes out of memory
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
        <20171013100603.5eed26sjjigph2il@glandium.org>
        <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
        <20171013103722.rvr7536mu2hoo4wb@glandium.org>
        <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
Date:   Fri, 13 Oct 2017 21:04:55 +0900
In-Reply-To: <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
        (Christian Couder's message of "Fri, 13 Oct 2017 12:44:52 +0200")
Message-ID: <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAADB36E-B00E-11E7-A492-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, but perhaps Git could be smarter when rev-listing too and avoid
> processing files or directories it has already seen?

Aren't you suggesting to optimize for a wrong case?
