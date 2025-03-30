Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221214B08A
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354971; cv=none; b=FOGEk2Dpy42C4bcpSEyxr9aP70a564hP6kVZherMrinpFqStHN/a4ZpW/zeZtaaXDPpj4lVkHbyvYFfOAXiYKyogMLfC4FvJ418qFMZV+DduVmpMwx3ZG3a7VBhjqbY2ukSWgF/x3cGybwgYjzYGli66q7mjlhFQYFqWLwG/5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354971; c=relaxed/simple;
	bh=Ov+bWOxARJlJFz+5CfnfTjPm7yGb/svi86pFG3YEniU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=O/0eU5QjH1WPw88PshPSu7dVJHW+FZ2cSzzuVtuo0r8isi88863OV9eYokuL720qQ+p5+ebyrRBhZsEv4iQML5EkR2V3KzuvfBsLSQ9f8sbH9LAmxmMRfk/+0J17XTk+aeJ875GVHlyl/Fqp5tEkgUfxdAKze30wGkNTmV3x8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW9Yp2Ku; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW9Yp2Ku"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2119564f8f.2
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354968; x=1743959768; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAAiuglveSzsCh52fS6Ti1UlCsNRXR76NCT6qXuOosQ=;
        b=fW9Yp2KuEAAtmykkr6rIfQudpboxASOYOXGrFHwBwDBRkM5ttbGrx5GI0oOtqfa7iy
         77WOn26OwPP4gnll5aEEDZ8PUFoRIAn3RIMLJ0jv/kOrjTBnRpV1AXZJcK/2aYkmjp6z
         GsO76kOxNTmr+gqh0rFGWgBHl15sfZuBrVJu0h3Uc9MMP+7GLsOdB5otT/wIDx0x6MSI
         sKTOAcBote8/a2dFU+/Fk36bqQHSrYfFVpNa200b1+l+10QywEQDtJ360m4NebH9TuZG
         21yAdgAhKJH6RyQKHV4DXiepaqaEIZEd58ngZbi60fqcyayaVmgJTJ4WJwgz2V0uU3ds
         jYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354968; x=1743959768;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAAiuglveSzsCh52fS6Ti1UlCsNRXR76NCT6qXuOosQ=;
        b=mnF5ZkMZnpEw+xPDctv1deAb36IOYPcdti/TH6xddW/kSiNT1UNOavafRm2NsmncQV
         qFGfFaTiXQw7wNaw0wUitgAabiW4M4MLdsANERsUW3L0v3KXsBbPlOKAEDnU23ITsowL
         rEmX7OhtgEKufZPdofFeWp3VuIYZcOzDP/sLMZkq7q24NQPzcNbqpHS5VEUet3IfcW27
         dmGYHPFotb+TM8cs+dhu2A69A6USiiCyEWkLaaI5H9RL5Emi/PItX8LFvDINC2SUfPGR
         CKNtWVmqJLT17paKwl7ST2nrpCtL9bjCgLwEWUAJoVfNdrcTWZGVx1rOrE1CCBc3ttJ8
         5P6Q==
X-Gm-Message-State: AOJu0YwgADRUhclMhLBKTLqB6ssxLvh31NAsiq7M8WFpoOkLEXYhvg64
	kUS6lVmaLcWv8luf96/feOv44/T1aYldJXv83m6Hi+fgBTgDru73CAXo5w==
X-Gm-Gg: ASbGncsbprv+zW762ASPiTZdQuQVobjLJMMwhvOQSB9YpQRwNg8A9TrTq6kMmo25QOt
	pOnOfq0VbNA0UMjT7LiY0/aa+u3FznhdUH5qWHoiM8jvS254lGMg850iqFy6OfkwxFLZh/3ZIzP
	eWLlecY4/O/acSIOEvaX735qZ5iVzvYg1ZZEPQqcqj7AZ9HMgLF2MA3kDz+ElXIUEdWPuBmkeYh
	RagW/tU2cymVuLfvaDQ1httlm5j1a2iugyxd/tcoyi5XGwQyhjRgz+W96UYkY6KZdicsZt86LSz
	F5duKTFoLIy0Ixd5QcSzxHAhjxc83biIoCQzvPxa5NcM4g==
X-Google-Smtp-Source: AGHT+IH0Q+/7beITQVWQ3apz8zdS1ZKotbgF5H2divOBpI8zaGNsk66Y0pMnpsse3+ccg/CRxhcE9Q==
X-Received: by 2002:a05:6000:18a6:b0:391:2db0:2961 with SMTP id ffacd0b85a97d-39c12115cf6mr5182727f8f.38.1743354967754;
        Sun, 30 Mar 2025 10:16:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66363fsm9323617f8f.36.2025.03.30.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:16:07 -0700 (PDT)
Message-Id: <6206e65ac4d50e174ad7e3dbafaa590b632f214b.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Mar 2025 17:16:01 +0000
Subject: [PATCH 2/5] doc: fix synopsis analysis logic
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

