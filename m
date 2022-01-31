Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28479C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 18:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357488AbiAaSze (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:55:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54941 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357853AbiAaSzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 13:55:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E33F811FCC9;
        Mon, 31 Jan 2022 13:55:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SJJNNNm1RCAP62nLyiYuXSWOlrZSGI1gER+H6V
        IkPQI=; b=lUXtZo4r+JTGqKjWNtfogi0gGKuNRAHJxT3a5gO1Hh+BDjjp+wmTOm
        WCrdc+JwBbZNUXOgGLJvIvEbxLyV9gsm0wt3l2fB9gpfovwTNyCMIUoGc+u9D27I
        8WHQMT4V+OYMzbLc2Zw0Lwr6ft8aOGKTj8wekhh6bkIJ7XY5N0jTc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA6A311FCC8;
        Mon, 31 Jan 2022 13:55:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 410E311FCC7;
        Mon, 31 Jan 2022 13:55:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V2] patch-id: fix scan_hunk_header on diffs with 1 line
 of before/after
References: <20220125221602.26557-1-jerry@skydio.com>
        <20220129024757.24763-1-jerry@skydio.com>
Date:   Mon, 31 Jan 2022 10:55:31 -0800
In-Reply-To: <20220129024757.24763-1-jerry@skydio.com> (Jerry Zhang's message
        of "Fri, 28 Jan 2022 18:47:57 -0800")
Message-ID: <xmqqleyvivks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DA49558-82C7-11EC-B4EE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Normally diffs will contain a hunk header of the format
> "@@ -2,2 +2,15 @@ code". However in certain situations git can
> omit the second comma separated value in either before or after
> line counts in the case where there is only one line.

No need to resend, but this is specific enough (i.e. ",1" is
omitted) and "in certain situations" makes it needlessly fuzzy,
making readers wonder if there are any other cases.  Also, this is
not "git can omit".  The "unified context" format output from any
"diff" command share this special case.

Otherwise looking very good.

Thanks for a fix.  Will queue.
