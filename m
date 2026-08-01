Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F43BD657
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577453; cv=none; b=VtYLd5TbpW0l/pMyiOJCaw9tFXuLkVTf++b4bHo1cRebPzvogeGnGWHmsl0G8fWw4Xpudpz+LOmA967JEtO0nfu5vBQc9o+l8TbrA3IEVNXGbKFkZdPB5pCf1lfe/jEqoJp93jUkZ8QwoSvhi7rtnMexg8+nLt93EfqxKDkfJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577453; c=relaxed/simple;
	bh=IevVEQwVYFT2/nOqBFoXrL8s3/4M9cw1BVF5sCBp/Ns=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZJfX6M1yi0AEFxdxWhtKDM/alzDH3uwBTPGJsraOC0te94nN5Pz/mYRuH/JnQMxhd6bvwnVz+iehOv82RZAopSAvZhTQ2F9Age+U3Vmwp4fvEqtc1MTSpcibLozy0sQVfjHpVb5Z+H8yuPgfeMAbe1ys3xQgIY9AgKMFodUGojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVYUr9RN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVYUr9RN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1891721a91.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785577449; x=1786182249; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BZ3uKEJqETKpamER61B7oB/o92woPnG6AlzzM1aDYxo=;
        b=mVYUr9RNvcijYvIYeT4h7uLvy6kqX9+nk/SldeTegLF3GsZYJKPbYoGM8Y1xy/stNw
         RjgtFoO5fPujgwa8a0Q1afJjCduz6XKK8dnlQ3nWKuTzJM4Q+F+VlSnLWVC3KFriPHu3
         Es00RArNruW1u3pocE8iYUUopcmaTiildZblhKzx0R+xnGGYmpwTSfcOyaAMOnHv7rPS
         F4RS9J85ditGXakMMqApRIa6YK0kH9ofgEnfuZFoW3UHTznOroTRAEGDH+tTXe9Kqua0
         y1zDUlZJ5Q/5sIAWJf0M1YSx4wTtl3VpPtOy9jNRw9wFjjcQ5CQX9PEWLDIBHwHt2uJ/
         urJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785577449; x=1786182249;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZ3uKEJqETKpamER61B7oB/o92woPnG6AlzzM1aDYxo=;
        b=DkZNEDx2WhmEBaM1OogydUogiyTAV2uZG9gn+hnuP/YubcImteea6j26yJ1e6Xbt7p
         q6wo+hqBQr/iJQanVghYaMLqFkaU1kjv7/hzpmznIRM02RGlPm9wpwWaojID+VTj5Dwc
         joSx1LQ0m0ajX0xscB+bqVJlVpFoIwRZ6HQgZ02KZjzyK2CAK5pWqRcFWKELZuuOYMe8
         ZsoZ/tlBd7AAqc1E33vss8mjp4EY4/wNpOesqA37udhI4ongEOZptMepVttidMDeXuKO
         3PZNlRH9VNou0qzbXytX7zQZVxAtEuHoEUmHTMD+pfVpvFF8oxuX2SCUrHYKU7/hEGiZ
         dlIg==
X-Gm-Message-State: AOJu0YwEYyozH697oOWm978DGpccFI3yKIUkrXWhk0mLbWnAgvf7cBfB
	Jyf2h7NsTxy0+paXqw0aqQTTUDSpEEnBAgZok4Glb9fSDpYxBXmk4g91fA3JeruY
