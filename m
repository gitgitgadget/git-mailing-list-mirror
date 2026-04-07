Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9A3A5421
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562784; cv=none; b=Sk/0kZPKEZQpUlm3iqDJuqYfnWE0eKNodi/7bKLSIRMpeZXGS0z/ayp3mSIOuYLpR4wvbcZMsyCzubI/5l6JJvzvvcgd6oZUAJb1GjWPt50V5Cc7HNdNUPQQkKGFUXunniPaoEdxm3Mo9Yfl2/J09U0IJYyz4sq4S4LH9kC/aZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562784; c=relaxed/simple;
	bh=t/P21/EXr+stvFNEwg43xT6IG3w5UlTipwU3UDUxROw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/DoWsXlwjJ0Zcy0JGV6jeHGv5KYWE4jhhR/ILc28X77pQFm1uu/ewrJPr5IS8gDB4t8wGL96Ju2wQfkGpHWEgYoa2qAGI+TddLaCGC853Hg6RxEzBXsmkOk5AKm5T/MMrdtF5GmYBKUE1pXqxkng3uHLCphrXLZVOPrOvas1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDA/eH34; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDA/eH34"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso37694805e9.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562781; x=1776167581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw9OGe3us5rcF6ZQwepiw0ZIUNtiVm5zkz2goE0FpP0=;
        b=JDA/eH34QXqGwDhcC8G6IgZryBvGXDnAXTfVsr4COCZPC5/+jcw3kv6IHkh876Eb0D
         LKtN3dDgh/yjRhqgt215XuBDMdjMN3XdH96mwe4j8MLBVTrO+zJhIRniidVnATuyCjh8
         YrPpldX+UFCxHDt5Eix0qfaqLgyOUGX0u/naemrJ8g8ynjT44f8YvVTRO+zj15zKA5wj
         nbqVd8CNr9huv9tObvs4WhabUqXZTEZkqc0QPTN/6HpnJjkkYV6lHHl+FFE2FKpsMQUD
         AAoS6XQL5bQNJ7Le2NmCL+saH8eSc3Yq6zyd0V1UYdGTNevMmTFrCBspW71cvcPbrvRQ
         drhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562781; x=1776167581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uw9OGe3us5rcF6ZQwepiw0ZIUNtiVm5zkz2goE0FpP0=;
        b=UNsHML/L1Z90YlK+JD3bYjnoMJeNiuwfLyiyzSAiHkNsG2v5SeltGZS7smxv5E0FcU
         b2cxiEp+M7sV8zbVXMoc/MBY0Md5LcpBwD4r3cqaZs2sa+hroLvDMSJz8UPy8OaJ29No
         CPus+47xtCVZreV7qp5wgxB/g4XHsHXKJ9gJ7CQJEkPcNvAL/+JeScxuyPsFHw7me392
         gX7GMk3998SAs2vOCCrqx45NdS/aV4V1liVJmxxGwLmxS3WV573WqhwO0oh8xFADu6NR
         nmPfpDuw9AIfyq+lzp9EFPTXo2aVe3MKo+HNZyfrz5SiwWIKq6QznDxePJLrXAAmyMU8
         Qtlg==
X-Gm-Message-State: AOJu0Yzp3bgJWei014S00y2W0YwziY736jeRt1K1QFIO46uUgbswAySf
	IOXk6TT2yc5PrQSGSWzD0QVkDNIuWxrjJl+xSbKkF8RRTLAxXUKzudg5NI22XA==
X-Gm-Gg: AeBDietCSI8QKUS0mdlZ88hXOUfD2a0IAB8/Zc4FsjpUCigUkd2/7sgL6NpiJxTx+ZQ
	h/z9wTS9II2raXjLKA+Mlb8Y+1AjXkT00qENxindAsbreUKnaYPIXPdyVxNYgaLEwZ3A8G5ScPt
	xvw/Gz8RtgFzGayARcsJy2UHZSbcx/a11OZKZCBHN/FmteuWJPV+oPyuBS0brocwbQauUhnhq74
	c5XLBJ9/2laqP0PEQq6A+ApEsT9oAbZKiORUczQmphiIP97iUZm+Mych159Uz8LaMteIputZQnD
	EWBB86G6+Dz6bCCXi5o8nDzLBPZN68zKicjNI6R+XRUPn+3Nn6zLPF1mJ2Xo2CEe3Ky2Ra9Xlia
	nS1jynt6J/aQKgflpSiwFcMNoDhyByNUazIkrQtqv0bA/PgrxdOB64uULGBgrsf3kw+gGOcbtNr
	hr/X5hAY10OVQHJYlAX/VA/dTnshZNM4CNzT/3OsrpIcDdcyaFC5SBYsIuBk5ARvqojkVrAh/6w
	Tt1ueDMdmp9/fJQt6mLNsJLFcNvFt5BwJLklrQ=
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr37841835e9.30.1775562780398;
        Tue, 07 Apr 2026 04:53:00 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:52:59 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 00/10] Prepare for advertised remotes auto-configure via URL allowlist
