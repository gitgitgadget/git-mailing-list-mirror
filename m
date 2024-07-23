Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FD14831C
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774686; cv=none; b=CzitK7HkIv55RrLKee5XuWbNVaLucyw0QAd8ACNqGB20zzIe0QrPnUmcd4maBrMs2QlPE2bAKo7vlgUPqsXCPjaAwKFN0h+4iZ3z9K8y1RdzQmeIUMilJChE/SlvwAC6PG9COzM0hOUG6lCu7bcRbSkaXid1OSzuU6by3Q7S36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774686; c=relaxed/simple;
	bh=Pj19QUyKQMcbl924pDcv31ALthBCEF6V8OKRrv2y7Nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=mmRw6EP1Y+6nIGMP+IveWVAoPIsh6BafNz+IjZbfkywweLDWFECnTnChh1YZ5fo5HnyyDA+uA99q9UKuuKF/0jfe0kOvZhF4EYWRrRGQ1TjNREO0tYDEwuuSXOm4XbBSXYTS60plhYRXlvya5hZnInvvJ7pQOd2jomKz4OZc0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQMss95j; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQMss95j"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367963ea053so4373149f8f.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721774682; x=1722379482; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mue7njXRWT3vZuKrZqwg0bNWpCe4CO2PbNnYhaj9FFw=;
        b=HQMss95jfaZEfNN6/S+RhBw+CSjrAwXhX3KFAGZOvp4om65DBm52D4fBDo67bWrnVW
         +s+yL1ViShMP/EpkagY6CkaGvTq4KiHUkz/2u/Gjm4G+qaTAtJ4+U8gqe+0KrfrF9BhI
         r/HmV3QXzrgCfEUBvz32zsSfKi9q/fP5TyZ2tZlUQbL3RJwX8fCLL+t0Y2WdmDHfZ7nv
         YNj7l2xIBf+Flf1486GQZzIxHSHCJmArdox7tD9cnj7U29rwJUpxPaq5DSinyS9Q0P8Y
         O1o1Of0rTXwoAL0fOy0LBC6nhx6gifzHLYlquRnAm6eqo5am937tHSsJP3VwVM/+6AkB
         C7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774682; x=1722379482;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mue7njXRWT3vZuKrZqwg0bNWpCe4CO2PbNnYhaj9FFw=;
        b=Vhiz3M4AQ+blHWe5eqhchrx+iyec3/9BLq/A9+7MJqhis2LUqz0QzAvNcjNfH9G8bY
         SumAfPWqVrcoBG+TB1cH0jMJtKEkS2VM0Yau8lRG25fgvP7dhKyk06pM6vY7vsARL28E
         mbhUklbjJQ91tj7oYWHADrTFcEinBaHjdywtuMaAzamhLAJvxba9jRV9cuX5k9PeK29i
         q9aBd17XI5mGdkP0V5Pm1iZM14hpRZWxt+nhA2df4E6kagRrT1UJ5MX4b1o9OBkEu03R
         57IVnocP7/x5AJp9OcUE6SBSs+MehWS5PxbTAbq5drlhnr7zQHG9k4QTDi4GNvMxQjCS
         gAlw==
X-Gm-Message-State: AOJu0Yz1rUp0+1OM6gzM5LMbDKlQMqbsAPCJ9dRbbIC5UcgdbZxl4w9I
	LZ4WO9w8G5FssAzmxTAKch0DsyUagnQWiiEOd9PyhYNDrhOMOVu942ILIQ==
X-Google-Smtp-Source: AGHT+IHDsRMBAcFBENNYStKkmiVxbu8ixs+09QrbYltDazY38aE2twd8QJvjAmpie4lT3IZRBkGsRA==
X-Received: by 2002:adf:b603:0:b0:368:3384:e9da with SMTP id ffacd0b85a97d-369f0aa550amr731909f8f.62.1721774682434;
        Tue, 23 Jul 2024 15:44:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b5fdsm12524985f8f.38.2024.07.23.15.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 15:44:42 -0700 (PDT)
Message-Id: <704f0333ef17c0e3596ba7ef7976ba6584345eff.1721774680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 22:44:38 +0000
Subject: [PATCH 1/3] doc: introduce a synopsis custom paragraph attribute
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
 Documentation/asciidoc.conf             | 14 ++++++++++++++
 Documentation/asciidoctor-extensions.rb | 17 +++++++++++++++++
 Documentation/git-clone.txt             |  2 +-
 Documentation/git-init.txt              |  2 +-
 t/t0450-txt-doc-vs-help.sh              |  7 ++-----
 5 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43edab..cb2a9ca59c65 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -57,3 +57,17 @@ git-relative-html-prefix=
 [linkgit-inlinemacro]
 <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
+
+ifdef::backend-docbook[]
+ifdef::doctype-manpage[]
+[paradef-default]
+#synopsis-style=template="verseparagraph",filter="sed -E 's!&lt;[a-z-]+&gt;!<emphasis>\\0</emphasis>!g' -E 's!([a-z-]+)!<literal>\\1</literal>!g'"
+synopsis-style=template="verseparagraph",filter="perl -pe 's!([\[\] |()>]|^)([=+a-zA-Z0-9-:+=]+)!\\1<literal>\\2</literal>!g;s!(&lt\\;[a-zA-Z0-9-.]+&gt\\;)!<emphasis>\\1</emphasis>!g'"
+#synopsis-style=template="verseparagraph"
+endif::doctype-manpage[]
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[paradef-default]
+synopsis-style=template="verseparagraph",filter="perl -pe 's!([\[\] |()>]|^)([+a-zA-Z0-9-:+=]+)!\\1<code>\\2</code>!g;s!(&lt\\;[a-zA-z0-9-.]+&gt\\;)!<em>\\1</em>!g'"
+endif::backend-xhtml11[]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a008039c..d1568f654627 100644
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
+          l.gsub(/([\[\] |()>]|^)([a-zA-Z0-9\-:+=]+)/, '\\1{empty}`\\2`{empty}')
+           .gsub(/(<[a-zA-Z0-9\-.]+>)/, '__\\1__')
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
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5de18de2ab83..70a3f0331f83 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 	  [++--recurse-submodules++[++=++__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
 	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]`reject-shallow`]
 	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
-	  [_<directory>_]
+	  [__<directory>__]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index daff93bd164b..7cdc693e1c68 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	  [`--separate-git-dir` _<git-dir>_] [++--object-format=++__<format>__]
 	  [++--ref-format=++__<format>__]
 	  [`-b` _<branch-name>_ | ++--initial-branch=++__<branch-name>__]
-	  [++--shared++[++=++__<permissions>__]] [_<directory>_]
+	  [`--shared`[++=++__<permissions>__]] [__<directory>__]
 
 
 DESCRIPTION
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 69917d7b8459..f9d89949ece3 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -56,12 +56,9 @@ txt_to_synopsis () {
 	fi &&
 	b2t="$(builtin_to_txt "$builtin")" &&
 	sed -n \
-		-e '/^\[verse\]$/,/^$/ {
+		-e '/^\[\(verse\|synopsis\)\]$/,/^$/ {
 			/^$/d;
-			/^\[verse\]$/d;
-			s/_//g;
-			s/++//g;
-			s/`//g;
+			/^\[\(verse\|synopsis\)\]$/d;
 			s/{litdd}/--/g;
 			s/'\''\(git[ a-z-]*\)'\''/\1/g;
 
-- 
gitgitgadget

