Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E7CA0EC3
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349108AbjIKVch (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbjIKRKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 13:10:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC8121
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 10:10:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48DDB2A209;
        Mon, 11 Sep 2023 13:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=k7sBPFWNUcjrwXMw1y+oePUQnSrrPrcGEiEK93
        PlKFs=; b=SH8JsKtEUvsuXj4TpckmMD7XRFYkfgpOLM/EUWrMWHRRpjNwVwv13a
        ZYuFFVxHL9mr47tf6GEmYxyS9RGN6/MLQyDO6LpkWg71om6RGLuLBle8BlgE+P6/
        LZY3uzIkaktQkREPYgnyWkpI5Bnxmfq+GrsPwBzXvYsttMteTC3uE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 40F332A208;
        Mon, 11 Sep 2023 13:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8F1E2A207;
        Mon, 11 Sep 2023 13:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 2/6] trailer: split process_input_file into separate
 pieces
In-Reply-To: <c00f4623d0b97cc8ed71ea018e6ecf6e21739b53.1694240177.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 09 Sep 2023 06:16:13
        +0000")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <c00f4623d0b97cc8ed71ea018e6ecf6e21739b53.1694240177.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Sep 2023 10:10:33 -0700
Message-ID: <xmqq7cowws8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EEDF97A-50C6-11EE-9290-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Currently, process_input_file does three things:
>
>     (1) parse the input string for trailers,
>     (2) print text before the trailers, and
>     (3) calculate the position of the input where the trailers end.
>
> Rename this function to parse_trailers(), and make it only do
> (1). The caller of this function, process_trailers, becomes responsible
> for (2) and (3). These items belong inside process_trailers because they
> are both concerned with printing the surrounding text around
> trailers (which is already one of the immediate concerns of
> process_trailers).

Nicely explained and the resulting code reads well.

Thanks.
