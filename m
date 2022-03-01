Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A86BC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiCAUcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiCAUcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:32:12 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179C47AD6
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:30:27 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C4BD1134B5;
        Tue,  1 Mar 2022 15:30:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IkCAaK2aw0K9
        TGJnnsK+VN5MnHy2V7+3sW1Cin1PSao=; b=bJveMXuew5hDA1g6C/QzGO3mjuux
        Ko1ODABv+B2/ZWliCN6MzICVdkYo62nIBnRr9k4OhKuC6A5hB4SnCVfa3eFqFnJ3
        Vjmb17owWmQDD+qZ66ZjZBm/iZ229C4J4kT5gmTHkTe/48F45Q8RCBaAY8PnslN3
        k3ukbc0xox8pjYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01A281134B4;
        Tue,  1 Mar 2022 15:30:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3ECEF1134B3;
        Tue,  1 Mar 2022 15:30:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        avarab@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 3/5] commit-graph: fix ordering bug in generation
 numbers
References: <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
        <pull.1163.v3.git.1646164112.gitgitgadget@gmail.com>
        <562341b76b30ff3cdc01cea4cda550a7b8165bdd.1646164112.git.gitgitgadget@gmail.com>
        <xmqqmti9ph26.fsf@gitster.g>
Date:   Tue, 01 Mar 2022 12:30:24 -0800
In-Reply-To: <xmqqmti9ph26.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        01 Mar 2022 12:13:21 -0800")
Message-ID: <xmqqbkyppg9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6CE9912E-999E-11EC-A609-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Create a new t5328-commit-graph-64-bit-time.sh test script to handle
>> special cases of testing 64-bit timestampes. This helps demonstrate th=
is
>> bug in more cases. It still won't hit all potential cases until the ne=
xt
>> change, which reenables reading generation numbers. Use the skip_all
>> trick from 0a2bfccb9c8 (t0051: use "skip_all" under !MINGW in
>> single-test file, 2022-02-04) to make the output clean when run on a
>> 32-bit system.
>>
>> Hepled-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> I can typofix this one locally if needed.

What I meant was s/timestampes/timestamps/ and s/Hepled/Helped/.
