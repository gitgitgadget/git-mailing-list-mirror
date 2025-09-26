Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555C2F28ED
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882777; cv=none; b=fdvUEinhxDSL4PPLT7oOxw37vcR3G6fWLtph9ErXWFEbPRaQ5B2iCExLH7YinC9RFYC0m9xebkbcc/dfCIsfakhR8IYCf/WIrIXDv25DKu8ytw6eFMaX5D1eRhByt5TEx/uYhHEu94iam5v534aJ/Pf6Uv3D4747w8OsmKdBEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882777; c=relaxed/simple;
	bh=XCvKLiAr/UW5aSVT2WepA8frpszGA5sEclrjqPkK1q8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dNz2NSz4nb4eIxlUwMdXisiMBCw4jR53Gg8KLaE7rzV9ec8wJI3TuvDDf5P8W2UfRGP0ElwwnkfKATP5h+CjQO8Zhft+3nWZnn83OH1WLQRdehmctQ6Et1L/R47eyfsRzqBScBLE9GirPefzVV6DkjspMyUxj2yQodiWn1iMpeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Neot+Hap; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Neot+Hap"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-84cb12f56c7so213756485a.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758882774; x=1759487574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daNak2oH4vBY0qLxzdpNejWX8guedrxWmXeEUrLKlhA=;
        b=Neot+HapLR72wRtbL4qayRZyxeNGc4WYatPKLmT6NBqIKtIRUbPjUICI9W+1cNg6j1
         RCj1NXAd0THTlW9BZbsHbMhHyuk2Hn80DCopn+NN0RmV9+KRGmfTpl4JvFeyxOljdTGu
         yozPJ85E5yPr539ButgObHs4LvKXfodbSJQXxI0An2XDekuMHZurTbdmwoVOsUzxzgWj
         NOYvQR1ptj8wiH0DG4oXD3W33d7p8MzTo1/nsXwsyvxXw5GzBrmkY0b+ofO6xId4Z0G9
         gilGvXJ29/kunGjaeHRzEDExRwZ6I+Rt7lPKq8iTqFt0ezYIMVI6AapdAri0x9DrKiDF
         JpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882774; x=1759487574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daNak2oH4vBY0qLxzdpNejWX8guedrxWmXeEUrLKlhA=;
        b=TzDZAXtLqMZkt5PtRMWY7w4QytvWre+smv0xqd7Z7DuE4+CYty1ziHcOTl7dFuUYs4
         WCLgXX8XyfKJ/dYPj/aJsvvzzLKjrAG9LzxCetlH1RACTlmwxdb9NLn8dm+EH/V8lLBZ
         K+A1P1GgcIdIHDsSDLXlDxtADM6XOPdmDL0WI8RQW7Fc/EWEML9sxcFwn/vXxocr0Hux
         PFiBFsj7nN5LTR30EjNDxh97d9tvEC3Vj/sVgVJYXVWg6mgU/BNiQhlltPQM8kk0c+X9
         PEMPhZJOLpn8STmaeDOtdOHlSI7Wit8eG3JMRmlu4s4r4nUChEFEsJWcOcXEPWOuOVET
         2mXw==
X-Gm-Message-State: AOJu0Yz7jSfqP0ATaCim8MRiuDVrMukF8SN8cREwEN9uZEqdekpTxtDH
	pocsrStjY7F0XUfgzPNRXwdmvSgczJ9S6JGp8D6fk4FpSmPRrY2n2J3ieRuqhQ==
X-Gm-Gg: ASbGncuI0IoeCJjIciWWqcesBArCRrtsI01weHrWNe+cV6Z+MZ3EJHjV5P7JI17IjiI
	Rl3AfXVCyouepyS5JIs6QvJuihZ8wtapGf+OsuDi0FzT3Gaj+prysXslQNeCc7sgJaNjMMA5Hhm
	amhJ9mgmPly69DwRCgXdzVHUN0gBCSkJK+OaNVjM+4adxULAfS/tFbtppSJ4UrSWW7mDDdnqoPu
	33wL4GrT7AOe671gBYN/4g1G1wluzJsFPvnMm0uivOFJsBSpT4mbuO8rtgazqQEBtsw90JLiP+7
	20xRIBl5OVZvaVbRqekoxuRItY1vyJ3zGmDf6Fq/V4LkPo66Kk7b6uo48yVVbWasvyytX4FWqut
	88ZEs3sEo80rA3tcp6MEYeA==
