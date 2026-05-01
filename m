Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1837F8B1
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677326; cv=none; b=M7CJ2whaiv4leK+SmMbOn9SMwcws8W9mfks0haRjhQ4tn+JG+Bkhps1NRn8rICSTgNZ9Y0IeVnRT7/wfD1fGxJAXfFk0wYKCEuHi2zxKSodPirWJoHOdGrdF82IaNopVpVi1dLeJ6wgB3bvV5DcbdO0+rI1/SqSFi5UZ9mHu0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677326; c=relaxed/simple;
	bh=LkGdUreL9Vaw63FpspvkprOIKWAIvC/JtmV4i6zHeRQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lWzqyRdKaYx51OtWd33snpjzIKgZ0cO56JPgnzUqg/h6aoQlV8Al4Y7OAJiA0v1hKqhn/nkq+5c44jl/7TOkHoKJNtzfwW06GucqQo1MVQZXq4GOuspziLYSHXl6NA07nYly3lm34oyGroVO3Kt7FReP14kk5jh7uwCNZ/MqDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXror+lI; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXror+lI"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so6198278eec.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677324; x=1778282124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxTuOFenopdaGsVedGOoozOJf0WWp21sJjG5eohJVt4=;
        b=VXror+lISICfbwjdb9H0hVCnBBqyj63Z+VBPRoz3SOsQdRz0iSV7+gve/MAhrau27w
         xZ94qJSptA5I3Qb/4NvS4iwGwjfIGTAmaCnQsQ8y+xQqyEIJL+b27fuQwzACUp14IcLa
         KbKyJ2a1p0ThZSHG0JmqC59QIYKkm1EswI2AZD6/6pKB8O/3ph0dDWiKMRx3nmlm+oyT
         KIAICsdzdX/jyT8hR+gyGLbN5GsHT96B86R+JQLy4a5tMs3cg/Y8MsOjdNhV3mY/ujJO
         3BqTeJZuiziHQ4DY3JD2gPXj5eoS67KAfWGRhNqxKsism2eb6lePlaHLP6dGr5tyu3HC
         u5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677324; x=1778282124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SxTuOFenopdaGsVedGOoozOJf0WWp21sJjG5eohJVt4=;
        b=SeOjvQiawxqUThUA0GeVf9c4traQ2+heKbLeVfTxAzmg58wdvKG2FdmGsPltqu4PE6
         qgszSXwGThmYy451ApUGmPTsFrsrWL8G8Ysx1TAQhf66Itvz+KKpNt4j1uXiFkRbQVEG
         vTgvAAcqCHDMGQhoG+AEx6CUtwnSNfHvXe2kXVKOyjBRzESaE1e1T1USoMX+8dU95xk+
         c2XsWNgg/OxTWP4RprD8iOepH1goHIizTcorALUWup7ayC2/YkDg41oB/8AgSv7hi3Xh
         zOrJP9egiATC8JPWTB2nqgrfXpmobQC6KoPnYbqAmeQynZYybYTnBoE31TRj5JSH24r3
         Oa8w==
X-Gm-Message-State: AOJu0YzRjhdEfO7epIhvi3lsRUKcwLcrysRSJ52GMR64V+DXGfQzXRjb
	fYsAIcBoU591FC3qjoliJeh2TRyUaDiMz78Dv/fiAB/iC0vExr2Q246Iu/fpGjyC
X-Gm-Gg: AeBDiese7X31yIdvP989G0JD4itZnc6cVvHKuxXapJ1TBrTZdQEUoprAENe59A1iIjK
	JXuuDBDpOLj3qXTYkd1TDj2cu2re0ZoX5YTq2ibtioCoNmxKlHr+Igy6S/yPa51U3W6wRNancLC
	DwG734R6lbInBda1X15yehJEHtBpqq/rKKoJwE34eP4XRgSdjKeg7GoRzfw7xeyyx4iyl77ub2V
	q/YZ314daHGuHpq4Pb0NL6NpKUrFTd9bUFTj05yVvpFJxTNNmnVNKmARy+M16udRFwKZW1IA3ya
	ehFoNU1m6tcCKzJMeKtSQGYTrCUJwiPPwX0W6p2OoQBHYTKV9CBSIyOEyY0f6cN1oHDk0tZykSj
	lvpBNVWeCPCSRUeeEwCPJpoEeAVDm59DV2ZFpWAxUkkmcLAEzS51yjdopplr3cgvkJk0EXVNwQt
	k7JxxhPB/6G/QWfrb0rW72bRImEfm4/zB8YjH9/7k/H1HrHRFMlA==
