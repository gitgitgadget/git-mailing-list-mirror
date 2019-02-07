Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349CC1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBGW2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:28:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38714 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGW2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:28:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so1589707wrw.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xzPe7+bHzyVdsSpVc7Nj5QiGhkR10ihlvbbfR8EsRfM=;
        b=kJrijdLcNeQ1upUnX6fBBmxSnvWV1Vczv1FeI25YOXl/zfw758wHLMIf5C1BcpM04e
         8wjT+fg6eNKj1jnsIagHKcDLfwuhL7nQG1fevGNEanoMfbEaEf1P59xrXAVJbwojxiPw
         Crcw07pvYXa4G7uLZZA4OBnayvzaL/thuFlZkjA9LEV2XyY05GnzvQROKwmJNSaTVJVM
         Jb8eRKM1Lk4CPEWMl3zajCJ3TmxFOFQnuwjOZHwWHycJ50nKSu6V+lNErpE+bWUIPMfD
         U3c9hwI/3xpe+QlCV82bNhplU7c/GTaKdS2qUOXPrYC1mGoDRDhZkSAGT1QoKqfEml/M
         TnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xzPe7+bHzyVdsSpVc7Nj5QiGhkR10ihlvbbfR8EsRfM=;
        b=n9rhgJjMR0nod+3maetnSqOMZ96t7QAo5hGrxXC7rab2sckvOx+o0JJE43KV+BUus6
         A9ExabyiKw/6hyxtjUPgm2s4noDmn3GcmndgszVu8H8OB4OSMcD0lCPd7OvYVterANnB
         SYBNE6vi1/aam/YR5UA5Ch8AIvai4O1Znri7xAFdwv8O5EAy4YWrV98miO1Q4IEeukwY
         ORVoigo88bKt2q0p+0CLWk4shXcAqn9K+Iqp0haptY7eCFtgEAAH4vwmdWgLWUVkrqdo
         UUNfbgB3wqQATb3l3idMj8JB9X5nI5Z1/znbWWyhlId8VJ1Y9DOE65dyvNO0MfMZ4DZk
         5LvQ==
X-Gm-Message-State: AHQUAub5jNVrfhqh2P3s/Hr+zQHFRXnC3LxsPmuqDLVTPxTTudF2NsFW
        JuziqA6eNCB0Efn+cdnjD2I=
X-Google-Smtp-Source: AHgI3IagMeOfAEl3Be9wVvJOZT/rV1mgqgTzG5DPGqj+9Oc84KYzWcc8scACj67154CqRMlymzjSQw==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr13664171wru.226.1549578493681;
        Thu, 07 Feb 2019 14:28:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm248766wrq.6.2019.02.07.14.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:28:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
References: <20190126221811.20241-1-newren@gmail.com>
        <20190204200754.16413-1-newren@gmail.com>
Date:   Thu, 07 Feb 2019 14:28:12 -0800
In-Reply-To: <20190204200754.16413-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 4 Feb 2019 12:07:54 -0800")
Message-ID: <xmqqtvhfmdxf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
> index 231105cff4..69cb3b0349 100644
> --- a/Documentation/diff-generate-patch.txt
> +++ b/Documentation/diff-generate-patch.txt
> @@ -144,6 +144,19 @@ Similar to two-line header for traditional 'unified' diff
>  format, `/dev/null` is used to signal created or deleted
>  files.
>  
> +However, if the --combined-all-paths option is provided, instead of a
> +two-line from-file/to-file you get a N+1 line from-file/to-file header,
> +where N is the number of parents in the merge commit
> +
> +       --- a/file
> +       --- a/file
> +       --- a/file
> +       +++ b/file
> ++
> +This extended format can be useful if rename or copy detection is
> +active, to allow you to see the original name of the file in different
> +parents.
> +
>  4.   Chunk header format is modified to prevent people from
>       accidentally feeding it to `patch -p1`. Combined diff format
>       was created for review of merge commit changes, and was not

You need to replace the blank line before the new paragraph that
begins with "However" with a line with a single "+" on it, to tell
the formatter that the new text is still part of the third item in
the list.
