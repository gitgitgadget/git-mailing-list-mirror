Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD651C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 15:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353123AbiFUPth (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350791AbiFUPtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 11:49:33 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A052CE17
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 08:49:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 474CB198094;
        Tue, 21 Jun 2022 11:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HZgcD4/4FjRngpQsg/YzvdOHpmpzURs2OMnas3
        3zgPE=; b=KM4HO+Q9kR+rW2KRlCKUchxEBttVrzPLBAzK+BPcFcA6t7/ChEZizO
        IMnh9os/F7lu84jnU08IbUbjcNB485r5b4KZGo+huieamoQUnKN6psPL3DFCFBbk
        KFq+8Jk2z+VbDmuouXuYLiAQ2i+TxriBJOrKq3C03jvWshu7MKFB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40220198093;
        Tue, 21 Jun 2022 11:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1D06198091;
        Tue, 21 Jun 2022 11:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dennis van Gerwen <dvg@xs4all.nl>, git@vger.kernel.org
Subject: Re: Feature Request: Custom split location for `git add --patch`
References: <da79cc66-42a0-2563-d09b-fbc0ad5b28bd@xs4all.nl>
        <nycvar.QRO.7.76.6.2206181359400.349@tvgsbejvaqbjf.bet>
Date:   Tue, 21 Jun 2022 08:49:26 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206181359400.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 18 Jun 2022 15:01:06 +0200 (CEST)")
Message-ID: <xmqq4k0ej9tl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB6C71DA-F179-11EC-A2A4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Dennis,
>
> On Thu, 16 Jun 2022, Dennis van Gerwen wrote:
>
> ...
> Note how the `-` line became a context line? It _has_ to be, otherwise the
> second hunk could not be applied as-is. That is, until the first hunk has
> been applied. In which case the second hunk needs to be modified:
>
> 	-- snip --
> 	@@
> 	 All journeys start with a first step.
>
> 	+Actually, some journeys, some interesting ones, end in a disaster
> 	+right at the start, because the first step was skipped.
>
> 	 And this concludes the chapter. Good night.
> 	-- snap --
>
> Now the `[tbd]` line in the context has vanished.
>
> This is really an important concept to keep in mind: if you split at
> context lines, your hunks can remain immutable. If you want to split
> elsewhere, after one of the hunks resulting from said split is a applied,
> you have to recompute the other hunk.

Good write-up.
