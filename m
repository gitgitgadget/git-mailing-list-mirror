Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 07:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiCDHjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 02:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiCDHjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 02:39:43 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF681107A89
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 23:38:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0C7710B6A8;
        Fri,  4 Mar 2022 02:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xBMSRRBV4zspPEKPwwPyKiqejPNDyLWzVg0UIh
        vfXvI=; b=BeLEskG1AZpj94bQRiK1DAj+zgY/tNK0PLVxZ3Qf7LJc6jlTvvkDuL
        nBjhefwB/iD9WfxAdxKIx+ru6QZiU7Y/9pOP3e+eEgeHAKWgY5pzpuUOyVj0a2n5
        bz+9NMnzlKDvhZzCsOZdqO9+/5fnAAqAKLigAyztWqdCbt4RIdcDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9729910B6A7;
        Fri,  4 Mar 2022 02:38:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C2AB10B6A6;
        Fri,  4 Mar 2022 02:38:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: win+VS environment has "cut" but not "paste"?
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g>
Date:   Thu, 03 Mar 2022 23:38:51 -0800
In-Reply-To: <xmqqv8x2dd7j.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        25 Feb 2022 10:16:00 -0800")
Message-ID: <xmqqee3i2mlw.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2399EB62-9B8E-11EC-9245-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub CI seems to fail due to lack of "paste" for win+VS job.  This
was somewhat unexpected, as our test scripts seem to make liberal
use of "cut" that goes together with it.

    https://github.com/git/git/runs/5415486631?check_suite_focus=true#step:5:6199

The particular failure at the URL comes from the use of "paste" in
5ea4f3a5 (name-rev: use generation numbers if available,
2022-02-28), but it hardly is the first use of the command.  There
is one use of it in t/aggregate-results.sh in 'master/main' already.

We could rewrite the tests that use "paste" but looking at the use
of the tool in the test (and the aggregate thing), rewriting them
due to lack of a tool, whose source should be freely available from
where "cut" was taken from, does not sound like too attractive a
direction to go in, but I do not know how much work is involved in
adding it (and in general, any basic tool with similar complexity
that we may find missing in the future) to the win+VS environment.

Thoughts?

Thanks.


