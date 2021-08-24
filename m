Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD3C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6A961165
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhHXRz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbhHXRy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 13:54:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FACAC03461A
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:23:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d2so17463971qto.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXAlArytbX78uL4QIJoKqIQOQ5ybcGF0fUFM5aQ3hjM=;
        b=MnLVzA1n2HkmLBo3G5iSxi1D0KNp5pxhwR+l7/l4bon9TghTo1YBRhPW6LuN5fXzVs
         id4ODhNS8wXo3BbiJf1OEJF4kjapRG13CqKUKrxwN+67BnNJEqhA4HA8hmXrampwpcAH
         gEuxWNvY/f7KKm1xdta2C6+OOUx+nt/pdj8ruKkwx6qScK8X0XXtpD2zEqdNDFs0SmCH
         HtQ7Z+tv/3A0r+Zgon3X+o/Gx8b0QZCUX2BFUeDBr83x+bGFpAO1egFWfKWNgsTI3ZfX
         cUdBisb2kIWEdZi+zO37mc5e8FEDj09dc5B/rK6U2zdlTT7fLnqA7Zulo+p4GBs8MKkJ
         1/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXAlArytbX78uL4QIJoKqIQOQ5ybcGF0fUFM5aQ3hjM=;
        b=OIUAwG2d25I0evmvUzGq2A3VovmWis6i68a3Eissg9kxrEdFNkcklJrpUm2wxBMlq2
         QIsyjedmmQXfRtQz2R5/5EHXLIIWIbqpemKtNkqLGmJ7OiujTlbtx61glOKDu67K4hX0
         lcSbM/RNZegon71YDQJ3EgDku7xprL32soMI+tXQV0zyKOTBY6LCnk/i1WIUf8TEoSbe
         sk6lXPkY+EOCdnz+6N6zRyfiZ3Y/KreHpwq2JqZVHwTGjle0Cvb83M/e7JpES5JnHbAP
         qfQ2tAZC7E6iUGuSUqJbFkZaTII5//YtyaLc/yZcXzYAM6aXeJJ/6nRrtpgmMWNKHi/9
         drWQ==
X-Gm-Message-State: AOAM533XAeh3np8OOW7eYWyf/cyBCZXlli4r/HbgvGe+tvIwjlhp4f7/
        BX5nTfDpKKf/fq1g5vdb82w=
X-Google-Smtp-Source: ABdhPJwwIOZPfjVJ7zOoP5HKPchFWOxKdqL+1Z5f/iiYz8+uC0lC4BOnBZoi7+nU1MyWwIJm9cFmCA==
X-Received: by 2002:a05:622a:652:: with SMTP id a18mr35369052qtb.112.1629825823915;
        Tue, 24 Aug 2021 10:23:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id v10sm2877481qkj.79.2021.08.24.10.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:23:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] bundle: show progress on "unbundle"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-4.4-e4ca8b26962-20210823T110136Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aacc0d53-6a95-b5f2-3098-94f6ffc8d2b2@gmail.com>
Date:   Tue, 24 Aug 2021 13:23:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-4.4-e4ca8b26962-20210823T110136Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
> The "unbundle" command added in 2e0afafebd8 (Add git-bundle: move
> objects and references by archive, 2007-02-22) did not show progress
> output, even though the underlying API learned how to show progress in
> be042aff24c (Teach progress eye-candy to fetch_refs_from_bundle(),
> 2011-09-18).
> 
> Now we'll show "Unbundling objects" using the new --progress-title
> option to "git index-pack", to go with its existing "Receiving
> objects" and "Indexing objects" (which it shows when invoked with
> "--stdin", and with a pack file, respectively).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/bundle.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 10f6f45770a..f027cce3fef 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -162,7 +162,11 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
>  	struct bundle_header header = BUNDLE_HEADER_INIT;
>  	int bundle_fd = -1;
>  	int ret;
> +	int progress = isatty(2);
> +
>  	struct option options[] = {
> +		OPT_BOOL(0, "progress", &progress,
> +			 N_("show progress meter")),

We should probably update Documentation/git-bundle.txt, specifically
the synopsis, which currently reads:

'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
		    [--version=<version>] <file> <git-rev-list-args>
'git bundle' verify [-q | --quiet] <file>
'git bundle' list-heads <file> [<refname>...]
'git bundle' unbundle <file> [<refname>...]

Add [--progress] to the unbundle line. The --progress option is
documented further down in the file, although it is confusing
where it applies.

What about the --all-progress and --all-progress-implied options?
Reading the docs, it seems that they won't apply to 'unbundle',
but it doesn't hurt to ask.

> +
> +	if (progress) {
> +		strvec_push(&extra_args, "-v");
> +		strvec_push(&extra_args, "--progress-title");
> +		strvec_push(&extra_args, _("Unbundling objects"));

If the previous patch changes to match the --progress-title=X
pattern of the other options in index-pack, then these two lines
will need to change, probably to a strvec_pushf().

> +	}
> +
>  	ret = !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||

Since this is the first real use of extra_args, as I mentioned
before it would not be the end of the world to have extra_args
appear for the first time within this patch.

Thanks,
-Stolee
