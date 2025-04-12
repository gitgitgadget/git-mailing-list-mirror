Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7441DC98B
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460462; cv=none; b=U45v92muqSWn/cKgq1esYWcdMz3taNX1tAzKuw1s8frccDXCrHpB6u57mdzoF0/Ti9ACaqu6cO1FCYkLwTjV4TDj2WFCba7Gt2TObrBGL6Raapp+I4Nh/bZGQdLx5THgl5IhFXVhyojkdYIdaLUalO4AYQ8mHSknNdKx1TUMMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460462; c=relaxed/simple;
	bh=6Ub4kXvAWwCrxXyk4nKRFj1z2itAn/vpTDXIIU6siEc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Du5vEzB3G1JRP/EA/mdT66SqDPe00lsjVyS5F3Duf2Ie6SU94Bl+BwI8snjn5/LuRaVXaHRKC+tZnj2Z6V5CXDmFIeQoSMgQ/o1dsaqBfGmzrtQwAP+97DvDysjAPb5hPYaLs7aYpgdZ1FpieV4T0kWLfwfCt7H9hNI80TKvKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5efVveM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5efVveM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391342fc1f6so2240505f8f.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460459; x=1745065259; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZu7Q3qc9/eZPZ19egOq9+HbkRe6d1I1lEpTMSR5k5Y=;
        b=I5efVveMNZwZTMjKNSTkKTiZf2PFaAVc3XUFItnt2fnnTPy8tWkF5fFBmxWivelq/k
         91LSzEub+LIrsYV4IoFRQhLqNnKtx9Sf17lWB/JDjM90/jX/sAvQ2YWTK9ir3BbcIcEs
         efjTp1s9dLiZRGGLGYlHp5ONSj/Zr7SFplMx6FojBVBkL0Xf1gPcc24FnR58OmvaNlog
         lrz48bern/QjrpO0j3G+mMl0n6D6bSgXff/vlz4EAZz1x3+EXhYOba0z/4wN2hG7M+/Q
         Z/nXBIqbiZp0h7Lt5JTk/jdPz2qsFujRaVnWCfXJFxNuYCxsITihXlLJVo9PvJugXQoo
         On/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460459; x=1745065259;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZu7Q3qc9/eZPZ19egOq9+HbkRe6d1I1lEpTMSR5k5Y=;
        b=TWHSGTGCP5MdZNqYf11yqOewUczyaaQXXVQnOcy5w7VzRz6ipSjKFDf00xJTFlP6Ld
         7mbCHndtcY4qunY+ZC5a/kLq0AozKa4JwaqmA222Tp0d7VZOYPXi8yIjea25HZHw0qum
         uIT3sd2KwZpI7FIw1Zx/hFS4noBxlUV+vtfknoUx/w3sNZzSRzpMOgPHEKRUpngq/zVt
         bwHTEBF3zysr7MjxGkmLBmfOLSlt6kGLH8rYliWBXhabdret0HBlLi5CDHJjAtdmYgcq
         bxGubR9LBw7pi79mjI/+EZQE0oEDUxy3tNqoF+rpkgzeE8mKa/CtFqyVZYiw12btjAxJ
         qleA==
X-Gm-Message-State: AOJu0YwutGejSIH5LCJX3zRYwRP67qevvtGTCecJRjDeMhe0EMty03NL
	Xh7q9tfzx2xHSNinB2fZrKBe/NsWyTGTSH9Jwkkt1MDJ9oNH65fKi1nGcQ==
X-Gm-Gg: ASbGnctrk/mkjKjMOJTjxhhwOSnfyHE+vrufvupI8m/lXAVfweiDFOG8WUTUR27XP3k
	HwpwIIWePOxqeZ0a5VaZKxe6uCmefA5YO0xq3yrFf4lARVBfP52vzLyzAXbrjK+jz0pThPWPb9f
	W1KXd0iyziLfb9XC3YczZnmH/YNzLYMxE9Dq4ZlD1PK48ZoY1NetR2Mkj4M3OToZFS9hXB97AcD
	H81zX2WfoVw+viaDlZEFEsDcdYJVPWxeCafF5GCh7R8GntffAKpJpSJb9fkIoKIWLdnoZ0QtOw4
	WcmJ208GhAF7WqafkP82Lb2Y09LB96FKmKTO0lfZNg==
X-Google-Smtp-Source: AGHT+IH2g2gHsGAg32WCnhozILc0fHyl7KBgs/+c/GTF6ozIk53LAlSJ/53Fq4G9f+7I3xm3hwbHSg==
X-Received: by 2002:a5d:5982:0:b0:39a:c9ed:8657 with SMTP id ffacd0b85a97d-39ea5202284mr4819403f8f.17.1744460458944;
        Sat, 12 Apr 2025 05:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c05asm4856355f8f.26.2025.04.12.05.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:58 -0700 (PDT)
Message-Id: <2ddce76f14d226d9f1b7b3efe5a27a4e812be60b.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:49 +0000
Subject: [PATCH v2 6/7] doc: fix asciidoctor synopsis processing of
 triple-dots
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
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The processing of triple dot notation is tricky because it can be
mis-interpreted as an ellipsis. The special processing of the ellipsis
is now complete and takes into account the case of
`git-mv <source>... <dest>`

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf.in             | 2 +-
 Documentation/asciidoctor-extensions.rb.in | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index 50f0e81a831..9d9139306e6 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -43,7 +43,7 @@ ifdef::doctype-book[]
 endif::doctype-book[]
 
 [literal-inlinemacro]
-{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\\\*\/_^\$]+\.?)+)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@\\\*\/_^\$]+\.?)+|,)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
 
 endif::backend-docbook[]
 
diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index 09156b71a4f..8b7b1613496 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -49,7 +49,7 @@ module Git
 
       def process parent, reader, attrs
         outlines = reader.lines.map do |l|
-          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
+          l.gsub(/(\.\.\.?)([^\]$\. ])/, '{empty}`\1`{empty}\2')
            .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$\\\*]+)}, '\1{empty}`\2`{empty}')
            .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
            .gsub(']', ']{empty}')
@@ -71,8 +71,9 @@ module Git
           # unhandled math; pass source to alt and required mathphrase element; dblatex will process alt as LaTeX math
           %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
         elsif type == :monospaced
-          node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
-              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<literal>\2</literal>')
+          node.text.gsub(/(\.\.\.?)([^\]$\.])/, '<literal>\1</literal>\2')
+              .gsub(/^\.\.\.?$/, '<literal>\0</literal>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@/_^\$\\\*]+\.{0,2})+|,)}, '\1<literal>\2</literal>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
         else
           open, close, supports_phrase = QUOTE_TAGS[type]
@@ -100,6 +101,7 @@ module Git
       def convert_inline_quoted node
         if node.type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
+              .gsub(/^\.\.\.?$/, '<code>\0</code>')
               .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<code>\2</code>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
 
-- 
gitgitgadget

