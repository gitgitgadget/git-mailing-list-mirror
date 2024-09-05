Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AC1A724A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573132; cv=none; b=tY3U11zPdvrRF3N3lpB+tD5hG+zY+ahxTSZi7xMO4WnXf1kOCintIOrkT13ueeJPPyRtrsmbyk6D5XU5PNdsfzUh7P86hha+FpZmDPeL3hIMtWVxhSvvzCj56jVXzMQwaEWHh0PKz0islPMdeQOJCqPBUGWYDyOsT7XwwX0mN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573132; c=relaxed/simple;
	bh=0DcWNNcKfw1VHxegoWaZu8UCO8t9yD4IaDst8zacdjg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=bhLsuW2fF7E0aIMdfdzHbm5k087UeAVbVkTSQc2nkaRkxB5DOYehmP54Zx5EdDc6mqrTbxmn8kIlFHo7Z8O8P1UVhTRmQ7jP3j5gtwBTyRRbpxVupTfjUoNSKphvYsGFs4BvhW+akqgh5uDAvuXX3SdeirZB4h+CvV4bfU/3oAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxFYxbd6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxFYxbd6"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c25554ec1eso1477956a12.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725573129; x=1726177929; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cn27tu37xl+IkvUoHDmY/cNfH672Dp7mLXqJ5mSDT4=;
        b=kxFYxbd6QBsPyBVIrzOSyizIgO5txES1ukU8Y50+B8e6QKg52eGm7SPEvGISuD4mwN
         PXLvounCRW6B/bt0kji5sG/g+5NLG84LaGJhd/h2x9nOHyhe1K7y4+w/FoG5uPTYFOjG
         tvqofEdNuuCRR6zywNqpQTGzD0w6moUlKhO0R4czd5PCl165PYZDH0ebGItGEc3Di3NZ
         as8flnWPp4YrIwDjhfIu6Zd3D7KxKSq9yg7mT6ZJWfwn6gvlhaioTtMtBvll4q168NDD
         d4jFU1o/BY0IaYLUTiYR2WE8dwTWnNvUyrKmR0k6n0Tt8re9JhbKkdQ+Jx2R8UOaUYOC
         mhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573129; x=1726177929;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cn27tu37xl+IkvUoHDmY/cNfH672Dp7mLXqJ5mSDT4=;
        b=sBJ9CSqDzOLY0y9WrAFlEqX9IyippM1OTc1AqMug+ls7EvlIeNCnRhuyR3qbX4GNva
         m6Qw9U5G611saTnrPt9n9ZvHyBQQI3cPHbIOT89bXk/u1MhUPPsHtO0q3HrKEvgThZg3
         y6s9XgfW1kHpM0CRlMMINk18qhOa9XhGpp+t0n2izx8JBgCEmf8QskkB1Rd9DtJ4yHYc
         DS6sac35thOMW7IE6VpCxKEw914Gmq47V18a7yP6m2rivLOu1/zXol1LwEuxVjO3M3fh
         23Io8WAkXgO3cfDI9VTnD07c02PIo/7fCrdhA83hKRuaOTtdeQu6tyF3ZprmJQQLmh7h
         jx1g==
X-Gm-Message-State: AOJu0YyNYLJY40xfKmYn0pPhIvWMxIE2K6AxdnyLo+6kZAxhntqDswv6
	SZwIsyA0Xyisp5nm0ANgpTw/4oiKfyCbZlpZedZnsyafkwt/NmwaAeUSYg==
X-Google-Smtp-Source: AGHT+IE74OKUeW3id246OYFqkWurfRrUAfJ5gNoKmkYcB3p692CeNcTpJUzMUPlIjKp4oOFvro3MSA==
X-Received: by 2002:a17:907:6e88:b0:a8a:8cdb:838c with SMTP id a640c23a62f3a-a8a8cdbc1cdmr1677666b.53.1725573128575;
        Thu, 05 Sep 2024 14:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038dc1sm186117266b.56.2024.09.05.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:52:08 -0700 (PDT)
Message-Id: <c09968d7ccbaa22b36daf0f3f8e88eb3e154c654.1725573126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
	<pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 21:52:04 +0000
Subject: [PATCH v4 1/3] doc: introduce a synopsis typesetting
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

In order to follow the common manpage usage, the synopsis of the
commands needs to be heavily typeset. A first try was performed with
using native markup, but it turned out to make the document source
almost unreadable, difficult to write and prone to mistakes with
unwanted Asciidoc's role attributes.

