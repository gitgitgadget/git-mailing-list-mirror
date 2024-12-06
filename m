Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA96204084
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488992; cv=none; b=Fcs4vgyQRFhPt74ddfjSeA4NZbhmKIj2XvIS2Ho57UEek+R3FjP6vHmxgQ4IlQGBQQeSdzMO+MF/M/hlHAw9CzxKVbIomBYphcwG90d4N/b3eLW6yZ9l0me5icfqh0mYd8nwmzOvpjwjwlw8SwdpzDtSwc+8KcjNfYoQdyQym8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488992; c=relaxed/simple;
	bh=hY7c7QXAl919J16kdbHn27ejDjftjbGgQJVcyawxBsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3CO13s1Ml9/q2Ba2cwpmEwf+zbbjmhLo95on7AesmGCEAakKHIsmxT9pcn6PyAzFG/3NOGnGIyPwae7x+HYz2Sqs1ZubYq81/HTy8OdDVkNBH56u+aM1fkA+VPUehKseY4RhWxhyBfowbMvZq5Fz2gA6Ertn58slkZ1HV35Ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG+PQTq0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG+PQTq0"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so19532201fa.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 04:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488987; x=1734093787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPZh4EiXCktI19EbH279Evjl7fzdNqIyCbjAksNaoGs=;
        b=YG+PQTq0LQyXzJMyYTZMPGi9+GfLJ9T/lb3fCCprBQL7t1brBQlQMqKfrHX9jpjRGG
         jn2IfuNZFSu+4en6Xwu+a4xKFtjOY7IEhGt9gKcZTB7RVKL51fe+JXXC6/RwEX5ZqfKk
         4qg8K5S7ubJwVcMxNXXZ3kf2oN0crt1EU8SpstcNxmWtrBMeZ7rhICoYwN0ln6TnLX+f
         GsAfDcpPPVZO7Ijoq0ooVDLb97Kl49IedLmcT6LAxiK3bx+mw0qsjMtcIOvS5iu5Q/Gq
         MW+xlMysOewyiTkKaDsoDNfAs7RgfuFD+8i1K5tGeERkL2OMdGSKTuZszxXKUAa5IaLt
         NBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488987; x=1734093787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPZh4EiXCktI19EbH279Evjl7fzdNqIyCbjAksNaoGs=;
        b=FGYP/0H7Mezcajq416pyacQ3rKAi0ni3Wvtb5D6Rv18BDUZ9XUucBsFp5IpjKCS90q
         Q1txbpZGrBlhLAcW5qEDghkjxRx5I9V0EfOCyc72meV3L3FHFLrLx43WlIRp1sYg80/v
         wu2BkXIfObdvqsQjq1jpavo8IU9dxyFvUZBO74rfQN6yxpN1pu4uRCk15HvHf+FXR0p+
         +jzRlBKtwVWRZZrVILx0lC4obKKPdIjYZI8QwYLn35qMDefnefvFIM6WVuLhxSVwsdK8
         GbyABSuxiVTC8PIO65YJeSad/JogPxTusCMBQWS+zEd1ce+EqKd2vAEo1IxGCJzzxUzb
         GfQQ==
X-Gm-Message-State: AOJu0YwknASXP7fpZeZHLfoBN/rpNbQnwnMCo5pAxa93XNdqP68UNUl8
	g0ez4i3wdzsURomgc3qt2B5+xXs2oUKO+KPHJlGTDXRbN7D5m9URIyeOoA==
X-Gm-Gg: ASbGnctsI8PIT3BKdDZeTetOEGrmv8KjPdi2rmFyQCUiCZpnYn7k/HpKfKWTf0JyiqP
	ZYDGFkeZrcQwk6YHwwH6mA4Q3iarKxXwaOyCnPqy6OayR4mrRF/Bq83n6x4MS4R9mWiFYZKTJPw
	rzPqY5HwBhw2ODVgMyENOHI+Z4DhURvdgv9pZaCvc3iu9kSNnPxQVh4sKNNk/Oz0xA1wj9k3wox
	Xw8FLWDgubd5dTyz1VlpiF1qol01352gZuHqLegjhMbi9EGlu1LT2hLtNdsHMV4juKDxIj1Yiip
	yMzvF6quN92wLuKq0BXf1FG2/VKDtSRP
