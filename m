Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8981C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjDEMzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbjDEMy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 08:54:59 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293F5358E
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 05:54:58 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so24236727fac.8
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUWM4fLbVR6wXyitwHU/ITe60PqVFdOOFFWyIV0K4JA=;
        b=WC/qcZdT3hNclKfEWHrhmNpavWa4fHnZ28vrk0s4UPQtu5VFP/UPedxB/S/w+ShQny
         PX+obsnJHnl5/GD9U+0D/yDOXoxJffEF0juYzBhzSp7F+RVDef2G4WRHqQZXJ5S5E2e6
         CYZR7JA4Wi+cMtkEnB5lKx1kUb3JY/ky3AIo6HfqebK9MxJBIhttlBUeX6vXiOatVxhc
         yqEXjwkXpxOpLSQRZKCYGBGLlIdzw/nT9sgci28rTcK3WHRcmGxOxiGdhRNBD1Uqs7ah
         DJomtExcyCvHUKlC7dXK7XgjDdmTRAF105aYIIlFL7k62/RvLQYcNOkwb2Zl+LLugg7l
         mE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUWM4fLbVR6wXyitwHU/ITe60PqVFdOOFFWyIV0K4JA=;
        b=YXQ6Z1I4sczC7KIOHROU3irfhpQcM0JuZ4dQNBiMoTJBbVUdvE2Ek6EpZh859EDwHR
         MB5HdklNivuXXstza5YREVxihLt8ecI0nnchr+02i21A7UdxTmnlSSBcJF8GtIrkLbiE
         GjJikoGpmqHKFzop3+LCVTYmL1GS46+rdaY+V7mG+hJHS9ZlcVpIZcFhN73eTjOBhsXy
         b9KAtPvM+ylAjV/B9XGz+oOkQYSpeUMl35ZFrMhKYfFK3ZJ540PElSCbKukjhglpSJ2d
         DiJHQ6lmh6GwY0uqPhEXliawxFqXJsRmTIVaoyxvbirHiZpT7LGuCS04615hh4lU3sZQ
         2U2Q==
X-Gm-Message-State: AAQBX9cAkgKvsVIxs63Ugv7EFl91d4Cm55jYKpzVfVRdLAw3k/4w1pQb
        ydYHEAZOhiJLu/PLQtdpcOtTSTiZ8sE=
X-Google-Smtp-Source: AKy350a6vb2sTBJ2bnPG9abek4H+M9mRbpqkIG98kmGX2c1N7ZOM4FS9Ot5cO2lT8wx85rdD51nD0g==
X-Received: by 2002:a05:6871:7a3:b0:177:8fc9:91ea with SMTP id o35-20020a05687107a300b001778fc991eamr3583927oap.2.1680699297162;
        Wed, 05 Apr 2023 05:54:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id sc15-20020a056871220f00b001729072f759sm5953263oab.0.2023.04.05.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:54:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 1/3] doc: add documentation guideline
Date:   Wed,  5 Apr 2023 06:54:51 -0600
Message-Id: <20230405125453.49674-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230405125453.49674-1-felipe.contreras@gmail.com>
References: <20230405125453.49674-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the documentation is in asciidoc, and nowhere in our
documentation is described how best to use it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/DocumentationGuideline.adoc | 195 ++++++++++++++++++++++
 Documentation/Makefile                    |   3 +
 2 files changed, 198 insertions(+)
 create mode 100644 Documentation/DocumentationGuideline.adoc