X-Gm-Gg: AR+sD11GQ1qlqugT8/F9kqoPewWAUhPmSPRSV8W6M9ln4fEQb/aWn1ociLJh0TGdCjp
	INW8s42OWrxQFOJoRNrdYHP1V8yuMqdCGzdPqoxZnnifIiumU11CL+OYk4zTiXSplzeJe93xYXA
	l/MkfFw4nCQMw7t8mEp7qt2UHfnEWEgIM7GVnZh9jI4Nmd9qwqK36y2sXY/tsLpx5WAa+anvAqx
	ak78yY6vgy7EB30cbX4yA7Iq9RhOMRfb/tOyzBIaaeMzzLBls9WCgY+3KE5qv4fu2pfeR0UmpBX
	t0cqWPHNQCxz/MtfsNqrU7QbNYysyKRfTxwRgZz1iaP2EJRaOhb/VjPRgjEJ0UPW8IYR/5GpJH/
	Xy7m1yCxKioh+HRIWQbx9U7ZZcC+A0tHkzVr25843VxgTeZI1IDVVV7ClqLrCjGFdm8vueWSvQx
	BbY5X+AWR168/+DO3Q8wUzAgRu3zYSOIbNu36Le636ZCkg86OOFLko6IsK4MY5jz8=
X-Received: by 2002:a17:90b:5690:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-38fbc4d6169mr2600641a91.24.1785577448387;
        Sat, 01 Aug 2026 02:44:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.26.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm1790847a91.13.2026.08.01.02.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:44:06 -0700 (PDT)
Message-Id: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
References: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 09:44:03 +0000
Subject: [PATCH v4 0/2] bisect: add --reset-when-found to leave when done
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>

Add a --reset-when-found option to git bisect that resets the bisect session
when culprit is found.

Changes in v4:

 * Simplify translation calls.
 * Avoid git subshell calls in tests, that can bury errors.

Changes in v3:

 * Rename --auto-reset to --reset-when-found, including internal names.
 * Defer git bisect run cleanup until captured output is printed and
   BISECT_RUN is closed. Drop the open-descriptor preparatory change,
   retaining the existing filename-based output handling.

Changes in v2:

 * Add option --auto-reset[=<where>] with option to go to final commit as
   well as original.
 * Refactored tests.

Harald Nordgren (2):
  bisect: let bisect_reset() optionally check out quietly
  bisect: add --reset-when-found to leave when done

 Documentation/git-bisect.adoc |  14 +++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 148 +++++++++++++++++++++++++++++-----
 t/t6030-bisect-porcelain.sh   | 121 +++++++++++++++++++++++++++
 4 files changed, 264 insertions(+), 21 deletions(-)


base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2335%2FHaraldNordgren%2Fbisect-auto-reset-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2335/HaraldNordgren/bisect-auto-reset-v4
Pull-Request: https://github.com/git/git/pull/2335

