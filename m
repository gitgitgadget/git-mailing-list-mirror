Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EEF38DC0
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001177; cv=none; b=Ib3EiQHQJPs+DbsJktvigavLi+/6qqAOodXBEvRPQDwcST6xNZQvIj9iwdC3WfFChJQ9PXp7LJ41wfIQ5YDZfZA0hQdlAjBfstzCCYl8zxLuoN99AzDdW51RIiAdNGN0yenKHgZdxvKMerYMATcSfhrLcD2bMUl9PZVSsjt4viA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001177; c=relaxed/simple;
	bh=EhN63A78Fva4nHG1z0g1rRfxgtYEhdDhkAa8GK/ZfB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkD8ytV8qsBnFqP6ODtfGozVq3GlsQJTjFAS0NmQus4/FMqbzD7Z9WCZFXeQMh2NB5mh4zgaAg4fjXyc8wcCUadxflZidwKcHlvQKiODXfaila6359JUfypDsZUamFEbDEc/nHaeRh7Y2KhCPGh7CRFC2z/d+ee48sXARqhbBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=p6vso+ns; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="p6vso+ns"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711001173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hX6v4yHH1IJe9LS4Q9pGAonpgrmZYLYDaKIHJcZnPs4=;
	b=p6vso+nsroP2ISOEiLR6djYnlZRnuRzgZfzcAgID7Tp+GK2fa8pHsSKay3YSpi7LlmO/Tu
	jBiBLMgv2ulhrMPqlRvFBHB1w8Fj9n0w8XH2dynlsXs0+SPL+xGkeW0VTIkJyicbYGhySz
	2lmT9URkfgg2rxm0OO6wCS4SV6xL+C9s3J/gVpZ/sBJwGimgEt2xx1rb/iK+BzsXPUKLxg
	jMqBMUTorahZAy3t7MOhqVG5vHfhJv0oUdMNOHY0vFmp1lwjKtLru5l1L2L0rlXxK51Q0V
	SUl7ndTwkv2MuNyRfWHoRcCG0IcnjjXy3NyKk1McS9D/IUrInN0b11xzqOeA7Q==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v5 4/4] config.txt: describe handling of whitespace further
Date: Thu, 21 Mar 2024 07:06:08 +0100
Message-Id: <a75a5eb8793f4ae6eb6e7cf0e2fd017471fefd0e.1711001016.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711001016.git.dsimic@manjaro.org>
References: <cover.1711001016.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Make it more clear what the whitespace characters are in the context of git
configuration files, and significantly improve the description of the leading
and trailing whitespace handling, especially how it works out together with
the presence of inline comments.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v5:
        - Rewrote the description of whitespace character handling again,
          to eliminate ambiguity, as suggested by Eric Sunshine [3][4]
        - Extended the improvements to the following paragraph as well, to
          tie it all together, and to make it less ambiguous how to include
          leading and trailing whitespace characters into configuration
          option values, if desired so
        - Added a Helped-by tag
    
    Changes in v4:
        - Improved the wording and accuracy of the description of whitespace
          character handling, as discussed with Junio, [1][2] by taking a more
          radical approach and rewriting an entire paragraph, because it has
          reached the point where "patching the patchwork" no longer worked;
          I'm quite happy with the way it turned out this time
        - Expanded the patch description a tiny bit
        - Added a Helped-by tag
    
    Changes in v3:
        - Patch description was expanded a bit, to make it more on point
        - No changes to the documentation were introduced
    
    Changes in v2:
        - No changes were introduced
    
    [1] https://lore.kernel.org/git/xmqqttl1js1o.fsf@gitster.g/
    [2] https://lore.kernel.org/git/ce041191a245ff888b1710cdcaad9e61@manjaro.org/
    [3] https://lore.kernel.org/git/CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com/
    [4] https://lore.kernel.org/git/fdaec126df16bf6fe1c1fca9698f7dcc@manjaro.org/

 Documentation/config.txt | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 782c2bab906c..70b448b13262 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -22,9 +22,10 @@ multivalued.
 Syntax
 ~~~~~~
 
-The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored.  The '#' and ';' characters begin comments to the end of line,
-blank lines are ignored.
+The syntax is fairly flexible and permissive.  Whitespace characters,
+which in this context are the space character (SP) and the horizontal
+tabulation (HT), are mostly ignored.  The '#' and ';' characters begin
+comments to the end of line.  Blank lines are ignored.
 
 The file consists of sections and variables.  A section begins with
 the name of the section in square brackets and continues until the next
@@ -63,16 +64,17 @@ the variable is the boolean "true").
 The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
-A line that defines a value can be continued to the next line by
-ending it with a `\`; the backslash and the end-of-line are
-stripped.  Leading whitespaces after 'name =', the remainder of the
-line after the first comment character '#' or ';', and trailing
-whitespaces of the line are discarded unless they are enclosed in
-double quotes.  Internal whitespaces within the value are retained
-verbatim.
-
-Inside double quotes, double quote `"` and backslash `\` characters
-must be escaped: use `\"` for `"` and `\\` for `\`.
+Whitespace characters surrounding `name`, `=` and `value` are discarded.
+Internal whitespace characters within 'value' are retained verbatim.
+Comments starting with either `#` or `;` and extending to the end of line
+are discarded.  A line that defines a value can be continued to the next
+line by ending it with a backslash (`\`);  the backslash and the end-of-line
+characters are discarded.
+
+If `value` needs to contain leading or trailing whitespace characters,
+it must be enclosed in double quotation marks (`"`).  Inside double quotation
+marks, double quote (`"`) and backslash (`\`) characters must be escaped:
+use `\"` for `"` and `\\` for `\`.
 
 The following escape sequences (beside `\"` and `\\`) are recognized:
 `\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
