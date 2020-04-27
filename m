Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0474FC4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC97E2070B
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pYBFIE2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgD0VlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:41:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50312 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgD0VlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 17:41:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 248195CFEC;
        Mon, 27 Apr 2020 17:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BEvnjxpPMNRYLTqsnDnua8Al9kA=; b=pYBFIE
        2UTcm+27fMO8CCapIymGC74Kcvd0ZZLCEwNl3MJzeTBOjOlNWzYK4fmNAxe71C9q
        6mcJ3sWDdYFLc+t53TP7BKkk8/JlS/clkw6cdf/lsq6kj9eA+6tAgu2ewRnikmzO
        nTiP/xslD9KCkfCx0GwgYrB57mAmkRhItj12A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WyaX8mgaep2QtK9krzpIkYREjW4HHGLT
        bxv270DOw5gQ2XzN+w5vb96hp7pffCjMo/O5Z93RNcisseC0hkQaZJc6i0VHKYfO
        0XV85KQ1dFlz/BPWfSoCjuS2YfsNO52rzIYCU7tK5gXUKrb6FqIuXgVJ9DXQj9Rf
        ePX3zrN3LnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C8895CFEB;
        Mon, 27 Apr 2020 17:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D9BC5CFEA;
        Mon, 27 Apr 2020 17:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: drop time.h include
References: <20200425003002.GC17217@google.com>
        <20200427204859.171084-1-emilyshaffer@google.com>
        <20200427210311.GB36078@google.com>
        <xmqqh7x47har.fsf@gitster.c.googlers.com>
Date:   Mon, 27 Apr 2020 14:41:12 -0700
In-Reply-To: <xmqqh7x47har.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 27 Apr 2020 14:25:00 -0700")
Message-ID: <xmqqd07s7gjr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D11A0B10-88CF-11EA-AA0F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Emily Shaffer wrote:
>>
>>> As pointed out in
>>> https://lore.kernel.org/git/20200425003002.GC17217@google.com,
>>
>> This breadcrumb shouldn't be needed, since the rest of the commit
>> message already speaks for itself.  We can save the future "git log"
>> reader some time by leaing it out.
>
> True.

Well, removing these two lines made the rest non-sentence, so I had
to rewrite the thing.  I am not sure if the educational value warrants
the mention of compat/ exemption, but it people find it too noisy,
it can certainly be dropped.

Thanks.

-- >8 --
From: Emily Shaffer <emilyshaffer@google.com>
Date: Mon, 27 Apr 2020 13:48:59 -0700
Subject: [PATCH] bugreport: do not include <time.h>

In the generic parts of the source files, system headers like
<time.h> are supposed to be included indirectly by including
"git-compat-util.h", which manages portability issues (platform
specific compat/ sources are generally exempt from this rule).

Drop the inclusion.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bugreport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bugreport.c b/bugreport.c
index 089b939a87..e4a7ed3a23 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -2,7 +2,6 @@
 #include "parse-options.h"
 #include "stdio.h"
 #include "strbuf.h"
-#include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
 
-- 
2.26.2-266-ge870325ee8

