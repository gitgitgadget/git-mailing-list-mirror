Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA8CC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 23:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiJYXnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiJYXnv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 19:43:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FAAB48C
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:43:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so676503pjk.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDvBlpSQ3jqcjN1wXwbZwNe0dZNLhjwXbRIxnMxLMJE=;
        b=KilwlDaGcMMQCn7yDPZxxsoaGTqy5kPqc1zf3MFCv3+PjyLX7jRFkiBL1tAIDMdiUG
         +486K2IdnTq5+rIDuvjG7x9M8Kk1s4y8mw7FC/pedBk2hqvezRlIBFEUWuV4J1MU9cBA
         6/vgc0Abh4BU01f331arrViANMZmbIJh5edUGFTGlH6r4x0oUCl87jYRFmzqzQXruh13
         u0DcacbtOiFSqUhluzXT2OM9DG6Bz9pbvmGmW3Zp18l41HQ2eSCN6h6O9QHFXFDB8OEW
         L1RVe0Q4Tq2Y/mUPn4rE21kyCwweoA0ZbowCIyiv/PHsLeiBXsVA3Gh8ZSjmUcJiXI4U
         hRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDvBlpSQ3jqcjN1wXwbZwNe0dZNLhjwXbRIxnMxLMJE=;
        b=ltYAc6fpatEpxXkAbuV/j5IiJ+tuKGykDWTiQdXctY/EIkIppF0lBhdjSTB34Zpcrg
         fwbv65S7d0phAhW100XUAHiSXoEh4T8Pg5dKAP0i6SVWwWjb+9Vur26q6hBr2lAjMNdq
         wLNgejOKlZ/1RCIDD6rmd3/kHH7dX5aK7/7CI0CBeikH4jJ1M5591c/nldwBX+SXJGOU
         GwXptuS7rdhKctVGAnq/mPPTbpiRoJEsLTToCrR+xvKxh+66/lNy76nbsUB3IedWtn2L
         hyywJcuce/yLevo0RXV3GyFlCpEf/ZY7BgzVLvUuoMmxmTM5Hkjt/NpgsuG2+OnXg5oG
         QLvw==
X-Gm-Message-State: ACrzQf27GcjEmCn2MhK5ZEx6IkxJjO9Uxm/097jWlRJi5FW9s51uoCUT
        omBkDSFm6586ky4s3M35fGPyApIOk6A=
X-Google-Smtp-Source: AMsMyM4WfoV3K2pasCbBWQqs15YM6vTRiYT88xVJM2vZm0KLIH4lP+cW9FpL1feEIVHnatWaliPrOw==
X-Received: by 2002:a17:90b:3847:b0:20d:c41f:de7a with SMTP id nl7-20020a17090b384700b0020dc41fde7amr890546pjb.85.1666741429981;
        Tue, 25 Oct 2022 16:43:49 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7958e000000b0056b9cd24403sm1898787pfj.214.2022.10.25.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:43:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: error code with --edit-description
References: <b0f96b35-4e69-a889-bcdf-e0b40b89384f@gmail.com>
Date:   Tue, 25 Oct 2022 16:43:48 -0700
In-Reply-To: <b0f96b35-4e69-a889-bcdf-e0b40b89384f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Wed, 26 Oct 2022 00:57:18 +0200")
Message-ID: <xmqqv8o7mpu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Since c2d17ba3db0d (branch --edit-description: protect against mistyped
> branch name, 2012-02-05) we return -1 on error editing the branch
> description.
>
> Let's change to 1, which follows the established convention and it is
> better for portability reasons.

Nicely explained.  As ret is initialized to 1 to assume failure (and
we set it to 0 when we are happy), the change to stop assigning the
return value from error() is a very sensible implementation, too.

Will queue.  Thanks.

>
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  builtin/branch.c  | 2 +-
>  t/t3200-branch.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c964ac7bb4..15be0c03ef 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -809,7 +809,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>  		if (!ref_exists(branch_ref.buf))
> -			ret = error((!argc || !strcmp(head, branch_name))
> +			error((!argc || !strcmp(head, branch_name))
>  			      ? _("No commit on branch '%s' yet.")
>  			      : _("No branch named '%s'."),
>  			      branch_name);
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 38c57de71b..7f605f865b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1394,7 +1394,7 @@ test_expect_success 'branch --delete --force removes dangling branch' '
>  
>  test_expect_success 'use --edit-description' '
>  	EDITOR=: git branch --edit-description &&
> -	test_must_fail git config branch.main.description &&
> +	test_expect_code 1 git config branch.main.description &&
>  
>  	write_script editor <<-\EOF &&
>  		echo "New contents" >"$1"
