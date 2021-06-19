Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F23C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3172611CE
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhFSGwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:52:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62702 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhFSGw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 02:52:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F967CB43B;
        Sat, 19 Jun 2021 02:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GPrKBaPH2AoxVIcfSGip6C7JIAM/v/eCsROSCK
        9wus8=; b=sctnqKb4RHN/82fOanEgNXDZmK71IbvbixjD/DYYWCACReKPgoFD9F
        FDiWn8rrGGSXRfKziGfS2Xy8ks8rnEt0YbL342WadXxwokSA59u2Cpg3hkCoq765
        iuAB6oLHIC5WobwxC3Z1BQq5tSYTAZUZ3TqzsFSDKqZwlJ+9uZY/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25435CB436;
        Sat, 19 Jun 2021 02:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A1D72CB435;
        Sat, 19 Jun 2021 02:50:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/4] t: new helper test_line_count_cmd
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <20210619013035.26313-1-congdanhqx@gmail.com>
        <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com>
        <xmqqfsxel6oo.fsf@gitster.g>
        <CAPig+cQdDibt2K6jFKehaWyGdtb72pj7FQ9nGLJYEmqna3vf5w@mail.gmail.com>
Date:   Sat, 19 Jun 2021 15:50:17 +0900
In-Reply-To: <CAPig+cQdDibt2K6jFKehaWyGdtb72pj7FQ9nGLJYEmqna3vf5w@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 19 Jun 2021 02:26:01 -0400")
Message-ID: <xmqqy2b6jql2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B8F9ACA-D0CA-11EB-897E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Indeed, I have no problem seeing this as a new mode of
> test_line_count() triggered by an option. In fact, I suggested exactly
> that[1] when this idea first arose (except I named the option `-c`
> rather than `-e`, but the latter is fine). However, my suggestion was
> pretty much shot down[2] (and I don't entirely disagree with [2],
> which is why I didn't pursue the idea in [1]).

;-)  

Yeah, I still am skeptical that we'd gain much by hiding the
redirection to >actual behind the helper, so as I said in response
to the v2 series, I am fine without this new helper or an enhanced
test_line_count, but go with more use of test_must_be_empty etc.