X-Google-Smtp-Source: AGHT+IFHqnpoVx6Fe4oKPHPsVhLv/cWVOuYHq1PmSXdLaf2PlsDgF8qyUfnqvFHOpcPsRGIkGTyEKQ==
X-Received: by 2002:a05:620a:4892:b0:858:c95d:c14b with SMTP id af79cd13be357-85ae8a3dee1mr872236685a.67.1758882774245;
        Fri, 26 Sep 2025 03:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c2718e5acsm254185985a.14.2025.09.26.03.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:32:53 -0700 (PDT)
Message-Id: <pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 10:32:49 +0000
Subject: [PATCH v2 0/3] Fix curl_easy_setopt() parameter type problem, again
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

As of last week, every CI build of Git for Windows' ARM64 flavor of its SDK
started failing (the first failed build is this here:
https://github.com/git-for-windows/git-sdk-arm64/actions/runs/17633130672/job/50104373185).

The reason is that we still have one curl_easy_setopt() call that is
supposed to pass a long parameter but doesn't.

The likely explanation is an update to libcurl in the Git for Windows/ARM64
SDK. A strange thing about this: GCC does not catch the problem, but clang
does. And even more strangely, the relevant parts of cURL's typecheck-gcc.h
haven't changed in a way that explains to me why this starts to trigger now.

To prevent more piecemeal solutions, I vetted all calls of
curl_easy_setopt() and satisified myself that all remaining calls that want
long parameters do indeed have arguments matching that type.

As is the custom in the Git project, I use this opportunity to do a bit more
than is strictly necessary to address this problem. I replace the affected
call with one that expects a wider data type, refactor an already-existing
function to cast to said data type, and use it in the modified call as well
as in another call which wants to perform the same cast but did so unsafely
(not that it mattered in practice, really, yet it is in line with other
refactors the Git project has seen).

Note for the curious: The affected call used CURLOPT_INFILESIZE
[https://curl.se/libcurl/c/CURLOPT_INFILESIZE.html] and now uses
CURLOPT_INFILESIZE_LARGE
[https://curl.se/libcurl/c/CURLOPT_INFILESIZE_LARGE.html], and it is a bit
strange that the latter wasn't used in the first place, given that it was
introduced into cURL over a year before Git itself was born, and almost two
years before the call was introduced in 58e60dd2033 (Add support for pushing
to a remote repository using HTTP/DAV, 2005-11-02).

For the record, these patches apply cleanly all the way back to v2.22,
according to git replay. I did not try to test whether it builds, though,
because all kinds of stunts are required nowadays to build this old versions
even without any patches on top.

Changes since v1:

 * The commit messages now reflect Junio's suggested edits.

Johannes Schindelin (3):
  http: offer to cast `size_t` to `curl_off_t` safely
  imap-send: be more careful when casting to `curl_off_t`
  http-push: avoid new compile error

 http-push.c   |  3 ++-
 http.h        | 10 ++++++++++
 imap-send.c   |  2 +-
 remote-curl.c | 14 +++-----------
 4 files changed, 16 insertions(+), 13 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1974%2Fdscho%2Fcurl-easy-setopt-typefix-again-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1974/dscho/curl-easy-setopt-typefix-again-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1974

Range-diff vs v1:

 1:  7caaec9102 ! 1:  114eb9c8ec http: offer to cast `size_t` to `curl_off_t` safely
     @@ Commit message
          naming convention of the helper functions that safely cast from one data
          type to another which has been well established in `git-compat-util.h`.
      
     -    With this move, the error message can unfortunately no longer be renamed
     -    because the `_(...)` function is not available at the time of
     -    definition.
     +    With this move, `gettext.h` must be `#include`d in `http.h` to allow the
     +    error message to remain translatable.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  e1d5a85f70 ! 2:  fdd1327e7b imap-send: be more careful when casting to `curl_off_t`
     @@ Commit message
          imap-send: be more careful when casting to `curl_off_t`
      
          When casting a `size_t` to `curl_off_t`, there is a currently uncommon
     -    chance that the value can be cut off (`curl_off_t` is supposed to be
     -    guaranteed to be 64-bit).
     +    chance that the value can be cut off (`curl_off_t` is expected to be a
     +    signed 64-bit data type).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 3:  bcb231125c = 3:  140755673d http-push: avoid new compile error

-- 
gitgitgadget
