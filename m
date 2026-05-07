Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A64657F5
	for <git@vger.kernel.org>; Thu,  7 May 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177621; cv=none; b=V2hZSTnyvyf5gTYpu092cbFQRcMKSBcIvLhHY+aPoi5yivAqZJaA7ELY/Z67WSyCwXDF1XRVhmzqv/MjePwXV9cbhPof0oFYE0rTojz6me5tBYBElt5FUNMk75OucXz4MHFqXfZvKK/3wJkq9lZV+UpSkGgKfOUIlllp/mCmce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177621; c=relaxed/simple;
	bh=wh/EEt6W8mgtb9fS3c1kkcXZS96VMtGD62dtD8Vhf6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=YuXoeswYc0N0qMAw1dNH/H+On1ZygPYi1ybvQfD7u+EKcImYeQOPKKjNOSdhTEQb1rBBd03L7V8N1MdpSTjf9+fwwkCS/wjAsLqyJKwZdoY1mgZrZgvcYAU+e/6MlbLlzZVc36iroq7NIrKcK0+bMUraqCXxiEar3u9LuERoGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N20HmyGF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N20HmyGF"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50fb1932b62so8563791cf.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177618; x=1778782418; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7nRTtfCjJxC9UQV9+BS15dfUv2y+1NzUrkQvocA4Q8=;
        b=N20HmyGFV65C7wlxINRM5+4endjEePebBBnI7O60tMDBKbchm1swNuuo5Edtl4VDGA
         JEEC28vIKguHZMUekhq0Lhv41mjl7p16YLF6tbvLv49nPWxOhVYO/ca1+SAWCrEx9roX
         g3MlkksU/Lg88tKdwDxcvhlHgJfMjzidizsRrusebZvnfKgcZPTAizBRmX807bZmR8OQ
         nsqtHE5yY57vePFIBHHkOtocMYnlwCWr0uRLx6EVlxzukK5dUoXDT8w0QYH0cTK1sLzr
         KnAqVQorYoctdJj6+J7TkF8lAItwel4zG6PzA2D3C3f2qmRijuvsdA6lwayeES8qW9xd
         /jRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177618; x=1778782418;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7nRTtfCjJxC9UQV9+BS15dfUv2y+1NzUrkQvocA4Q8=;
        b=PF+3b+FgX0/RUzo1kYvlxdiapBhoYJmkAyzpSW7/G24g13oOGhX1CifD88RJY/K34f
         iJJKdi/g7aDLSltnuSPpacy7DVBCs71mclLGcrw3Y7cTMG7qX0j1DrjZZlnaPtyfkz72
         o7mN0b3wR/RdIe+duUdEaVuBg2NlTTL5SpO79vR9G+Mq5Y0lZcGh8bHzIv2Q7RIN7YOn
         7O+K2vullgCvT3nttRTAZmWGryBrtjJ1c95++MAS+9tvT67ZBO4vQPHCLTFV66r3dTRx
         MEUbnzhPWPoJdEQvxCQUXvdr08ce1OtzzInRdK0PywuRdn7UvW/xhsO6SInYuX+9J4c/
         zduA==
X-Gm-Message-State: AOJu0Yxb3pVjSRcyXp7uhTzuaCCtSDc3XOxqYqyn8iHJUx9oPteCGzKb
	8rDb79ehhwS3AKqp5UvDyy8d3LGfq6Xhxg3S6yh9gJtJMZUkrSF7qnQXrh+ek1BV
