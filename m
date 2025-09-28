Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B929BD90
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097376; cv=none; b=tPP+IdjN7TcJr205h9MOUat+wA+1VtULKF5Nzdz8RERTUbVK1vMhRqlz2zLVCxvsrqWaqJlnStkTQaXmOiFXJdq8ivViAW9euow9B9zS6KKohZe1FzQPVNKB1zfqOCz8HCEWz2TCsoFItkEDO9LSNCF1qc7ME/gXXaY/cnofBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097376; c=relaxed/simple;
	bh=E0OOgwoNtSje4FCGs91Ks9EtuewNvHsL1RUoY8NyLGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfm9h41yvhOGfHrVL4bPlzC9Rfhvn3zO9Wb0OwwTSuqSBq3TQi1e/As76ZFWSMsSRid25HMXuDH6hctYS9KazUp2VE5IQIH29Enj89WSLFASqBAQESXHXWIVD7/DgT4eGCqA7tcs13ll3N32+rOXkWLjAWs8Nl1YiAqhrVQP7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=f3wJFkGi; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="f3wJFkGi"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-6353f2937f3so3019034d50.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097373; x=1759702173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMTcabX6P4fgSRpxuNdLM7yGcGTMWMWILcJXlcaYL7U=;
        b=f3wJFkGi9K+U3rH9BLIXZ4D50U/KYje/FQN0QJcLj5J3UrbRsO07tZFuMixn9hJQXi
         /BUYHxIwU9svgs/w0ooOFOMMUFbo6vr4XC8LUm5lAAqCP40vsuFdHvDGUC8zv/UYDwYy
         Kr/7HX57yqUwTRwaGK+tG4B/yOS94bk0z/SNE8/puHSL6DOJrisb+/GBmYDh/lTlheA1
         sYCcSiLLxwH1xXf0mFT65bb0GoyNRv342Gbj43BboKF/4d+uLWbTBY/BlA0Q2TFXMHxS
         BkzoO4r8a0XuyZJxSbrTDIijv8nP7z231Y8hkkkUKmhNKneC0uDKyjyanZRm29DlerMy
         aOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097373; x=1759702173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMTcabX6P4fgSRpxuNdLM7yGcGTMWMWILcJXlcaYL7U=;
        b=SgMl4RebiHpkZ/PXsgNVZBj4aiUJqAurUD5b//d9+u+9H24UuyN7PivVCg0uwDsmMG
         1B2IKFEVGPZunkxcPGjWs9FAg8DDS5ZVf92HVudgmWcftngDZ36so3tn83J3CAgz4OUX
         T8djjz62mFHNNAPRh5Y2PWDB88lTYdilrQgy87NxEa6NoVKMHXFBTLMEOFFzxw3ACNx4
         plZUglt/qLrSmMyq/0ZYUi/rddscPzMyksikXIloiUFaCeoppvjSw8dKn4hQuyLJs5DY
         fWZwbVTBxyOlA+IwyCRIXLpi/h110BkiEqj/lBaJNzdCXE8OiWLUIqWMVVNMlt+0PPNM
         BK+Q==
X-Gm-Message-State: AOJu0YwB2ldqUH/NNtyPr9CPr72TbMut/EjQwqKQB6zBw2d4YnXQcqoh
	kg8C29zAJSaFMIf5dJ1XDNnigQECrmRRQ/elzEGBox5o8c8ViFuGOeALzo8pJeyVvkgFJCIwo1y
	k90V144OHv6RQ
X-Gm-Gg: ASbGncvWIspDuXlm1tFZOCls/9hM6UuDsr1vGpY+xUiT2XrC9OcQGndqKr1TkYY3nvt
	fIsoJrxFTcXCJtj/aT0Bx12ADh00k2i3ytvD30ld4KUKpsnK3U4xZCOuPYTdPctjx77rkRqmKtW
	uvV75Kd+dEUIfAOLYH23hKsNMgZr+4xI124Pq8KVfgPYWA9y5N6+kZZARY4lI7Ho5p/TSABWL8x
	DDeTndezUUoe0Pa2SWL6yZOoLb9iCP6zQS6vP2nM22Tr3fwyOhe3Vkg0hB1q+b/VvgXIoFC8t6J
	2CmVF8eFQ6XR8+FEh/BsFt+HpjuRpNQiLbx716u2PIyt0fU9X0NT29r8p4Vx5/dsB+oFAMRGoQ9
	a09434WXuX8LdAEFlRcatq02V1ABCpYHFu0KyDRDp8p+8Tge8xQHhr1RIuNF9NufInFgmTdCWpn
	7Hc3o9jlmxR69rQ9Qf79X6BCvt7lT5S9LnEzK8
X-Google-Smtp-Source: AGHT+IH8nNqyj8otUQVTpDDbIarge4ukOEr1Ux16fm8UBLoxpM1PY527aHvWaZyatSqqjk0B+XCwbA==
X-Received: by 2002:a05:690e:15cf:b0:633:b017:42ba with SMTP id 956f58d0204a3-6361a74aae9mr13427360d50.14.1759097373515;
        Sun, 28 Sep 2025 15:09:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38393c804sm2939206276.24.2025.09.28.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:33 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 36/49] builtin/repack.c: inline `remove_redundant_bitmaps()`
Message-ID: <2bf732009ab8330d207ab3a4653fe784b1a5df83.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

After writing a new MIDX, the repack command removes any bitmaps
belonging to packs which were written into the MIDX.

This is currently done in a separate function outside of
`write_midx_included_packs()`, which forces the caller to keep track of
the set of packs written into the MIDX.

Prepare to no longer require the caller to keep track of such
information by inlining the clean-up into `write_midx_included_packs()`.
Future commits will make the caller oblivious to the set of packs
included in the MIDX altogether.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 957a9b5f9e..b55c8934e8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -331,10 +331,10 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	struct string_list_item *item;
 	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
 	FILE *in;
-	int ret;
+	int ret = 0;
 
 	if (!opts->include->nr)
-		return 0;
+		goto done;
 
 	cmd.in = -1;
 	cmd.git_cmd = 1;
@@ -392,14 +392,18 @@ static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return ret;
+		goto done;
 
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, opts->include)
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
-	return finish_command(&cmd);
+	ret = finish_command(&cmd);
+done:
+	if (!ret && opts->write_bitmaps)
+		remove_redundant_bitmaps(opts->include, opts->packdir);
+	return ret;
 }
 
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
@@ -1003,9 +1007,6 @@ int cmd_repack(int argc,
 
 		ret = write_midx_included_packs(&opts);
 
-		if (!ret && write_bitmaps)
-			remove_redundant_bitmaps(&include, opts.packdir);
-
 		string_list_clear(&include, 0);
 
 		if (ret)
-- 
2.51.0.243.g16eca91f2c0

