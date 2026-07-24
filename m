Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E793ADB98
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880866; cv=none; b=ov/ofyljm0OzEJDTaA1WcKFmzsNPjanPN/i2s6buATp1yRQmCnZ1RCiq9HABiWgi2CPiKKB4R3sGzi0BJSBUOn77eV97cM7/zmV4qzpUbx4XHg+KQv0zi1fH5WtV88PwAy6JACtR9LGw46ew2wQ0ubeCxWJuuv4V0xczBROkXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880866; c=relaxed/simple;
	bh=+bifR97wQmZWPISNSrnl6ofKJl/RslF+4fS4zZQ75ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxJ3o9mehAwK/kHG+jklDniqgF9Vf57JLdxYn49Y6nzJhY0vIFYdLpUawRCft0IeOoPwQAI2kwM7NH1r8Wf2Rx8bst7f/CPuyARwmGz4WYSnk8bgEmV/G310XlZ+65YRYGLzuwvTPCEZMPcwjt+2PvZN4lz0annzqI6M7VMJyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Yq8q5uuf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Yq8q5uuf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf30af983aso306575ad.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784880864; x=1785485664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3N87Xne9nsk1n7XvZh+DfkUeVJYFYKBMXA7OWZa1+fA=;
        b=Yq8q5uuf7cUL/umsqKTmMabYVs4r2WQMcSXK1pgCcCVbwDlX+znnYeZcN3g85S4bza
         HF7odBKYyWP+HAt2fdWqbpr2x3tZG6Si6A8X61LEpaAHtf98ErlG0/97O/kMUvGYFYyA
         tA/4Ty7eJ2Sbe7O7r1hM8+JlAybetz7lvMuVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784880864; x=1785485664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3N87Xne9nsk1n7XvZh+DfkUeVJYFYKBMXA7OWZa1+fA=;
        b=MyxCoJ5hCWv8ebgSy4Qkzt2zdPSkevml6UwSbv9eJzaFsNzj3Kr8ZXB/7wMwbtRTN0
         v3gpcY4Jx6k1dLBVl5QSjM09jv9bvxQPE+803FrvRE/Y/wAZzPYvIro6DwHOcbFCHD7W
         eSulr78Dmflgdg9gaZcfUUBbO/Yf3Lf4ubWdsLs3Fv53iUe0WsHy3qggl3ddEawyvyWg
         BfIt92smyYxPOjDhnecuXgQUYxAQyzgWZf7kbKi7k8a9fXc7YZ+eLhvPkoiooPU4Iiq4
         CKgRnWw53iYQGz3xeAiCOHnQVNNcL8WXIwQ6G1yo+pUUDMh/4ldcqfKPI7PLz2kdkahT
         nFUA==
X-Gm-Message-State: AOJu0YyYudLBC8d3S2emsXBOaxuY2chVXgB4zgoaJ+CL32gcsq6Eovb5
	dC/s7IYc+VoQSqUhxYikJHZmveS5yufJFdSVQdL7kVQi8XELS4ZpDTxWz8RBoy1IRFB2OJ7zuxC
	2J4zTgP0=
X-Gm-Gg: AR+sD125ZSl2qgjJPdBYYc7aIXyOjq/x4GvUyWdVL0qHkL1yiMFdmFWPEHfz8sRln3L
	Vvjosv1xbIaQc2TDKTysHtEpXugCiwmE1Gd95fuf1OlKeirWv7fx5hlNEsu/v1v17fVJRdBlI8w
	G6qSTbxjH1GBz3+CR36T3JEitkU+kA+5HoT65YEOWbzmi+ZqbFsaReWx/RNSBQDVnDv897ATM86
	jKQLbSwsBxemJvf0ozTYCb0HjUhC17mj5h82hDJheTjKJtrRuT6/DWDyALBKEWzSUaZSTLLiwlj
	NZR8B6/SAOtNERcTPsozwa2b8FJbELRVH0JWhuex65ICPf5k6rZboBDTRUQMsY082l6w98pvem+
	hQgMymNhj6a2+P42x8Lrx7eRyw8wbohj1dFlUphGOZyFGwbJz6eIU7rgAR0wg3kyicdUYxysLbS
	P62OyZCjlZjCUL0gpl9BkD9Ob/Q7Uxuhyi25oiZX8LN4WxCcV3td+xt+YASqbu7GZPIeAaAPZpe
	HLq/9sLP1x3omc=
X-Received: by 2002:a17:903:b88:b0:2c9:fbde:ab68 with SMTP id d9443c01a7336-2cfa6c59dd0mr56203455ad.3.1784880863766;
        Fri, 24 Jul 2026 01:14:23 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147d47960dsm26218810eec.0.2026.07.24.01.14.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 01:14:23 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v4 0/3] packfile URIs: support concurrent downloads
Date: Fri, 24 Jul 2026 01:14:22 -0700
Message-ID: <cover.1784874850.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784676106.git.tnyman@openai.com>
References: <cover.1784676106.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packfile URI and dumb HTTP downloads stage packs at
objects/pack/pack-<hash>.pack.temp so an interrupted transfer can
resume. Opening that file in append mode forces every write to its
current end. Two Git processes fetching the same pack into one object
database can therefore append duplicate data and corrupt the pack.

The first patch separates the unrelated --index-pack-arg documentation
and error-message correction requested during review.

