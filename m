Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860561F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeDXVuy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:50:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35940 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDXVux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:50:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id g14so13385611pfh.3
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xR6yDI4vwwbrfy//8a25IGH0dYee1pLmH0+dK7s+mV0=;
        b=fq8uL/juFUhuSo573ISGeAVW9S0SrCW3GWWDQSDBKXD+t28rZm+44OQBc92ZhcGRol
         gCc2PcVRhPejYeu3SglrByRXnf+vQRICFh8fMc2RAiehvIerFZaBLn1f/+i09WDf/Xff
         zM6FBxGI9AIOus+RGSui5/QYuNfNYFVTLmHoRGJMrJs9nJj5Xh7kH/Jh5q0V8WXQlSq2
         gAK5UhlNqv2sYJAg4JsOwFlpK4WdrnAka4YPVaZd0FNmlMD5JUCClfTmxu2425cNHnt3
         +RjKMhJCr3bhTfm3jnBRDRscSk8xgqRv6ULQ2bk7UNAYx5xUsniJQjZwdR+yNCLuvyNS
         n7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xR6yDI4vwwbrfy//8a25IGH0dYee1pLmH0+dK7s+mV0=;
        b=qW67zPzgoAzFUvk50ZdSY2+IS/AZZgbbQN5/LhApQP0EspEEepT4UvySTHEOEEAwys
         nUbFDCOFjubYjKPuAm/EXUdsx00h7xeNwkLdhEFhQAK4WNpYDgz3RR7Cc0qIDpXobh4t
         /lVRmjsM1vPEodZRlAmZIfVNHgQHUGVp7Akz7u08SADoBDlEeNOe1lx4/sPXGU9SRYr9
         D+lubHGVhD42QAp2vSOunb8/hdzzWfryohVjNphg1U7oko/o6Mhu1H6HfAWYFAhlLyA0
         jn2t0kkTzvWOy8hEB7I78gLrs4s55DMmpcOaSa7LEaTrbBX9lITG83Zzn/xRUO6z0yNV
         xTiQ==
X-Gm-Message-State: ALQs6tBA+K84mjUHaGrgJtV9xWC52ChF124YU5chjfGSwJzRSniUeKz6
        /Vzhu32B+FsI1ugmCEWeAiX1Qg==
X-Google-Smtp-Source: AIpwx48tCXjFWpfJFamDcCiPRqJyA8SBF6kN/9dTMYdKTeq7TAKkws30CcoQWx58cBJIMhMJssKIuw==
X-Received: by 10.101.93.2 with SMTP id e2mr21455647pgr.100.1524606652404;
        Tue, 24 Apr 2018 14:50:52 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id y17sm1196888pfl.19.2018.04.24.14.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:50:51 -0700 (PDT)
Date:   Tue, 24 Apr 2018 14:50:50 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com
Subject: Re: [PATCH 5/7] diff.c: add a blocks mode for moved code detection
Message-Id: <20180424145050.e0ad29d4f304216441656057@google.com>
In-Reply-To: <20180424210330.87861-6-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
        <20180424210330.87861-6-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 14:03:28 -0700
Stefan Beller <sbeller@google.com> wrote:

> Suggested-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
>  (https://public-inbox.org/git/87o9j0uljo.fsf@evledraar.gmail.com/)
> Signed-off-by: Stefan Beller <sbeller@google.com>

Firstly, I don't know if this is the right solution- as written
in the linked e-mail [1], the issue might be more that the config
conflates 2 unrelated things, not that a certain intersection is
missing.

[1] https://public-inbox.org/git/87muykuij7.fsf@evledraar.gmail.com/

Optional: Probably better to put the link inline, instead of in the
trailer.

> -test_expect_success 'detect permutations inside moved code -- dimmed_zeb=
ra' '
> +test_expect_success 'detect blocks of moved code' '
>  	git reset --hard &&
>  	cat <<-\EOF >lines.txt &&
>  		long line 1
> @@ -1271,6 +1271,52 @@ test_expect_success 'detect permutations inside mo=
ved code -- dimmed_zebra' '
>  	test_config color.diff.newMovedDimmed "normal cyan" &&
>  	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
>  	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&

Add a comment here explaining that these colors do not appear in the
output, but merely set to recognizable values to ensure that they do not
appear in the output.

> +
> +	git diff HEAD --no-renames --color-moved=3Dblocks --color |
> +		grep -v "index" |
> +		test_decode_color >actual &&
> +	cat <<-\EOF >expected &&
> +	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
> +	<BOLD>--- a/lines.txt<RESET>
> +	<BOLD>+++ b/lines.txt<RESET>
> +	<CYAN>@@ -1,16 +1,16 @@<RESET>
> +	<MAGENTA>-long line 1<RESET>
> +	<MAGENTA>-long line 2<RESET>
> +	<MAGENTA>-long line 3<RESET>
> +	 line 4<RESET>
> +	 line 5<RESET>
> +	 line 6<RESET>
> +	 line 7<RESET>
> +	 line 8<RESET>
> +	 line 9<RESET>
> +	<CYAN>+<RESET><CYAN>long line 1<RESET>
> +	<CYAN>+<RESET><CYAN>long line 2<RESET>
> +	<CYAN>+<RESET><CYAN>long line 3<RESET>
> +	<CYAN>+<RESET><CYAN>long line 14<RESET>
> +	<CYAN>+<RESET><CYAN>long line 15<RESET>
> +	<CYAN>+<RESET><CYAN>long line 16<RESET>
> +	 line 10<RESET>
> +	 line 11<RESET>
> +	 line 12<RESET>
> +	 line 13<RESET>
> +	<MAGENTA>-long line 14<RESET>
> +	<MAGENTA>-long line 15<RESET>
> +	<MAGENTA>-long line 16<RESET>
> +	EOF
> +	test_cmp expected actual
> +
> +'

[snip]
