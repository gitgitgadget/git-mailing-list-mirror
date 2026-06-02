Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBD3DA5B1
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407561; cv=none; b=iyPTF9hYg7aBx1xMr5PwMXx6xNl+GySsVVckzIK/J3ZaiLGcmDg3Lt6izENZryHFU1USmOKdPTY/amU+rtZFIc/4Xet9P8dPNNBTewVj845cG9VMJJc7XSkjl8T4FX3Jwpf7SHdiV6g5D1BmlKVBu36WexZm4GNvockgw/1DSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407561; c=relaxed/simple;
	bh=jSOUCn7i1YomPVPnFl3/AX0K3BcFKBCRa4Ic9kau3a8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZYXYDze+pDa4cDeS4l/7ZDNIS03LE7FiFnNkYuR6B1RQsIWCMuduRySwbtlA7RkH1mGgHM85TzTfxf/soAQjw0MwkCVzaanHi58ByLoIrGVnwP9uB8q429i6IM9ePrfUCv/Dd0qALtt/JHseSMub/Y4MD03XgF4JgNWKnjAN9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN7F6m9M; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN7F6m9M"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176d4c14f5so4969351cf.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407559; x=1781012359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3Zwto6MdMS6YtBkNjZ5fKWWFOILr2KNTg7LBFJ4izE=;
        b=RN7F6m9MYQuPkLHm7uTt7C+iIXR+h1iOTMbwx7mm07iEjMvdaFuSBzwxyTpxPmSpKZ
         3KL9Eu9L6F5Sdew0WF4XHDBHON1sLskQc0UZTnO+HLUaPL3EYOau+7JbmDLGXB2I2jXb
         LPCxCmgp0ZtK1FmksvH6TtpnDmr/EfII2G2Pe9aCh6sk961cZ2N4wOYuw+eV0/xcIFQ2
         V+x+oSx2iV3AvvALLDOOVB7AVM8T+ChYKx/nhFWx65d3wk8GN0mwEoNpEjyPNw5l5g5f
         L8Y8LesZ0aqzvDBr8Krwzv2IM0ppU7Qqf/2XTAIAPMhtmS2GIRyqaGBNCccgX6t+KgMO
         MsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407559; x=1781012359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I3Zwto6MdMS6YtBkNjZ5fKWWFOILr2KNTg7LBFJ4izE=;
        b=eA7L4wSt67a6Hll1eEp3CyQIrR3QSXRzGcgU6oZ0Oa5MJC0eBg49RVcFikg/77GitX
         haTToRuuKVtmMl2C1yrY+5xzrEv325I5NPYu/W9B9RQ5VmE/Dvd7aFtcuKLf32gWU6GT
         oxfYZob37VZmP6PIk//dvhXQuF2WFwOxVy4WrOdJaxbf61DL1bFX2cdjuSdDVwcDx1OP
         NLnvWXhwec/0nxbNKonbSD34uCkIZ0zT2XE4cw72XfD6BMegQAkytheN+tWzecz+qb2o
         PYSsfj5GFFs6rlf3kskQjZDjeFaqL5xL9jvpPC8TCDLrh2+hpHuIV0ZtYjgQCaEu6dHa
         dzRQ==
X-Gm-Message-State: AOJu0YzSl8UInvLh7PLlw83SUepgkmVsDJd6Q0piNFmCvHoNzJiFSuFg
	OixynXzWY5D/JUjHcxNxg68gRI22C2hnv9SulWJhp7Bn+Hmp11JfSR4fCxl9Yg==
X-Gm-Gg: Acq92OFIlcaIf56ReHsqw+ykrnKe83TFSsfOZQpNb/sfosGYqj8NAjlDcn4bIwEJaEm
	PzwS9WpbZXwWJmvRCpmxyVE1zEYzoIj5PTkzF4Kx6keUqFHBiS+OlxgGWaV2sLYT4qYr8lWU9IX
	4Z70rHmB69cJkR3ozC2hvGAlgtSWGD5b2Tazfx8t5DRTpBG+x9KZrt/oJ0BFFFH1R/ibxpgBZZq
	GtKB+CjxiKPyxQ23o0Oyi01QELwqBkmT5RbCwi12Ncgt0+xomOV5kzi1IXvBYD76mZIS6aazmUq
	PiLSUrSuPQg6veh+m3/KmNYm9qRgtJOMGHS7HhujirVjQiFBOAWsqhs+dpLevE6ipCpPRatGRrm
	7D/D80VH/FSM9DZNaX95KPU2NvVBAUm0EJZwUBv3rgag+JkoqC7WdKdT/E5dRzZbiq9eoD716e8
	pyZrkdBfnOW3QISb/Vxv5R7WWo+pBObBAbHpU=
