Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFB3B9D99
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546477; cv=none; b=TbxOaeF1FGNLGaYOSEoM5cNguvrC5K6sJshWTJXHmGW7yllkXckNjeQZXGmEgsPu0+z+DSBoFY35dSwbkkTW/nm2XHfgB+k1eGT11yWkYnBFLne0j9H8QAOF/jdSDUu4MSrCXWgipcQPgzu159+cPKVWebYoFc9xhG7eDxKdQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546477; c=relaxed/simple;
	bh=AF4kxt9knvdBs/u0vtnjh1LwcfbdbDs7ILuLty808lA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=COj9hoZb2iPetdwr4fM5itfk/0L0t2VhRdm81OwWGFwUax5/bsuS/Zg74RXSsXhlWKnmTx70dSfYRd97o4cindnqEbUeHIIG2+57cFymCpglXaOYImB5PYHtWr1dbUXQlAIWTQWDxuzWhK5KvLL6qPXsFGqSr2FyE0IEGbCML9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF9T9ZBb; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF9T9ZBb"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2e221a71e19so1050910eec.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546474; x=1778151274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isU/MJB7AfNbguRWhVmCmSXx+t0VR4YL/qKzbsuGgJM=;
        b=OF9T9ZBbI+nmcbiO2rwrgJf7IFfyXb/CyyOndqOb1Tmm0bZIHNVDnKcbIrCZSVP/Es
         VtE5fiX+CqgT542BbG+ltZprhJuEzQej97izP08BQxxJMtCvEgccshYyiVTH6nFFKJe6
         GzyaldW7kueKv1fKMF62FZdrgvIPAgASv/j+eYL5jq3Sx7432VM6Gn40cPY57VGkpDQ7
         ZTDF48akjKCcJOgwMPp9XLKUqMpdZE/z2CnWuNICdhLoSWNkAO58PAsqL/xjz9Os1pZM
         K7x5xrNkeO/Y9FBJr8xrY8JzqY7tPhUbxwdZE93PTvqDDlW3BFRVW8Y+H0+R79F/fZ3I
         mC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546474; x=1778151274;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=isU/MJB7AfNbguRWhVmCmSXx+t0VR4YL/qKzbsuGgJM=;
        b=TYX1cimECPXlQTYSXZ4AyKNxvP5LIatO+uAm2weTe8c/HZGtoc812ZhTlMjyiVhCc2
         HMoKnq/HWmzDWIoLov8iKNpmEwPYfe5FdQOqetneV/F3NZOqHkSOh2wG4i/wdbgfRQqx
         b/C7x0g+e21TYA/VdG2Yb9CMCYH2lUAseyFsIj/YBzM2WJY3NX/EqJuvWmXdeU3PYtyt
         gSkio2t5SAckzec1g+gOhE954PuLIhDSSuih7BBQ+l+0tLscYgnN1N8y5la3gz3llLTr
         Hnb51vfyvqtK5L9H6dBOcHaBFyiABNVfz/B8423B6CnOKaKej3niN7/pCPl5dZyVQZwq
         7XRg==
X-Gm-Message-State: AOJu0Yxof0/4Ba/S94NrEq0WGzcxKUv15RIC4Gw0+Uo5pCeyUwvnTw4l
	Bzp7Iwb/ij8w2AKOYAmq9CVsbdj4UgHC5uxYs4rB4BI6SUdmntFzYQHO3ZNVFQ==
X-Gm-Gg: AeBDievjWb6E3E3BVLlJdhyQ/pzBJMuZ7F3p4tcaqi8UZs66djJ+BnKWiUztfQ8IBDh
	M8T7OVspzD/G5FhYw/dHG9qq1mBUJP+EBKxDFYDPvSc0/oKT/XUM1+OgheXMFc364cTRISyLzle
	/s/XTD06sbezBYJr07SJHCgU5rPKdmHsDsN24TGhyv5PkFEX1/SVN/KTBriy1QoU80h1NG7Tq9m
	NeXY1+QHJKZTQHMjHELESzzs9QFQexA+TagXoRn9Q3mLgUalEZXls8yCY3xEeBqOOAo0Eqa2czn
	Lk0cMuSB1ipQMf8Juq+GdyF81ymVO+ibkH797VcEJeyMgzBRORAmcNy3ZfPad3c2/MFwHtUupn1
	MfOz1r0lP9xyeGFCm1NzCqNAfN3516FJKwQWrwEt+VIblZ5GuBBeYJLLZGgtljeo9XuKC5DzJW5
	Xg9bo9EDmveOX73FgKxUGoEXhH8UCCEg/Oyp4H
