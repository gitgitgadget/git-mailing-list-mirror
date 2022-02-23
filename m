Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC7AC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 22:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiBWWQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBWWQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 17:16:44 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED635047F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 14:16:16 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B7BA10392B;
        Wed, 23 Feb 2022 17:16:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HNUGNzjKYmlq
        YSYFZjdVSZ1molTBH+xRKy1Z764fec0=; b=gXSdg+15BGZNYCdVbNo2Pr5K8j9+
        24/sbMkZuwWt3fnIZfyJryf7uZ5u5Bk/YG9w4tXLM0Xi/H4jBXpEnxhCin6XyIDT
        d5/aqVSCR/h0PtyorrQRXLLVceIugAJBbzXRBXfp25ZL1vC9XBi6JynxKGfO50sA
        zmQZ1CMbbI9PrCk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72CE710392A;
        Wed, 23 Feb 2022 17:16:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4438103929;
        Wed, 23 Feb 2022 17:16:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 7/9] help: error if [-a|-g|-c] and [-i|-m|-w] are
 combined
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
        <patch-v2-7.9-992ee6580ac-20220221T193708Z-avarab@gmail.com>
Date:   Wed, 23 Feb 2022 14:16:13 -0800
In-Reply-To: <patch-v2-7.9-992ee6580ac-20220221T193708Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Feb
 2022 20:38:50
        +0100")
Message-ID: <xmqqv8x5qlea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3718BA22-94F6-11EC-A675-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add more sanity checking to "git help" usage by erroring out if these
> man viewer options are combined with incompatible command-modes that
> will never use these documentation viewers.
>
> This continues the work started in d35d03cf93e (help: simplify by
> moving to OPT_CMDMODE(), 2021-09-22) of adding more sanity checking to
> "git help". Doing this allows us to clarify the "SYNOPSIS" in the
> documentation, and the "git help -h" output.

While this is not wrong per-se, "git help --all --web" in the
future that pops the same information up in your running browser
would not be a bad thing to have.

That use of --web is certainly not in line with --man and --info,
though (at that point we'd be saying "show in browser or show in
terminal").

So I guess this is OK at least for now.
