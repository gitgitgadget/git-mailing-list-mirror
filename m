Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2iqfV5q8"
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B54D54
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 13:35:45 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b9e6262fccso1040445b6e.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702071345; x=1702676145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNqXk7g2nZGPONBQtgwbNLlLo5QXDvmq1mIFdUF5qlc=;
        b=2iqfV5q8+RZVBDfNr+5GQNhRuaRqubO11tDgZHjSvfVtCP73U+Fbg/qCvs1kFzZ99o
         IefCBYTFXqNBlt9BkIwQ4jeZQFpQeP6M3mWA5HyaDR5A1bjrUU05uBj5o2kDvrz44isS
         PdxEJ7+wK7N8fzMCvm9vIpLReK14O/CzjiJoJIMD0NAoz276bMv/WmWfB1LLSRQUV64q
         NUkiWYS+m/qd5VOBguteJj5qs0aMOLRtxciu6oEukMdvFN5kw/jUZODeuOQJIEUBCk7z
         GbaE29a29beJj5JGFK2wxaMwD1qEic7zU8HrszG1pZ5mNvW73yestdeDY6hNyL6Lb5or
         EooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702071345; x=1702676145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNqXk7g2nZGPONBQtgwbNLlLo5QXDvmq1mIFdUF5qlc=;
        b=ZuFfclRJoWJWnv/HEVzLZk1Wq/ZUC/nl3eyD7/iOHFIuaEzXxMkRVKPnYMpn6Tobx4
         u/q3lorYZ/pBLnDc7wJk8LIxXWRYpoEASFCtiCsRxK6eoRhGzZwv1GFZmrdE26LCi/xf
         I8ypkcn3G+FF15lbmSfM+ySJ95JvmcnNLUDN094S5iSKxI5lDQEEUCb9Iv+Dn+Evi3yR
         oCyZKULCC7Wjg9b4KiHeMpQ70zou3f2nyappWJA2U0PQgLplg4cUW+g39UhcA+7UCjXx
         JZs1dxwPAKm9K6aGJv8PgeiehvjI/DKJPcv/KvoqCN2kAMiqtk6kZdsj/KmxAb6NInRS
         xGXA==
X-Gm-Message-State: AOJu0YzlxFuYaKHNxiZBWness3HhwkhWTFLhnReeH/z7Nlf28w5UxYwL
	fbhv4aSid6YNJkI5K4mtABbcpQ==
X-Google-Smtp-Source: AGHT+IGEy6ZtJlSvbb/uGuXwWMbl2CjuEfyIQrsv8YVZzXCfG5MgFfPh2/EQEVlwoClVPwnS7GGtPw==
X-Received: by 2002:a05:6808:189b:b0:3b8:b6f6:4f7c with SMTP id bi27-20020a056808189b00b003b8b6f64f7cmr859465oib.54.1702071345063;
        Fri, 08 Dec 2023 13:35:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ud11-20020a05620a6a8b00b0077d90497738sm968420qkn.102.2023.12.08.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:35:44 -0800 (PST)
Date: Fri, 8 Dec 2023 16:35:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 04/11] reftable/stack: verify that
 `reftable_stack_add()` uses auto-compaction
Message-ID: <ZXOML2pcqVnVo0oX@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <8061b9d2fcb3e8c3d1fd641e705b9a8879e452f4.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8061b9d2fcb3e8c3d1fd641e705b9a8879e452f4.1702047081.git.ps@pks.im>

On Fri, Dec 08, 2023 at 03:53:10PM +0100, Patrick Steinhardt wrote:
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 0644c8ad2e..c979d177c2 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -850,6 +850,52 @@ static void test_reftable_stack_auto_compaction(void)
>  	clear_dir(dir);
>  }
>
> +static void test_reftable_stack_add_performs_auto_compaction(void)
> +{
> +	struct reftable_write_options cfg = { 0 };
> +	struct reftable_stack *st = NULL;
> +	char *dir = get_tmp_dir(__LINE__);
> +	int err, i, n = 20;
> +
> +	err = reftable_new_stack(&st, dir, cfg);
> +	EXPECT_ERR(err);
> +
> +	for (i = 0; i <= n; i++) {
> +		struct reftable_ref_record ref = {
> +			.update_index = reftable_stack_next_update_index(st),
> +			.value_type = REFTABLE_REF_SYMREF,
> +			.value.symref = "master",
> +		};
> +		char name[100];
> +
> +		/*
> +		 * Disable auto-compaction for all but the last runs. Like this
> +		 * we can ensure that we indeed honor this setting and have
> +		 * better control over when exactly auto compaction runs.
> +		 */
> +		st->disable_auto_compact = i != n;
> +
> +		snprintf(name, sizeof(name), "branch%04d", i);
> +		ref.refname = name;

Is there a reason that we have to use snprintf() here and not a strbuf?

I would have expected to see something like:

    struct strbuf buf = STRBUF_INIT;
    /* ... */
    strbuf_addf(&buf, "branch%04d", i);
    ref.refname = strbuf_detach(&buf, NULL);

I guess it doesn't matter too much, but I think if we can avoid using
snprintf(), it's worth doing. If we must use snprintf() here, we should
probably use Git's xsnprintf() instead.

> +		err = reftable_stack_add(st, &write_test_ref, &ref);
> +		EXPECT_ERR(err);
> +
> +		/*
> +		 * The stack length should grow continuously for all runs where
> +		 * auto compaction is disabled. When enabled, we should merge
> +		 * all tables in the stack.
> +		 */
> +		if (i != n)
> +			EXPECT(st->merged->stack_len == i + 1);
> +		else
> +			EXPECT(st->merged->stack_len == 1);

You could shorten this to

    EXPECT(st->merged->stack_len == (i == n ? 1 : i + 1);

But I like the version that you wrote here better, because it clearly
indicates when we should and should not perform compaction.

Thanks,
Taylor
