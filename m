Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3B37649B
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112484; cv=none; b=WHFqcNG552vLHwycPBUjGXHjlVrARu3G+o77x7t1Ircs3JMS6hdslKFdP1GHveDy1U7UHQ3lZJMkrR6scNTy68aB8qAPhfSKKWA5aB6avLmkB+e1PlG8K6jGH9njiW8udJEx+O8NwqVwtgVkPNwQoPGQUIZm0S2isUfKkyHYjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112484; c=relaxed/simple;
	bh=cQF4Ctq+OI6wmw0tzONcoC6YE66HxXNsI8dNJqgJPt8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ncCXZ1hQ9QQgtor8hsJcuvXMrLY3zZjZBfyLLp23AurJOwtV6qVytK6ZPN09mdBiFqsMps0zowee+oUUJeKjeqW9N2NMQafDeJb2oMRlsUXJC9V8MO5l884vu7GbMvXPjrmGVoDUU4AlSclSQSiQs7lmuZYHfmC/SYjtR1tA7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkPHrmud; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkPHrmud"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1233b953bebso3124227c88.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112473; x=1769717273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfG4h2xO8Zt8eTkMnv5UQnUvr40tyBqb8p62GMJXBrU=;
        b=PkPHrmudSAfqVk8Av23BF8hLIGYgI+hT8PFpWE7q0odg1g+xdx8+sfQzrZiVPpXXtn
         PnpelXuuDnCcxVLwcIc2HZq0+eETi7GVAyd2z3iF4Zb43ee3iFtEXMqA+WtQ0hqxb1JX
         +I0OGBXPf52hWJ6vHnlKedUi68DNVmxFda9ZqROcjbcGkcmB1a9XKXeQv0SYT3b1Kvv6
         kENq1c2AakiuWnLTzzqwc7MBNEqF18L4veD5JqZttYvFzBXwtZ9ijjQFricSgzoXbaak
         rfEMwPYeOZQ9U/xEJMIVBU16lD4IJy1VeywgwTGvh2lfEgVsW351R4KxWnCMnwrOlIIC
         CAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112473; x=1769717273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JfG4h2xO8Zt8eTkMnv5UQnUvr40tyBqb8p62GMJXBrU=;
        b=jMH0Uwj30JSN/5il7WzTxMQ52Ji2rZDxV3R88uB0ms2LQmdoozHD0KBReN6dU06TMG
         ChC9wKlL8PezWyIQkluaJ6M8W0HZHDVytvaDP1rPCknUH9SaFJn8kNI5J9odDTmmVi2H
         t0uj2LEItTEkhOuTLMvH9dM3kAx2NoWIyltGn0er6MpUkvFft4PrLfSmiKfkLlEtzyH8
         j0fP775Gjp+GP/Eez6f8CHkqFvqIGuzbARcs0tFtJSvxdQdxwtBZB3u3EGqELPtk7C8p
         BlRA16WYmnQukXDRFf2vOUA2Sk+523FuFwYusZ7lPlwIckMbmA4pBaTy5tPvYUyVRcDf
         CpYw==
X-Gm-Message-State: AOJu0YxO6OooYBlgWpnFPlunG7/eBaAE6zvnO+9Tb9ewC++u2Yw+x9Rf
	PAOdZIJL2/NW7BiXQmSe6KpgeaphSOJJIWfwAVX+hXlBlciW1lXmL1uWvhJtAg==
X-Gm-Gg: AZuq6aK9YCn24SFCD9nFC9GEsx4b2tUzWm/TFmzIqrq35R0fyuj9/rIN7gLJ/URmGLd
	XvYU3S0JQBIJJEMO3tBf4YfLLOGiBEhzPvYvpSqbW6kCEqehBqaw4sSrLF9Ts+mliEKDJVgIQ/s
	hBoLaO/wfDVtwn2NgQ8ww4ynU8xFkvjtQHatNyRF/AxklosElZcehOvFiR7llgDU5pq9Aqqgvxt
	5U2VOITrEwwVIodn2SWzR28XgvU4svjsS+Nh0nsvrQ3USiBHyQGxc7VfF7GDaUh8IGuxpPGcotA
	mFEABLsPNlZuXylxEbu6Rk9cbGpg71h1RcgfXIMpDgCOYqr3vCg6Zpyd23IgBLZ/9HjK9CGf9/6
	/xJ9+4REKYd1GeaUjyWC+g+5uwPHe/D0mlflGRkf/suajOuqwqXzzj6FNproYoAnq5QpF2G3h+A
	/Hz17TLtsuDpMo
X-Received: by 2002:a05:7022:689b:b0:119:e56b:c73e with SMTP id a92af1059eb24-1247dba9d34mr316819c88.3.1769112472672;
        Thu, 22 Jan 2026 12:07:52 -0800 (PST)
Received: from [127.0.0.1] ([52.161.51.150])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a4698sm708025c88.16.2026.01.22.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:07:52 -0800 (PST)
Message-Id: <pull.2138.v28.git.git.1769112471.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
References: <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 20:07:49 +0000
Subject: [PATCH v28 0/2] status: add status.compareBranches config for multiple branch comparisons
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
Jeff King peff@peff.net

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: add status.compareBranches config for multiple branch
    comparisons

 Documentation/config/status.adoc |  20 ++
 remote.c                         | 191 ++++++++++++++----
 t/t6040-tracking-info.sh         | 337 +++++++++++++++++++++++++++++++
 3 files changed, 511 insertions(+), 37 deletions(-)


base-commit: 83a69f19359e6d9bc980563caca38b2b5729808c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v28
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v28
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v27:

 1:  27a46f8d9c = 1:  f3c8c782b0 refactor format_branch_comparison in preparation
 2:  0993420fc1 ! 2:  067978dd09 status: add status.compareBranches config for multiple branch comparisons
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      -	int upstream_is_gone = 0;
      +	char *compare_branches = NULL;
      +	struct string_list branches = STRING_LIST_INIT_DUP;
     -+	struct string_list processed_refs = STRING_LIST_INIT_DUP;
     ++	struct strset processed_refs = STRSET_INIT;
      +	int reported = 0;
      +	size_t i;
      +	const char *upstream_ref;
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +		if (!full_ref)
      +			continue;
      +
     -+		if (string_list_has_string(&processed_refs, full_ref)) {
     ++		if (!strset_add(&processed_refs, full_ref)) {
      +			free(full_ref);
      +			continue;
      +		}
     -+		string_list_insert(&processed_refs, full_ref);
      +
      +		short_ref = refs_shorten_unambiguous_ref(
      +			get_main_ref_store(the_repository), full_ref, 0);
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      -	free(base);
      -	return 1;
      +	string_list_clear(&branches, 0);
     -+	string_list_clear(&processed_refs, 0);
     ++	strset_clear(&processed_refs);
      +	free(compare_branches);
      +	return reported;
       }

-- 
gitgitgadget