Date: Tue,  7 Apr 2026 13:52:33 +0200
Message-ID: <20260407115243.358642-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, I sent a 16 patch long series that makes it possible for
promisor remotes advertised through the "promisor-remote" protocol
capability to be auto-configured on the client side via a URL
allowlist configured using a new `promisor.acceptFromServerUrl`
configuration variable:

https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmail.com/

I got the suggestion to split the 16 patches series into two smaller
series, starting with a preparatory series. So here is this
preparatory series. It's a mix of mostly small fixes, refactorings and
cleanups.

High level description of the patches
=====================================

 - Patches 1-4/10 are fixes:

   - Patch 1/10 is the most significant. The others are relatively
     small.
     
   - Patch 4/10 is the only new in this series (while all the others
     were in the previous series). It prepares for Patch 5/10.

 - Patches 5-10/10 are refactorings and cleanups:

   - Patches 5-7/10 are relatively small independents cleanups or
     refactorings.

   - Patches 8-9/10 are related refactorings simplifying the data
     structures used in filter_promisor_remote() and
     promisor_remote_reply().

   - Patch 10/10 is cleaning up the 'file://' URIs with absolute paths
     in the test script.

Changes since v1
================

Thanks to Patrick and Junio for reviewing the previous versions of
this series.

Only patch 10/10 ("t5710: use proper file:// URIs for absolute paths")
changed since v1:

 - PWD_URL and ENCODED_PWD_URL have been renamed TRASH_DIRECTORY_URL
   and ENCODED_TRASH_DIRECTORY_URL respectively.

 - Instead of percent-encoding only space characters, we now encode
   '%', ' ', '=', ',' and ';'.

 - The test script is skipped altogether if there are other characters
   than those we encode or expect in the current directory path.

 - The tests introduced by commit 1/10 now also benefit from the
   TRASH_DIRECTORY_URL and ENCODED_TRASH_DIRECTORY_URL variables.

 - Commit message and code comments are improved a bit.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/24076952684

Range-diff since v1
===================

 1:  906c5f6fbb =  1:  6687a0fe3f promisor-remote: try accepted remotes before others in get_direct()
 2:  830eb10097 =  2:  23869a4509 promisor-remote: pass config entry to all_fields_match() directly
 3:  b18cdf2fcb =  3:  16d5e0b7ef promisor-remote: clarify that a remote is ignored
 4:  b2125ec770 =  4:  f55f6e8c14 promisor-remote: reject empty name or URL in advertised remote
 5:  e69abb1256 =  5:  52cd36ab64 promisor-remote: refactor should_accept_remote() control flow
 6:  772ea53e9e =  6:  286ae3b4e3 promisor-remote: refactor has_control_char()
 7:  79cf945c24 =  7:  4cb239cd24 promisor-remote: refactor accept_from_server()
 8:  b953e2491e =  8:  7bfe26d5d4 promisor-remote: keep accepted promisor_info structs alive
 9:  3fce719fc0 =  9:  9ffa80444f promisor-remote: remove the 'accepted' strvec
