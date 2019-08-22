Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B9D1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfHVUSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 16:18:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56862 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfHVUSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 16:18:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ABD5166F00;
        Thu, 22 Aug 2019 16:18:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RLtNU1c5mXq58W8os7fwqgGDW5Q=; b=sJm/tC2r/Gmt8IEZ6y2i
        XZ6RHtDQBCWzNhhimQIcCzt6yKH1nw3X1IiYrAFnBxmdHeG4asCulFOaxu+3qKI7
        atg2j+TxUKj3HQzLljZBXw3ikPZ8QtlW7HStwPexfdU/Z5eV36nsRLaO1Sv0yHQG
        K2+DVJdRiRESyke08SFkERo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=f8bQxyiLo1nwD38auGBPaSRK1PaB9f2jei3MVeIvWKsCqC
        WEKaeboLO5YC+Z1U8xGpeldYzOF8bs38EH2tVk/0kzQgZOsQ5d/KsvcACxNoRs6p
        wCCy15aCbl+qXs+t5Vvbi1XnGXTh2SLkB64iaj4iO+pVAOd2FXJq43kgNqlT0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 307B6166EFF;
        Thu, 22 Aug 2019 16:18:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91E72166EFE;
        Thu, 22 Aug 2019 16:18:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] format-patch: learn --infer-cover-subject option (also t4014 cleanup)
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
Date:   Thu, 22 Aug 2019 13:18:08 -0700
Message-ID: <xmqqsgptnedb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F58F1F1E-C519-11E9-B9DD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> While we're at it, perform some major cleanup of t4014 including some
> stylistic cleanup and also, unmasking of Git return codes.

Wow.  It seems that "while we're at it" grew quite large and (from
purely patch count's point of view) ends up appearing as if it were
the primary focus of the series ;-)

Thanks for tackling the age-old mess.  Admittedly, this particular
script is from the older parts of Git's history and a clean-up was
long overdue.

With the "split pipes" approach taken in patches 09 and 10, we'd end
up leaving more untracked and unignored cruft in the working tree. I
do not think they would cause problems with the existing tests after
reading the patches over.


