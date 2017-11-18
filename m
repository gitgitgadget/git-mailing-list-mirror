Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD91202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 03:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937492AbdKRD5P (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 22:57:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52942 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S937489AbdKRD5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 22:57:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7CCDBBE00;
        Fri, 17 Nov 2017 22:57:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pI1nKqWZPiLSh8dQiz0S2U+Qlp4=; b=U+6deg
        LYh1IkzNGcDVD7ExzrmB/mpfFB2IY18ZKsb7y28Zr3BpVQYdWsxlxde78wvZGSec
        HIbLZuSj1/ZDHF0AIl+OKV6AJK/tOX8nCpOWBHIbbUANyUtq6Dlf1Lg87i0iVzfq
        njk6+3J4kpJH2BjoUxfM7CQh/wxrDLDm6q3Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mwlIHZpU7s4rsZEVJdnGXzgKo6jtIZw/
        Wr+sxYTLj3KoxWm1YOW5pnSO0iwtOFTjIcYvtuoXtG3fS9LEfek//dE3ZNpS4G2W
        mr+BoUa/xOZ0E3tHwPB8T81+d9v2/AhKsbroBB7H2WMJ/nHZdniymGKUoBJWBM7J
        3dCf3mG078I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFC52BBDFE;
        Fri, 17 Nov 2017 22:57:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44B39BBDFD;
        Fri, 17 Nov 2017 22:57:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/8] sequencer: don't fork git commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171117113452.26597-1-phillip.wood@talktalk.net>
        <xmqq4lpsqmm5.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 18 Nov 2017 12:57:12 +0900
In-Reply-To: <xmqq4lpsqmm5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 18 Nov 2017 12:41:54 +0900")
Message-ID: <xmqqvai8p7c7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F41DFBC-CC14-11E7-BA59-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood@talktalk.net> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> I've updated these based on the feedback for v2. I've dropped the
>> patch that stopped print_commit_summary() from dying as I think it is
>> better to die than return an error (see the commit message of the
>> patch that adds print_commit_summary() for the reasoning). Apart from
>> that they're minor changes - style fixes and a reworded a commit message.
>
> Thanks for further polishing this topic; I found nothing in the
> update that was questionable.  Will replace.
>
> With this, perhaps it is ready for 'next'?

Not really.  I needed at least this to get it even compile, which
hints that I do not yet know what _else_ I missed by skimming this
round of the series.

 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 37460db6b1..63cfb6ddd9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1139,8 +1139,8 @@ static int do_commit(const char *msg_file, const char *author,
 			unlink(git_path_cherry_pick_head());
 			unlink(git_path_merge_msg());
 			if (!is_rebase_i(opts))
-				res = print_commit_summary(NULL, &oid,
-						SUMMARY_SHOW_AUTHOR_DATE);
+				print_commit_summary(NULL, &oid,
+						     SUMMARY_SHOW_AUTHOR_DATE);
 			return res;
 		}
 	}
-- 
2.15.0-372-g9a6f8facfd