X-Gm-Gg: AeBDietP7pi5JPPraKTwvKbEQVfZrZzOimLERj/dkhXmbYaDwl/FQQrj91YvrQyMLae
	DtieyXVmCFLaNQ6x6XOM6wtMq9JubykKshCfjLFDvERTryozJc66JBfpB5JZoGJLOUv9cE3l+KN
	OHs3pDnyBmipoEoDgjLgLltUd82CPpMkOvA3OaWinVotiAubNQOOU/YgXW9fAi93AnB5HQNHCCB
	JHAB0HOznHYNa46NOrGWyOgCdeusgle8FiNlvNX+TzjI2PAH6Q1m6mzSICAPFjC1pr3XQfG7/7h
	cfBqxHtMT5kvx/uq8uw/Va7JFpSVogN+8K33aS1ViKXu3Lu4ZUKL4qNqRE2JhbHwexDxoWW88bx
	80G/EdmKXEf0aJOh2eSaAIGPFNQsTH7cC1spofLcxym0AiPf27mUW+2+6MNW0KHYXkmynTPwGBC
	sziPin75OeVRX7cFvjAHkqCeU58diiVaEFmCMmzQQozNNOj2g84yN2bPWHQICQRX00WLq4QxmsH
	cTM0pilT8t58o6TKbC1pI60aXJZ7pULrdOV2GZXqfeSJTuGBZtpVxW+9M1+IJde9b7P6jJbuotv
	jGHIOisCfz4IfQFXjyazmgLM3Q1Tea5O1pahHOoejf/TrmRAzSlw
X-Received: by 2002:a05:622a:1e87:b0:512:e813:7ce8 with SMTP id d75a77b69052e-514621c7db1mr132237811cf.54.1778177618057;
        Thu, 07 May 2026 11:13:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([208.80.35.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148522ab8bsm3245941cf.19.2026.05.07.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:13:37 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 07 May 2026 14:13:33 -0400
Subject: [PATCH v2] doc: git-log: clarify --follow options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBBGr0K6dkxb/qIr72FYQBlgTOmYFlBDu
 LsFD+DyJe973yoCesIgrskqPC4UiF0EfUqEGWrXI1AbWWipC5nLElo284huAss9OIaOreUXlNq
 kaWtULlUp4vjpsaP3Eb5XPw5z80Az7bXdGChM7D/H86J27+/JokBBVhiUOrtIbOpbP9Zkz4ZHU
 W3b9gVAkHA1zgAAAA==
X-Change-ID: 20260507-document-log-no-follow-72c33dc15017
In-Reply-To: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
References: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Junio C Hamano <gitster@pobox.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1778177617; l=2832;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=wh/EEt6W8mgtb9fS3c1kkcXZS96VMtGD62dtD8Vhf6k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCwmGHuu/XYxPhOEClby7vSALKr9pz0xnyDahirf7uu5iG8x7CsXT94aJnDfWDmDfRqPk8wuDhx
 tPpas93i8BQM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The --no-follow option was added by aebbcf5797 (diff: accept --no-follow
option, 2012-09-21), but git-log(1) only documents the positive --follow
form.

Later, 076c98372e (log: add "log.follow" configuration variable,
2015-07-07) taught git log to act as if --follow were given when
log.follow is true and there is a single pathspec, with --no-follow
overriding that default. 1e9250b5aa (diff-parseopt: convert
--[no-]follow, 2019-03-05) preserved the negated form while moving the
option to parse-options.

Document --no-follow alongside --follow. While here, describe --follow
as limited to a single pathspec, rather than a single file, and mention
the override in the log.follow documentation.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Document --follow as limited to a single pathspec, not a single file.
- Adjust the log.follow documentation to use the same wording.
- Link to v1: https://patch.msgid.link/20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com
---
 Documentation/config/log.adoc | 7 ++++---
 Documentation/git-log.adoc    | 7 +++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f20cc25cd7..1001672dc7 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -52,9 +52,10 @@ This is the same as the `--decorate` option of the `git log`.
 
 `log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
+	a single pathspec is given.  This has the same limitations as
+	`--follow`, i.e. it cannot be used with multiple pathspecs and does not
+	work well on non-linear history.  This can be overridden by
+	`--no-follow`.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index e304739c5e..f73031fb71 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -28,8 +28,11 @@ OPTIONS
 -------
 
 `--follow`::
-	Continue listing the history of a file beyond renames
-	(works only for a single file).
+`--no-follow`::
+	Continue listing the history of a path beyond renames.  This
+	option works only with a single pathspec.  `--no-follow` disables
+	this behavior, including when it was enabled by the `log.follow`
+	configuration variable.
 
 `--no-decorate`::
 `--decorate[=(short|full|auto|no)]`::

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260507-document-log-no-follow-72c33dc15017

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