X-Received: by 2002:a05:7300:e8aa:b0:2e1:e5c0:7992 with SMTP id 5a478bee46e88-2ed3c5cc8dbmr852074eec.8.1777546474249;
        Thu, 30 Apr 2026 03:54:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c07058esm8026780eec.15.2026.04.30.03.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:54:33 -0700 (PDT)
Message-Id: <pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 10:54:28 +0000
Subject: [PATCH v2 0/4] http: fix emptyAuth=auto for Negotiate/SPNEGO
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

When a server advertises Negotiate (SPNEGO) authentication alongside Basic,
the "auto" mode of http.emptyAuth should allow libcurl to attempt Kerberos
authentication using the system ticket cache before falling back to
credential_fill(). Currently this never happens due to an interaction
between two older features.

The Negotiate-stripping logic from 4dbe66464b (remote-curl: fall back to
Basic auth if Negotiate fails, 2015-01-08) removes CURLAUTH_GSSNEGOTIATE on
the first 401, before the auto-detection from 40a18fc77c (http: add an
"auto" mode for http.emptyauth, 2017-02-25) gets a chance to see it as an
"exotic" method. The result is that auto mode silently degrades to the same
behavior as emptyAuth=false for any server whose only non-Basic/Digest
method is Negotiate, forcing Kerberos users to manually set
http.emptyAuth=true to get seamless ticket-based authentication.

This series fixes the interaction by delaying the Negotiate stripping in
auto mode by one round-trip, giving empty auth a chance to use the system
Kerberos ticket. If there is no valid ticket, Negotiate is stripped on the
second 401 and we fall through to credential_fill() as before. The true and
false modes are unchanged.

Patch 1: Extract a http_reauth_prepare() helper from the three retry paths
that call credential_fill() on HTTP_REAUTH. Pure refactor, no behavior
change.

Patch 2: Delay the GSSNEGOTIATE stripping in auto mode and teach
http_reauth_prepare() to skip credential_fill() when empty auth should be
attempted first.

Patch 3: Add tests verifying that auto mode produces an extra round-trip
(empty auth attempt) compared to false mode, using the existing
nph-custom-auth.sh CGI infrastructure.

Patch 4: Update http.emptyAuth documentation to clarify possible values
(true, false, and auto).

There is a trade-off in auto mode: when a server advertises Negotiate but
the client has no valid Kerberos ticket, there is one extra round-trip
compared to the current behavior. This matches the trade-off already
documented in 40a18fc77c. Users who want to avoid it can set
http.emptyAuth=false.

Note: this patch series was taken early into Git for Windows for the
2.54.0-rc2 release.
https://github.com/git-for-windows/git/commit/8e94b65c003783d7d7b09d9fccdf06a1363e347c

----------------------------------------------------------------------------

Update in v2:

 * Add patch 4 to clarify the available options for http.emptyAuth in the
   config documentation.

Matthew John Cheetham (4):
  http: extract http_reauth_prepare() from retry paths
  http: attempt Negotiate auth in http.emptyAuth=auto mode
  t5563: add tests for http.emptyAuth with Negotiate
  doc: clarify http.emptyAuth values

 Documentation/config/http.adoc | 13 +++++-
 http.c                         | 32 ++++++++++++++-
 http.h                         |  6 +++
 remote-curl.c                  |  4 +-
 t/t5563-simple-http-auth.sh    | 74 ++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 5 deletions(-)


base-commit: 2b39a27d40682c09ac1c031f099ee602061597cd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2087%2Fmjcheetham%2Fspnego-fix-upstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2087/mjcheetham/spnego-fix-upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2087

Range-diff vs v1:

 1:  49488cc7d4 = 1:  49488cc7d4 http: extract http_reauth_prepare() from retry paths
 2:  f175294459 = 2:  f175294459 http: attempt Negotiate auth in http.emptyAuth=auto mode
 3:  650acab79e = 3:  650acab79e t5563: add tests for http.emptyAuth with Negotiate
 -:  ---------- > 4:  e0f236767f doc: clarify http.emptyAuth values

-- 
gitgitgadget