Range-diff vs v3:

 1:  59920c51ae = 1:  e39670edf4 bisect: let bisect_reset() optionally check out quietly
 2:  542f4b2c80 ! 2:  f5f370df1b bisect: add --reset-when-found to leave when done
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       		}
       	}
      +	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
     -+		res = error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
     ++		res = error(_("options '%s' and '%s' cannot be used together"),
     ++			    "--reset-when-found", "--no-checkout");
      +		goto finish;
      +	}
       	pathspec_pos = i;
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
      +
      +	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
      +		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
     -+			return error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
     ++			return error(_("options '%s' and '%s' cannot be used together"),
     ++				     "--reset-when-found", "--no-checkout");
      +		write_file(git_path_bisect_reset_when_found(), "%s\n",
      +			   reset_when_found_mode_name(reset_when_found));
      +		argc--;
     @@ t/t6030-bisect-porcelain.sh: test_bisect_usage () {
       }
       
      +test_bisect_state_file () {
     -+	test_path_is_file "$(git rev-parse --git-path "$1")"
     ++	local file &&
     ++	file=$(git rev-parse --git-path "$1") &&
     ++	test_path_is_file "$file"
      +}
      +
      +test_bisect_state_missing () {
     -+	test_path_is_missing "$(git rev-parse --git-path "$1")"
     ++	local file &&
     ++	file=$(git rev-parse --git-path "$1") &&
     ++	test_path_is_missing "$file"
      +}
      +
      +bisect_start_and_finish () {
     @@ t/t6030-bisect-porcelain.sh: test_expect_success '"git bisect run" simple case'
       '
       
      +test_expect_success '"git bisect start --reset-when-found" defaults to original' '
     -+	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_when_finished "git bisect reset && git checkout main" &&
      +	git checkout main &&
      +	bisect_start_and_finish --reset-when-found &&
     -+	test "$HASH4" = "$(git rev-parse HEAD)" &&
     -+	test main = "$(git branch --show-current)" &&
     ++	actual=$(git rev-parse HEAD) &&
     ++	test "$HASH4" = "$actual" &&
     ++	actual=$(git branch --show-current) &&
     ++	test main = "$actual" &&
      +	test_bisect_state_missing BISECT_START &&
      +
      +	bisect_start_and_finish --reset-when-found=original &&
     -+	test "$HASH4" = "$(git rev-parse HEAD)" &&
     -+	test main = "$(git branch --show-current)" &&
     ++	actual=$(git rev-parse HEAD) &&
     ++	test "$HASH4" = "$actual" &&
     ++	actual=$(git branch --show-current) &&
     ++	test main = "$actual" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
      +test_expect_success '"git bisect start --reset-when-found=found" leaves first bad checked out' '
     -+	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_when_finished "git bisect reset && git checkout main" &&
      +	bisect_start_and_finish --reset-when-found=found &&
     -+	test "$HASH3" = "$(git rev-parse HEAD)" &&
     ++	actual=$(git rev-parse HEAD) &&
     ++	test "$HASH3" = "$actual" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
      +test_expect_success '"git bisect run --reset-when-found" defaults to original' '
     -+	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_when_finished "git bisect reset && git checkout main" &&
      +	bisect_run_reset_when_found --reset-when-found &&
     -+	test "$HASH4" = "$(git rev-parse HEAD)" &&
     -+	test main = "$(git branch --show-current)" &&
     ++	actual=$(git rev-parse HEAD) &&
     ++	test "$HASH4" = "$actual" &&
     ++	actual=$(git branch --show-current) &&
     ++	test main = "$actual" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
      +test_expect_success '"git bisect run --reset-when-found=found" leaves first bad checked out' '
     -+	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_when_finished "git bisect reset && git checkout main" &&
      +	bisect_run_reset_when_found --reset-when-found=found &&
     -+	test "$HASH3" = "$(git rev-parse HEAD)" &&
     ++	actual=$(git rev-parse HEAD) &&
     ++	test "$HASH3" = "$actual" &&
      +	test_bisect_state_missing BISECT_START
      +'
      +
      +test_expect_success '--reset-when-found rejects an unknown reset target' '
     -+	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_when_finished "git bisect reset && git checkout main" &&
      +	test_reset_when_found_fails \
      +		"invalid value for.*--reset-when-found.*unknown" BISECT_START \
      +		git bisect start --reset-when-found=unknown $HASH4 $HASH2 &&
     @@ t/t6030-bisect-porcelain.sh: test_expect_success '"git bisect run" simple case'
      +test_expect_success '--reset-when-found cannot be used with --no-checkout' '
      +	test_when_finished "git bisect reset" &&
      +	test_reset_when_found_fails \
     -+		"cannot be used with.*--no-checkout" BISECT_START \
     ++		"options .*--reset-when-found.* and .*--no-checkout.* cannot be used together" BISECT_START \
      +		git bisect start --reset-when-found=original --no-checkout $HASH4 $HASH2 &&
      +
      +	git bisect start --no-checkout $HASH4 $HASH2 &&
      +	test_reset_when_found_fails \
     -+		"cannot be used with.*--no-checkout" BISECT_RESET_WHEN_FOUND \
     ++		"options .*--reset-when-found.* and .*--no-checkout.* cannot be used together" BISECT_RESET_WHEN_FOUND \
      +		git bisect run --reset-when-found=found true
      +'
      +
     @@ t/t6030-bisect-porcelain.sh: test_expect_success '"git bisect run" simple case'
      +'
      +
      +test_expect_success '--reset-when-found does not leak into a later bisection' '
     -+	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_when_finished "git bisect reset && git checkout main" &&
      +	bisect_start_and_finish --reset-when-found &&
      +
      +	git bisect start $HASH4 $HASH2 &&

-- 
gitgitgadget