10:  e54af9e176 ! 10:  b77b449c76 t5710: use proper file:// URIs for absolute paths
    @@ Commit message
         these URLs through `url_normalize()` or similar functions.
     
         To future-proof the tests and ensure cross-platform URI compliance,
    -    let's introduce a $PWD_URL helper that explicitly guarantees a leading
    -    slash for the path component, ensuring valid 3-slash `file:///` URIs on
    -    all operating systems.
    +    let's introduce a $TRASH_DIRECTORY_URL helper variable that explicitly
    +    guarantees a leading slash for the path component, ensuring valid
    +    3-slash `file:///` URIs on all operating systems.
     
    -    While at it, let's also introduce $ENCODED_PWD_URL to handle spaces in
    -    directory paths (which is needed for URL glob pattern matching).
    +    While at it, let's also introduce $ENCODED_TRASH_DIRECTORY_URL to
    +    handle some common special characters in directory paths.
     
    -    Then let's replace all instances of `file://$(pwd)` with $PWD_URL across
    -    the test script, and let's simplify the `ENCODED_URL` constructions in
    -    the `sendFields` and `checkFields` tests to use $ENCODED_PWD_URL
    -    directly.
    +    To be extra safe, let's skip all the tests if there are uncommon
    +    special characters in the directory path.
    +
    +    Then let's replace all instances of `file://$(pwd)` with
    +    $TRASH_DIRECTORY_URL across the test script, and let's simplify the
    +    `sendFields` and `checkFields` tests to use
    +    $ENCODED_TRASH_DIRECTORY_URL directly.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ t/t5710-promisor-remote-capability.sh: copy_to_lop () {
      	cp "$path" "$path2"
      }
      
    -+# On Windows, 'pwd' returns a path like 'D:/foo/bar'. Prepend '/' to turn
    ++# On Windows, `pwd` returns a path like 'D:/foo/bar'. Prepend '/' to turn
     +# it into '/D:/foo/bar', which is what git expects in file:// URLs on Windows.
     +# On Unix, the path already starts with '/', so this is a no-op.
     +pwd_path=$(pwd)
     +case "$pwd_path" in
     +[a-zA-Z]:*) pwd_path="/$pwd_path" ;;
     +esac
    -+PWD_URL="file://$pwd_path"
    -+# Same as PWD_URL but with spaces percent-encoded, for use in URL patterns.
    -+ENCODED_PWD_URL="file://$(echo "$pwd_path" | sed "s/ /%20/g")"
    ++
    ++# Allowed characters: alphanumeric, standard path/URI (_ . ~ / : -),
    ++# and those percent-encoded below (% space = , ;)
    ++rest=$(printf "%s" "$pwd_path" | tr -d 'a-zA-Z0-9_.~/:% =,;-')
    ++if test -n "$rest"
    ++then
    ++	skip_all="PWD contains unsupported special characters"
    ++	test_done
    ++fi
    ++
    ++TRASH_DIRECTORY_URL="file://$pwd_path"
    ++
    ++encoded_path=$(printf "%s" "$pwd_path" |
    ++	       sed -e 's/%/%25/g' -e 's/ /%20/g' -e 's/=/%3D/g' \
    ++		   -e 's/;/%3B/g' -e 's/,/%2C/g')
    ++
    ++ENCODED_TRASH_DIRECTORY_URL="file://$encoded_path"
     +
      test_expect_success "setup for testing promisor remote advertisement" '
      	# Create another bare repo called "lop" (for Large Object Promisor)
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "setup for testing pr
      
      	# Configure lop as promisor remote for server
     -	git -C server remote add lop "file://$(pwd)/lop" &&
    -+	git -C server remote add lop "$PWD_URL/lop" &&
    ++	git -C server remote add lop "$TRASH_DIRECTORY_URL/lop" &&
      	git -C server config remote.lop.promisor true &&
      
      	git -C lop config uploadpack.allowFilter true &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=All \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=All \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=None \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with pr
      	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
     -	git -C client config remote.lop.url "file://$(pwd)/lop" &&
     -	git -C client config remote.server.url "file://$(pwd)/server" &&
    -+	git -C client config remote.lop.url "$PWD_URL/lop" &&
    -+	git -C client config remote.server.url "$PWD_URL/server" &&
    ++	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
    ++	git -C client config remote.server.url "$TRASH_DIRECTORY_URL/server" &&
      	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
      	git -C client config promisor.acceptfromserver All &&
      	GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with two promisors but only one advertised" '
    + 	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
    + 		-c remote.unused_lop.promisor=true \
    + 		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
    +-		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
    ++		-c remote.unused_lop.url="$TRASH_DIRECTORY_URL/unused_lop" \
    + 		-c remote.lop.promisor=true \
    + 		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    +-		-c remote.lop.url="file://$(pwd)/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
    + 		-c promisor.acceptfromserver=All \
    + 		--no-local --filter="blob:limit=5k" server client &&
    + 
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch two promisors but only one advertised" '
    + 	git -C client init &&
    + 	git -C client config remote.unused_lop.promisor true &&
    + 	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
    +-	git -C client config remote.unused_lop.url "file://$(pwd)/unused_lop" &&
    ++	git -C client config remote.unused_lop.url "$TRASH_DIRECTORY_URL/unused_lop" &&
    + 	git -C client config remote.lop.promisor true &&
    + 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
    +-	git -C client config remote.lop.url "file://$(pwd)/lop" &&
    +-	git -C client config remote.server.url "file://$(pwd)/server" &&
    ++	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
    ++	git -C client config remote.server.url "$TRASH_DIRECTORY_URL/server" &&
    + 	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
    + 	git -C client config promisor.acceptfromserver All &&
    + 
     @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
      	# Clone from server to create a client
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=KnownName \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownNam
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.serverTwo.promisor=true \
      		-c remote.serverTwo.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.serverTwo.url="file://$(pwd)/lop" \
    -+		-c remote.serverTwo.url="$PWD_URL/lop" \
    ++		-c remote.serverTwo.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=KnownName \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=KnownUrl \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/serverTwo" \
    -+		-c remote.lop.url="$PWD_URL/serverTwo" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/serverTwo" \
      		-c promisor.acceptfromserver=KnownUrl \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	test_when_finished "rm -rf client" &&
      
     -	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
    -+	test_when_finished "git -C server config set remote.lop.url \"$PWD_URL/lop\"" &&
    ++	test_when_finished "git -C server config set remote.lop.url \"$TRASH_DIRECTORY_URL/lop\"" &&
      	git -C server config unset remote.lop.url &&
      
      	# Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=KnownUrl \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	test_when_finished "rm -rf client" &&
      
     -	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
    -+	test_when_finished "git -C server config set remote.lop.url \"$PWD_URL/lop\"" &&
    ++	test_when_finished "git -C server config set remote.lop.url \"$TRASH_DIRECTORY_URL/lop\"" &&
      	git -C server config set remote.lop.url "" &&
      
      	# Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
      	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=KnownUrl \
      		--no-local --filter="blob:limit=5k" server client &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      		-c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=All \
      		--no-local --filter="blob:limit=5k" server client &&
      
      	# Check that fields are properly transmitted
     -	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
     -	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
    -+	PR1="name=lop,url=$ENCODED_PWD_URL/lop,partialCloneFilter=blob:none" &&
    ++	PR1="name=lop,url=$ENCODED_TRASH_DIRECTORY_URL/lop,partialCloneFilter=blob:none" &&
      	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
      	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
      	test_grep "clone> promisor-remote=lop;otherLop" trace &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      		-c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c remote.lop.partialCloneFilter="blob:none" \
      		-c promisor.acceptfromserver=All \
      		-c promisor.checkFields=partialcloneFilter \
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      	# Check that fields are properly transmitted
     -	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
     -	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
    -+	PR1="name=lop,url=$ENCODED_PWD_URL/lop,partialCloneFilter=blob:none" &&
    ++	PR1="name=lop,url=$ENCODED_TRASH_DIRECTORY_URL/lop,partialCloneFilter=blob:none" &&
      	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
      	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
      	test_grep "clone> promisor-remote=lop" trace &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      		-c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c remote.lop.token="fooYYY" \
      		-c remote.lop.partialCloneFilter="blob:none" \
      		-c promisor.acceptfromserver=All \
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone and fetch with
      	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
      		-c remote.lop.promisor=true \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=All \
      		--no-local --filter=auto server client 2>err &&
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
      	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
      		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
     -		-c remote.lop.url="file://$(pwd)/lop" \
    -+		-c remote.lop.url="$PWD_URL/lop" \
    ++		-c remote.lop.url="$TRASH_DIRECTORY_URL/lop" \
      		-c promisor.acceptfromserver=All \
      		--no-local --filter="blob:limit=5k" server client &&

Christian Couder (10):
  promisor-remote: try accepted remotes before others in get_direct()
  promisor-remote: pass config entry to all_fields_match() directly
  promisor-remote: clarify that a remote is ignored
  promisor-remote: reject empty name or URL in advertised remote
  promisor-remote: refactor should_accept_remote() control flow
  promisor-remote: refactor has_control_char()
  promisor-remote: refactor accept_from_server()
  promisor-remote: keep accepted promisor_info structs alive
  promisor-remote: remove the 'accepted' strvec
  t5710: use proper file:// URIs for absolute paths

 Documentation/gitprotocol-v2.adoc     |   4 +
 promisor-remote.c                     | 207 +++++++++++++++-----------
 t/t5710-promisor-remote-capability.sh | 138 ++++++++++++++---
 3 files changed, 238 insertions(+), 111 deletions(-)

-- 
2.54.0.rc0.114.g05d466edb8

