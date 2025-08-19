Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D03112BE
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638676; cv=none; b=Ij9P40rV+x22SXPgRwHxhrv00zwF8i+q3Bpl6HkZZzp0LlnYDt3uUQclKFEAwaY6QpK3GddoOKJ+b0wJX7aplYTuUEWHBBKz6SZCLA7sTigf1mER0fEGmCZh/IlDV9iM7KQGk9zSBE7wSIR02/FT7cc9g+oQ+KfzOuu7POXME7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638676; c=relaxed/simple;
	bh=nWXDhHRzerft292sR9k4QmSjfPh135cKCb2lwsc801o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1+13dCidx8GjnzttuN3a0Bayo1sWKL8wr+OCMT/t5kZcBVMkVCT4z97+f/HkT+0NIaHczYBtYr4OjZeScywZVXG9T6y7rWANdSSn3S+Uj7OXak81cb/XE2byKaDJbhqpLKb2/bHzJqGb5Mn9ALZf2sv3FLWJ7rf86+ceo/8ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne (unknown [IPv6:2a01:e0a:d1:f360:a197:5391:9e0e:3dd2])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1BB7213F861;
	Tue, 19 Aug 2025 23:24:23 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: fix asciidoc format compatibility in pretty-formats.adoc
Date: Tue, 19 Aug 2025 23:22:33 +0200
Message-ID: <20250819212340.73886-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aKJJs7OkBIg7Y9J0@szeder.dev>
References: <aKJJs7OkBIg7Y9J0@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Asciidoc.py and Asciidoctor do not process the same '+' verbatim syntax in
the same way. For most usages, Asciidoctor requires a double '+'.

Unfortunately, the postprocessing of verbatim synopsis in asciidoctor cannot
be bypassed and formatting of the parentheses is forced in syntax sign
instead of keywords, unless a proper grammar analyzer is used.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/pretty-formats.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 9ed0417fc8..618ddc4a0c 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -233,11 +233,11 @@ colon and zero or more comma-separated options. Option values may contain
 literal formatting codes. These must be used for commas (`%x2C`) and closing
 parentheses (`%x29`), due to their role in the option syntax.
 +
-** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}+(+".
+** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}++(++".
 ** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
 ** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
 ** `pointer=<value>`: Shown between HEAD and the branch it points to, if any.
-		      Defaults to "{nbsp}+->+{nbsp}".
+		      Defaults to "{nbsp}++->++{nbsp}".
 ** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
 
 +
-- 
2.51.0

