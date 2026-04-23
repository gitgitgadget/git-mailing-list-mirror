Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABB2F83A2
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960587; cv=none; b=eQUJAUmhEB/w9DjW3mqXrY9rzuCmOIz9RKpV4XS1Sk3/vnvL4LoOLLYo/AP9v0aA50S/wJzEg4uUBVywmJc6xB6xt5Np0QnOtDH6aDPKILGQ+GzQ+c2uPN52F2D1YKW4sSHQfdRtdSkIk9POpwo2gyzixTVCy8+8ssXc3/kj7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960587; c=relaxed/simple;
	bh=EATDC2QxXE47FzT0TtH0Yv1qUKQw7BdVGWrEg1Hr8ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz8lGbQgH3o5TSTWrQKTtw4ZvASOuKf5febd+A9aaCSa9knqPucxkB+yux/eXCi/r85XegtVg5+dzxC+2MYmOfRw2LXsn0dU3KXK/AHpSkCor6D4W/N2FF0EV8FWSLpoPZOvaE9CHhXBv2ksSqc0jTedv6dQ4AtX1xTRRj4+Dfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6XtMfku; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6XtMfku"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7927261a3acso61743457b3.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960584; x=1777565384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPRPL5punQNaWoNjjpIIOjboKk23d27rew/cxMROqbo=;
        b=Y6XtMfkuzWUMTDYFmBBRiW6DsMLx7ppYy9FwMurVWvjhodlzwiO85Mg0Jv+/zj5GSU
         j7LvEMMgUnMLGdDFF8z4FVo3IMSAAQnzYI5KEtk9ePJUtdP9bjVXz3Cu15jEVq6xfwuX
         hzE3zdE9YGV1o2xkTlfEH3lE6fGt4t+GDW0j6seNi2fPmmwna8Rdt/8t36kImhiX0XEa
         pKzvHjt5eN93UG5i1tDhuKEnjNlmM+hh1Y33t3+Ef11eecssnRtBJr63ydB21/DuO4kF
         yPXPm6AOYkiKbtlIirxzzZ+O1ogaGTPGx2cu8t5tOQi3FkmN2K/op0EdeLnPT0z2KpcL
         lzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960584; x=1777565384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPRPL5punQNaWoNjjpIIOjboKk23d27rew/cxMROqbo=;
        b=dQN8m1gJ8DC8qX/wcPcaz4gnQiS67PCXHIvLD0vXWp265wuPu+Km3rT9Aa0NHtr3Xb
         h2/8bU5HhlEKw0+VKsr2JJ3/NsTpd6bOQfxNbi2BMnfPqsQwpEnMiKLt1rbDpTZirZWS
         h43mc6XHLoexEKFc2ZzKfn8wTBrYC9swVcC2nuYja/KzPG7RUs+msS8rbhpbhXyd0ZXb
         HVB8QH9a98rR43cFmGVv9rU/dbBm43fjvn21Tv8F55kZtedyTJk6m0w5RyxBibfUSQ9h
         opmlJQ++ieVardwXKg2L3m86X0zqFswgP/uC4/p3LLLSLMAoZ4C+RuZSbFTCgdFvElF8
         xXNw==
X-Gm-Message-State: AOJu0YxJw4wRm7D9WsEFclNRjiaWxkAEjKyd8bbxBNMqVLJuKDg80ghT
	KUV/vBd0hrA1jxA2vJZxFiCtGQjHj57YgYbF4oS4i0eKsXE+3An7lGbKa+omjml9
X-Gm-Gg: AeBDietBkWFh9U2be+PiM587BLeVObcA4t0EULWh2LParlaYSRB3lzeHmwlCfFWxfRo
	WsIhWIHlEx4gcu0F+9x7E6NHzmHufm2a2BdVbaoW7lwzwr0CwSXKU1XUQqvURcLooMwfIgDPmVV
	LYpsGigw4jBH1McPZPDWkdX5BqBAyyFs/TgjdtpYksKZWfaR1xbl8drchFJwaPUzkaMnnYAZsV2
	bPd/bfEXwaaBWXSIKT8RHYI/HqpjRB7rRXAKuFE+bLV2vPqa7tI3Iu9vbyz99TYpc4fS8lfC3+F
	l9vNGPZpYrY3BFv01tGnjg51GzY/yT1xn5GyJL/1JRD5TaLmB1klJSs7tT1HtkpRacxZHRS42YW
	DbKbmGaUZNFGxlt5zzMYoQjeRLM93Sv2AWH2TKsQIgtMsMpZ95NnBU/cMm7zckbEABi2u4sf5LE
	+XHn/PkhOE0WnX7BLPsYRjowcbWCEyMH9z6AdrCCZUKwUq2+VTSXnY1i1znWcLMhUcykoV2Z3Nr
	wSL5PsH
