Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A62199BA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="H3m0xZKB"
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F87B4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:31:34 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so2024856241.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698694293; x=1699299093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg8zfVecurN1X7vN3VHoOkB0AidceGOVJ7kedJzr/5g=;
        b=H3m0xZKBV5+IeH9ynmznvpRIYrc7Ie0qtBped8WcF/o3JJ/EHNjTBp1ldVXt+O7+N9
         HjQ/c6sjDx+eFZC83+ydOxZFhDxs/z1NJrnpMIUTq+Mth3Bima/9gpoGuTZCQIjO8bPV
         zXsLWLXlz6xaGAshT0VXTnlsCvxrhvJaDXGVeDlDy167xXkEv5L4bZk8Jn19I9IZ2gUY
         6QEj/C+xkhFQxryFPL6aSlVlXeHv9dT5edMTL3WYXwZlMN7dG5sY+U6/JSEhxG+byGoB
         VXDXtmzPJBaG7po2GvEsAtwOjiq9TuuGTTfP6ERNXQyOBOFcosU4loOmDS6VHTgHCfZK
         s32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694293; x=1699299093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg8zfVecurN1X7vN3VHoOkB0AidceGOVJ7kedJzr/5g=;
        b=tMvKIRk9VD/byqMjU8m4p5TjYlGzY3JOOtpQJl7Tdzm+rI/2vchxy30gpWTWSkVoWJ
         f/AGBtIc+3xjnHrIzWVPcVvU/FGguMOJJnU29cQHEBANPSIDJpQcsXui4ZoythgYcwAS
         2VvZN6bj0RkLYKp9ZFmulkoTHt/Z8/NKfANElZ+gsiusByA8M5CY0DX5AVVv0kFfMoeP
         7PKv+hnCzMOOveXqgFvUgL3sk3l1do0acgZ6ABcT0gF5WIF6Eul2Sgy637xMHk3D3tbn
         k8lQ/P/GGef3DxedenEJ0Z0sPcYlcPI/ilgDED/G5qC/pZnPCAjKThCPrX8hLFnb2NLY
         N4cw==
X-Gm-Message-State: AOJu0YxAEKE3BIivSMfbfKBTy79ylZCEdrdltUP0aY/egibHV8GTXIkv
	NLzlsJvS3ZNGH4CvFme+tAOq5Q==
X-Google-Smtp-Source: AGHT+IFkBvZ7uc2WhN5Co5mIU15UVywrohu/XuFVzDFp1zuPm3haeBm9pNsIxv4wavv/eypctbB9Nw==
X-Received: by 2002:a05:6102:104c:b0:452:6178:642c with SMTP id h12-20020a056102104c00b004526178642cmr9095389vsq.1.1698694293546;
        Mon, 30 Oct 2023 12:31:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z16-20020a0cfc10000000b0065b24c08994sm2780352qvo.128.2023.10.30.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:31:33 -0700 (PDT)
Date: Mon, 30 Oct 2023 15:31:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 09/12] builtin/show-ref: ensure mutual exclusiveness
 of subcommands
Message-ID: <ZUAElIb7mjoBBRcn@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <5ba566723e8742e6df150b12f1d044089ff62b59.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ba566723e8742e6df150b12f1d044089ff62b59.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:57AM +0200, Patrick Steinhardt wrote:
> The git-show-ref(1) command has three different modes, of which one is
> implicit and the other two can be chosen explicitly by passing a flag.
> But while these modes are standalone and cause us to execute completely
> separate code paths, we gladly accept the case where a user asks for
> both `--exclude-existing` and `--verify` at the same time even though it
> is not obvious what will happen. Spoiler: we ignore `--verify` and
> execute the `--exclude-existing` mode.
>
> Let's explicitly detect this invalid usage and die in case both modes
> were requested.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/show-ref.c  | 4 ++++
>  t/t1403-show-ref.sh | 5 +++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/builtin/show-ref.c b/builtin/show-ref.c
> index 87bc45d2d13..1768aef77b3 100644
> --- a/builtin/show-ref.c
> +++ b/builtin/show-ref.c
> @@ -271,6 +271,10 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, show_ref_options,
>  			     show_ref_usage, 0);
>
> +	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
> +		die(_("only one of '%s' or '%s' can be given"),
> +		    "--exclude-existing", "--verify");
> +

This is technically correct, but I was surprised to see it written this
way instead of

    if (exclude_existing_opts.enabled && verify)
        die(...);

I don't think it's a big deal either way, I was just curious why you
chose one over the other.

> +test_expect_success 'show-ref sub-modes are mutually exclusive' '
> +	test_must_fail git show-ref --verify --exclude-existing 2>err &&
> +	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ} can be given" err
> +'

grepping is fine here, but since you have the exact error message, it
may be worth switching to test_cmp.

Thanks,
Taylor
