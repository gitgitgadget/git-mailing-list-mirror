Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 516FD1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfBFTHE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:07:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39289 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfBFTHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:07:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so4042528wmi.4
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AU2W9kHNefKL/nCt8991HopKigXCLIOX1dKTm7/f0KI=;
        b=vea04qLFrBHAjA3Ce8k1GGekMYS3LpxRyNLFnfhnPjVZLCxFTVNq4s2GZ9arJUzRT2
         IY+GQ+Z+uVdsfYngXqpcpKCkNxdMwsWWSxuN09S5Rlh8o/FgtBqXT+A0GWCmPyikLOwD
         scnVD/SOtLr2ixvOaBz06xXiIE7u1mZvcEJAN62YLCCDiKs1YDw5WKNwqqfaRtMQt5iX
         BnFaipOkefC6iEDTOZG9SgoYbbrubuhOb6l2aNwlzfBUwU3w79M0KgtfNktCjfw+cuZg
         BcE3UYglhCkv7xn9b0ePg0m1jEAUf9VPFr/obQB9FJTdStsiK4M+uxg6T5EFvL3Pt1h/
         Uxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AU2W9kHNefKL/nCt8991HopKigXCLIOX1dKTm7/f0KI=;
        b=ZNqq7uUOdhQEGBQAny92sgllNkmVBWYlOaZEUGE/0j2N3S/WS7Dmfu4sE6DjhgHo82
         bHeMLGSXy1V0YL96hdOQRHX/FHlp9faWBWhuaoHEc63WwJMgCekBFflhCOlFmhqJbEaY
         AXkAQcsJO4HyxpcYumsdl9ak0ifSaRZeaR/M78XWaQmSly2HSqigk8s2I2+YkdtPMigE
         clNYNIEg7so2MsgaAO6EeXHaWPxyaWpdjNt1OyVCgHxGqTUaZ1FKIsho12nbw/35feWe
         xHFJlI8au5586M3yQFX2kBoWf8Gr4xhZLiRVq/9mHumioQBHijk6vO3U2jAwN0Zp/IeB
         8vuA==
X-Gm-Message-State: AHQUAuYgycptZFMRQh8T6izzhWMCREHcDPL6zuOF0Cv3gL4yBFyOjI0i
        CnKbcvVJ0HzrZUP9TSQu+uY=
X-Google-Smtp-Source: AHgI3IZat992pnhKPfee3ZfAlOBWU02MfFE/DqErbc9QIIx2vrn5xoEtZEGoes6T1KVjV1WerDyPIA==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr4103407wmf.17.1549480022192;
        Wed, 06 Feb 2019 11:07:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f134sm17281734wme.31.2019.02.06.11.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:07:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] submodule--helper: teach config subcommand --unset
References: <cover.1549450636.git.liu.denton@gmail.com>
        <f24f20b024f4d41f106ed014a31508fab4fa5eb2.1549450636.git.liu.denton@gmail.com>
Date:   Wed, 06 Feb 2019 11:07:00 -0800
In-Reply-To: <f24f20b024f4d41f106ed014a31508fab4fa5eb2.1549450636.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 6 Feb 2019 02:59:54 -0800")
Message-ID: <xmqqbm3orb1n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This teaches submodule--helper config the --unset option, which removes
> the specified configuration key from the .gitmodule file.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/submodule--helper.c | 15 +++++++++++----
>  t/t7411-submodule-config.sh |  9 +++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 0e140f176c..336e4429e6 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2149,15 +2149,21 @@ static int module_config(int argc, const char **argv, const char *prefix)
>  	enum {
>  		CHECK_WRITEABLE = 1
>  	} command = 0;
> +	enum {
> +		DO_UNSET = 1
> +	} unset = 0;
>  
>  	struct option module_config_options[] = {
>  		OPT_CMDMODE(0, "check-writeable", &command,
>  			    N_("check if it is safe to write to the .gitmodules file"),
>  			    CHECK_WRITEABLE),
> +		OPT_CMDMODE(0, "unset", &unset,
> +			    N_("unset the config in the .gitmodules file"),
> +			    DO_UNSET),
>  		OPT_END()
>  	};

The way this patch uses OPT_CMDMODE() is wrong.

The situation in which CMDMODE is meant to be used is that there are
multiple (that's two or more) choices the end user can make, and the
end user can choose only one of them at a time, iow, giving more
than one is an error.  

In such a case, the programmer would

 - prepare a single variable to store the single choice the end user
   makes the choice in and initialize it to zero.

 - have one OPT_CMDMODE() element for each valid choice, all
   pointing at the same variable, but with different value that is
   not zero.

The parse_options() call would then make sure that the variable is
set to non-zero value only once, to detect conflicting command modes
given from the command line.  The program then can read from the
single variable to see if the end user made any choice (or left it
0).

An example of typical and good use of OPT_CMDMODE() mechanism can be
seen in builtin/tag.c; the 'l(ist)', 'd(elete)' and 'v(erify)' are
the distinct operating modes of the "git tag" command (i.e. you do
not delete a tag while listing them), so the &cmdmode variable is
used to ensure only one of them (or none of them) is given.

The existing use of OPT_CMDMODE we see in this function anticipates
that there would be new operating modes added other than the
check-writable mode, so if you are making a new command mode that
cannot be used with the existing check-writable, then the right way
to use the OPT_CMDMODE() is to add to the command enum a new
non-zero value distinct from CHECK_WRITABLE, without introducing a
new "unset" variable.

If this --unset thing is truly independent from --check-writable,
i.e. if all four possible combinations of having and not having
these two options are valid, then you would not want to muck with
the &command variable, but in that case, wouldn't it make more sense
for the new --unset thing to simply be using OPT_BOOL()?  After all,
it is not like you are planning to add new oprating modes in the
"unset" family that is not "--unset" in the future, no?
