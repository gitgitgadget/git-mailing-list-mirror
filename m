Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0AC1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 23:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBHXMZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 18:12:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36251 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHXMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 18:12:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so5943883wmc.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 15:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hoXTnNMa8Gt9hYKid6VirzZH4HCvGQFLdCPPWAtDr3c=;
        b=ATVtuB/LbHTmB5nroqWlPSj4g+J1/qKwwxmrtbjMGkXuhBeDyPmYIFEKAw3FU/3yER
         a81zyuPLHQK+OwiMShVE9WCVEQPPlw7XFdiuTJ5pRrDzipQ7aUP3pRv5VbkYpmzxiheU
         PR/DkV5feH7lfEfiZAkfp96Gnx0kB9kDMbxOTG0QW92sRvxIXYoRfyPV1oflwOHQvptA
         vmHd4Zs9zMfPVljul2Src2TrsPQ2mVXbutCkPAQOC/oyFNnD2qSFoMnWsSVipT6X+Zck
         YcQGzm9RQxLc04wym++nro3ODG6Xe0NCVcsJWufMljnHUP6X4WbO7u57MyzZ4tWuWonM
         CX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hoXTnNMa8Gt9hYKid6VirzZH4HCvGQFLdCPPWAtDr3c=;
        b=qsnxH+udxh7I53FI5vFVC+iYGLrKAFXaKz37haU62wg+bqprOsLJjX6KRIeuadtWZO
         C6kY8QeU58obB2Sdq4eWfVlHN5MF2CWcBs8hdGecDTKvrnItyZhNSbvFErDxEL6leqwN
         6Lq0ueLCmD0X5FzgF+DebOJcxUyZTCi3P37V00JG2xTJthLvL9u9sF9L71ylWK65x6lr
         6PeDwPq/GM9KGlTuLxgu4BCf61odrrfLHUaXNWjM80sVkueUD+/2Ckz1GLLMmZx5t7Ri
         5W8W9bSUKRDN7clCb+bvC03cGF8FA4+g0s2O8DPs4TI+aEt2TB/cmYLcaXpwOuGVcRWA
         wrEQ==
X-Gm-Message-State: AHQUAubhLOvTgi5fr4RIEkteMjE6AuvifkqHkgtv0BQvxGO1zp3ntym2
        Yh2b38WxYfWY/1N1UwRVrX0=
X-Google-Smtp-Source: AHgI3Ialgi8XAPNykXxLNsyeAkQim0BiFYg5Uc5G8EaWlguiN3lt45l/1310xCRsIRUgWz+MtkyZvw==
X-Received: by 2002:adf:8273:: with SMTP id 106mr6861898wrb.34.1549667543456;
        Fri, 08 Feb 2019 15:12:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m4sm1900334wml.2.2019.02.08.15.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 15:12:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rich Felker <dalias@libc.org>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems (Alpine Linux)
References: <20190207215935.GA31515@alpha>
        <20190208001705.GC11927@genre.crustytoothpaste.net>
        <20190208060403.GA29788@brightrain.aerifal.cx>
        <20190208114502.GD11927@genre.crustytoothpaste.net>
        <20190208115511.GA30779@alpha>
        <20190208135137.GE11927@genre.crustytoothpaste.net>
        <xmqqr2cikw4w.fsf@gitster-ct.c.googlers.com>
        <20190208202336.GA5284@alpha>
        <20190208204219.GF11927@genre.crustytoothpaste.net>
Date:   Fri, 08 Feb 2019 15:12:22 -0800
In-Reply-To: <20190208204219.GF11927@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 8 Feb 2019 20:42:19 +0000")
Message-ID: <xmqqd0o1kh7t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_lazy_prereq NO_BOM '
> +	printf abc | iconv -f UTF-8 -t UTF-16 &&
> +	test $(wc -c) = 6
> +'

This must be "just for illustration of idea" patch?  The pipeline
goes to the standard output, and nobody feeds "wc".

But I think I got the idea.

In the real implementation, it probably is a good idea to allow
NO_BOM16 and NO_BOM32 be orthogonal.


> +
> +write_utf16 () {
> +	test_have_prereq NO_BOM && printf '\xfe\xff'
> +	iconv -f UTF-8 -t UTF-16

This assumes "iconv -t UTF-16" on the platform gives little endian
(with or without BOM), which may not be a good assumption.

If you are forcing the world to be where UTF-16 (no other
specificaiton) means LE with BOM, then perhaps doing

	printf '\xfe\xff'; iconv -f UTF-8 -t UTF-16LE

without any lazy prereq may be more explicit and in line with what
you did in utf8.c::reencode_string_len() below.

> -	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
> -	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
> +	printf "$text" | write_utf16 >test.utf16.raw &&
> +	printf "$text" | write_utf32 >test.utf32.raw &&

> diff --git a/utf8.c b/utf8.c
> index 83824dc2f4..4aa69cd65b 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -568,6 +568,10 @@ char *reencode_string_len(const char *in, size_t insz,
>  		bom_str = utf16_be_bom;
>  		bom_len = sizeof(utf16_be_bom);
>  		out_encoding = "UTF-16BE";
> +	} else if (same_utf_encoding("UTF-16", out_encoding)) {
> +		bom_str = utf16_le_bom;
> +		bom_len = sizeof(utf16_le_bom);
> +		out_encoding = "UTF-16LE";
>  	}

I am not sure what is going on here.  When the caller asks for
"UTF-16", we do not let the platform implementation of iconv() to
pick one of the allowed ones (i.e. BE with BOM, LE with BOM, or BE
without BOM) but instead force LE with BOM?

>  	conv = iconv_open(out_encoding, in_encoding);
> ------ %< ---------
>
> This passes for me on glibc, but only on a little-endian system. If this
> works for musl folks, then I'll add a config option for those people who
> have UTF-16 without BOM.
