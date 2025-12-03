Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514530276F
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776101; cv=none; b=pvLoRHrAdubY4iPQzNR3GGwStLwb3LxjBYaOoYkluADOzmp1aesD32CW+Kv8SOJqQC5Sw0I63sK25Wv1JQ80SXknXUvT1oAOt49LlQQ3lS+ITmC58o22wy48pREfXlU2j8f/4oZOC/SfeOb+s95UpRla/bd8eM9GAcQU0HPIb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776101; c=relaxed/simple;
	bh=F3WcGH64TYDFzqxXG5nh4oKKtY4hFB+2mOrl1uAehfw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=DnW4PZslcjWFvSF0jWkz3g0cvHmAtJIn65XpTP0qnjOVUyZM6Lxtt8gdc7Tgr0ZgCgDVMo4LaX6/NbbJk9tXVxj68++HvnqaBbiNezj0vKvGsFWzSbHN+R0iKvfmjPjoLka4MZkk5l4hNPnbaWUGwwzPY/bTn9rsQy4dfpnVrGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRKW/D8p; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRKW/D8p"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88059c28da1so65802186d6.2
        for <git@vger.kernel.org>; Wed, 03 Dec 2025 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764776097; x=1765380897; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LqcKsj6oXgJVsYZ0fSB5gb4iyYxIpkgJXsUN++/QiI8=;
        b=aRKW/D8pbZ9UbiGgtO5OysLyHcFyxl7Fhlt4x9jHqQS22fBknxrKkK9fDcSKLHUV+p
         SwsDLHWzhWyVtyzxhlLmmNZYWWXipbdBjuP1hVMalPyzj9LUH1n4Rp5GtdiezXenRLJ4
         f4JnuM8f8siLr2m1P/mXPbux9sJoGvTgyLcPPLqXEWwDKUUgTmGNtD0JCY+mxlsCMm+F
         lF07WImqhE62qS3vG9zGZ8fgoPCk/tIcYM96ovjiIO4+6hVO826Paw5YT2qtujQPiBbw
         cPDcVvhBQb6X/ShUB5mx3mP8+eqxUXUG0TqyvR7RK9xSO99OezvM4HMXVgAMhR0WDMKS
         q6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776097; x=1765380897;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqcKsj6oXgJVsYZ0fSB5gb4iyYxIpkgJXsUN++/QiI8=;
        b=nsaJyP8uf9nYDCiwYvo9feNMCzlTr4fw4YVIJ6p8xqb6UAYv8X/r2oZFTGeV84Te66
         vTson5ocg8p2MWVukK9/imp76UNTuJBYI4bgAp8qH6Ix8tvY0rLenqF1ezFOLDWDzd60
         oJ3dwstgYS9gXJ/XC89kwzULgTdFlUt3KT+4aRYGBUGuxzffydn2FsXpmbv/Lx/eK7X6
         TGGMXR0U6lRvJDG5XsK6L791eMRZdhaQFW1qDa8DL6Ql6jjkW1tF6Z0sgFJNkh4FYI7p
         3H5x9eDTiB1kh1bfxbZ/3hh0lByOBbHWYrgK+HQjj0Md62TeLVDvb6LavjV15t/IJfIr
         WZnQ==
X-Gm-Message-State: AOJu0Yxzx6F/vS5qKEb/pE+qMeSKOdByN0Ue0F2wfBcaxLOrZGv9JWxX
	htogMNwkD65Y4pARBj05p5qbY8KJEuapgeY8luX5eOXZtOgxOK1wKCGRawqu8Q==
X-Gm-Gg: ASbGnctJntnugIaBmVdQCT9+K14apzGssE48Cif8acxUvUU1cc8NXfSlEN40ZRcWl1N
	1bn0T2fpXmhq+WsD1nxRyTfTUIFxqni9CV9MVAv5yy4xmXbEBpvfkZuA4Bm2HAhqLzMNYYzooOA
	gb9Y1loa2RBuu/m1rWDX1s7BR/zOOlQ1HeBDpFHI/bEi7KtYo+oglRS2Yg2MFI93ZmZ4o5YFpKe
	o8LAwCtlI5jkQXunamXlrOPM3sOUrXbCyJvtWo0KdbFJnSiBV1DF2RaIMmZNYu9UUq9lKRxA0to
	ouMIJWC4KkenMqHWvyfgeRRRwabrQVWPS66s2G0li7Z1ZxFf9JI6VqXf6FaczJQ+m+AzVRqIcRH
	x6AXaBCnwDp22JjrIs0q5NVdTG1lZxla5SVWu5KCFhyBGKcDm+NryNhMyT+pMQFobKCVUcdylL4
	H7CPtWtQsMK7rn
X-Google-Smtp-Source: AGHT+IE378jzG4j7Wigt8i6156L2HdGogAAycrcTpBKDACgI25n+X6hEQBo5ctphpC9WTtez6GTQ8w==
X-Received: by 2002:a05:6214:3d9a:b0:880:4bf6:21a1 with SMTP id 6a1803df08f44-88819483832mr36239606d6.5.1764776096708;
        Wed, 03 Dec 2025 07:34:56 -0800 (PST)
Received: from [127.0.0.1] ([20.161.28.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524e4b15sm127850356d6.15.2025.12.03.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:34:56 -0800 (PST)
Message-Id: <pull.2015.git.1764776095597.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Dec 2025 15:34:55 +0000
Subject: [PATCH] doc: git-pull: fix 'git --rebase abort' typo
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

`git --rebase abort` should be `git rebase --abort`.
(typo introduced in e9d221b0b)

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: git-pull: fix 'git --rebase abort' typo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2015%2Fjvns%2Frebase-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2015/jvns/rebase-typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2015

 Documentation/git-pull.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 248f6c3f39..88f4fd3926 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -37,8 +37,8 @@ You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
-want to handle, you can safely abort it with `git merge --abort` or `git
---rebase abort`.
+want to handle, you can safely abort it with `git merge --abort` or
+`git rebase --abort`.
 
 OPTIONS
 -------

base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
-- 
gitgitgadget
