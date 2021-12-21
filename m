Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056AC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 13:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhLUNwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbhLUNwo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 08:52:44 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490FC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:52:44 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id v22-20020a9d4e96000000b005799790cf0bso4208104otk.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y0RxriNclKal+X7nnu1Mxm+ol0qfzYvzV9DENQSwtdQ=;
        b=PvYge/HMSK8XcPL+FSnHcFHrhXw++JIiQHx8CgPy/JE2L3e09Di7RJsmJkZvTz8J+l
         CdvgJ8Ah7yZjVMOePBc5B6QdvTCNYcaVeyMwzxT52XmpJWl5JBw0+c1W4erUZguRdZe6
         Z/cocKKtOSmQPRQvibVv4BCWQg2yGdI15qUpXkbE0QDSb9qy1AsTtguT9/qOH4hGbA6c
         5IIT2mKbI9zha/az8GM21DP+zajgJ211G0ONjZktaRRvcLFkG6LP2Ttb3NhME7GG4O98
         DAXv6u6zSK17VsRNY58s7q6Jqo4QiAc5Ihs2jN5y5wj9jD2R7FNa8cIakrmCIrH2M0uJ
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y0RxriNclKal+X7nnu1Mxm+ol0qfzYvzV9DENQSwtdQ=;
        b=OnB/snel66buaG3oAUzA/upkRrB+NTVYcXy94OT/VhA9KOxK0h/5Yo0hIxxqsAhJ9d
         i85NttaDVUa9y4XwtH/gGfhozPMEtjJuhECgjshKq3uc1tz6lvl0RGtdtzJ2/iS+h8T2
         7YyD6iTKngfYc5nYWDH2ya3qP7/NGr2DYXXMcOAxkso80ermg2yBzDcU6tPwk2pNYbya
         TycV8NA1Qn1AZ7FsTNJwsW5POvbrLWbjpn42SBx9gaZ4NmAq0HJZiuQp58pzLEqlvAVD
         Kfc40GG/bT8kv9Tt/jaLg+1YSTwU4NBGHlybUIYRYnXNhxrFpPzrRnNYQBeIA9ZmNyVS
         juFw==
X-Gm-Message-State: AOAM531YDeF0+OhDyPrnej4sQCPYexiTsFmbkGsyfdgx7+wOqhGEAzcr
        ha2IkHJEMTgPMOi3TxesRYlDEx1BixI=
X-Google-Smtp-Source: ABdhPJxgV8pDRWy1BwKTtp4ifUMIIzospHLielYkYfeC8UhH8NPkfmI/unOe4CkxlX5SBLO2RXSjVQ==
X-Received: by 2002:a05:6830:243b:: with SMTP id k27mr517709ots.257.1640094764012;
        Tue, 21 Dec 2021 05:52:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c11c:699d:989:f926? ([2600:1700:e72:80a0:c11c:699d:989:f926])
        by smtp.gmail.com with ESMTPSA id w8sm19677oik.41.2021.12.21.05.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 05:52:43 -0800 (PST)
Message-ID: <c09a2e85-1c27-ed19-eb6b-c4daece49133@gmail.com>
Date:   Tue, 21 Dec 2021 08:52:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] merge: allow to pretend a merge is made into a
 different branch
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>
References: <xmqqbl1ezq5j.fsf@gitster.g> <87a6gyiamm.fsf@osv.gnss.ru>
 <xmqq35mnz2x6.fsf@gitster.g> <xmqqee66ubuw.fsf_-_@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqee66ubuw.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 5:53 PM, Junio C Hamano wrote:

> Teach the "--into-name=<branch>" option to "git merge" and its
> underlying "git fmt-merge-message", to pretend as if we were merging
> into <branch>, no matter what branch we are actually merging into,
> when they prepare the merge message.  The pretend name honors the
> usual "into <target>" suppression mechanism, which can be seen in
> the tests added here.

I like the change to "--into-name".
 
> -	if (starts_with(current_branch, "refs/heads/"))
> +
> +	if (opts->into_name)
> +		current_branch = opts->into_name;
> +	else if (starts_with(current_branch, "refs/heads/"))
>  		current_branch += 11;

I briefly considered whether this 'else if' should just be an
'if' to allow stripping "revs/heads/" from the --into-name option,
but I think it is better as-is, so we use the literal value that
the user supplied.

This patch LGTM.

Thanks,
-Stolee
