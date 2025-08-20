Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBB6FBF
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727642; cv=none; b=Z7einuNB5eQRCprx9jUsAvWq8g5WvBtQrDKIW781u0nr1HSwcY7yS5UrSHzZuj/DH6cbRZKNQvB12mq2lRuEEnTmMrsz6W01d3ky5+NgE5Txf+khzpXWY9eP0uOGBQkvObu8/wDsIp6IgyCn2t/y11+QxjjUPw2r0IEiENui0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727642; c=relaxed/simple;
	bh=J4PY05dxkW22fPuLEIPgbtqL7tj7WNP6QR4UjkMOz1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ6A7L12I1mg614uXnjGBI2EB667ZVYoL6XKS0CB/LGCql2eqRaePYwNskpctTn+UN7KWiv0Q7YzdG1EfiqAztKZkd7sulrxu24gS7SPzcF/cSoXPOtlcNS4Ledy+DQKjjILl79bEKXQ171AKX5IagPjfoAPc7ahjKMg+xziSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WR8Uzey+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WR8Uzey+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-242d3be5bdfso25185ad.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755727640; x=1756332440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NiTGr+knH+TuVnePg9YH42D1Wje9Xtg1H2xO1HnZ0I=;
        b=WR8Uzey+oYbZeasmWOmOmhnCsilNVrj1ZnZd4hB3bWkgYNubZVWykEg2wt/7InEOVV
         1yUssgD0NCeMKi5r8t/HjLYig0oXX/ivOjr9ig8sh1IprEIDazkmuDOwIXN4pQ2dOSln
         4MjSzVn/AWvNrdQ050CrPM/0mNSDtEPpyaU+WEsEocC0tJ7Iz1UX4bSuBD7WPzrV+ZvW
         awx7J1tJ8K0ztDXji104aPwiiEX9Wjg+eIn09TzkauTUW+l8zFLjyGTHmzPLuZ+y4GmU
         4gR/CdBCzQsnsLM3YgUUpIJ0te/GtvRIqHWyB/cpJwjODUXpEb+F2js49CLHGFIOZgXl
         Y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727640; x=1756332440;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NiTGr+knH+TuVnePg9YH42D1Wje9Xtg1H2xO1HnZ0I=;
        b=JFzAw76pf1YrVhf0fKw/Y8CEFzzNEp4rt4HA4No4dMfCLrwCzcqGm/xQoU0dsIt/WC
         Fif0CdvUGQFeTkbfcSJc2hncHLB8VgxXYR6Mrd7+Nt4UECeL2VGI5c8qs06a8v62b4NF
         csuT6z7yV9limTQ++4I4LEv2Ulv57Ez9OMZJbSbh+ogXuHJs3MJbUNbYbI2B5+A6Fc71
         qePh6z/9W+uGq3dnex/GU7iKIZaTjL3pmhVj0UGTXjzNbPheT7vgF3LnzvCqgTdKCaVW
         3afIuonlNyIdAmctTwcHD2imBOkbOH9GC20hStbWCeDvUiOopPqki6tu60jpT02/8wEM
         TokQ==
X-Gm-Message-State: AOJu0Yxx989JCS/e0oz8Gmc+Jfm/i2+meb0EyiJneDLu/CBRcZOG0YgT
	1SKBOl6bsbel9KEOwDtOnyAdqR9xfzidioUUduWE66BMKkjI6edn8KGJQDH3xu07Cw==
X-Gm-Gg: ASbGnctD65c3g2X9joslVO5MHmJawODeTELyxJJjiRLTCnzMeYUF5Ogi1QI74rDPWuQ
	EeiPHTP7xosmZlEHba04dcnRgQy/Xlq3BhpGRvmX4Zgc9IqRjI2SX93h+bUIXFSN4G2SKllBsUz
	x7WQU8xV7GRLuP7uNJm9oaabdUQHVENl4inNFzx8P6eTsqTdIdXIamNQIKoWAkTNmmvvt6vs1rD
	B6QLGSrnS9zE0mPvpRvPn3t3AMpya3MVMyUebBiqilm9I7LzMW3bHlKHw0MPBVAmmzvExHHnJZN
	3E5pAJi1pXaepfijallCkEUReeGMcqKdX/rDcU5THq/oQB73j/YWpnaOYl0PxQ6eD4K1jy5RDwl
	YApln5/yebe//ZouF5jmbC5lzJ2I=
