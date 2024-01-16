Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8E2557B
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438168; cv=none; b=gv/xlV0+9e7likTbbpeGP+c5k/LOVauKLzJpD+XGxeBNLK+fMivJqz0E7bRfo8FiKWWYbWRUl+s43GwUc8zOZr0zUWIq87aPqN5qjQbZpF5dGGn7iP1YjSX+1UzFdD2KyjdOuHuqnEek9hoLAetRkkDQO9uF4JNP9myjfSYsMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438168; c=relaxed/simple;
	bh=XsDm58sYuP7GQzj+uHIO1py0kWsEac7zD25UjgJsfRA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=Wj8NhPXlDt+XDVVv/nQgP2OMa5nYV4h0LpJTNu9Np4CwV0fhHRU821mU/maJBGr8mi0yLSkKIcIw8g9SBcp0HlfIxlfoWAUEEfwig3gXREGkVwpzUEIITo1Ba65ta6FmSOPGVM7fAmCzTBK7bDSgbERenhNH6XFF36RtyepOUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gvPzRo6Q; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gvPzRo6Q"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff63b12340so1112267b3.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 12:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705438165; x=1706042965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGWjGAEXlpxHM9XzIT6dGXwlPG8WoG3JUATuiNW+Ao8=;
        b=gvPzRo6Qh4O+CbSKnBIoEHDkSmO8y+oU3TpFqO0OoNN25S+QOON2RNvgIgp4bgMbsC
         3vQ4rRmVrdBUhj58bZef8Hh7ifPCUoGbtCSraQcI7fovJtgTB4bqIarPCfV6JbS7ykBP
         N9ZlWCtKoGqVmqWpB0BfKcs28q+6LN9hXlhxL4k3SBakYOroZ8oXkASZ7eHfyJURkM7d
         WC6iBdP+QTU3QwfmdmLdzViZKNDlRoNYQLNOYQ41ryiAEmI+OLtfgvaoXYN6bt617Vce
         ldD+nJdmyliqiwjuxY1VB15V9KWbZA1rsfgynZcPN0P6lWhR4QO4UiWI0SX78Gh72YSk
         T35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438165; x=1706042965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGWjGAEXlpxHM9XzIT6dGXwlPG8WoG3JUATuiNW+Ao8=;
        b=ERfkgOUfTeHl7SLZs5CALzJ9i8qs7Nar7M4MKVzzsKy52xXZZ9ETWp8VnOWHtaM5t9
         kA5yn1Xy50l6wx1JYo058kW8qkqiE/xVB1LkbjpGBXxK2ztstv5jp6JuZN9nNC9bWrKV
         bqF70iODMPnELEAYECPWZzR8qqhAi2PfaApkWQ5lQj1cd+BV7lGZ1K7ywPbSpW+VZAgN
         1EVvQmoP9nfnRO5kJYyM1w/eHusa+w0FAzA5wS85tmoqU4060Vl7fH16DwtnCgfaB2e8
         PYE9R1ElWUZpnIxbHIUUVSGCWd7FvF6tYKuULmCvAAQnuHsdLVrtvUnN4M6hqkFXKo9E
         m9nw==
X-Gm-Message-State: AOJu0YyhgCmbEsrF4zsLUZag+1JuUBobTTxjFbSX+ONmRtMmHeZNIww8
	E3FmdTb/VD9EZSZ1bedu5ZUFOu/e/SQ0zU/sUZ/1t8Cy/lfeIA==
X-Google-Smtp-Source: AGHT+IHzYxph2/2sLPkf9D7TiNu5KElTOVE8QgNcR3lqHCCK1e5aUaIA5SnkNUwsB+XoGad93RASHw==
X-Received: by 2002:a81:b104:0:b0:5f1:f638:2bd8 with SMTP id p4-20020a81b104000000b005f1f6382bd8mr4899603ywh.31.1705438165597;
        Tue, 16 Jan 2024 12:49:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x19-20020ad44593000000b0067f678747ffsm4486265qvu.50.2024.01.16.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:49:25 -0800 (PST)