X-Google-Smtp-Source: AGHT+IGjoTBuMjMUAEFoGd1aegbT9DI/xIOr813/DrkizfuoO9F0cAYP9Q8ivVIBSfBV8bu6i0MxwQ==
X-Received: by 2002:a05:6512:3b98:b0:53e:16ed:eac2 with SMTP id 2adb3069b0e04-53e2c2efc44mr1504787e87.54.1733488986613;
        Fri, 06 Dec 2024 04:43:06 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4da51sm236527266b.37.2024.12.06.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:43:05 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/5] Introduce a "promisor-remote" capability
Date: Fri,  6 Dec 2024 13:42:43 +0100
Message-ID: <20241206124248.160494-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.47.1.402.gc25c94707f
In-Reply-To: <20240910163000.1985723-1-christian.couder@gmail.com>
References: <20240910163000.1985723-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This work is part of some effort to better handle large files/blobs in
a client-server context using promisor remotes dedicated to storing
large blobs. To help understand this effort, this series now contains
a patch (patch 5/5) that adds design documentation about this effort.

Earlier this year, I sent 3 versions of a patch series with the goal
of allowing a client C to clone from a server S while using the same
promisor remote X that S already use. See:

https://lore.kernel.org/git/20240418184043.2900955-1-christian.couder@gmail.com/

Junio suggested to implement that feature using:

"a protocol extension that lets S tell C that S wants C to fetch
missing objects from X (which means that if C knows about X in its
".git/config" then there is no need for end-user interaction at all),
or a protocol extension that C tells S that C is willing to see
objects available from X omitted when S does not have them (again,
this could be done by looking at ".git/config" at C, but there may be
security implications???)"

This patch series implements that protocol extension called
"promisor-remote" (that name is open to change or simplification)
which allows S and C to agree on C using X directly or not.

I have tried to implement it in a quite generic way that could allow S
and C to share more information about promisor remotes and how to use
them.

For now, C doesn't use the information it gets from S when cloning.
That information is only used to decide if C is OK to use the promisor
remotes advertised by S. But this could change in the future which
could make it much simpler for clients than using the current way of
passing information about X with the `-c` option of `git clone` many
times on the command line.

Another improvement could be to not require GIT_NO_LAZY_FETCH=0 when S
and C have agreed on using S.

Changes compared to version 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Summary of the changes: there are few changes in the C code, but a
numberof them in the tests, and a new design doc.

  - To avoid conflicts and benefit from recent improvements (like leak
    checks) this series has been rebased to a recent master:
    23692e08c6 (The thirteenth batch, 2024-12-04)

  - In patch 3/5, some functions are not passed a
    `struct repository *repo` argument anymore as this argument is only used
    in patch 4/5, so it's better to introduce it in that patch.

  - In patch 3/5, a memory leak was fixed using
    git_config_get_string_tmp() instead of git_config_get_string() as
    suggested by Patrick.

  - In patch 3/5, a number of tests using `git fetch` are added. This
    is why there are a number of other refactorings and improvements
    in the tests described in some points below.

  - In patch 3/5, some tests using `git clone` had a title that used
    "fetch" instead of "clone". This has been corrected.

  - In patch 3/5, the test helper function initialize_server() now
    takes 2 arguments to make it more generic.

  - In patch 3/5, a new copy_to_server2() test helper function has
    been introduced.

  - In patch 3/5, a test repacking with a filter was writting outside
    the test directory which has been corrected using
    `--filter-to="$(pwd)/pack"`.

  - In patch 3/5, a test was using `touch "$promisor_file"`. This was
    replaced with `>"$promisor_file"`.

  - In patch 4/5, some functions are now passed a
    `struct repository *repo` argument. This is related to the
    corresponding change in patch 3/5 that removed this argument.

  - In patch 4/5, some tests using `git clone` had a title that used
    "fetch" instead of "clone". This has been corrected (in the same
    way as in patch 3/5).

  - Patch 5/5 is new. It adds design documentation that could help
    understand the broader context of this patch series, as this was
    requested by some reviewers. This patch is optional. I am OK with
    removing it or discussing it as a single separate patch.

