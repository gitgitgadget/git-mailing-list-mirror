Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18621F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKOF0i (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:26:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60696 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOF0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:26:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58F5B8F7FA;
        Fri, 15 Nov 2019 00:26:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w4F8njR8twHIoipsg8kZyPbDNiQ=; b=N4nQGB
        apChQRZmvJVvQ5iTRk7n/KLqQ0yx9u6pyL9W9uJ7oEvdhqSyogYst9lVk2GrHCbp
        7f8X8CQcWCeIOU0s4dwtv6R1F8z9znM6I4KjOP22HSSsJOhX6dGVikubtazOH4IX
        9CeOLp25cGreo5kztMEYcyPSXgWcRq4+E4O70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dl41XwNaYvYmrfYitR3D4reoYm1mD+st
        K3u4G4Uyd7OkTCvRV6ayte4fSDRjGIx1GBZ4BmGsZYCgF1AsWiJ3txaLkxRw/S8J
        BrMf706ahbK62Wkt7P4T18F6/LwpyoVmQxd0KqHRGdh3PUiDxuQOHgYNc1Fd8sHo
        pNN+h4ytCI4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4491B8F7F9;
        Fri, 15 Nov 2019 00:26:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43F428F7F8;
        Fri, 15 Nov 2019 00:26:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 21/27] t: define test_grep_return_success()
References: <cover.1573779465.git.liu.denton@gmail.com>
        <3f79d23b40c0586d0351f4d721097be4f7ba26b8.1573779465.git.liu.denton@gmail.com>
Date:   Fri, 15 Nov 2019 14:26:31 +0900
In-Reply-To: <3f79d23b40c0586d0351f4d721097be4f7ba26b8.1573779465.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 14 Nov 2019 17:01:19 -0800")
Message-ID: <xmqq1ru990c8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C60EA46-0768-11EA-8714-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +# Calls grep but returns zero even if no matching lines are found.
> +test_grep_return_success () {
> +	grep "$@" || :
> +}

It makes sense to have a helper like this, but the name is quite a
mouthful.  I wonder if we can call it with a shorter name, e.g.
"test_filter" or something.

