Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21B20297C
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373795; cv=none; b=lt4s/ZaZGatw48+rtJFp8zy+7lC+kiFodVwCl3rhKMQxg/yaq2vCQ6vXp9QT62QFrjtNtZnNJG5JLV8jS8/5TfBpOvRILlvXtNJdfMfd6TvAqXOXs9cyug6UPu398YFAsrqDsb2KBtVkypgFfIvzkXDC1Rn9Ku9Lacl2Fv3sQjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373795; c=relaxed/simple;
	bh=ycuh470JgOMKOPCZ5ZyCa53f1xY0kKsH2F4D/zhuIJU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=FYuro+YrJmROfSfu2q70NBV3dFNwa7Pgaub0zcpzbrkeAvan1iJZDhkwBgGFVmbvlBpxkIb0ZrDT3WGQaj3L4ZGWV0vqpVebxt9Yz+j/d8KTm7T62EKK0LBb6L1jE79epZKRERxGTO9sKGCXCSBr+pCTH6vfgNcrdNWMtibhuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz/CQAA1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz/CQAA1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so44598835e9.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373792; x=1749978592; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtGLQIoK+r3lkTuRkZEbs3LHqcoKyxr7lYoIjxI11zo=;
        b=Oz/CQAA11SdD+NY4iV9kzx3elVS/jQFP+JiXNSPCKgydTxtUlLEIToBzuUhnWUWY8o
         p3w6JrRBdnW05hA6sIZUAAyROsRE2D5KueRscHX+zu8T8i5fidqpy9pS74/abA/Zg1sv
         8re5RfFMwHgEhKM4o4aUOojTJZ+jRLCR0sJZJPgeK+/PiIFNH5OZIktLMs/fCmeTN8s7
         6nDMUYlPQsfbgMUkTJRDFm4Y94LlKNR0NMbydTUbP8znUj5VmlH/tfkS05bnkBIMRAm6
         lvkFxQTtBwINVwVPj/BJKCt2+6x4o6t5Qt+WUOGUDyoNJdHuKFFq6o3/e3dUlvhIdWPw
         tV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373792; x=1749978592;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtGLQIoK+r3lkTuRkZEbs3LHqcoKyxr7lYoIjxI11zo=;
        b=dZSRhPduohIALKC8b3BdDz3O7+d1/dJbj/H/nNqplU6ctohlKLrO7VgbTj9oAyscFY
         pn44BgOKWhGwYn0U/FGPhN3AQDuc1jx91kXMkI1w5Fzhbr9ONaVeekajr5Wij5pbDslm
         fPI270Ptldm0n987XCxmopxc/Z8jOiqRp/OTR+Rbyisgq5coEy6IWyx7NbtaMi8wym/V
         oYfVy6IgGFjbl/kDWQGhf1Nal0OeX1Xm++ovSDxC11iQjQnl4f9rsxAz6JS14oz/ats9
         ZCTzb584s7rytOEaawNB4p/ZWmkq9GZG+Cni9xMjqdVpltaL6yCHhIGOhUBxVfvkIfNE
         WTiQ==
X-Gm-Message-State: AOJu0Ywszs4xuHsK2nOlVGsTphwlH43QuZULd90gTC5YUZ9329A5zSIm
	aGUPRYTU+mAKkTjJc9eUBvgs6iPUORZrRYplIILLV7d3SlAssn3hTQ3sM7+0aQ==
X-Gm-Gg: ASbGncvll69xZwYiKXRg2yfH7PJX0OzL2+91y021cWNT9DhdcXhOV43Zj9P+/Jo8Zfc
	4RcsTqqgAiaEGpaKp467hsDxaoaaW6F8tg3RTlk/ZpoXqrtX0ch8ULBmY4f3/3+OfUjfijWQ1Ak
	vSe2Q8UCtVHspDyFivXdeXi0GYj3fVTcCsc3bJ+JTpGg4Btq/3rCZAskV74yX+r6kUxMIQwO5qC
	uxrn0pDy5ccKxmD58FbECIWt19emrVqyOmsgkT0rJKXqeaCWB3J6J1E7AiJ9lEIaKzJQc8+Vyqq
	+09LFtSUXWeIVEIDd/xkYhiMVu1uU6hW0t8PiE4qakelLislKygcAqU4a5dilYc=
X-Google-Smtp-Source: AGHT+IFJey89JpRhQ4draDK7vl/kLwx+82aABEhuy49LmGgRsCCFiIFdRMKRIIRQGT88/zDnh1zopQ==
X-Received: by 2002:a05:6000:4011:b0:3a4:d898:3e2d with SMTP id ffacd0b85a97d-3a5318a0406mr6586325f8f.24.1749373791684;
        Sun, 08 Jun 2025 02:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4521370961csm79242885e9.22.2025.06.08.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:51 -0700 (PDT)
Message-Id: <d451d7f6c0aabfc92c6e6f07fb1fc537cf521926.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:41 +0000
Subject: [PATCH 4/9] doc: git-log: convert line range format to new doc format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/line-range-format.adoc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/line-range-format.adoc b/Documentation/line-range-format.adoc
index 9b51e9fb6614..3cc2a14544cf 100644
--- a/Documentation/line-range-format.adoc
+++ b/Documentation/line-range-format.adoc
@@ -1,30 +1,30 @@
-'<start>' and '<end>' can take one of these forms:
+_<start>_ and _<end>_ can take one of these forms:
 
-- number
+- _<number>_
 +
-If '<start>' or '<end>' is a number, it specifies an
+If _<start>_ or _<end>_ is a number, it specifies an
 absolute line number (lines count from 1).
 +
 
-- `/regex/`
+- `/<regex>/`
 +
 This form will use the first line matching the given
-POSIX regex. If '<start>' is a regex, it will search from the end of
+POSIX _<regex>_. If _<start>_ is a regex, it will search from the end of
 the previous `-L` range, if any, otherwise from the start of file.
-If '<start>' is `^/regex/`, it will search from the start of file.
-If '<end>' is a regex, it will search
-starting at the line given by '<start>'.
+If _<start>_ is `^/<regex>/`, it will search from the start of file.
+If _<end>_ is a regex, it will search starting at the line given by
+_<start>_.
 +
 
-- +offset or -offset
+- `+<offset>` or `-<offset>`
 +
-This is only valid for '<end>' and will specify a number
-of lines before or after the line given by '<start>'.
+This is only valid for _<end>_ and will specify a number
+of lines before or after the line given by _<start>_.
 
 +
-If `:<funcname>` is given in place of '<start>' and '<end>', it is a
+If `:<funcname>` is given in place of _<start>_ and _<end>_, it is a
 regular expression that denotes the range from the first funcname line
-that matches '<funcname>', up to the next funcname line. `:<funcname>`
+that matches _<funcname>_, up to the next funcname line. `:<funcname>`
 searches from the end of the previous `-L` range, if any, otherwise
 from the start of file. `^:<funcname>` searches from the start of
 file. The function names are determined in the same way as `git diff`
-- 
gitgitgadget