X-Google-Smtp-Source: AGHT+IHtwvNi/B/497mBIWuiGKMumtMjWaDvly1G+F02dyMl1Zw+AsZ920uwcsSlc37qeSt3omXe8A==
X-Received: by 2002:a17:903:1c9:b0:240:8f2:6442 with SMTP id d9443c01a7336-246023374eemr365625ad.15.1755727640370;
        Wed, 20 Aug 2025 15:07:20 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:23b5:65e6:69f5:ee81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e21asm35873955ad.164.2025.08.20.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:07:19 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:07:13 -0700
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/9] t: submodules: add basic mixed gitdir path tests
Message-ID: <dm32eyyidns26e7swqmdxjgxgbrlkq65fwpxfvsaapdgpbkfgq@iy2dxxcwigtj>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816213642.3517822-5-adrian.ratiu@collabora.com>

On 2025.08.17 00:36, Adrian Ratiu wrote:
> Add some basic submodule tests for mixed gitdir path handling of
> legacy (.git/modules) and new-style (.git/submodule) paths.
> 
> For now these just test the coexistence, creation and push/pull of
> submodules using mixed paths.
> 
> More tests will be added later, especially for new-style encoding.
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  t/meson.build                           |   1 +
>  t/t7425-submodule-mixed-gitdir-paths.sh | 101 ++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100755 t/t7425-submodule-mixed-gitdir-paths.sh
> 
> diff --git a/t/meson.build b/t/meson.build
> index bbeba1a8d5..ffd74f1d3b 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -874,6 +874,7 @@ integration_tests = [
>    't7422-submodule-output.sh',
>    't7423-submodule-symlinks.sh',
>    't7424-submodule-mixed-ref-formats.sh',
> +  't7425-submodule-mixed-gitdir-paths.sh',
>    't7450-bad-git-dotfiles.sh',
>    't7500-commit-template-squash-signoff.sh',
>    't7501-commit-basic-functionality.sh',
> diff --git a/t/t7425-submodule-mixed-gitdir-paths.sh b/t/t7425-submodule-mixed-gitdir-paths.sh
> new file mode 100755
> index 0000000000..801e90522a
> --- /dev/null
> +++ b/t/t7425-submodule-mixed-gitdir-paths.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup: allow file protocol' '
> +	git config --global protocol.file.allow always
> +'
> +
> +test_expect_success 'create repo with mixed new and legacy submodules' '
> +	git init legacy-sub &&
> +	test_commit -C legacy-sub legacy-initial &&
> +	git -C legacy-sub config receive.denyCurrentBranch updateInstead &&
> +	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
> +
> +	git init new-sub &&
> +	test_commit -C new-sub new-initial &&
> +	git -C new-sub config receive.denyCurrentBranch updateInstead &&
> +	new_rev=$(git -C new-sub rev-parse HEAD) &&
> +
> +	git init main &&
> +	(
> +		cd main &&
> +
> +		git config receive.denyCurrentBranch updateInstead &&
> +
> +		git submodule add ../new-sub new &&
> +		test_commit new-sub &&
> +
> +		git submodule add ../legacy-sub legacy &&
> +		test_commit legacy-sub &&
> +
> +		# simulate legacy .git/modules path by moving submodule
> +		mkdir -p .git/modules &&
> +		mv .git/submodules/legacy .git/modules/ &&
> +		echo "gitdir: ../.git/modules/legacy" > legacy/.git
> +	)
> +'
> +
> +test_expect_success 'clone from repo with both legacy and new-style submodules' '
> +	git clone --recurse-submodules main cloned &&
> +	(
> +		cd cloned &&
> +
> +		# At this point, .git/modules/<name> should not exist as
> +		# submodules are checked out into the new path
> +		test_path_is_dir .git/submodules/legacy &&
> +		test_path_is_dir .git/submodules/new &&
> +
> +		git submodule status >list &&
> +		grep "$legacy_rev legacy" list &&
> +		grep "$new_rev new" list
> +	)

You probably want to use `test_grep` here and below.
