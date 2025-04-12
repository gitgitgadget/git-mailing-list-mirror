Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734991D8E1A
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460459; cv=none; b=rzUzVG3O0WLrGALNY07/cZyx1rqSAc1lp8qSaims6hFwd0hcZR6FcpkeXhqjWh9gGpd4XR1jrVKHpmJFaAmGA4y0ecEmswM+M9r5P1cZ0fS0XnCBuVXo44lbBJM6peUS2FKfjJ72BURHxFipBm/UThk53wX7+rKtAvPhA64MK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460459; c=relaxed/simple;
	bh=Ov+bWOxARJlJFz+5CfnfTjPm7yGb/svi86pFG3YEniU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Q7TfzUw4AsGT15U/GK161DZa5hmXbG1IFC+Z3hpV4hxq60VB8GUkb4rrV/n3O56QrPez6iXi4hqXhHRWVfKp6Hd+AojI6cl/zHnxegL/rfGFjbCftJnJlSQX4T+iqse5EoKisKlyQC6WHdi0qa7wTXIEvb4w/bPeUUGIgZs5yD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDLYvEcv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDLYvEcv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3914a5def6bso1629002f8f.1
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460455; x=1745065255; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAAiuglveSzsCh52fS6Ti1UlCsNRXR76NCT6qXuOosQ=;
        b=eDLYvEcvdlGRPzBiD8yVQ4WxaWxeIgR+bBD1SINvk9B9zVYmwLG0aaetkiqIJDlSuk
         PthoAf9vuVv9NQfdyHlWyIth3x3Rtu/UIe8+27hLVFDsjmE9iZvNoHr0dBfr+yiI+/D4
         kotqpYmVCW/TD8Ti7i1SZZhHs9H2ZNxswHp0e1E1mpXfHAiMeEGQXBEVONszPwcMDv7e
         7pVf9YRyfNoHyKZgEPc/4Rz4CEOuGsdiCSCvO0Ly+NFjo6YFvX8/ECkgturDXofq/Si3
         V3dI/DtEsHXolrkWMzD/ljB/+O+ts9Rbg/2MquPKlFwq1l9DWmeR2NayRI+kpFDODiK2
         pFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460455; x=1745065255;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAAiuglveSzsCh52fS6Ti1UlCsNRXR76NCT6qXuOosQ=;
        b=P2Rr7zDZlXLknCyehKupNiYhW7+uoeDihUnDhU06Be8wYhOD9VOtDLNm28a2zeCsHk
         MSD6CTfdomqSLy/Hoo5mUbJGNbwvBUUX+NcAAeDp0g54DlX7nzm8dZrek3Gv0DedA7nP
         qjml2r6yUnPMP57bGHlaOiK4QMyUtwPMSjrwH9xpCaQaUEC79wT7ZWSgqKz8CFKyhrZN
         MNeMr8bor1nWSbeTm3P6/XosNja25V3W2N99pq6kOExvjtZM5zEuKPZZvz0H42MQCe/N
         miaM+yTPqunzfmFrAHuioT5gq+vfN4nqfHBO1tLg1bvZD2FBgnjbkwGR1sMSxOPnOQ50
         8F2A==
X-Gm-Message-State: AOJu0YxCkKqSKKL2da8PZD4bEi5rd7zpadYJu7231+5mrIcLKPuI/nba
	vjpJPSXGPjr+y0o10iInbgynET+9KTCWVkxXDgkXzXTeSQxIO1jQzBjYag==
X-Gm-Gg: ASbGncvB071/PIBZ5BAU60SOTeTYYxFpLMitc3s8K6NitcoeNNpWT/KinN9JRKGcsk4
	Q5/wH0q+Yg+a1WAROZ0JVWSguxmMGsP6jFtZu8jtJcPqsXVyrWSgImZ76BtnBmSq86b8nCQN3r1
	ej/TxCJUdRVlHAd/2VDPlBbwU/2eYSka7N9yGXAn/Sj5OP8Rp8fAaVL0WrirDFPOd1zqqbl6Ev8
	bdVgyFch4zJpauIO3+Gy6C/I5U5ekYtr2ousnEZUgoSNQVb3V3EhR6nDL9CdsATP9cTnWktJf6G
	/dvlPAZhIvLXgI8N688X8yNrDTdmUHbxqdFOtM4k2A==
X-Google-Smtp-Source: AGHT+IHOdtMbLyKu3X46tZ6GlcMI0DfbAgjOBCKVenlIk50eyEVsyxwsL6OyKWCuMK63EDY4Xm80rw==
X-Received: by 2002:a05:6000:1883:b0:391:10c5:d1a9 with SMTP id ffacd0b85a97d-39ea5215172mr4876723f8f.31.1744460454489;
        Sat, 12 Apr 2025 05:20:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640fdsm4906248f8f.7.2025.04.12.05.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:20:53 -0700 (PDT)
Message-Id: <440eac1f974880b004992972385e4af030a6691e.1744460450.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Apr 2025 12:20:45 +0000
Subject: [PATCH v2 2/7] doc: fix synopsis analysis logic
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

The synopsis analysis logic was not able to handle backslashes and stars
which are used in the synopsis of the git-rm command. This patch fixes the
issue by updating the regular expression used to match the keywords.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf.in             | 8 ++++----
 Documentation/asciidoctor-extensions.rb.in | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index f2aef6cb79f..50f0e81a831 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -43,7 +43,7 @@ ifdef::doctype-book[]
 endif::doctype-book[]
 
 [literal-inlinemacro]
-{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\\\*\/_^\$]+\.?)+)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
 
 endif::backend-docbook[]
 
@@ -75,18 +75,18 @@ git-relative-html-prefix=
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
 
 [literal-inlinemacro]
-{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<code>\2</code>', re.sub(r'(\.\.\.?)([^\]$.])', r'<code>\1</code>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\\\*\/_^\$]+\.?)+)',r'\1<code>\2</code>', re.sub(r'(\.\.\.?)([^\]$.])', r'<code>\1</code>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
 
 endif::backend-xhtml11[]
 
 ifdef::backend-docbook[]
 ifdef::doctype-manpage[]
 [paradef-default]
-synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
+synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
 endif::doctype-manpage[]
 endif::backend-docbook[]
 
 ifdef::backend-xhtml11[]
 [paradef-default]
-synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
+synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index 2494f17a514..09156b71a4f 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -50,7 +50,7 @@ module Git
       def process parent, reader, attrs
         outlines = reader.lines.map do |l|
           l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
-           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
+           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$\\\*]+)}, '\1{empty}`\2`{empty}')
            .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
            .gsub(']', ']{empty}')
         end
@@ -72,7 +72,7 @@ module Git
           %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
         elsif type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
-              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<literal>\2</literal>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
         else
           open, close, supports_phrase = QUOTE_TAGS[type]
@@ -100,7 +100,7 @@ module Git
       def convert_inline_quoted node
         if node.type == :monospaced
           node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
-              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$\\\*]+\.{0,2})+)}, '\1<code>\2</code>')
               .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
 
         else
-- 
gitgitgadget