In order to both simplify the writer's task and obtain a consistant
typesetting in the synopsis, a custom 'synopsis' paragraph type is
created and the processor for backticked text are modified. The
backends of asciidoc and asciidoctor take in charge to correctly add
the required typesetting.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf             | 20 ++++++
 Documentation/asciidoctor-extensions.rb | 87 +++++++++++++++++++++++++
 ci/install-dependencies.sh              |  1 +
 t/t0450-txt-doc-vs-help.sh              | 11 ++--
 4 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43eda..75ae9f3da92 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -28,6 +28,10 @@ ifdef::backend-docbook[]
 {0#<citerefentry>}
 {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
 {0#</citerefentry>}
+
+[literal-inlinemacro]
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+
 endif::backend-docbook[]
 
 ifdef::backend-docbook[]
@@ -56,4 +60,20 @@ ifdef::backend-xhtml11[]
 git-relative-html-prefix=
 [linkgit-inlinemacro]
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
+
+[literal-inlinemacro]
+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<code>\2</code>', re.sub(r'(\.\.\.?)([^\]$.])', r'<code>\1</code>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
+
+endif::backend-xhtml11[]
+
+ifdef::backend-docbook[]
+ifdef::doctype-manpage[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@,\/_^\$]+\.?+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
+endif::doctype-manpage[]
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@,\/_^\$]+\.?)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
 endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a008039..cb24480b63d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,5 +1,7 @@
 require 'asciidoctor'
 require 'asciidoctor/extensions'
+require 'asciidoctor/converter/docbook5'
+require 'asciidoctor/converter/html5'
 
 module Git
   module Documentation
@@ -39,10 +41,95 @@ module Git
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
+          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
+           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
+           .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
+           .gsub(']', ']{empty}')
+        end
+        create_block parent, :verse, outlines, attrs
+      end
+    end
+
+    class GitDBConverter < Asciidoctor::Converter::DocBook5Converter
+
+      extend Asciidoctor::Converter::Config
+      register_for 'docbook5'
+
+      def convert_inline_quoted node
+        if (type = node.type) == :asciimath
+          # NOTE fop requires jeuclid to process mathml markup
+          asciimath_available? ? %(<inlineequation>#{(::AsciiMath.parse node.text).to_mathml 'mml:', 'xmlns:mml' => 'http://www.w3.org/1998/Math/MathML'}</inlineequation>) : %(<inlineequation><mathphrase><![CDATA[#{node.text}]]></mathphrase></inlineequation>)
+        elsif type == :latexmath
+          # unhandled math; pass source to alt and required mathphrase element; dblatex will process alt as LaTeX math
+          %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
+        elsif type == :monospaced
+          node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
+              .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
+        else
+          open, close, supports_phrase = QUOTE_TAGS[type]
+          text = node.text
+          if node.role
+            if supports_phrase
+              quoted_text = %(#{open}<phrase role="#{node.role}">#{text}</phrase>#{close})
+            else
+              quoted_text = %(#{open.chop} role="#{node.role}">#{text}#{close})
+            end
+          else
+            quoted_text = %(#{open}#{text}#{close})
+          end
+          node.id ? %(<anchor#{common_attributes node.id, nil, text}/>#{quoted_text}) : quoted_text
+        end
+      end
+    end
+
+    # register a html5 converter that takes in charge to convert monospaced text into Git style synopsis
+    class GitHTMLConverter < Asciidoctor::Converter::Html5Converter
+
+      extend Asciidoctor::Converter::Config
+      register_for 'html5'
+
+      def convert_inline_quoted node
+        if node.type == :monospaced
+          node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
+              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
+              .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
+
+        else
+          open, close, tag = QUOTE_TAGS[node.type]
+          if node.id
+            class_attr = node.role ? %( class="#{node.role}") : ''
+            if tag
+              %(#{open.chop} id="#{node.id}"#{class_attr}>#{node.text}#{close})
+            else
+              %(<span id="#{node.id}"#{class_attr}>#{open}#{node.text}#{close}</span>)
+            end
+          elsif node.role
+            if tag
+              %(#{open.chop} class="#{node.role}">#{node.text}#{close})
+            else
+              %(<span class="#{node.role}">#{open}#{node.text}#{close}</span>)
+            end
+          else
+            %(#{open}#{node.text}#{close})
+          end
+        end
+      end
+    end
   end
 end
 
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
+  block Git::Documentation::SynopsisBlock
   postprocessor Git::Documentation::DocumentPostProcessor
 end
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4781cd20bb0..3e3ae39cbb1 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -107,6 +107,7 @@ Documentation)
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
+	sudo gem install concurrent-ruby
 	;;
 esac
 
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