Thanks to Junio, Patrick, Eric and Taylor for their suggestions.

CI tests
~~~~~~~~

https://github.com/chriscool/git/actions/runs/12197064528

Unfortunately some tests (linux-sha256, linux-reftable, linux-gcc and
linux-gcc-default) failed after around 46 minutes as the dependencies
couldn't be intalled.

One test, linux-TEST-vars, failed much earlier, in what doesn't look
like a CI issue as I could reproduce the failure locally when setting
GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL to 1. I will investigate,
but in the meantime I think I can send this as-is so we can start
discussing.

Range diff compared to version 2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1:  0d9d094181 = 1:  13dd730641 version: refactor strbuf_sanitize()
2:  fc53229eff = 2:  8f2aecf6a1 strbuf: refactor strbuf_trim_trailing_ch()
3:  5c507e427f ! 3:  57e1481bc4 Add 'promisor-remote' capability to protocol v2
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +  BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
     +}
     +
    -+static void filter_promisor_remote(struct repository *repo,
    -+                             struct strvec *accepted,
    -+                             const char *info)
    ++static void filter_promisor_remote(struct strvec *accepted, const char *info)
     +{
     +  struct strbuf **remotes;
    -+  char *accept_str;
    ++  const char *accept_str;
     +  enum accept_promisor accept = ACCEPT_NONE;
     +
    -+  if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
    ++  if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
     +          if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
     +                  accept = ACCEPT_NONE;
     +          else if (!strcasecmp("All", accept_str))
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +          free(decoded_url);
     +  }
     +
    -+  free(accept_str);
     +  strbuf_list_free(remotes);
     +}
     +
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
     +  struct strvec accepted = STRVEC_INIT;
     +  struct strbuf reply = STRBUF_INIT;
     +
    -+  filter_promisor_remote(the_repository, &accepted, info);
    ++  filter_promisor_remote(&accepted, info);
     +
     +  if (!accepted.nr)
     +          return NULL;
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  git -C "$1" rev-list --objects --all --missing=print > all.txt &&
     +  perl -ne 'print if s/^[?]//' all.txt >missing.txt &&
     +  test_line_count = "$2" missing.txt &&
    -+  test "$3" = "$(cat missing.txt)"
    ++  if test "$2" -lt 2
    ++  then
    ++          test "$3" = "$(cat missing.txt)"
    ++  else
    ++          test -f "$3" &&
    ++          sort <"$3" >expected_sorted &&
    ++          sort <missing.txt >actual_sorted &&
    ++          test_cmp expected_sorted actual_sorted
    ++  fi
     +}
     +
     +initialize_server () {
    ++  count="$1"
    ++  missing_oids="$2"
    ++
     +  # Repack everything first
     +  git -C server -c repack.writebitmaps=false repack -a -d &&
     +
    @@ t/t5710-promisor-remote-capability.sh (new)
     +
     +  # Repack without the largest object and create a promisor pack on server
     +  git -C server -c repack.writebitmaps=false repack -a -d \
    -+      --filter=blob:limit=5k --filter-to="$(pwd)" &&
    ++      --filter=blob:limit=5k --filter-to="$(pwd)/pack" &&
     +  promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
    -+  touch "$promisor_file" &&
    ++  >"$promisor_file" &&
     +
    -+  # Check that only one object is missing on the server
    -+  check_missing_objects server 1 "$oid"
    ++  # Check objects missing on the server
    ++  check_missing_objects server "$count" "$missing_oids"
    ++}
    ++
    ++copy_to_server2 () {
    ++  oid_path="$(test_oid_to_path $1)" &&
    ++  path="server/objects/$oid_path" &&
    ++  path2="server2/objects/$oid_path" &&
    ++  mkdir -p $(dirname "$path2") &&
    ++  cp "$path" "$path2"
     +}
     +
     +test_expect_success "setup for testing promisor remote advertisement" '
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  # Copy the largest object from server to server2
     +  obj="HEAD:foo" &&
     +  oid="$(git -C server rev-parse $obj)" &&
    -+  oid_path="$(test_oid_to_path $oid)" &&
    -+  path="server/objects/$oid_path" &&
    -+  path2="server2/objects/$oid_path" &&
    -+  mkdir -p $(dirname "$path2") &&
    -+  cp "$path" "$path2" &&
    ++  copy_to_server2 "$oid" &&
     +
    -+  initialize_server &&
    ++  initialize_server 1 "$oid" &&
     +
     +  # Configure server2 as promisor remote for server
     +  git -C server remote add server2 "file://$(pwd)/server2" &&
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  git -C server config uploadpack.allowAnySHA1InWant true
     +'
     +
    -+test_expect_success "fetch with promisor.advertise set to 'true'" '
    ++test_expect_success "clone with promisor.advertise set to 'true'" '
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "fetch with promisor.advertise set to 'false'" '
    ++test_expect_success "clone with promisor.advertise set to 'false'" '
     +  git -C server config promisor.advertise false &&
     +
     +  # Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  check_missing_objects server 0 "" &&
     +
     +  # Reinitialize server so that the largest object is missing again
    -+  initialize_server
    ++  initialize_server 1 "$oid"
     +'
     +
    -+test_expect_success "fetch with promisor.acceptfromserver set to 'None'" '
    ++test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh (new)
     +  test_when_finished "rm -rf client" &&
     +
     +  # Check that the largest object is not missing on the server
    -+  check_missing_objects server 0 ""
    ++  check_missing_objects server 0 "" &&
    ++
    ++  # Reinitialize server so that the largest object is missing again
    ++  initialize_server 1 "$oid"
    ++'
    ++
    ++test_expect_success "init + fetch with promisor.advertise set to 'true'" '
    ++  git -C server config promisor.advertise true &&
    ++
    ++  test_when_finished "rm -rf client" &&
    ++  mkdir client &&
    ++  git -C client init &&
    ++  git -C client config remote.server2.promisor true &&
    ++  git -C client config remote.server2.fetch "+refs/heads/*:refs/remotes/server2/*" &&
    ++  git -C client config remote.server2.url "file://$(pwd)/server2" &&
    ++  git -C client config remote.server.url "file://$(pwd)/server" &&
    ++  git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
    ++  git -C client config promisor.acceptfromserver All &&
    ++  GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
    ++
    ++  # Check that the largest object is still missing on the server
    ++  check_missing_objects server 1 "$oid"
    ++'
    ++
    ++test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
    ++  git -C server config promisor.advertise true &&
    ++
    ++  # Clone from server to create a client
    ++  GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
    ++          -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
    ++          -c remote.server2.url="file://$(pwd)/server2" \
    ++          -c promisor.acceptfromserver=All \
    ++          --no-local --filter="blob:limit=5k" server client &&
    ++
    ++  # Check that the largest object is still missing on the server
    ++  check_missing_objects server 1 "$oid"
    ++'
    ++
    ++test_expect_success "setup for subsequent fetches" '
    ++  # Generate new commit with large blob
    ++  test-tool genrandom bar 10240 >template/bar &&
    ++  git -C template add bar &&
    ++  git -C template commit -m bar &&
    ++
    ++  # Fetch new commit with large blob
    ++  git -C server fetch origin &&
    ++  git -C server update-ref HEAD FETCH_HEAD &&
    ++  git -C server rev-parse HEAD >expected_head &&
    ++
    ++  # Repack everything twice and remove .promisor files before
    ++  # each repack. This makes sure everything gets repacked
    ++  # into a single packfile. The second repack is necessary
    ++  # because the first one fetches from server2 and creates a new
    ++  # packfile and its associated .promisor file.
    ++
    ++  rm -f server/objects/pack/*.promisor &&
    ++  git -C server -c repack.writebitmaps=false repack -a -d &&
    ++  rm -f server/objects/pack/*.promisor &&
    ++  git -C server -c repack.writebitmaps=false repack -a -d &&
    ++
    ++  # Unpack everything
    ++  rm pack-* &&
    ++  mv server/objects/pack/pack-* . &&
    ++  packfile=$(ls pack-*.pack) &&
    ++  git -C server unpack-objects --strict <"$packfile" &&
    ++
    ++  # Copy new large object to server2
    ++  obj_bar="HEAD:bar" &&
    ++  oid_bar="$(git -C server rev-parse $obj_bar)" &&
    ++  copy_to_server2 "$oid_bar" &&
    ++
    ++  # Reinitialize server so that the 2 largest objects are missing
    ++  printf "%s\n" "$oid" "$oid_bar" >expected_missing.txt &&
    ++  initialize_server 2 expected_missing.txt &&
    ++
    ++  # Create one more client
    ++  cp -r client client2
    ++'
    ++
    ++test_expect_success "subsequent fetch from a client when promisor.advertise is true" '
    ++  git -C server config promisor.advertise true &&
    ++
    ++  GIT_NO_LAZY_FETCH=0 git -C client pull origin &&
    ++
    ++  git -C client rev-parse HEAD >actual &&
    ++  test_cmp expected_head actual &&
    ++
    ++  cat client/bar >/dev/null &&
    ++
    ++  check_missing_objects server 2 expected_missing.txt
    ++'
    ++
    ++test_expect_success "subsequent fetch from a client when promisor.advertise is false" '
    ++  git -C server config promisor.advertise false &&
    ++
    ++  GIT_NO_LAZY_FETCH=0 git -C client2 pull origin &&
    ++
    ++  git -C client2 rev-parse HEAD >actual &&
    ++  test_cmp expected_head actual &&
    ++
    ++  cat client2/bar >/dev/null &&
    ++
    ++  check_missing_objects server 1 "$oid"
     +'
     +
     +test_done
4:  1c2794f139 ! 4:  7fcc619e41 promisor-remote: check advertised name or URL
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
     +  return 0;
      }
      
    - static void filter_promisor_remote(struct repository *repo,
    -@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    +-static void filter_promisor_remote(struct strvec *accepted, const char *info)
    ++static void filter_promisor_remote(struct repository *repo,
    ++                             struct strvec *accepted,
    ++                             const char *info)
    + {
        struct strbuf **remotes;
    -   char *accept_str;
    +   const char *accept_str;
        enum accept_promisor accept = ACCEPT_NONE;
     +  struct strvec names = STRVEC_INIT;
     +  struct strvec urls = STRVEC_INIT;
      
    -   if (!git_config_get_string("promisor.acceptfromserver", &accept_str)) {
    +   if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
                if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
                        accept = ACCEPT_NONE;
     +          else if (!strcasecmp("KnownUrl", accept_str))
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
                else if (!strcasecmp("All", accept_str))
                        accept = ACCEPT_ALL;
                else
    -@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    +@@ promisor-remote.c: static void filter_promisor_remote(struct strvec *accepted, const char *info)
        if (accept == ACCEPT_NONE)
                return;
      
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
        /* Parse remote info received */
      
        remotes = strbuf_split_str(info, ';', 0);
    -@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    +@@ promisor-remote.c: static void filter_promisor_remote(struct strvec *accepted, const char *info)
                if (remote_url)
                        decoded_url = url_percent_decode(remote_url);
      
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
                        strvec_push(accepted, decoded_name);
      
                strbuf_list_free(elems);
    -@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    +@@ promisor-remote.c: static void filter_promisor_remote(struct strvec *accepted, const char *info)
    +           free(decoded_url);
        }
      
    -   free(accept_str);
     +  strvec_clear(&names);
     +  strvec_clear(&urls);
        strbuf_list_free(remotes);
      }
      
    +@@ promisor-remote.c: char *promisor_remote_reply(const char *info)
    +   struct strvec accepted = STRVEC_INIT;
    +   struct strbuf reply = STRBUF_INIT;
    + 
    +-  filter_promisor_remote(&accepted, info);
    ++  filter_promisor_remote(the_repository, &accepted, info);
    + 
    +   if (!accepted.nr)
    +           return NULL;
     
      ## t/t5710-promisor-remote-capability.sh ##
    -@@ t/t5710-promisor-remote-capability.sh: test_expect_success "fetch with promisor.acceptfromserver set to 'None'" '
    -           --no-local --filter="blob:limit=5k" server client &&
    -   test_when_finished "rm -rf client" &&
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with promisor.advertise set to 'true'" '
    +   check_missing_objects server 1 "$oid"
    + '
      
    -+  # Check that the largest object is not missing on the server
    -+  check_missing_objects server 0 "" &&
    -+
    -+  # Reinitialize server so that the largest object is missing again
    -+  initialize_server
    -+'
    -+
    -+test_expect_success "fetch with promisor.acceptfromserver set to 'KnownName'" '
    ++test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "fetch with promisor.
     +  check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "fetch with 'KnownName' and different remote names" '
    ++test_expect_success "clone with 'KnownName' and different remote names" '
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "fetch with promisor.
     +  check_missing_objects server 0 "" &&
     +
     +  # Reinitialize server so that the largest object is missing again
    -+  initialize_server
    ++  initialize_server 1 "$oid"
     +'
     +
    -+test_expect_success "fetch with promisor.acceptfromserver set to 'KnownUrl'" '
    ++test_expect_success "clone with promisor.acceptfromserver set to 'KnownUrl'" '
     +  git -C server config promisor.advertise true &&
     +
     +  # Clone from server to create a client
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "fetch with promisor.
     +  check_missing_objects server 1 "$oid"
     +'
     +
    -+test_expect_success "fetch with 'KnownUrl' and different remote urls" '
    ++test_expect_success "clone with 'KnownUrl' and different remote urls" '
     +  ln -s server2 serverTwo &&
     +
     +  git -C server config promisor.advertise true &&
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "fetch with promisor.
     +          --no-local --filter="blob:limit=5k" server client &&
     +  test_when_finished "rm -rf client" &&
     +
    -   # Check that the largest object is not missing on the server
    -   check_missing_objects server 0 ""
    - '
    ++  # Check that the largest object is not missing on the server
    ++  check_missing_objects server 0 "" &&
    ++
    ++  # Reinitialize server so that the largest object is missing again
    ++  initialize_server 1 "$oid"
    ++'
    ++
    + test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
    +   git -C server config promisor.advertise true &&
    + 
-:  ---------- > 5:  c25c94707f doc: add technical design doc for large object promisors


Christian Couder (5):
  version: refactor strbuf_sanitize()
  strbuf: refactor strbuf_trim_trailing_ch()
  Add 'promisor-remote' capability to protocol v2
  promisor-remote: check advertised name or URL
  doc: add technical design doc for large object promisors

 Documentation/config/promisor.txt             |  27 +
 Documentation/gitprotocol-v2.txt              |  54 ++
 .../technical/large-object-promisors.txt      | 530 ++++++++++++++++++
 connect.c                                     |   9 +
 promisor-remote.c                             | 243 ++++++++
 promisor-remote.h                             |  36 +-
 serve.c                                       |  26 +
 strbuf.c                                      |  16 +
 strbuf.h                                      |  10 +
 t/t5710-promisor-remote-capability.sh         | 309 ++++++++++
 trace2/tr2_cfg.c                              |  10 +-
 upload-pack.c                                 |   3 +
 version.c                                     |   9 +-
 13 files changed, 1266 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/technical/large-object-promisors.txt
 create mode 100755 t/t5710-promisor-remote-capability.sh

-- 
2.47.1.402.gc25c94707f

