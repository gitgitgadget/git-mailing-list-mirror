Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB3C7EE23
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 14:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjFHOeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjFHOeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 10:34:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368542729
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 07:34:05 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb167972cffso787867276.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686234844; x=1688826844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11RL7VRXTSFU7dc9w1aGCwXHwKtc7RIgFeISPePvDXA=;
        b=fEU1Oz4NPk1j4hH57EVuRdx7cZsl88a+df4NoE8Hp+h2rNEEIN/ZTGMYAOMQ8HJtW2
         +SRsnmQLT7HKQA5DzCus/saEwIlkB4sB3t7MzrhQ/Og9ZftFsOwgnA3yJWpBo6IjA3hf
         wcgJQ78Y1feytRrzJIVMOCl1sMSYoaOPbJEfmvO07Y3RfjK5uHpIYR8zdXXuY2UXO/op
         rW4KWMqK9PBfVjgNEUAziqcCt2q/1tePEcfV8Y0/9gYMCcj9/d2Q3QrSQDWedxA4Xyaz
         x50DLO/0I453UMznWotvbOY07+N+EqMznMGM1vqt3gQzR//X3r9xqhft4FYZuPA2OmW5
         moog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234844; x=1688826844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11RL7VRXTSFU7dc9w1aGCwXHwKtc7RIgFeISPePvDXA=;
        b=dIbGU8OsRLyv6aN7yGUU1e625tvBhO1aJT38MKYbGgGG+T9iibLOtCRfSO2rJPkOVJ
         njJMh4vr5NtlDOxFXEqplmhAcJYEFI2ZBFLQ2jpDx5t4gBR7RF5FKQgHPZTJJkA66YC7
         ih+pUxQYWTyMzqezSoUA0dd27lGJ6Kmz739CO2LFMOO/lkMyDYUtxBGTfUmlrKK3S3j8
         F/7f54STdW/HWL/QGrh2siI9wBg3gd+pkQXk3dStcX5r3ewKcEgWkNkx1JVtLid+xYT0
         nRK5njzQZTF8k4NO0MAnJVQpfWNySUw6DbAmUxHGu0wb719ZkCbXs+8wF9E/bVWJcSjP
         nH0Q==
X-Gm-Message-State: AC+VfDw5rbuLHNb9K/3Rz0L+11OwDBCqdN49vmCvsqvwCwfiBI9pkJQ9
        TPQi9cUkCy6iTLaJ/2Z8pRWl
X-Google-Smtp-Source: ACHHUZ4gWGscR1kbsa4JSoa7B2PpH9WZ4DdMSV98O8PTir2puBsAsZGnxsq7p4nywB7lFzsW3J8vcQ==
X-Received: by 2002:a81:c310:0:b0:561:8fef:13ce with SMTP id r16-20020a81c310000000b005618fef13cemr10860385ywk.37.1686234844129;
        Thu, 08 Jun 2023 07:34:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:480d:b5f8:d041:482? ([2600:1700:e72:80a0:480d:b5f8:d041:482])
        by smtp.gmail.com with ESMTPSA id b66-20020a816745000000b00569f4135ffdsm389257ywc.107.2023.06.08.07.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 07:34:03 -0700 (PDT)
Message-ID: <3778f07f-6e6f-5a39-631d-1266d61b9715@github.com>
Date:   Thu, 8 Jun 2023 10:34:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] shortlog: introduce `--group-filter` to restrict
 output
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1686178917.git.me@ttaylorr.com>
 <5cec04b65d350ca8b482ca14260ef118341e4039.1686178917.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5cec04b65d350ca8b482ca14260ef118341e4039.1686178917.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2023 7:02 PM, Taylor Blau wrote:

> This means that you could easily view the hashes of all commits you
> either wrote or co-authored with something like:
> 
>     $ git shortlog -n --group=author --group=trailer:Co-authored-by \
>         --group-filter="$(git config user.name)"
> 
> When filtering just by trailers, it is tempting to want to introduce a
> new grep mode for matching a given trailer, like `--author=<pattern>`
> for matching the author header. But this would not be suitable for the
> above, since we want commits which match either the author or the
> Co-authored-by trailer, not ones which match both.

One thing that is not immediately obvious from reading the patch, but
becomes clearer in patch 2, is that your --group-filter is an exact
string match. This differs from the --author filter in 'git log' and
similar, which is actually a case-insensitive substring match.

> +static int want_shortlog_group(struct shortlog *log, const char *group)
> +{
> +	if (!log->group_filter.nr)
> +		return 1;
> +	return string_list_has_string(&log->group_filter, group);
> +}
> +

This is the critical piece of code for this issue. Replacing it with

static int want_shortlog_group(struct shortlog *log, const char *group)
{
	struct string_list_item *item;
	if (!log->group_filter.nr)
		return 1;

	for_each_string_list_item(item, &log->group_filter) {
		if (strcasestr(group, item->string))
			return 1;
	}

	return 0;
}

Results in the case-insensitive substring search that I would expect
from this parameter.

This would also solve the problem from Patch 2 where we want to search
by email address. Using '-e --group-filter="my@email.com"' works, though
it will catch users with 'tammy@email.com' emails, as well.

Something to consider at a high level before committing to this CLI.

Thanks,
-Stolee
