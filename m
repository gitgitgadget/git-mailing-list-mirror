Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957D51FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbdBNSNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:13:17 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36230 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753720AbdBNSNP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:13:15 -0500
Received: by mail-ot0-f195.google.com with SMTP id l26so4620721ota.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WYg3D7PFyr+LUgOXxvpT8O8dtvU45hFW5KHrTsfK0EQ=;
        b=TLxKaxkWsAtOJbu7UXYOlmXQ0sQMGfLx4ES/MHuVgLter8EzZjY7IHNwXUNfpi/l7U
         CXcSvhpSWGsfi7p+D3mUxmLRVG6hlOCPh9lezrA+e0ARNeL2L73CGlkK72x/1VtyJH+0
         ky5tsB6Q3dS1tf4Y1IIv/YqWkcTwRF0aoPMidMsGyyMQzpAIBvEDmScFme2dUXiF5Dld
         jS1XYXXqgIJEOCyLGGhxerKnmoy6x3A0yIsuiGZP0unR1ZOJ4jaP7MC5WgYe260EDfEw
         T7fVaE3HLk10h/9I1tkcxdrBdddoyMHqYTRerlxGBWC0GyT/lCfzGNjDTaVG9Ge2tsdH
         BC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WYg3D7PFyr+LUgOXxvpT8O8dtvU45hFW5KHrTsfK0EQ=;
        b=Dmr2pJONeb6Ps1mLtd17H2AKESZ/NKWcl2yTG0aFmI7pAvjh59OOt+o1j7w5IYumEa
         4MQ4/MU0k5LV269lSKlazlQrddErpRff9njRhEW4bNHiEy6TpJhyd8/mT8dRGjs2/1AR
         25ax/D4PLThuNVZf64QbSP6ugP+mkWlNZ3oYLL/mh2ImbkI55ylP2cpfEQIWfTi+phV0
         q5bz+nNUHjz/H5osww2W4sQ/DJMoaNB0pEkHqaOc4yS0VbQcEUDDoY4pfqY3ExFIG5VS
         mvTbDA6bP/WYh8IK5fPgPL6hnjE8wuK+7/I2fx5C9cFV+JnxXP+FjPpnWPykxMjAxeXh
         /uSw==
X-Gm-Message-State: AMke39mOc0fsRnO30GZIUbzwAMjPGMaW9N2D37QEGeMq19lXLKEbMpGhkh0VFR6c6pDB8g==
X-Received: by 10.99.149.27 with SMTP id p27mr34122044pgd.21.1487095994398;
        Tue, 14 Feb 2017 10:13:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id e90sm2628180pfl.32.2017.02.14.10.13.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:13:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] clean: use warning_errno() when appropriate
References: <20170213092702.10462-1-pclouds@gmail.com>
        <20170214095449.15585-1-pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 10:13:12 -0800
In-Reply-To: <20170214095449.15585-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 14 Feb 2017 16:54:49 +0700")
Message-ID: <xmqqh93wabev.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> All these warning() calls are preceded by a system call. Report the
> actual error to help the user understand why we fail to remove
> something.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v2 dances with errno

Thanks.

>
>  builtin/clean.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index d6bc3aaae..3569736f6 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -154,6 +154,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  	struct strbuf quoted = STRBUF_INIT;
>  	struct dirent *e;
>  	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
> +	int saved_errno;
>  	struct string_list dels = STRING_LIST_INIT_DUP;
>  
>  	*dir_gone = 1;
> @@ -173,9 +174,11 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  	if (!dir) {
>  		/* an empty dir could be removed even if it is unreadble */
>  		res = dry_run ? 0 : rmdir(path->buf);
> +		saved_errno = errno;
>  		if (res) {
>  			quote_path_relative(path->buf, prefix, &quoted);

I think this part should be more like

		res = ... : rmdir(...);
		if (res) {
			int saved_errno = errno;
			... do other things that can touch errno ...
			errno = saved_errno;
			... now we know what the original error was ...

The reason to store the errno in saved_errno here is not because we
want to help code after "if (res) {...}", but the patch sent as-is
gives that impression and is confusing to the readers.  

Perhaps all hunks of this patch share the same issue?  I could
locally amend, of course, but I'd like to double check before doing
so myself---perhaps you did it this way for a good reason that I am
missing?