The second patch keeps the predictable staging name but removes append
mode. Each downloader seeks once to the current end, requests the
corresponding Range, and writes using its own descriptor offset. Since
the staging key must identify immutable pack contents, overlapping
responses write identical bytes at identical offsets. There is no need
for pwrite(2) or cross-process coordination, and resumption continues to
work for both packfile URI and ordinary dumb HTTP downloads.

A downloader can also find that the partial pack has completed and
request a range starting at EOF. Servers may respond with HTTP 416 in
that case. Treat the response as a completed download and let
index-pack validate the pack.

On MinGW, the non-append O_RDWR open grants FILE_SHARE_DELETE only for an
existing file. Create a missing staging file exclusively, close it, and
reopen it without O_CREAT so every retained descriptor permits another
downloader to unlink the path. Keep the open descriptor for index-pack;
it installs its own pack, so the shared staging file is only unlinked,
never renamed.

The third patch handles the related .keep race. When another process has
already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process. Read only the prefix and
hash so any following fsck output remains available to fetch-pack.

The tests cover resumption, a completed partial returning 416,
overlapping 200 and 206 responses, unlinking the staging path while
index-pack holds its descriptor, and a pre-existing .keep file. The
unlink test does not require FIFOs, so it can exercise MinGW's sharing
behavior even though the concurrent-download tests are skipped there.

Changes since v3:

  * Match HTTP 416 in trace output from both older and current libcurl.
  * Add a timeout to the overlapping-download test server, notify FIFO
    waiters on server failures, and track the actual server process for
    cleanup.
  * Wait for the second downloader first so an early failure cannot
    leave the test server waiting for a request that will never arrive.
  * No production code changes.

These changes avoid false failures with older libcurl and prevent a
failed downloader from leaving the test server running indefinitely.

The v3 discussion is at:

  https://lore.kernel.org/git/cover.1784676106.git.tnyman@openai.com/

Ted Nyman (3):
  http-fetch: correct --index-pack-arg documentation
  http: avoid concurrent appends to partial packs
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  13 +-
 fetch-pack.c                      |  33 ++--
 http-fetch.c                      |   7 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  56 ++++---
 t/t5550-http-fetch-dumb.sh        | 250 ++++++++++++++++++++++++++++++
 t/t5702-protocol-v2.sh            |  31 ++++
 8 files changed, 350 insertions(+), 46 deletions(-)

Range-diff against v3:
1:  a6a40b8046 = 1:  a6a40b8046 http-fetch: correct --index-pack-arg documentation
2:  6c91054afc ! 2:  144c98cdfa http: avoid concurrent appends to partial packs
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	test_cmp expect second.out &&
     +	test_grep "Range: bytes=64-" first.trace &&
     +	test_grep "Range: bytes=[0-9]*-" second.trace &&
    -+	test_grep "HTTP/[0-9.]* 416" second.trace &&
    ++	test_grep "416 Requested Range Not Satisfiable" second.trace &&
     +	test_path_is_missing "$tmpfile" &&
     +	git -C packfileclient-concurrent cat-file -e "$HASH"
     +'
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	use IO::Socket::INET;
     +
     +	my ($packfile, $server_ready, $first_ready) = @ARGV;
    ++	my $completed = 0;
    ++	END {
    ++		if (!$completed) {
    ++			signal_ready($server_ready, "failed");
    ++			signal_ready($first_ready, "failed");
    ++		}
    ++	}
    ++
    ++	$SIG{ALRM} = sub { die "timed out serving concurrent pack requests\n" };
    ++	alarm 60;
    ++
     +	open(my $in, "<:raw", $packfile) or die "open $packfile: $!";
     +	my $pack = do { local $/; <$in> };
     +	close($in) or die "close $packfile: $!";
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	write_all($second, substr($pack, $second_pos));
     +	close($first) or die "close first response: $!";
     +	close($second) or die "close second response: $!";
    ++	$completed = 1;
    ++	alarm 0;
     +	EOF
     +	{
    -+		(
    -+			if ! "$TRASH_DIRECTORY/slow-pack-server" "$pack" \
    -+				"$TRASH_DIRECTORY/server-ready" \
    -+				"$TRASH_DIRECTORY/first-ready"
    -+			then
    -+				echo failed >"$TRASH_DIRECTORY/server-ready" &&
    -+				echo failed >"$TRASH_DIRECTORY/first-ready" &&
    -+				exit 1
    -+			fi
    -+		) >server.log 2>&1 &
    ++		"$TRASH_DIRECTORY/slow-pack-server" "$pack" \
    ++			"$TRASH_DIRECTORY/server-ready" \
    ++			"$TRASH_DIRECTORY/first-ready" >server.log 2>&1 &
     +		server_pid=$!
     +	} &&
     +	test_when_finished "
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +		kill $second_pid 2>/dev/null || :
     +		wait $second_pid 2>/dev/null || :
     +	" &&
    -+	wait "$server_pid" &&
    -+	wait "$first_pid" &&
     +	wait "$second_pid" &&
    ++	wait "$first_pid" &&
    ++	wait "$server_pid" &&
     +	test_grep "HTTP/[0-9.]* 200" overlap-first.trace &&
     +	test_grep "Range: bytes=[1-9][0-9]*-" overlap-second.trace &&
     +	test_grep "HTTP/[0-9.]* 206" overlap-second.trace &&
3:  1ee5d7e027 = 3:  d9063deb60 fetch-pack: accept "pack" output for packfile URIs

base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
-- 
2.55.0.openai.131.g83a728de1eb6
