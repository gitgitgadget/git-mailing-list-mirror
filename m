Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A58F66
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721507421; cv=none; b=Qor8+A3y8V8qvJYSSgb9Iusk35HmF+IqwZQDaBMnORHDmTMtzG17YjY5hK/1/ymcwpTvMCmX+BibvP9UmoidExheTfJeTdTIzTY+VqObWciFiONzIGbmRnu6BfuGTlF8t0GuCpvdJ0eoUl+qYn9uQe3+q4fZVQGEsRLNUaVv8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721507421; c=relaxed/simple;
	bh=V8myExlDmGWA83s9BQniVDcShKNwqIVMyW+2/wBjrPc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=n7g/vFRvjjhr5xSI/v6tqpJQoqlV4T6PfEzf8x9F64kXzxYgJ/Pf9Y3+byElxrubjgjZT184HwjCZsTvtugckB/JHi2DcosVMhk5glHcF0vxgpE14k+bQpU6fXJU0zkzo3kXuZJBKRjW/amfh0f85Q1Mv+r0Nw7OiO5kwK/Zttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn8wWbRr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn8wWbRr"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c25beae1so257635366b.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721507418; x=1722112218; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G+4EFpP1m4h5RCImQ3L72OpdmU6V/Fp0GasmGrEG9cI=;
        b=Cn8wWbRrKQ1KqiqHHxhKp0paJYmNSyX1pUcfZ3OLIOQdIqJaU6OaF3zS2WadUZaEKw
         281NhDlxgh7dw6w1kM0NS0yThfjdZUFpLk6rsZIzMp5u7wLs/AS+MM902uviVSnvtkzD
         aiwZP8FBOw558Hq+MTifHovJZqYHJnt05Ocg2Bjg1tCep73pcFhwwqVuxM6cqxwx+o+b
         ixJ+gJSoLva8ioAX4dszJVdkx03VVPzjY90L6jW3EOqplNAVIkB9K57W2V+5nGuobrdR
         5ECnSMYpmOGWWYRvSTX90nafyeZWT1RWbx5ai0e5ioNz9vTisey/hXwuuRWKqpgMkUGX
         Dhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721507418; x=1722112218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+4EFpP1m4h5RCImQ3L72OpdmU6V/Fp0GasmGrEG9cI=;
        b=ED+PMewxJ+vzSMfv77Cdf3CrynZeclHesN0ytAhJvwV6gRY9Dd6QRB/RIbnsmz6vz7
         Yh/kuSObAoGBzYPkXGbT9ZURrOX/1emrLnMBwX0L/ksotEqAw29Yynm+0LSW6ZRCSC3w
         S9FzeRttKqVlyHBQRlfrfPSOeB9iYGIGAgip/uH6NiWHgDXlWiVH0nUrJAuVuMiC6P9k
         h+AjbotgFHd9jrJu60evwuW+pAwi1VV8zHFZP5BP7pIfDG53ulE1MtkAATQqfU6BzTAD
         t2eBV5vLviDejuUAQ7I+VGst7w0INkr/V2K0VLEddXj6bDKSHiRO6VXHRDfk2yjPuXu8
         RSjw==
X-Gm-Message-State: AOJu0YxMGYiHVJBIut0Bza6PYUuh36xmYTznPZaRoKXioZ4OCY2QP667
	aGXIAM/8dYRR5CDW+uZixwJlIFgE070kpcWtDvAx9432gwA8w6kbFLgzwA==
X-Google-Smtp-Source: AGHT+IFW/7KrWVM/dc+rk2K3R15+VZNqAMTeYdWDf2oO44medrOvBfrPYgSLzVFVqDcu9U/WuM+Elw==
X-Received: by 2002:a17:907:97c4:b0:a77:e2e3:3550 with SMTP id a640c23a62f3a-a7a4c00f80bmr143050866b.17.1721507417896;
        Sat, 20 Jul 2024 13:30:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7e8ef0sm203648066b.94.2024.07.20.13.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 13:30:17 -0700 (PDT)
Message-Id: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 20:30:16 +0000
Subject: [PATCH] asciidoctor: fix `synopsis` rendering
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 76880f0510c (doc: git-clone: apply new documentation formatting
guidelines, 2024-03-29), the synopsis of `git clone`'s manual page is
rendered differently than before; Its parent commit did the same for
`git init`.

The result looks quite nice. When rendered with AsciiDoc, that is. When
rendered using AsciiDoctor, the result is quite unpleasant to my eye,
reading something like this:

	SYNOPSIS

	 git clone
	  [
	 --template=
	 <template-directory>]
		  [
	 -l
	 ] [
	 -s
	 ] [
	 --no-hardlinks
	 ] [
	 -q
	 ] [
	[... continuing like this ...]

Even on the Git home page, where AsciiDoctor's default stylesheet is not
used, this change results in some unpleasant rendering where not only
the font is changed for the `<code>` sections of the synopsis, but
padding and a different background color make the visual impression
quite uneven: compare https://git-scm.com/docs/git-clone/2.45.0 to
https://git-scm.com/docs/git-clone/2.44.0.

To fix this, let's apply the method recommended by AsciiDoctor in
https://docs.asciidoctor.org/asciidoctor/latest/html-backend/default-stylesheet/#customize-docinfo
to partially override AsciiDoctor's default style sheet so that the
`<code>` sections of the synopsis are no longer each rendered on their
own, individual lines.

This fixes https://github.com/git-for-windows/git/issues/5063.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    asciidoctor: fix synopsis rendering
    
    This was reported in https://github.com/git-for-windows/git/issues/5063
    and has been fixed in Git for Windows already (in
    https://github.com/git-for-windows/git/pull/5064, because Git for
    Windows uses AsciiDoctor to render the HTML help pages).
    
    A related fix for https://git-scm.com/docs/ (where AsciiDoctor is used,
    too) was submitted as part of
    https://github.com/git/git-scm.com/pull/1855.
    
    This patch is based on ja/doc-markup-updates, but also applies cleanly
    to the default branch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1749%2Fdscho%2Ffix-synopses-rendering-with-asciidoctor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1749/dscho/fix-synopses-rendering-with-asciidoctor-v1
Pull-Request: https://github.com/git/git/pull/1749

 Documentation/Makefile     | 1 +
 Documentation/docinfo.html | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 Documentation/docinfo.html

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c7..78e407e4bd1 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -202,6 +202,7 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -adocinfo=shared
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
diff --git a/Documentation/docinfo.html b/Documentation/docinfo.html
new file mode 100644
index 00000000000..fb3560eb92b
--- /dev/null
+++ b/Documentation/docinfo.html
@@ -0,0 +1,5 @@
+<style>
+pre>code {
+   display: inline;
+}
+</style>

base-commit: 76880f0510c6be9f6385f2d43dcfcba4eca9ccbc
-- 
gitgitgadget
