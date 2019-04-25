Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D951F462
	for <e@80x24.org>; Thu, 25 Apr 2019 02:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbfDYCgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 22:36:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53379 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbfDYCgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 22:36:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D138F14DBF2;
        Wed, 24 Apr 2019 22:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Jpnx6gndRCFcz8wS8XxMOCWlaU=; b=NXIIsB
        3ZA4W2+p3pG5nw3b+q5n0EaJnfbD2Ff5OSExlHbWU7blMAuZ7F8yAGyuOtwbZku4
        fCe/gRFqj9twEPRp/Qol91Kw2k6+ursyTvm2dNND+sSTGpMmp8vgpyiqZBelp0+u
        zau8pDCFPSDQsOGDPzNQ+bWFKE4IhkjE0LDYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hhD9gIl0/wR83u7sSM9eNpdFIekDmk97
        Hp9J44Gtor8h6liTsIZt5bdT83B//mC0ItfRBv3G5dJGd+7HFmneqlgVWQTZLoSh
        vgnhgE5yhYilB20juQKyvI9/t+usicNJ2x2z4CypTZf06ulEVu/E7NwNKt/q8yOt
        5yiQrwVVnqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8ED014DBF1;
        Wed, 24 Apr 2019 22:36:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2084214DBF0;
        Wed, 24 Apr 2019 22:36:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] mergetool: use get_merge_tool function
References: <cover.1556009181.git.liu.denton@gmail.com>
        <cover.1556142510.git.liu.denton@gmail.com>
        <ff83d25ff2d0b9585b52c7e28cd7b93292b5304d.1556142510.git.liu.denton@gmail.com>
Date:   Thu, 25 Apr 2019 11:36:01 +0900
In-Reply-To: <ff83d25ff2d0b9585b52c7e28cd7b93292b5304d.1556142510.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 24 Apr 2019 15:47:00 -0700")
Message-ID: <xmqqbm0uzu9a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDDF60C4-6702-11E9-86D4-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This change is not completely backwards compatible as there may be
> external users of git-mergetool--lib. However, only one user,
> git-diffall[1], was found from searching GitHub and Google. It seems
> very unlikely that there exists an external caller that would take into
> account the return code of `get_merge_tool` as it would always return 0
> before this change so this change probably does not affect any external
> users.

Sounds like a risk that is OK to accept, as it is easy enough to
reintroduce the middle layer function like you did in the previous
round when it becomes an issue.

Will queue; thanks.