X-Received: by 2002:a05:690c:9211:b0:7ae:904c:11ed with SMTP id 00721157ae682-7b9ecfbf12bmr235002577b3.36.1776960584578;
        Thu, 23 Apr 2026 09:09:44 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:44 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 6/8] gitglossary: fix indentation of sub-lists
Date: Thu, 23 Apr 2026 17:08:30 +0100
Message-ID: <20260423160832.114816-7-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

The glossary entry is a list of terms and their definitions, so
multi-paragraph definitions need "+" continuation lines to indicate
that they are part of a single entry.

When an entry contains a sub-list (say, a bulleted list), the final "+"
may become ambiguous: is it connecting the next paragraph to the final
entry of the sub-list, or to the original list of definition paragraphs?

Asciidoc generally connects it to the former, even when we mean the
latter, and you end up with the next paragraph indented incorrectly,
like this:

  glob
    ...defines glob...

    Two consecutive asterisks ("**") in patterns matched
    against full pathname may have special meaning:

    - ...some special meaning of **...

    - ...another special meaning of **...

    - Other consecutive asterisks are considered invalid.

      Glob magic is incompatible with literal magic.

That final "Glob magic is incompatible" paragraph is in the wrong spot.
It should be at the same level as "Two consecutive asterisks", as it is
not part of the final "Other consecutive asterisks" bullet point.

The same problem appears in several other spots in the glossary.

Usually we'd fix this by using "--" markers, which put the sub-list into
its own block. But there's a catch: in some of these spots we are
already in an open block, and nesting open blocks is a problem. It seems
to work for me using Asciidoc 10.2.1, but Asciidoctor 2.0.26 makes a
mess of it (our intent to open a new block seems to close the old one).

Fortunately there's a work-around: when using a "+" list-continuation,
the number of empty lines above the continuation indicates which level
of parent list to continue. So by adding an empty line after our
unordered list (before the "+"), we should be able to continue the
definition list item.

But asciidoc being asciidoc, of course that is not the end of the story.
That technique works fine for the "glob" and "attr" lists in this patch,
but under the "refs" item it works for only 1 of the 2 lists! I can't
figure out why, and this may be an asciidoctor bug. But we can work
around it by using "--" open-block markers here, since we're not
already in an open block.

So using the extra blank line for the first two instances, and "--"
markers for the second two, this patch produces identical output from
"doc-diff HEAD^ HEAD" for both --asciidoctor and --asciidoc modes.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 20ba121314..8c4e9dd3be 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -430,6 +430,7 @@ full pathname may have special meaning:
    matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
 
  - Other consecutive asterisks are considered invalid.
+
 +
 Glob magic is incompatible with literal magic.
 
@@ -452,6 +453,7 @@ these forms:
 
 - "`!ATTR`" requires that the attribute `ATTR` be
   unspecified.
+
 +
 Note that when matching against a tree object, attributes are still
 obtained from working tree, not from the given tree object.
@@ -560,14 +562,17 @@ The ref namespace is hierarchical.
 Ref names must either start with `refs/` or be located in the root of
 the hierarchy. For the latter, their name must follow these rules:
 +
+--
  - The name consists of only upper-case characters or underscores.
 
  - The name ends with "`_HEAD`" or is equal to "`HEAD`".
+--
 +
 There are some irregular refs in the root of the hierarchy that do not
 match these rules. The following list is exhaustive and shall not be
 extended in the future:
 +
+--
  - `AUTO_MERGE`
 
  - `BISECT_EXPECTED_REV`
@@ -577,6 +582,7 @@ extended in the future:
  - `NOTES_MERGE_REF`
 
  - `MERGE_AUTOSTASH`
+--
 +
 Different subhierarchies are used for different purposes. For example,
 the `refs/heads/` hierarchy is used to represent local branches whereas
-- 
2.53.0.155.g9f36b15afa

