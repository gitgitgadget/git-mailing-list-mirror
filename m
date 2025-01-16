Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C6236A79
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737066046; cv=none; b=gVt/TvA+5y735LTlGoM7lCMBSlQQZuMFLpX5Q7b+TO4gF66mXpDZwB7rZhMW5SUDehzn28kG8gaSESE4LhqVmHnjIcmiCIdcMYJ3bQ7qAdHw4XzqpikBWyOHav3Z5Cchpv18O1aXR5383sOjaWfb2WBC8i8xzYhajG4C9ktUr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737066046; c=relaxed/simple;
	bh=k/AevW5uiewqTQsTB8rungB4B1jn7wvEWkrz/Gt4LNc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZuWM6/y9mFX+bvnoGUqNeE5n2Ty41LOXqEOvbP3yVYQfs7QKGcUgB7wFHvgLi4cABZMDGcjLzKdl5b1rHpXYgUbkiXxgUJL0up9utmXCkfT24FWDSswjnxo4AIOrjzvrCFbwpCZZPjYpcW3sFKc47EpBRRnLJZeu+7UpwKaIfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD0dcCUS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD0dcCUS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e06af753so785518f8f.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 14:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737066043; x=1737670843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Prk3dWH0bxfD7xuETVMMs3Jhr0zsN1IDj448DKQ/QfQ=;
        b=FD0dcCUSG+naF5UZe3D4We/eIrflYfAqP/3x9VdzJOuhyZl2AO/LC/Zzm89Iwnn43h
         BUQdey34YOKSGeEXvJQligR2nTlXMCzvIsbRm1IgkX7O1xBkqJd5k5UTor3J1Kf9lepc
         ITuUsPx9d1ssE6JX1YlDWQp4toj++HvYbn1TzRIqJqTfQr9y3rFi8q7MhcqL993XkjpB
         1gSLMLWwVDYdgSO+Rz7O73gQxL7aUOKTqmzlvgzXzy13g8tVBVkyCG/ozXsem0zBwd6Y
         l0i8OouzCF/YIEXE+hKexYbO6TfUPi8TCXWgHgj572KF+vCjxkmW/VEHb6XrccW5JiiF
         3A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737066043; x=1737670843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prk3dWH0bxfD7xuETVMMs3Jhr0zsN1IDj448DKQ/QfQ=;
        b=MFRl/cIORvEs8ZW8nDprv+5p7HAKHwIZkvJ1epyTECSl+8RxRxMBOhEDQvj3Mr+4W2
         yO9swmDBeURRyKItKpH8G9N/RuMUeAKDS0Gf+XS0lewRdPQHvEiL/eAzANsgSPp3Lci6
         c+5jcG7Wg4Y2YJDS5XvJV1Bi07aYwAwsQOP+8BrJXDzMYgQEUfzUErGtdOy0HgMb/3Xd
         IeRgVP7KQNhSoucRD4tiSO5/uSNxzKeHjC8A/DFUHrVXkrOy9929JWZzZHYF/q1xo+jG
         Q/um4U2vZqzEV4X61cE3kEPe+PLBclVBPqWvQp6UkEPm8zgTm1qwPAsn3aJN0lvJyuzs
         RlTw==
X-Gm-Message-State: AOJu0YzxZeL0nXWTuNQCn+E1GE/Dj07oeBLz0+nGX06OrVcP2RqLDC/k
	prRtnadTV/zhnxH/AYxafPmHH2yUi1PwetT0tsmVAPC4n8Uw01DGx9gVRA==
X-Gm-Gg: ASbGncuHfbbkWg3abo3PMGR4151S3LSi55GdG/kJPa1THNIZdOOC634MKttuzMk8fNI
	lCelTOfwzwUnd3D3FPR8CNPAOZf9xqM7Yuj1vkw2cWZu/ReivgfRSIM9wtShevPhgRslXd0Yo46
	onOCQgWFfjXUdYe7hs6g0ZSHVykKFkgmbOw3l+VsvZ28O6llT30FXqgITTHzgWhzVVh/zlM+TTb
	XyeZ7CKWKmAfBxnLRwGWGw4ICPJJBTpKAA9bMPT4HE/CIhhArFyqHjRcA==
X-Google-Smtp-Source: AGHT+IECri/QVD4K3r0R4gE6EBnnD8+/v6dR0Hg3/TesECnDBn3ykAMhHUtxgqUQnydfHZNkvXq7Zw==
X-Received: by 2002:a05:6000:178a:b0:385:d7f9:f169 with SMTP id ffacd0b85a97d-38bf565bf88mr205141f8f.12.1737066042878;
        Thu, 16 Jan 2025 14:20:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221baasm907089f8f.35.2025.01.16.14.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 14:20:42 -0800 (PST)
Message-Id: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
From: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jan 2025 22:20:41 +0000
Subject: [PATCH] grep: document negated line-number, column long options
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
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
    "D. Ben Knoble" <ben.knoble+github@gmail.com>

From: "D. Ben Knoble" <ben.knoble+github@gmail.com>

I set grep.lineNumber and grep.column on in my user .gitconfig;
sometimes, when I script over the results from `git grep`, I want no
prefixes, only a filename prefix, or only the matched text. I usually
comment out the relevant config sections or use `git -c` to tweak them for
a single run---why? Because `git help grep` doesn't mention they can be
disabled any other way!

Intending to add the ability to negate these options, I reviewed
builtin/grep.c and learned that OPT_BOOL already provides this feature.
Document it for future readers. Borrow "configuration file" language
from `--no-color`, since that's my motivating use case.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
    grep: document negated line-number, column long options

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1878%2Fbenknoble%2Fdocument-grep-negated-options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1878/benknoble/document-grep-negated-options-v1
Pull-Request: https://github.com/git/git/pull/1878

 Documentation/git-grep.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 1e6d7b65c84..7ec5ad381db 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number] [--column]
+	   [-F | --fixed-strings] [-n | --[no-]line-number] [--[no-]column]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
@@ -157,10 +157,18 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--no-line-number::
+	Turn off line number prefixes, even when the configuration file or a
+	previous option requests them.
+
 --column::
 	Prefix the 1-indexed byte-offset of the first match from the start of the
 	matching line.
 
+--no-column::
+	Turn off column prefixes, even when the configuration file or a
+	previous option requests them.
+
 -l::
 --files-with-matches::
 --name-only::

base-commit: 757161efcca150a9a96b312d9e780a071e601a03
-- 
gitgitgadget
