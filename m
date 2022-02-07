Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9BEC4707E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiBHBFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiBGXka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:40:30 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09EC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:40:28 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BB0B17D134;
        Mon,  7 Feb 2022 18:40:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i79oKJadQjH7CnehnHbcONbcG3yu6OX+L32IPy
        KcH5s=; b=eI1j6sLqFnqVPpaSlObOxTHniIn9vEZcom8SwpLKgwd0GzT7Ge+FXY
        vDcsouczzo1gKZxalWvRAjUg6hEU1qP14QwSdb55OfyJS00awMAIJQVFyWqY4KHm
        CfqcGgEGHZvQHai4GWSRvJ/5D4U2YRZoF9jlWDfsa0S8OQZxOgth0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 546FC17D133;
        Mon,  7 Feb 2022 18:40:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B76E717D132;
        Mon,  7 Feb 2022 18:40:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
        <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
        <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
        <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
        <xmqqa6facn9i.fsf@gitster.g>
        <220201.861r0m9t8n.gmgdl@evledraar.gmail.com>
        <xmqqsft2b5jl.fsf@gitster.g>
        <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
        <xmqq4k5fr1mh.fsf@gitster.g>
        <CAFQ2z_Nb=wY_+B1ub0XDgZnvgCHGmFu1rjMuKgbFFir0=1PHtw@mail.gmail.com>
        <CAFQ2z_PE_ERoocVjUGCqcFxTDUy79PFbkCVh-y+At7KvXx8TtQ@mail.gmail.com>
Date:   Mon, 07 Feb 2022 15:40:24 -0800
In-Reply-To: <CAFQ2z_PE_ERoocVjUGCqcFxTDUy79PFbkCVh-y+At7KvXx8TtQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 7 Feb 2022 17:52:36 +0100")
Message-ID: <xmqq35kugs9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 530BBABA-886F-11EC-A9F7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> It also has less chances of creating complicated control flows
>> (especially in JGit which wasn't designed for this bit from the
>> start): the tables have to be written in lexicographic order, so you
>> only can write this bit after you know if reflog entries were written
>> for a certain ref.
>
> Correction. I wish the table blocks were written in lexicographic
> order, but they are written in order 'g', ['i',] 'o', ['i'], 'g',
> ['i']. Since the 'g' block is last within a table, we could add a new
> section at the end.  My point that this is considerable work to think
> through how to make this work with JGit still stands, though.

As long as a fake/NULL entry in the reflog is invisible to iterators
and does not count as part of numbered entries when reflog@{23}
notation is used, I think it is perfectly fine to take that
approach, instead of "separate bit".  I brought it up only as a
possible alternative (i.e. "if bit is on or any entry exists, we do
have log for the ref") in case ignoring the fake entry is impossible.

