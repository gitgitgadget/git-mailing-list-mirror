Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CC13AA45
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855185; cv=none; b=j6wrSKpVAfJqTbPnvi9cxvZKBVBG8soirObJ1LrzvUsukqF6QT3yxfeq8rNPARy5PB0f0Sl5FUCg6eQZHmM6mZKpptTcVkrLJyaCFWm1nao5exVBnCrjqJGpJ3WauW8NOrkBBmTjr98dc+5wGVkLTPK8Z6MNAFXR3P1wjKJxMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855185; c=relaxed/simple;
	bh=ptf9/XRhnLCkGxdU6+IpYEryGjinqZzPz3DNJxqK3R8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=u8n0IE2xp6r8M4sHRC7tjD0xkZnOW43FiBxI1CqZqpT7Qctl/JuYzSlU4E3u6dM9VpuTx9CNjrg9v4ET1A/F3nFKGMfuKaodfuv+JnoAW+hxACs28UJlct0FeL/inhX0VUtszsels3xAvYWqknSsrbpNIdWRIUvJsdP2qER3CG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1QHk4gy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1QHk4gy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so1556315e9.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721855182; x=1722459982; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxJmoz8tAJSxV0IPgU16v7QX0c16++1CnGrgJ+b6E78=;
        b=d1QHk4gyPsu+7so74z03uWofcbjEVeFCjXSThlX87Kv73txTppjvITGCjTuARkxbXm
         oDetymXYaQh56K3mC+cZB3nUa57yf2qTDMXDqxx0m6LpK4f5nT+URzkZUWArlBQFCOps
         6nBiiGhVdvIno1UnGFNvUDfRUo7EZTRoX89pYCxZATBPRm3AxLCzGntytqkquhRbQe3G
         iL78k3bGypwcekuf3xQf2QdXbBVsvMRCIhzobJ8iujlWWARWDFWlm+xSSPZO4LHbKo3M
         HadgyT2bxOQNwRPHCTEiNAEk2Zd9xVZprv7m/MxE09MlsrKf6FWH/YPwiihdxeZRkpDO
         9//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855182; x=1722459982;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxJmoz8tAJSxV0IPgU16v7QX0c16++1CnGrgJ+b6E78=;
        b=gjw6kV0kY+xbK/2TYgg402H5v4wxHdqjfxoU/Z/Op13nzo4ArnWdeyC81Vuw/+5VFW
         W7F4xXXZi63ANDbqky5H1d5geubaRw/WqmBc6R/Phw1OgZGC52egjJC3ozlwa3KTnOkg
         h8XRt3a2Cg/N/xxJ3w06hNROO92UPvMLTbWNZl5md48MqzITG7CGFQW6zn7oyK2v0tCj
         fWw6wujpUrerOzV2LbUGc+bd2R6LcxLV950p93Sw8vXWh0Bf5FKyjI7f9Z0pLvhpsf9K
         baKnvWcqZkoOlfjyAlJB8dNlCFWexyl45zFy8ufeAcsEuaLKW9r1QZd5ymmF0u35qNXO
         DaGA==
X-Gm-Message-State: AOJu0YwgyrqfZZF6Xf3JavWSLDjmzC32eoTsJjmhd8SwkgufQ3knfv/f
	/LKHVYKLmGtJhKtv0A1dWUxVn+lQ34C7P5nP75nP0dFpGTVzF64NEpDQfA==
X-Google-Smtp-Source: AGHT+IFapyMSO8wQQ7aLpWKnjlIjlOjIW76YJPQmd8uRDfSCJl4JG575NlIDFqjTFkL4CSfAzFKS4Q==
X-Received: by 2002:a05:600c:3b28:b0:426:5cee:4abc with SMTP id 5b1f17b1804b1-4280570fefamr1293425e9.20.1721855181667;
        Wed, 24 Jul 2024 14:06:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9359478sm45698095e9.6.2024.07.24.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:06:21 -0700 (PDT)
Message-Id: <aba144f4ff3fe204aa76864c8d439f39719e4bab.1721855179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jul 2024 21:06:17 +0000
Subject: [PATCH v2 1/3] doc: introduce a synopsis custom paragraph attribute
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

In order to follow the common manpage usage, the synopsis of the
commands needs to be heavily typeset. A first try was performed with
using native markup, but it turned out to make the document source
almost unreadable, difficult to write and prone to mistakes with
unwanted Asciidoc's role attributes.

In order to both simplify the writer's task and obtain a consistant
typesetting in the synopsis, a custom 'synopsis' paragraph type is
created and the backends of asciidoc and asciidoctor take in charge to
correctly add the required typesetting.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf             | 12 ++++++++++++
 Documentation/asciidoctor-extensions.rb | 17 +++++++++++++++++
 t/t0450-txt-doc-vs-help.sh              | 11 ++++-------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43edab..08111e98ab33 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -57,3 +57,15 @@ git-relative-html-prefix=
 [linkgit-inlinemacro]
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
+
+ifdef::backend-docbook[]
+ifdef::doctype-manpage[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])([-=a-zA-Z0-9:+.]+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
+endif::doctype-manpage[]
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])([-=a-zA-Z0-9:+.]+)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
+endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a008039c..8c7612743504 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -39,10 +39,27 @@ module Git
         output
       end
     end
+
+    class SynopsisBlock < Asciidoctor::Extensions::BlockProcessor
+
+      use_dsl
+      named :synopsis
+      parse_content_as :simple
+
+      def process parent, reader, attrs
+        outlines = reader.lines.map do |l|
+          l.gsub(/([\[\] |()>]|^)([-a-zA-Z0-9:+=.]+)/, '\\1{empty}`\\2`{empty}')
+           .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
+           .gsub(']', ']{empty}')
+        end
+        create_block parent, :verse, outlines, attrs
+      end
+    end
   end
 end
 
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
+  block Git::Documentation::SynopsisBlock
   postprocessor Git::Documentation::DocumentPostProcessor
 end
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 69917d7b8459..f99a69ae1b74 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -56,14 +56,11 @@ txt_to_synopsis () {
 	fi &&
 	b2t="$(builtin_to_txt "$builtin")" &&
 	sed -n \
-		-e '/^\[verse\]$/,/^$/ {
+		-E '/^\[(verse|synopsis)\]$/,/^$/ {
 			/^$/d;
-			/^\[verse\]$/d;
-			s/_//g;
-			s/++//g;
-			s/`//g;
-			s/{litdd}/--/g;
-			s/'\''\(git[ a-z-]*\)'\''/\1/g;
+			/^\[(verse|synopsis)\]$/d;
+			s/\{litdd\}/--/g;
+			s/'\''(git[ a-z-]*)'\''/\1/g;
 
 			p;
 		}' \
-- 
gitgitgadget

