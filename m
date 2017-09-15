Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D95420A21
	for <e@80x24.org>; Fri, 15 Sep 2017 05:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdIOFsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 01:48:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56500 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750787AbdIOFsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 01:48:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A0EDA23D8;
        Fri, 15 Sep 2017 01:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5WnlsxjStsERS5xzwcTC7rtVKf4=; b=SkDbzd
        q9rnwfUnwHrBU9OGFgCCp8MvClppvPhCc9tP4R+0h5Bl6J8Gymj1fffA6/cZY0oz
        BuombI7hu6fK7tjxFnuDFiqn+cVf9yWb/oCUO5IA9taajYbt4Kz9r1FHxB/N9A07
        faUyMuwqlAJuu2TaHC1kdvxAz4fDmaX7e05jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x0aoKIfPr7DKi144JyGdgW49oIrKf1E3
        ZGPiSVmyLubCNfqtNsdjx150/8Xf3V3EHilfZ6ha4Z1cLMo/ElusvG0Xs23pFKzn
        /WiWALOGHgewxzxLIfLom33Lu3uUopvHC11P/vwR4ZTkXfbaOReVPbt2sLIWMCKU
        bZ7ZbcEIyE8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92868A23D7;
        Fri, 15 Sep 2017 01:47:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C2DAA23D6;
        Fri, 15 Sep 2017 01:47:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gene Thomas <gene@nlc.co.nz>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git diff --name-status for deleted files
References: <PS1PR0601MB1883177814CA771567A7193B8A6F0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
        <xmqq1sn8zn1d.fsf@gitster.mtv.corp.google.com>
        <PS1PR0601MB188364D92388A08D1D62E7078A6C0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
Date:   Fri, 15 Sep 2017 14:47:57 +0900
In-Reply-To: <PS1PR0601MB188364D92388A08D1D62E7078A6C0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
        (Gene Thomas's message of "Fri, 15 Sep 2017 05:18:43 +0000")
Message-ID: <xmqqd16sy0ky.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E014F3A-99D9-11E7-823C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gene Thomas <gene@nlc.co.nz> writes:

> Junio,
>            Thanks for your reply. So git is essentially doing a
>            "git commit" when I "git rm".

No. You'd probably need to read a bit more on Git; unlike other
systems like CVS and SVN, where you only have two states
(i.e. committed contents vs files on the filesystem), we have three
states (i.e. the index in addition to the above two).

"git add file" and "git rm file" make the index match what's on the
filesystem wrt "file".  They never touch committed contents, which
"git commit" command is about.

