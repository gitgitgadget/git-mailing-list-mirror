Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A152C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A87061165
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbhHXRxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbhHXRxB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 13:53:01 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B195C06A83C
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:18:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so47998710otf.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=my6x9xX1bVlZfiC25bz6e7SN+qWBLUfEcT6hgTUAYkY=;
        b=NYds0aoqHXH5gG2Vu9/8vEr+JS7KPdeFMkAUMe7Q7iWm1dGuvajg7jjPYdwN5s9QTR
         ehZDIEF1zv3hQ0SY3V115xIeeUS5Z84znT8M2/N7LkQS44ZATnBOcIPK3c1G9AIjnFxR
         9mN295p1/GwNDCLPbkZ5RrC09CqTkFmlwD36cXE5ZWOecc5+kzPr0fXHtQsNB2utU1TT
         +MRL2NxUisgFH/KjTOlq7DRFHr4NQ8JzX4v6R9UYSujlNVXZUBQvS4EwvMfZe/dQwnX3
         e573S4cnPZASHD8/xtpyDj0ijFjB/phpqRcCh5/qZ419NMF94akSxncfofBRtttfpYK6
         685Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=my6x9xX1bVlZfiC25bz6e7SN+qWBLUfEcT6hgTUAYkY=;
        b=UOL4hUEgHp0Xq5K0lUjldVJPdqSDhIO/1invVkmD9Tb//bLbykqd4n8pPdzJ1XmskB
         QmR4RQUwQUCvFiFiXgA1hXMriCXFyRxz99fWy83OuQU391jGShIX17+eFQAVaK/GAC0M
         q4oqYSNPyKKsddhfeXT4jUAweCC1rT//ywmAQJ/btJqbyiEMCyDINUNpfdpyIO3fBujd
         cItK31SBDWoCN8idjd7hXDqYouokwgZ6KX7iy9iIqPi6oq3xoVv4QuMW8fiu9CwJolpu
         KkJuQE0tYbpGmCaA9sRVtLskPJGxZs6s0Og5L/xyQR647p4/H4TGOdop78IbUjJGXPVj
         aWjQ==
X-Gm-Message-State: AOAM531x3S9UYX8Q2wBV4Rp7saN6vRjVFIQ16xMWq4tuSmGbnrNZ8rdt
        o+W9runmCLTzyFHSp8kT4N0=
X-Google-Smtp-Source: ABdhPJw34Ivh0b5/SrRgdEwfFeZdeDZw7o69EE9G/UxxNDHwvUCcjQbipomEpAaTmrSeg7KW0WONgg==
X-Received: by 2002:aca:1917:: with SMTP id l23mr3562723oii.10.1629825483710;
        Tue, 24 Aug 2021 10:18:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id l3sm4069202ooo.7.2021.08.24.10.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:18:02 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] index-pack: add --progress-title option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-3.4-67197064a8b-20210823T110136Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f081ac63-cb5c-1777-d9df-828382637ed1@gmail.com>
Date:   Tue, 24 Aug 2021 13:18:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-3.4-67197064a8b-20210823T110136Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
> +--progress-title::
> +	For internal use only.
> ++
> +Set the title of the "Receiving objects" progress bar (it's "Indexing
> +objects" under `--stdin`).

May I suggest a minor edit:

  Set the title of the progress bar. The title is "Receiving objects"
  by default and "Indexing objects" when `--stdin` is specified.

> @@ -1806,6 +1808,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  				input_len = sizeof(*hdr);
>  			} else if (!strcmp(arg, "-v")) {
>  				verbose = 1;
> +			} else if (!strcmp(arg, "--progress-title")) {

Unfortunate that we are not using the parse-opts API. Not your fault.

> +				if (progress_title || (i+1) >= argc)

style nit:

	if (progress_title || i + 1 >= argc)

Although, I notice a similar line elsewhere in the file, so this gets
a pass.

	if (index_name || (i+1) >= argc)

> +					usage(index_pack_usage);
> +				progress_title = argv[++i];

One downside to this organization is that `--progress-title=X` will
not work here. There are other `--<option-name>=X` options in this
builtin, and the index output name is specified with the short name
`-o X`. We should probably err to match the `--<option-name>=X`
pattern in this file for now. An eventual conversion to standard
option parsing would be helpful here, but I don't think is worth
blocking this series.

Thanks,
-Stolee

