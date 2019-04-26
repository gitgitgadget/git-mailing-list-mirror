Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1638C1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 03:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDZDCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 23:02:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51946 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDZDCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 23:02:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so1816322wmf.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8/qcmkhYNMw90a3cUAyjHeVKXFB1lNuZm8r9W7Li8D4=;
        b=hQFnUnIryN53PqeHqSyQKzeIjg9KiWkQouNcsw4P88Zs8+OtFfYfBofdWWkvGyv8J6
         uVQ+O5Z9Aju/YlcJn3DdERKxLVlJYb52/GftD4v+vKVGNY1FtrBC/pF9PVZ1KWjm4BmP
         IYf6DRKDvk00QFdaVewTmqui/N5wB9/gv0g9gpUjuKQPmUklFX9v82LKpHW55IVSnbTV
         PdA9jxAAEAh3I4b3KTsNYJvMiZUzoLtlAl5VM0sXx5g6jVG89ulXqQ/d+1+a1c6mpIcT
         KRxocIkufet8ghWCbFW2ojP46IIxILzgq/2Yr4iSNJ0Uz8cy8vo8yCQo5GVRAtXHICiD
         O2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8/qcmkhYNMw90a3cUAyjHeVKXFB1lNuZm8r9W7Li8D4=;
        b=nKpbdUWondCVBfFs+sFA045yGxAdoGGflh3NdzXFRmNUYNXyEYf6cASL4OMWCBXh47
         chgqFC35KFNgnpGOymdZWG0G6c6UewfNMic8QbufuO/MlqE40KFfvNUoLuPx6Fyk8qdC
         q6X0xxwN+DRjTeFYN6pNKtLdgXGSxIEUkFM5dHFQNRAqqRlY9rnzEZ6+0sTRmuyz4HS5
         Y358c3z0iApq0BWOwJWCUUgdNL+nmQkHtXRTlUDrPy8IoWs/Sdnnf6vcgnksW6f9uLxE
         iH+ktuWVgR1DE9EVVpLyO7dhbp338xnRcJY6cb99MR2qsXNhNYm8FJ0jwuMpS6Wu3qyY
         eNqQ==
X-Gm-Message-State: APjAAAV1UG6VStxSsdD+o0qxzJ7BdI4uA0eWbN67jZHj2JRqJC4k7fzR
        IAPn2UJEg6ne4B1fkEMUzIg=
X-Google-Smtp-Source: APXvYqyLSq3wvGRA1K6TjtEA1IDsrZBRp/BY7pWibDO3gBycR4GbuLf+8pUWK5Dz8TA7aS8RKEKRkw==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr5477577wmb.23.1556247770431;
        Thu, 25 Apr 2019 20:02:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z7sm17717300wml.40.2019.04.25.20.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 20:02:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] checkout: allow -b/-B to work on a merge base
References: <cover.1556226502.git.liu.denton@gmail.com>
        <031780431d790c16b3862d6f155693e197bb74ed.1556226502.git.liu.denton@gmail.com>
Date:   Fri, 26 Apr 2019 12:02:49 +0900
In-Reply-To: <031780431d790c16b3862d6f155693e197bb74ed.1556226502.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 25 Apr 2019 14:10:38 -0700")
Message-ID: <xmqqmukdv57q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> -	new_branch_info->name = arg;
> +	new_branch_info->name = strstr(arg, "...") ?
> +		xstrdup(oid_to_hex(rev)) :
> +		arg;

Can we do better?

I am not sure why we want to hardcode the knowledge of "..." syntax
like this here.  "git checkout A...B" introduced in 2009 needed only
a single-liner change from get_sha1() to get_sha1_mb() without making
the ugly implementation detail seep into this layer.
