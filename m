Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB43CC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C6622525
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="blN+KyL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfLERcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:32:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53831 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 12:32:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51EFC97C81;
        Thu,  5 Dec 2019 12:32:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2G+c7DF9s//TIwKgHkpKW/6qGT0=; b=blN+Ky
        L8wAL7qUtZ95yPC6qbGAVxG+nmlVjbzV/rJmXO87aqw4wi4gfPBxBvbeXH4eG3s5
        G1CCg3yG9AHevtc7FdmfeJrK227Jq7Xsy6VKwWpSoN8jc1r/W/yAlZl14Rvsgjrg
        q1teGh520sL+jmWUMMS0Nx2Zicn4lZoqf4uGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TGkF4sZrXuHpuk3hCCptrVLSjZMK0ULS
        El7wQa+a9nKcA5VlRWN8vnlU1MI+0zMMDtwhcvHl1aWf+1Uz2qg9WRZZsYLYb+Bo
        jQOA+kDJZcKq5cZWR8vklvIrBCSlRiKpoLbJHImBg4+nB//Llzkd/D9PFD3afK0B
        h4a0doSQJko=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49B5097C80;
        Thu,  5 Dec 2019 12:32:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5269997C7E;
        Thu,  5 Dec 2019 12:32:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathaniel Manista <nathaniel@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [ISSUE] Stop accessing, storing, and sharing the user's time zone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
Date:   Thu, 05 Dec 2019 09:31:59 -0800
In-Reply-To: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        (Nathaniel Manista's message of "Thu, 5 Dec 2019 18:14:04 +0100")
Message-ID: <xmqq1rti1xww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25626BAC-1785-11EA-B5BC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathaniel Manista <nathaniel@google.com> writes:

> Authoring and sharing a commit by default exposes the user's time zone.

s/exposes/stores/ and that is a feature.  You are free to run 

    $ TZ=GMT git commit

if you wanted to opt out of the feature, but this has been the
default since day one and people expect Git to behave this way.

