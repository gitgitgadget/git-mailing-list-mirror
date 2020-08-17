Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC7C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 20:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7EA20738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 20:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MT7RBXrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgHQUxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:53:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57938 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHQUxg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 16:53:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 469ACDBF97;
        Mon, 17 Aug 2020 16:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=33tbWgsHhZzXr/9PsvSqfv4egV8=; b=MT7RBX
        rYLy+XcBzADoF8FoTWe/RVNct6KsDNflW6szAfFV2aTfiS94Iwg2qoYbINaehWxh
        Tt2GLmGSMLClderZvv16CvQUxV1m7YWyTytmxVCKjmt7WK9qr9XhSE2Xy0s/asOI
        Hhws4jL7WFlx60cwMtOwns6nlRNC3Z2jhG0dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uxuyNmc8gm8XD6MJTVllEn1ghQylrSPV
        cGOYHJvsSzQmRhNnu3Um/gUxxcHDfnFWhYEo/XULu0t8MxKY+5DcViElY9WE3X4J
        u5wCsEP3sTIUzdEsvD0xy9lz4YEjktpY1x9ZpzcH9VRKwzCopOhwnLctPHBdtpnS
        bgadUEKJ6EI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F882DBF96;
        Mon, 17 Aug 2020 16:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C02ADBF95;
        Mon, 17 Aug 2020 16:53:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v17 03/10] receive-pack: add new proc-receive hook
References: <20200518094039.757-1-worldhello.net@gmail.com>
        <20200815171740.6257-4-worldhello.net@gmail.com>
Date:   Mon, 17 Aug 2020 13:53:29 -0700
In-Reply-To: <20200815171740.6257-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 15 Aug 2020 13:17:33 -0400")
Message-ID: <xmqq8sed0zau.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B579F95C-E0CB-11EA-A751-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

Did I????  I do not think I deserve any credit here.

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>


> +static struct command *find_command_by_refname(const struct command *list,
> +					       const char *refname)
> +{
> +	for (; list; list = list->next)
> +		if (!strcmp(list->ref_name, refname))
> +			return (struct command *)list;
> +	return NULL;
> +}

Does the last cast really needed, perhaps the caller is adding
"const" to its objects where it is not needed, or the variable
caller uses to receive the returned value of too loose a type?


> diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
> new file mode 100644
> index 0000000000..4f352a7baf
> --- /dev/null
> +++ b/t/helper/test-proc-receive.c
> @@ -0,0 +1,176 @@
> +#include "cache.h"
> +#include "connect.h"
> +#include "parse-options.h"
> +#include "pkt-line.h"
> +#include "sigchain.h"
> +#include "test-tool.h"
> +
> +static const char *proc_receive_usage[] = {
> +	"test-tool proc-receive [<options>...]",
> +	NULL
> +};
> +
> +static int die_version = 0;
> +static int die_readline = 0;
> +static int no_push_options = 0;
> +static int use_atomic = 0;
> +static int use_push_options = 0;
> +static int verbose = 0;

Let BSS do its job by omitting " = 0;" and " = NULL;" at the end.

