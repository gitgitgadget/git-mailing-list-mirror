Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3480C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 12:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLLMcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 07:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiLLMb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 07:31:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D910FD4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 04:31:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d14so12575288edj.11
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjX8caMBO1q+gh9y+Z0bmOoAKActXfoMrf+y+b8e3C8=;
        b=hg+kBzbKnWZxz8yJPBkgdGU9Ry1AVtW8SB1t4HpXijLIkvttpvlkha0kHPPEc9FYk3
         Tj12qVlg1DqeEDz8yzSxcBKdzDRvB+V40+B/4gcK22VWq9/LJZBJq2txeXdHF/9IzBgz
         bs+6O6Y+YjAgB9fGyo96bWd767kDPXHcDDafdzRmLplPshUR+lWkcNeN3uYh0ZIYJrBc
         EhayLQM8r6hhqxsKSbrKNsLw9jBhzKRQUb+GwPwgLK1jfOTgo9HQC9uxhIcZRDvfLQuu
         89R9+SidZmAZx2NNCxNBc1tsUCnI9DXYAStB0Gq/IyJHXO49jLLPXfOTqipWcGhpYJyh
         fCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjX8caMBO1q+gh9y+Z0bmOoAKActXfoMrf+y+b8e3C8=;
        b=uptYa1ErEcROIx4SWbI4zWRt7Snr6I+x9sn8kysNwor3/hGGW5V3/sQYGIqZsReP1Z
         VCoQYyLoUwmtT3g56no6PUc6I1D11A9bDvLTWdnIORKWTJZC2/I6sWfnOMKE/0VTReqz
         j2yvlSTTV3WheorWAYMktymc+ElwfNRQEBXVJ2k4QC3SgP21oB1BDiyuBQUGO8cbuSrL
         ZxpfD31mWbcgH3FI20Jcl4ppMGo0l0Ah+34pHvPrSDQtQQ9OU9EcohCEouBx3WcXPNyC
         XCuHXsLvtwugRfmxGq8QWsYJJItXLhsGi/4VrMLG/GVj6kmUcr+J7/r/O/QrytVfvR0T
         +IMQ==
X-Gm-Message-State: ANoB5pkEPL6ote37Tnvwvp5EUeydfBleEcIp3nZu/xLMnfoNTscfBZtx
        MgsuQuZhU+FsJEExXwG0hApFaC15oXI=
X-Google-Smtp-Source: AA0mqf4KqNC0EEF334r3hgVdzcbjp2cFdeW0Hf0l3VQvIosXvF4OHYJfmOtxZs9koPr4ODDXv5+Org==
X-Received: by 2002:aa7:dcd0:0:b0:46a:cc65:5797 with SMTP id w16-20020aa7dcd0000000b0046acc655797mr11941815edu.8.1670848311389;
        Mon, 12 Dec 2022 04:31:51 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t4-20020aa7d704000000b00463bc1ddc76sm3719490edq.28.2022.12.12.04.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:31:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p4hyI-005K4D-1J;
        Mon, 12 Dec 2022 13:31:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] rebase --onto: Skip previously applied commits
Date:   Mon, 12 Dec 2022 13:27:35 +0100
References: <20221212113516.27816-1-cristian.ciocaltea@collabora.com>
 <20221212113516.27816-2-cristian.ciocaltea@collabora.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221212113516.27816-2-cristian.ciocaltea@collabora.com>
Message-ID: <221212.86cz8o6bwp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Cristian Ciocaltea wrote:

> When rebase is used with '--onto <newbase>', the patches that might have
> been already applied on <newbase> are not detected, unless they resolve
> to an empty commit. When the related files contain additional changes
> merged, the rebase operation fails due to conflicts that require manual
> intervention.
>
> Ensure the '--onto' variant behaviour is consistent with the common
> rebase by dropping the already applied commits on the target branch.
>
> Note the current behavior is still reachable by using the
> '--reapply-cherry-picks' flag.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  builtin/rebase.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b22768ca5b9f..2907c6db5cce 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1659,8 +1659,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		strbuf_addstr(&buf, "...");
>  		strbuf_addstr(&buf, branch_name);
>  		options.onto_name = xstrdup(buf.buf);
> -	} else if (!options.onto_name)
> +	} else if (!options.onto_name) {
>  		options.onto_name = options.upstream_name;
> +	} else if (options.upstream) {
> +		options.restrict_revision = options.upstream;
> +		options.upstream = NULL;
> +	}
>  	if (strstr(options.onto_name, "...")) {
>  		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
>  			if (keep_base)

When I apply this & run the tests e.g. t3418 will segfault, and t3403
seems to fail due to the new behavior not having adjusted the test.

Which would be my "C" for the "RFC" :)

I.e. try to get the tests working, and not segfaulting.

If this is a good idea UX wise (I haven't formed an opinion) the main
thing that should inform that is having to decide on the various cases
that the tests are checking for already.

Do I understand this correctly that we'll currently stop and requise a
"git rebase --continue" if we have an empty patch with "--onto", but
without "--onto" we'll just print a warning, and that you'd like
"--onto" to be consistent with the non-onto case?