Date: Tue, 16 Jan 2024 15:49:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <Zabr1Glljjgl/UUB@nand.local>
References: <xmqq5y0bcjpw.fsf@gitster.g>
 <ZZWOtnP2IHNldcy6@nand.local>
 <xmqqa5pm9tnx.fsf@gitster.g>
 <20240113183544.GA3000857@szeder.dev>
 <20240113225157.GD3000857@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113225157.GD3000857@szeder.dev>

On Sat, Jan 13, 2024 at 11:51:57PM +0100, SZEDER Gábor wrote:
> On a related note, if current git (I tried current master and v2.43.0)
> encounters a commit graph layer containing v2 Bloom filters (created
> by current seen) while writing a new commit graph, then it segfaults
> dereferencing a NULL 'settings' pointer in
> get_or_compute_bloom_filter().
>
> The test below demonstrates this, but it's quite hacky using two
> different git versions: it has to be run by an old git version not yet
> supporting v2 Bloom filters, and a new git version already supporting
> them should be installed at /tmp/git-new/.
>
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 2ba0324a69..0464dd68d5 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -454,4 +454,33 @@ test_expect_success 'Bloom reader notices out-of-order index offsets' '
>  	test_cmp expect.err err
>  '
>
> +CENT=$(printf "\302\242")
> +test_expect_success 'split commit graph vs changed paths Bloom filter v2 vs old git' '
> +	git init split-v2-old &&
> +	(
> +		cd split-v2-old &&
> +		git commit --allow-empty -m "Bloom filters are written but still ignored for root commits :(" &&
> +		for i in 1 2 3
> +		do
> +			echo $i >$CENT &&
> +			git add $CENT &&
> +			git commit -m "$i" || return 1
> +		done &&
> +		git log --oneline -- $CENT >expect &&
> +
> +		# Here we write a commit graph layer containing v2 changed
> +		# path Bloom filters using a git binary built from current
> +		# 'seen' branch.
> +		git rev-parse HEAD^ |
> +		/tmp/git-new/bin/git -c commitgraph.changedPathsVersion=2 \
> +			commit-graph write --stdin-commits --changed-paths --split &&
> +
> +		# This is current master, and segfaults.
> +		git commit-graph write --reachable --changed-paths &&
> +
> +		git log --oneline -- $CENT >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done

Thanks. The segfault is reproducible on my end, but I don't think that
it is possible to fix this for existing versions of Git. The problem (as
you note in your backtrace) is here:

    #0  0x000055555569c842 in get_or_compute_bloom_filter (
        r=0x5555559c9ce0 <the_repo>, c=0x5555559dffd0, compute_if_not_present=1,
        settings=0x0, computed=0x7fffffffe0f4) at bloom.c:253

Which tries to dereference ctx->bloom_settings, which is NULL. Note that
we initialize some sensible defaults for ctx->bloom_settings in
commit-graph.c::write_commit_graph():

    struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
    /* ... */
    bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
                                                  bloom_settings.bits_per_entry);
    bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
                                              bloom_settings.num_hashes);
    bloom_settings.max_changed_paths = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS",
                                                     bloom_settings.max_changed_paths);
    ctx->bloom_settings = &bloom_settings;

...but we'll throw those away in favor of whatever is in the topmost
layer of the existing commit-graph chain later on in that same function:

    if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
      struct commit_graph *g;

      g = ctx->r->objects->commit_graph;

      /* We have changed-paths already. Keep them in the next graph */
      if (g && g->chunk_bloom_data) {
        ctx->changed_paths = 1;
        ctx->bloom_settings = g->bloom_filter_settings;
      }
    }

OK, everything seems fine thus far, until we inspect the value of
g->bloom_filter_settings, which is NULL, becuase of this hunk from
commit-graph.c::graph_read_bloom_data():

    if (hash_version != 1)
      return 0;

which terminates the function before we assign g->bloom_filter_settings
for the existing (written with v2 Bloom filters) graph layer.

I don't think that there is a way to fix this in a backwards compatible
way, but I'm comfortable with that in this instance since we don't
expect users to upgrading to v2 Bloom filters and then writing new graph
layers using a non-v2 compatible version of Git.

We can add a warning in the series that I'm working on indicating this,
but I don't think there's much more we can do besides changing this to
indicate a warning and bailing instead of segfaulting.

Thanks,
Taylor
