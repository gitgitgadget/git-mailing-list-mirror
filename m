Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA174CE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 19:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjISToE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjISToC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 15:44:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C159C
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 12:43:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EAB4919B81F;
        Tue, 19 Sep 2023 15:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=fVdgmb1IlP/dtRXjqU0fL59em0PDCcfe80R7of
        dA+fI=; b=NnzjmuaeIdb6o4huarVTqWOrgv8ST1siIIwGQHwS2/N3iydSPvcBN6
        vvVLsOuJ4Ti4CUkwOpSaOhO0ANSHdZ7Y4iPfnhLbhseVlrKqdXwWVUWuTi3BHLcf
        qzTyxsVZLthDGG7AfHXc0rzz8H+DqmRtDTjAD40ebkpn5HdxABfZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E215219B81E;
        Tue, 19 Sep 2023 15:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55C1619B81C;
        Tue, 19 Sep 2023 15:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc:     git@vger.kernel.org,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Denton Liu" <liu.denton@gmail.com>, "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v4 1/1] range-diff: treat notes like `log`
In-Reply-To: <9f9610fa-f1cc-404a-9496-d8b77ca05d5b@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Tue, 19 Sep 2023 21:27:57 +0200")
References: <cover.1694383247.git.code@khaugsbakk.name>
        <cover.1695144790.git.code@khaugsbakk.name>
        <244e102cc4693bb6291e03cffea6df05cdb29df3.1695144790.git.code@khaugsbakk.name>
        <9f9610fa-f1cc-404a-9496-d8b77ca05d5b@app.fastmail.com>
Date:   Tue, 19 Sep 2023 12:43:55 -0700
Message-ID: <xmqqfs3aeyo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DED09B58-5724-11EE-857E-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> The original CI failed.[1] Then I rebased on `master` (d4a83d07b8c (The
> tenth batch, 2023-09-18)) which also failed.[2] Problem in t5559.
>
> So: fair warning. :)
>
> [1] https://github.com/LemmingAvalanche/git/actions/runs/6238806624
> [2] https://github.com/LemmingAvalanche/git/actions/runs/6239585493

I think you can ignore these macOS ones that spew

    == Info: [HTTP/2] [1] ...

in the log.  The adjustments necessary for the redaction code to
deal with these new messages from cURL are known and are cooking.
