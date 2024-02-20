Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C354152E19
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468380; cv=none; b=EcfPy7iaEHtqiYKCyb4MZPB89YFhsyKdFWiTuzrf8FS1UD976hIy+GqdsbfymDqt45J4qtLKLeHgPlGa5f06zyu2kFzNsctg88oxHbk8FngAmqmBdqRusnaY0I5ubsI53Ske/O3wt7vwJdDXJX2wvyuE7bm6i/WxJ5RavKv9pso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468380; c=relaxed/simple;
	bh=7gkN4K7PyTseCkGyC3Y8rknY1eBNNEU8PIwzbVrpCz8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Q1tWnVdyaPm6q9eUZvkUShrZZQPHL6bvT59QI/lc9vLMht2FRzlpqdoUPjpDqgYuvupmXXEFU+BFier83ct/qe5Dfh5gkQlKEQcVZaOZubcHr8+ix62L5BcNq+GOaaArlivoHs9ojSKGxOsY/mhCUkDMgHt0s+oih80YJsA9HpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxRk05hL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxRk05hL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412730e5b95so2814365e9.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 14:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468376; x=1709073176; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vTnyNJgDt2LYgaxlrWOD/Nt+XttDee4n8UJrbXXAEE=;
        b=DxRk05hLs1gSpy5shU6C7oI0WCHZQ1yo9CylrbqXxPysuJ3ONo1faTobIWVbAm8hic
         uaTyc3pt2OeCMxtxAfN/dNSCY8nHTUg6dJKMoJDtDrsVswOqWrjZ0cvB7/KbMKYP5fnQ
         i1d1wX/NPZkOuRdWhe76WBelk2w2mOEmsu/DSie0YgZsWX+PtgfX3cPp2i8uyVysNkg/
         UzMg/BX+OEO+Y0OvDpOoggEO9JL///6qZv6k3LZzAdK8dQzFWxPKnAlAH7DIWf17DCao
         vLCjrDtOo32ZiSJbxZFhFV2iVubGNHEAG+FyB6rBZCZa6hldH2G0wPgzqfkC4X+Shm5P
         cghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468376; x=1709073176;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vTnyNJgDt2LYgaxlrWOD/Nt+XttDee4n8UJrbXXAEE=;
        b=vPi8SCnnzWvL+LfqjvkyMdzBvFKFRxe8fOt7O2htvi5COh+Ul1utY4fSmcXhwpIVc8
         Q6R7JvOOoQPJD34xR5H8dq+b5ixduiGJgbXu+x9S4cpeYREEgF6UXrTTrlII3SGfonJ6
         LV/HGwzMPjLeS1wM0ZvZaDjc3FiTRSxbP8nz7GiPIrOzRYvP79grd5r9l9sJeuyGNYdo
         /b1g+BI8WpkrdbtR22O4G5tCbfCOKnaey4nZMlfBLtNKH3kUmwbeJznNA/f7hOWMJlc5
         pv5Wb7hEjJLu7MPouWf+1kYVbue/o0coi0JAr2mw5F3ODJ67xxw13vr070oFv4oK5wuf
         jyLw==
X-Gm-Message-State: AOJu0Yy6eu7USOvoADrCdiDv3VNxF+gGpZAU3ehZYKVsSf5YqwI6+L3H
	SMOfmNhwOnCvp1oQpMQg1toZV3GZa8+8hgS52Nlhg30dqnZTTkMsopGWs0Sj
X-Google-Smtp-Source: AGHT+IHobb3VguH6j/Uht3G0jjmTjPnYrDQQqQyoTVI2B0gUX4g6nbdPobs5bwqcto/qfvgz+S3w+Q==
X-Received: by 2002:a05:600c:3541:b0:412:6e8a:efff with SMTP id i1-20020a05600c354100b004126e8aefffmr2178104wmq.16.1708468376050;
        Tue, 20 Feb 2024 14:32:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c510800b004105528c61fsm16244478wms.35.2024.02.20.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:32:55 -0800 (PST)
Message-ID: <17b0284c379e62a756e1bba008f4671f6afc0ad9.1708468374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 22:32:52 +0000
Subject: [PATCH 1/3] doc: git-rev-parse: enforce command-line description
 syntax
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

git-rev-parse(1) manpage is completely off with respect to the
command-line description syntax with badly formatted placeholders and
malformed alternatives.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-rev-parse.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 546faf90177..5d83dd36da1 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -9,7 +9,7 @@ git-rev-parse - Pick out and massage parameters
 SYNOPSIS
 --------
 [verse]
-'git rev-parse' [<options>] <args>...
+'git rev-parse' [<options>] <arg>...
 
 DESCRIPTION
 -----------
@@ -130,7 +130,7 @@ for another option.
 	'git diff-{asterisk}'). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.
 
---short[=length]::
+--short[=<length>]::
 	Same as `--verify` but shortens the object name to a unique
 	prefix with at least `length` characters. The minimum length
 	is 4, the default is the effective value of the `core.abbrev`
@@ -165,9 +165,9 @@ Options for Objects
 --all::
 	Show all refs found in `refs/`.
 
---branches[=pattern]::
---tags[=pattern]::
---remotes[=pattern]::
+--branches[=<pattern>]::
+--tags[=<pattern>]::
+--remotes[=<pattern>]::
 	Show all branches, tags, or remote-tracking branches,
 	respectively (i.e., refs found in `refs/heads`,
 	`refs/tags`, or `refs/remotes`, respectively).
@@ -176,7 +176,7 @@ If a `pattern` is given, only refs matching the given shell glob are
 shown.  If the pattern does not contain a globbing character (`?`,
 `*`, or `[`), it is turned into a prefix match by appending `/*`.
 
---glob=pattern::
+--glob=<pattern>::
 	Show all refs matching the shell glob pattern `pattern`. If
 	the pattern does not start with `refs/`, this is automatically
 	prepended.  If the pattern does not contain a globbing
@@ -197,7 +197,7 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
---exclude-hidden=[fetch|receive|uploadpack]::
+--exclude-hidden=(fetch|receive|uploadpack)::
 	Do not include refs that would be hidden by `git-fetch`,
 	`git-receive-pack` or `git-upload-pack` by consulting the appropriate
 	`fetch.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs`
@@ -314,17 +314,17 @@ The following options are unaffected by `--path-format`:
 Other Options
 ~~~~~~~~~~~~~
 
---since=datestring::
---after=datestring::
+--since=<datestring>::
+--after=<datestring>::
 	Parse the date string, and output the corresponding
 	--max-age= parameter for 'git rev-list'.
 
---until=datestring::
---before=datestring::
+--until=<datestring>::
+--before=<datestring>::
 	Parse the date string, and output the corresponding
 	--min-age= parameter for 'git rev-list'.
 
-<args>...::
+<arg>...::
 	Flags and parameters to be parsed.
 
 
-- 
gitgitgadget