diff --git a/Documentation/DocumentationGuideline.adoc b/Documentation/DocumentationGuideline.adoc
new file mode 100644
index 0000000000..940c09c905
--- /dev/null
+++ b/Documentation/DocumentationGuideline.adoc
@@ -0,0 +1,195 @@
+= Documentation Guideline
+:1: https://docs.asciidoctor.org/asciidoc/latest/
+:2: https://docs.asciidoctor.org/asciidoc/latest/subs/special-characters/
+:3: https://docs.asciidoctor.org/asciidoc/latest/text/troubleshoot-unconstrained-formatting/
+:4: https://docs.asciidoctor.org/asciidoc/latest/text/literal-monospace/
+:5: https://lore.kernel.org/git/pull.1304.git.git.1659387885711.gitgitgadget@gmail.com/[[PATCH\\] Documentation/git-reflog: remove unneeded \ from \{]
+:6: https://lore.kernel.org/git/CABPp-BEEDS%3Dv7ouOKts83OFMxDq%3DF0TKO1XvHEbnmXJ+Z1WELA@mail.gmail.com/[Re: [PATCH\\] git-merge-tree.txt: replace spurious HTML entity]
+
+Documents shall follow the AsciiDoc format, a simple markup language specified in the {1}[AsciiDoc Language
+Documentation].
+
+----
+This is a basic document.
+----
+
+Documents simply contain normal text, except this text will be interpreted using various rules.
+
+----
+This is a line which contains special characters: < > &
+----
+
+The tools used to generate the documentation will convert these special characters when appropriate, for example for
+HTML they will be converted to `\&lt; \&gt; \&amp;`, so you don't have to worry about that (for reference check
+{2}[Special Character Substitutions]).
+
+Formatting can be easily added:
+
+----
+When all else fails, do `git reset --hard`.
+----
+
+This will render as:
+
+====
+When all else fails, do `git reset --hard`.
+====
+
+Therefore one must be careful when using certain characters as they may be interpreted as formatting marks. All of these
+are special characters: `pass:[_ * ` ^ ~ ']`. For a detailed explanation and examples of troubleshooting edge cases see
+{3}[Troubleshoot Unconstrained Formatting Pairs].
+
+== Titles
+
+Titles is how you organize your document, you can have as many sections as you like, but only one document title (level
+0 title).
+
+----
+= Document Title (level 0)
+
+This is a document introduction.
+
+== Section Title (level 1)
+
+This is a section introduction.
+----
+
+== Description Lists
+
+Description list are used to describe a list of things, for example options:
+
+----
+-v:: verbose
+-h:: help
+-q:: quiet
+-f:: force
+----
+
+Renders as:
+
+====
+-v:: verbose
+-h:: help
+-q:: quiet
+-f:: force
+====
+
+== Listing Blocks
+
+Often you'll want to include example code, for that you can use listing blocks:
+
+-----
+----
+__attribute__((format (printf, 2, 3)))
+void fprintf_or_die(FILE *, const char *fmt, ...);
+----
+-----
+
+Renders as:
+
+====
+----
+__attribute__((format (printf, 2, 3)))
+void fprintf_or_die(FILE *, const char *fmt, ...);
+----
+====
+
+Anything inside them is literal, so you don't need to escape it.
+
+If the code is a single line, you can use a single or more spaces of indentation:
+
+ {space}$ cat .git/HEAD >&2
+
+====
+ $ cat .git/HEAD >&2
+====
+
+== Links
+
+To link to other parts of the documentation, use the `link` macro:
+
+----
+For more information see link:CodingGuidelines.html[Coding Guidelines].
+----
+
+====
+For more information see link:CodingGuidelines.html[Coding Guidelines].
+====
+
+To link to a manpage, use the `linkgit` macro:
+
+----
+linkgit:git-config[1]
+----
+
+====
+linkgit:git-config[1]
+====
+
+External links don't use a macro:
+
+----
+https://docs.asciidoctor.org/asciidoc/latest/[AsciiDoc Language Documentation]
+----
+
+====
+https://docs.asciidoctor.org/asciidoc/latest/[AsciiDoc Language Documentation]
+====
+
+== Caveats
+
+Because the format is so straightforward, one might be tempted to forget that we are using a markup language, but it is
+a language, and certain strings have certain interpretations, for example `+{tilde}+` is going to be substituted with the
+`tilde` attribute (`~`).
+
+So one can't just use `+{foo}+` haphazardly, these texts have to be escaped. For example with `+\{foo}+`. So one should
+write `+master@\{upstream}+`. However, other texts, such as `{<foo>}` can't be attributes, so escaping would show the
+backspace.
+
+To avoid all these problems, one should use literals `pass:[+foo+]`.
+
+----
+* {<tilde>}
+* \{<tilde>}
+* {tilde}
+* \{tilde}
+* +{tilde}+
+* +{<tilde>}+
+----
+
+Renders as:
+
+====
+* {<tilde>}
+* \{<tilde>}
+* {tilde}
+* \{tilde}
+* +{tilde}+
+* +{<tilde>}+
+====
+
+However, more often than not what we want to show is `+{tilde}+`, not +{tilde}+, so in those cases what we want is
+literal monospace text, so we have to add backticks: `pass:[`+{tilde}+`]`. For more information see {4}[Literal
+Monospace].
+
+This isn't theoretical, developers have been confused by this.footnote:[{5}]
+
+There are other replacements, such as `+<=+` replaced with `<=`. Which again: has confused people.footnote:[{6}]
+
+So when in doubt just use literal monospace.
+
+=== There's more
+
+But what happens if the literal text contains `{backtick}` or `{plus}`? In those cases you can use the inline `pass` macro:
+
+----
+The following characters must be encoded: `pass:[~!@#$^&*(){}\;",<>?'`+]`.
+----
+
+====
+The following characters must be encoded: `pass:[~!@#$^&*(){}\;",<>?'`+]`.
+====
+
+---
+
+This should cover the basics, but there's no substitute to {1}[RTFM].
diff --git a/Documentation/Makefile b/Documentation/Makefile
index a6ba5bd460..59b64a6d5e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -372,6 +372,9 @@ $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.tx
 SubmittingPatches.txt: SubmittingPatches
 	$(QUIET_GEN) cp $< $@
 
+%.html : %.adoc
+	asciidoctor -I . -r asciidoctor-extensions.rb -o $@ $<
+
 XSLT = docbook.xsl
 XSLTOPTS =
 XSLTOPTS += --xinclude
-- 
2.40.0+fc1

