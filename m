Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF1C07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B3961C9D
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGFT0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:26:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63359 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhGFT0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:26:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94F46C1203;
        Tue,  6 Jul 2021 15:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qu8F/nCWD055gtSnB7jI88/gaieAoJxyrbHtpz
        LG/qA=; b=mlJl0U7Hr6v3Z1yYDVEeZkdna9xoeqO0hS8UNPEJkyNW54OdWngdsv
        sEIy98uc3AWW4Zfao11uirhDVPAjIhcFqsmUo/lHQMoq/u0wIDMwjvBpknxmD/0V
        F85BChij17OLqF3mJMtu+47FrbBqstQngaX3zI+z56mGfPXUtnVKU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86465C1201;
        Tue,  6 Jul 2021 15:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61979C1200;
        Tue,  6 Jul 2021 15:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 1/3] test-lib-functions: introduce
 test_stdout_line_count
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <cover.1625362488.git.congdanhqx@gmail.com>
        <ab542ae9aa35decd2bc55561c5ba8f5653fa07a2.1625362489.git.congdanhqx@gmail.com>
        <CAPig+cRNw_RVx3CCXN-Usz0Jmi0iphDv2Vqg1cZFqa+QricuJw@mail.gmail.com>
Date:   Tue, 06 Jul 2021 12:24:05 -0700
In-Reply-To: <CAPig+cRNw_RVx3CCXN-Usz0Jmi0iphDv2Vqg1cZFqa+QricuJw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 4 Jul 2021 01:56:41 -0400")
Message-ID: <xmqqo8bfjley.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB0C3746-DE8F-11EB-9AAB-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A minor think-out-loud: I wonder if there would be value in deriving
> the name of the output file from the command being run (perhaps by
> using `tr` to translate oddball characters to underscore or to fold
> them out). This might or might not help someone debugging a test
> failure since there would be less chance of "$trashdir/output" being
> repeatedly clobbered.

Probably not.

The iterations of output that are clobbered are all from the passing
call to test_stdout_count_lines helper we made previously.