X-Received: by 2002:a05:7300:4312:b0:2c0:e404:8b08 with SMTP id 5a478bee46e88-2efbb2908b0mr654889eec.29.1777677324061;
        Fri, 01 May 2026 16:15:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2e0sm6236939eec.16.2026.05.01.16.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:23 -0700 (PDT)
Message-Id: <3c44e0f478c40375a63cc08139736aeb07aff26c.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:09 +0000
Subject: [PATCH v2 7/8] doc: describe the url-parse builtin
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

The new url-parse builtin validates git URLs
and optionally extracts their components.

Helped-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 Documentation/git-url-parse.adoc | 80 ++++++++++++++++++++++++++++++++
 Documentation/meson.build        |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/git-url-parse.adoc

diff --git a/Documentation/git-url-parse.adoc b/Documentation/git-url-parse.adoc
new file mode 100644
index 0000000000..9d0d93da4a
--- /dev/null
+++ b/Documentation/git-url-parse.adoc
@@ -0,0 +1,80 @@
+git-url-parse(1)
+================
+
+NAME
+----
+git-url-parse - Parse and extract git URL components
+
+SYNOPSIS
+--------
+[synopsis]
+git url-parse [-c <component>] [--] <url>...
+
+DESCRIPTION
+-----------
+
+Git supports many ways to specify URLs, some of them non-standard.
+For example, git supports the scp style [user@]host:[path] format.
+This command eases interoperability with git URLs by enabling the
+parsing and extraction of the components of all git URLs.
+
+Any syntactically valid URL is parsed, even if the scheme is not one
+git supports for fetching or pushing.
+
+OPTIONS
+-------
+
+`-c <component>`::
+`--component <component>`::
+	Extract the _<component>_ component from the given Git URLs.
+	_<component>_ can be one of:
+	`scheme`, `user`, `password`, `host`, `port`, `path`.
+
+OUTPUT
+------
+
+When `--component` is given, the requested component of each URL
+is printed on its own line, in the order the URLs were given. If
+the URL has no such component (for example, a port in a URL that
+does not specify one), an empty line is printed in its place.
+
+When `--component` is not given, no output is produced. The exit
+status is zero if every URL parses successfully and non-zero
+otherwise, allowing the command to be used purely as a validator.
+
+EXAMPLES
+--------
+
+* Print the host name:
++
+------------
+$ git url-parse --component host https://example.com/user/repo
+example.com
+------------
+
+* Print the path:
++
+------------
+$ git url-parse --component path https://example.com/user/repo
+/user/repo
+$ git url-parse --component path example.com:~user/repo
+~user/repo
+$ git url-parse --component path example.com:user/repo
+/user/repo
+------------
+
+* Validate URLs without outputting anything:
++
+------------
+$ git url-parse https://example.com/user/repo example.com:~user/repo
+------------
+
+SEE ALSO
+--------
+linkgit:git-clone[1],
+linkgit:git-fetch[1],
+linkgit:git-config[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index d6365b888b..32c8606a80 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -155,6 +155,7 @@ manpages = {
   'git-update-server-info.adoc' : 1,
   'git-upload-archive.adoc' : 1,
   'git-upload-pack.adoc' : 1,
+  'git-url-parse.adoc' : 1,
   'git-var.adoc' : 1,
   'git-verify-commit.adoc' : 1,
   'git-verify-pack.adoc' : 1,
-- 
gitgitgadget

