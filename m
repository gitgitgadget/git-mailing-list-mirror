Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D972EAE9
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389619; cv=none; b=cqewzPzmSJCitk4WNgIc3qR1UAqYMCkZizNzR2f5X2XPBUaghReIk5/1j/5Rq7XiGwz+7SANemY5plEvdLbKBtJgUnVhGggawVRMki96L5fNU4Nsg05Nzv8jXc8Xq495x5BN4O4hyonO4a7FciUY2d3HzB8t/Q4aMVwyrDlwAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389619; c=relaxed/simple;
	bh=20pSkOmI4J8NlDI2OhZ8Jruc3/MkiGWz+hyTBZ4nTjs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=V6LuUjjW8387LE8HmlTtnnbO+7lD6hskoO1CGy8xXqhigTateloexel9AjjVjTOMvoz0kdNmduqJBovf+Zk04DvfQt00vV16kMlhKYC2E9Aw70P1xdp2U4Xc/YUgKESHXbC5btxxWb5JKHEbbeXzEUQCepycF9F21lmlsIUY/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgsUOhL/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgsUOhL/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so24656885e9.2
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723389615; x=1723994415; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u/WbOBbN0ZFVzr77I3VUk1mvc5QNsLeAjJjo4K9qfA=;
        b=WgsUOhL/Y7DUmPLv3hfGub/RxsLhsIIkKv8TYYX49Vt067p992fjIJ5uSpKTyECEcF
         rIrCfRg2BfoFfPzb3FE4yLa7h7RJHFWjvIIXFTGZEHxuXRaGocGIhH3Zewyqb/G4wh/D
         9zkclIVCb8/+89JFuIyzxuaAbGkJ3m6eLKqEuD7eFgb0x8wDBi9u35RTIgPquumGtpNR
         E7nAllhIshWjsl/wRlkw7buZUfPkiW3KakopTQBkluMRHp8VJsFC2N1TqE1Rl7n1VhaE
         gSbKijSDNTtPd0qwRmjZoKm7ElNFDrfNEzJfiVJy3jK+kmvIdLwruVcWK4F5tjk0Hp1M
         Fi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723389615; x=1723994415;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u/WbOBbN0ZFVzr77I3VUk1mvc5QNsLeAjJjo4K9qfA=;
        b=QAjZjZOMttsuZri1xdgvckFW4FSwSvplTOfhltmmF5jlGZzhASox23wPInxfYniatJ
         8tv5WghQCxtLULeHsURPfJ6vF/Vtg9wxMC+qP8hRx3722+0jqNXSo1WxGNhwgNmgyong
         L5eQJFmImSRmqM3HVmhWqvGoVaDlPgty26Mrm9LfD+pQeUyTLA0iumAadQ17RFGVfmww
         38ci8+ip+vEN4lFYOeptI1PiiUySxlhMxriMxOtWs6+cba5P+CrO7tn6dx1/FlqgLeqq
         Jij5CkueJIYfUxc89zqwoIxMzStfeuy9nzGNDMxtRF8XiPGpIiaxLG3rELNT/ziSDwGz
         +uyg==
X-Gm-Message-State: AOJu0Yyi4rcVrWUM+CIchImXVd9HUXniBWyWYtkWJgrdaYB6hwJE8NLh
	5JWjB/8MQH3PSsdQS1obIqL27ma2mwsdtRFZD+yXGjnaARlhMnoSROnzrw==
X-Google-Smtp-Source: AGHT+IGl9g7Jw4nM49h5nPAiRID0aj9Y1XKH3x1GKqFps+06i253tQjDT5CfVKc9EA2BGX+fvCLQCw==
X-Received: by 2002:a05:600c:190f:b0:427:d8f2:550 with SMTP id 5b1f17b1804b1-429c3a19f7cmr41357705e9.14.1723389614918;
        Sun, 11 Aug 2024 08:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738947sm151729315e9.10.2024.08.11.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:20:14 -0700 (PDT)
Message-Id: <0d7c1dd8f26f8bdfd93bcbf981b5bb6a6041f069.1723389612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
	<pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Aug 2024 15:20:10 +0000
Subject: [PATCH v3 1/3] doc: introduce a synopsis custom paragraph attribute
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

additionally, a 's' macro ('s' standing for synopsis) is introduced to
allow writers to freely apply automatic styling whereever required.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf             | 21 +++++++++++++++-
 Documentation/asciidoctor-extensions.rb | 33 +++++++++++++++++++++++++
 t/t0450-txt-doc-vs-help.sh              | 11 +++------
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43eda..04405453415 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -9,7 +9,7 @@
 
 [macros]
 (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
-
+(?su)[\\]?(?P<name>s):(?P<target>\S*?)\["(?P<attrlist>.*?)"\]=
 [attributes]
 asterisk=&#42;
 plus=&#43;
@@ -28,6 +28,9 @@ ifdef::backend-docbook[]
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+
+[s-inlinemacro]
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[ |()>]|^|\]|&gt;)(\.?[-a-zA-Z0-9:+=~@,\/]+\.?)',r'\1<literal>\2</literal>', '{attrlist}'))}
 endif::backend-docbook[]
 
 ifdef::backend-docbook[]
@@ -56,4 +59,20 @@ ifdef::backend-xhtml11[]
 git-relative-html-prefix=
 [linkgit-inlinemacro]
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
+
+[s-inlinemacro]
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[ |()>]|^|\]|&gt;)(\.?[-=a-zA-Z0-9:+,@]+\.?)',r'\1<code>\2</code>', '{attrlist}'))}
+
+endif::backend-xhtml11[]
+
+ifdef::backend-docbook[]
+ifdef::doctype-manpage[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@]+\.?+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
+endif::doctype-manpage[]
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@]+\.?)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a008039..46cbbbbfd76 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -24,6 +24,21 @@ module Git
       end
     end
 
+    class SynopsisMacroProcessor < Asciidoctor::Extensions::InlineMacroProcessor
+      use_dsl
+
+      named :s
+      match(/s:\["(.+?)"\]/)
+
+      def process(parent, target, attrs)
+        l = target.gsub(/([\[\] |()]|^|&gt;)(\.?[-a-zA-Z0-9:+=~@,\/]+\.?)/, '\1{empty}`\2`{empty}')
+                  .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '__\\1__')
+                  .gsub(']', ']{empty}')
+
+        create_inline parent, :quoted, l, attributes: { 'subs' => :normal }
+      end
+    end
+
     class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
       def process document, output
         if document.basebackend? 'docbook'
@@ -39,10 +54,28 @@ module Git
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
+          l.gsub(/([\[\] |()>]|^)([-a-zA-Z0-9:+=]+)/, '\1{empty}`\2`{empty}')
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
+  inline_macro Git::Documentation::SynopsisMacroProcessor
+  block Git::Documentation::SynopsisBlock
   postprocessor Git::Documentation::DocumentPostProcessor
 end
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 69917d7b845..f99a69ae1b7 100755
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

