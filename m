Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C9C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D008720757
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nDdGYOsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgD1RwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:52:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62917 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgD1RwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 13:52:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E317CEA2E;
        Tue, 28 Apr 2020 13:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cPkNOPTXGpAmPSGzr4k7c1WQqmU=; b=nDdGYO
        suNPr2jzIZvUNlDZDf84tBtIp5hAMrePo2Pay4fHYYAKCCtQKjclkVgmY0FI2Dgt
        1vh5/38cd8gKfhx/hI1nnXhZf0NHQUPpALJuZs+AIUhi8EI9ol9QokxYieNlBCYm
        Cp5o/fUOmstjXs+S69nLbZoMn2/TLWP/UhgrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dAJcGeFwclGrMPAe6/RpkQZ6dU5hHtd9
        /k7GXF4gIBPYbyzBlGTDulWilSpwAV/ZOHYpF21H0MzmVJU0YCAUfrq2W1hFkTwI
        0wmZQvf6U4cw6SXPg+EEABkijp3ab24ndbrib6JtvpJNBGxQS6ge8eyWc7cpMiVk
        QWL6lquIQmU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75C8DCEA2D;
        Tue, 28 Apr 2020 13:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FEC6CEA2B;
        Tue, 28 Apr 2020 13:51:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Andrew White <andrew.white@audinate.com>
Subject: Re: [PATCH] push: unset PARSE_OPT_OPTARG for --recurse-submodules
References: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
        <c2b92691ca85029fde3bd6969252cc827ca697b5.1587969824.git.liu.denton@gmail.com>
        <20200427120225.GB1718141@coredump.intra.peff.net>
        <xmqq7dy092tq.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Apr 2020 10:51:56 -0700
In-Reply-To: <xmqq7dy092tq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 27 Apr 2020 11:54:41 -0700")
Message-ID: <xmqqwo5z33cz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4F0BFEE-8978-11EA-B283-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> @@ -554,7 +552,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>>>  		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
>>>  		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
>>>  			N_("control recursive pushing of submodules"),
>>> -			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>>> +			0, option_parse_recurse_submodules },
>>
>> This could collapse down to OPT_CALLBACK() now, though I don't think
>> it's a big deal either way.
>
> I would prefer to see OPT_CALLBACK() used; it would send a strong
> signal that this place is using the canned bog-standard and boring
> pattern, and nothing fancy is going on.

Here is what I am going to queue for this fix; hopefully it can be
cherry-picked by folks who maintain older versions of Git for
distros and in-house use.

The other "huge" patch has also been adjusted by dropping the first
hunk on builtin/push.c from it, and then resurrecting the part to
use OPT_CALLBACK_F() for compare-and-swap (which happened to be in
the same hunk).

Thanks for the fix and clean-up.  Very much appreciated.

-- >8 --
From: Denton Liu <liu.denton@gmail.com>
Date: Mon, 27 Apr 2020 02:44:08 -0400
Subject: [PATCH] push: unset PARSE_OPT_OPTARG for --recurse-submodules

When the usage for `git push` is shown, it includes the following
lines

	--recurse-submodules[=(check|on-demand|no)]
			      control recursive pushing of submodules

which seem to indicate that the argument for --recurse-submodules is
optional. However, we cannot actually run that optiion without an
argument:

	$ git push --recurse-submodules
	fatal: recurse-submodules missing parameter

Unset PARSE_OPT_OPTARG so that it is clear that this option requires an
argument. Since the parse-options machinery guarantees that an argument
is present now, assume that `arg` is set in the else of
option_parse_recurse_submodules().

Reported-by: Andrew White <andrew.white@audinate.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6dbf0f0bb7..208c2540e9 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -434,10 +434,8 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 	if (unset)
 		*recurse_submodules = RECURSE_SUBMODULES_OFF;
-	else if (arg)
-		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
 	else
-		die("%s missing parameter", opt->long_name);
+		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
 
 	return 0;
 }
@@ -552,9 +550,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
-			N_("control recursive pushing of submodules"),
-			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+		OPT_CALLBACK(0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
+			     N_("control recursive pushing of submodules"), option_parse_recurse_submodules),
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
-- 
2.26.2-266-ge870325ee8

