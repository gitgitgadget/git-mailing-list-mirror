Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEA3B3894
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981459; cv=none; b=kRvTMgsqBn2tXj1oQ2gs7cszj5Xb5wrqs9I0DX2xNFwsYWu3DvovODPGyjmDSRXC2QMIwCijKvBPHi2HcQfMu9a8OJMmn2jd42T/cCHVM7QpXyOHXmhMTlUgPPm7XBywnIVDgB81CP3yPkFrgJKDhNYJbt7WoLgv47qkP7JVTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981459; c=relaxed/simple;
	bh=H0PizsPPV+MUAUIJw03y2J4nzFYS8HH7EkBFpHktLpc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=taFuNHqoMt13gSmMZVCNmMInoc7BIEPRFYDdjvDCgp7pRXaVYz6yyXZeExh8kEgeayQr8+txA/AkuJTWXxp27de8E6aSVqYjPjdZV/JYurRxzxZVGGjudcqDREpI/3Ap03ETFu60bdWDb/iGpz7xCyM2Tfi1OUGiLEcF5/WbH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYIVfdUp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYIVfdUp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0248cfso634322a12.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981456; x=1789586256; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BU7QYyd1JGW8st5nbHVrxZlsyyeMc3aYDaoFk0R7Cks=;
        b=OYIVfdUpLDxDZp67Jj9Gm5xcyA0FrglKZJLE3hoovv1aAtyrxrPUtIg5xkdpY2P5+3
         56aoGwQMk9JdM2aspkJgjQH1vYcYR/Icyn+8zof+C0LoA9GAC/X3G1Ac6gTLk2j9D5RZ
         GHOHpRTRAdvFuhkhVXaxJNFmOlGaXpcH6H9WbWvRmXwr07ZPx3hgDtDOdZoOsGsKgNqa
         Zx20UVr0EM8WG+hCVxKQMngNq4CR2jitmmE6bXkVI+4bE5V19RrJXTEbWcKOrGbjls/b
         brrUrXwublPm2RBxsP6scK15lW+BsmO1+kj3nBN3yN3YUpbL18HAkoh6a5A15zGnRWqj
         tTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981456; x=1789586256;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BU7QYyd1JGW8st5nbHVrxZlsyyeMc3aYDaoFk0R7Cks=;
        b=L8rijTuyN+1/Eb5Djp6fEhlN68sTv5KEXCYNmW5797J515hM3GlyJ9meDbgpelPZmL
         gPSs3Tx8fLM6cxsfqGNNRbgfJ/LiRaWTaTdR/eLdrN+76fU4EoeX6+tmNZMMkpOng/jm
         7RRs79uR94/IguHotEPJ1S2sJoZe601D6TZ5rAJtgRh0zwE2vC4dynfyojWV1wO/T1a8
         o8IdEF6KL6ct5VW0zAxowkGdXFKXlnBxKHgevN6JbC3PfSLOcMflwhH8UT6KAiGbOdv3
         MvzdcIGJh120LDT2enZ71bm7pQIT0s0+wIfHyqCBuGaCEFe6cVUnrXuo7gnmWEflYsbY
         ESWg==
X-Gm-Message-State: AFuF++lmIYq/mMFVnYM1AGLS/g6j4ESBASyrGAwfg7OAmnknaG+NyVOr
	LrJzsGOdP8B9UC/ftSBtitE1E8vFEyrn5pr7hg3d3Dh0CPDaeMajpEbpGDUvow==
X-Gm-Gg: AYBFou29SWjnPx4jofUkRMlhll+Xa4GWdTCdjFIOn+n0/fd70N/om6CPgTtsZp93g8a
	0ioaWJ3KKRLGnRxhPykSV9RrxT53WmYlTF+BLRTN/hUxE3X4vigCAxW9/36aUlWPWJqf5v9WBsz
	uSSIoR1tsdgRjj1n+xfwAtZWvqj4oNtTWKJEVY3xBmlrul3GCtb+X/E9oSplGyZtRZcV/X+3iiw
	qgvn8AuPmskUIdV6jlwF+ykX//x3uJJ2m9fsxvfUO8FoywEiRvNFWQc1muisD6pan7s2VR9Irb1
	ICKR8/0DcmTHva5QdkH9wou8XyUSPTl2XSV0jfJMxj4Hi/lMge2OhHXzI+aWlkTA5rMuoFUMwam
	2DlPQEICfnKyBxbYP8iXHTXDGlBovlYFZM6Iba69Lu49+2W35VAAIKWIeKj07XpuxIhD0mEsgP5
	lHYt1DSyRHqzC3M7rp5dk1gQZdjX+V34fu72Tr8ZCf8H7RPaKbKiKh1IXpWLvbKdU9iO1XjmeO
X-Received: by 2002:a17:90b:3c05:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39b26106c44mr55799606a91.10.1788981456483;
        Wed, 09 Sep 2026 12:17:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm41605719c88.13.2026.09.09.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:35 -0700 (PDT)
Message-Id: <09c90015fb129129ca2f35945269d46611efbd24.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:15 +0000
Subject: [PATCH v3 11/12] mingw: ensure valid CTYPE
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A change between versions 2.4.1 and 2.6.0 of the MSYS2 runtime modified
how Cygwin's runtime (and hence Git for Windows' MSYS2 runtime
derivative) handles locales: d16a56306d (Consolidate wctomb/mbtowc calls
for POSIX-1.2008, 2016-07-20).

An unintended side-effect is that "cold-calling" into the POSIX
emulation will start with a locale based on the current code page,
something that Git for Windows is very ill-prepared for, as it expects
to be able to pass a command-line containing non-ASCII characters to the
shell without having those characters munged.

One symptom of this behavior: when `git clone` or `git fetch` shell out
to call `git-upload-pack` with a path that contains non-ASCII
characters, the shell tried to interpret the entire command-line
(including command-line parameters) as executable path, which obviously
must fail.

This fixes https://github.com/git-for-windows/git/issues/1036

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e0fbd2c66d..afdc1ef2db 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3185,6 +3185,9 @@ static void setup_windows_environment(void)
 		if (!tmp && (tmp = getenv("USERPROFILE")))
 			setenv("HOME", tmp, 1);
 	}
+
+	if (!getenv("LC_ALL") && !getenv("LC_CTYPE") && !getenv("LANG"))
+		setenv("LC_CTYPE", "C.UTF-8", 1);
 }
 
 int mingw_platform_has_symlinks(void)
-- 
gitgitgadget