X-Received: by 2002:a05:622a:14d1:b0:516:a471:dfc1 with SMTP id d75a77b69052e-5173a817bc3mr224481971cf.49.1780407558724;
        Tue, 02 Jun 2026 06:39:18 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b2afd2sm79964171cf.10.2026.06.02.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:39:18 -0700 (PDT)
Message-Id: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 13:39:15 +0000
Subject: [PATCH v5 0/2] config: suggest the correct form when key contains "="
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * New commit config: let git_config_parse_key() validate quietly adds a
   quiet parameter (and an optional store_key) so callers can validate
   without writing to stderr.
 * Validation in die_missing_set_value() now routes through
   git_config_parse_key(key, NULL, NULL, 1) instead of the previous local
   helper.
 * Added tests for 1foo.bar=baz and foo.some.b_r=baz.

Harald Nordgren (2):
  config: let git_config_parse_key() validate quietly
  config: improve diagnostic for "set" with missing value

 builtin/config.c   | 34 ++++++++++++++++++++++++++--
 config.c           | 34 ++++++++++++++++++----------
 config.h           |  2 +-
 submodule-config.c |  2 +-
 t/t1300-config.sh  | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 16 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2302%2FHaraldNordgren%2Fconfig-hint-equals-key-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/HaraldNordgren/config-hint-equals-key-v5
Pull-Request: https://github.com/git/git/pull/2302

Range-diff vs v4:

 -:  ---------- > 1:  d938ebf95a config: let git_config_parse_key() validate quietly
 1:  780b99409c ! 2:  e5a2070ee1 config: improve diagnostic for "set" with missing value
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
       	exit(129);
       }
       
     -+static int is_valid_key(const char *key)
     -+{
     -+	const char *last_dot = strrchr(key, '.');
     -+
     -+	return last_dot && isalpha(last_dot[1]);
     -+}
     -+
      +static NORETURN void die_missing_set_value(const char *arg)
      +{
      +	const char *last_dot = strrchr(arg, '.');
      +	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;
      +	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
      +
     -+	if (prefix && is_valid_key(prefix)) {
     ++	if (prefix && !git_config_parse_key(prefix, NULL, NULL, 1)) {
      +		error(_("missing value to set to the variable '%s'"), arg);
      +		advise(_("did you mean \"git config set %s %s\"?"),
      +		       prefix, eq + 1);
     -+	} else if (is_valid_key(arg)) {
     ++	} else if (!git_config_parse_key(arg, NULL, NULL, 1)) {
      +		error(_("missing value to set to the variable '%s'"), arg);
      +	} else {
      +		error(_("missing value to set to a variable with an invalid name '%s'"),
     @@ t/t1300-config.sh: test_expect_success 'invalid key' '
      +	test_grep ! "did you mean" err
      +'
      +
     ++test_expect_success 'set with 1 arg: digit-led section name is valid' '
     ++	test_must_fail git config set 1foo.bar=baz 2>err &&
     ++	test_grep "missing value to set to the variable .1foo\\.bar=baz." err &&
     ++	test_grep "did you mean .git config set 1foo\\.bar baz." err
     ++'
     ++
     ++test_expect_success 'set with 1 arg: subsection plus invalid variable name' '
     ++	test_must_fail git config set foo.some.b_r=baz 2>err &&
     ++	test_grep "missing value to set to a variable with an invalid name .foo\\.some\\.b_r=baz." err &&
     ++	test_grep ! "did you mean" err
     ++'
     ++
      +test_expect_success 'set with 1 arg of valid key reports missing value' '
      +	test_must_fail git config set pull.rebase 2>err &&
      +	test_grep "missing value to set to the variable .pull\\.rebase." err &&

-- 
gitgitgadget
