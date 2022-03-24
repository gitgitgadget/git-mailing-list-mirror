Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3289C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbiCXRph (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbiCXRph (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:45:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947863C1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:44:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE3F918FAF6;
        Thu, 24 Mar 2022 13:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bOp72RfUi16KfPjePvE5AHWiyLYCcoTnM/xlSg
        uo8ak=; b=l6sBmsctElCEzqkxWl/qOmkfilR4I1zmY78nhwIWDx+3JmnOQpC+Vu
        e5vBb/faL2QVlV7YmtIzBtjG43t7eps9EmvgSeIUrW2WjfUA0e9wecjGEOuNpeNN
        AgA1qI7TQiyyCbYLOOt/7X2WKjdZD+662MvGOo/d3dc5RnvBrJ+mA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A736D18FAF5;
        Thu, 24 Mar 2022 13:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1632818FAF3;
        Thu, 24 Mar 2022 13:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 00/11] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 10:44:00 -0700
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com> (Neeraj
        K. Singh via GitGitGadget's message of "Thu, 24 Mar 2022 04:58:15
        +0000")
Message-ID: <xmqqo81vi6u7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD62C4F2-AB99-11EC-85DD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> V3 changes:
>
>  * Rebrand plug/unplug-bulk-checkin to "begin_odb_transaction" and
>    "end_odb_transaction"

OK.  Makes me wonder (not "object", more appropriate verb than
"object" being "be curious") how well "odb-transaction" meshes with
mechanisms to ensure that the bits hit the disk platter to protect
things outside the odb that you may or may not be covering in this
series (e.g. the index file, the refs, the working tree files).

> This work is based on 'seen' at . It's dependent on ns/core-fsyncmethod.

"at ."???

