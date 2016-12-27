Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C3D200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 17:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755169AbcL0RRC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 12:17:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751638AbcL0RRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 12:17:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02CD657280;
        Tue, 27 Dec 2016 12:16:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lUrclpMN2jialabNj20fbB99MVY=; b=pGmNDf
        s3y41pErZdKRzxgHq9f7IkrMQQX5XeU5CKwyNttBJwPPSxxclhWZ8Yek6Nf3hRY8
        AxJ/y/5Y3lUN4uPySCZ2kTJJGYQKj6bIm/1R43Q09dEP48nZAhxE0YSzjmnHn/mS
        Wp3D0LsXFbRncIm1yI4tEdY7c4RPgy+SJEHew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JX/x8TlfwsVZrw88yfgtPz3HjpUxr1m2
        uigrSoTDis5iORTlYz9pxCPt5T7pqmT492hferzx0oyjA04wl4/9CdMhPc4QJnYJ
        P0fXZnmxMBmXogWq0fw/PQWfDjWY1e4XQTLpLvoYGK32tICAz3ruEEfU9goD+LS1
        qNoGaedNCZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E95695727F;
        Tue, 27 Dec 2016 12:16:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 414955727E;
        Tue, 27 Dec 2016 12:16:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #05; Mon, 19)
References: <xmqq37hjmow0.fsf@gitster.mtv.corp.google.com>
        <afd95065-d076-b962-8337-b87008b9f894@alum.mit.edu>
Date:   Tue, 27 Dec 2016 09:16:56 -0800
In-Reply-To: <afd95065-d076-b962-8337-b87008b9f894@alum.mit.edu> (Michael
        Haggerty's message of "Tue, 27 Dec 2016 18:04:30 +0100")
Message-ID: <xmqqd1gdcmwn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45DF1400-CC58-11E6-BCEF-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Sorry I didn't notice this earlier, but the `LOCK_REPORT_ON_ERROR`
> constant introduced by
>
>     3f061bf "lockfile: LOCK_REPORT_ON_ERROR", 2016-12-07
>
> sets that constant to the value 2,...

Sorry I didn't notice this earlier, either.  Thanks for spotting.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 27 Dec 2016 09:12:09 -0800
Subject: [PATCH] lockfile: move REPORT_ON_ERROR bit elsewhere

There was LOCK_NO_DEREF defined as 2 = 1<<1 with the same value,
which was missed due to a huge comment block.  Deconflict by moving
the new one to 4 = 1<<2 for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 lockfile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.h b/lockfile.h
index 16775a7d79..7b715f9e77 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -137,7 +137,7 @@ struct lock_file {
  * ... this flag can be passed instead to return -1 and give the usual
  * error message upon an error.
  */
-#define LOCK_REPORT_ON_ERROR 2
+#define LOCK_REPORT_ON_ERROR 4
 
 /*
  * Usually symbolic links in the destination path are resolved. This
-- 
2.11.0-449-gc01fa73926

