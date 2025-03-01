Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44B1DDC11
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865655; cv=none; b=r/XDZjjX+EPFWU8BLnJvfArfXolAAIakZRdZEYbpgcpYmDZ17y6U/wChnkz/m962T3QlC0L1vWrfAuRBPW6zPryiIsTImZ3+VWbacxjBvi/oNjwksiOhT9Yk+8CahyIKn5aaoki2wNzTYIUMFieIkSJsvMSFAPk0SneslVMcCso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865655; c=relaxed/simple;
	bh=VDzbMFBxEVjLZpqE5rC34q6jnqzw5lGIfZE2QJ0Xw94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ri35wZi2yc3NCfOi2ZhRJk8YE5lj/4L/BQc0l/i6JTdwhU4ajGWjiyuUAw9EZkZzHruqVVFYAehfP+8aKNTsJGu+fiTeuiBCtdySL0MbO8ZRyOJHo/Y+BipsEarNOGaPtk7S7KhVJWpfaSD9StgDkQIRAvKt4OJ8F9/NOHk7GQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5v8q3ck; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5v8q3ck"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439946a49e1so20568105e9.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865652; x=1741470452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNoDGICRIZjpFc0M3crv7zQYP0PG5C5ExoDptZTbM90=;
        b=b5v8q3cks1zDI0d5H4YTYKgJ/kbXaYdX0uTgbR04UzPMiw4BpwSxN6sCVsR8r81FC8
         ecz22yUydEDkB2xEiE4a5m5JZD3bIQLpVCjzOWcd1MTAUP/8R4SqJbM++VSqgbl/Ixu3
         AuNXsOLeDjCt4rdCYPAjNOiBYM9OI/8os/4vu9bp4RCdc927oPSlHD9TSEdreAknpbfK
         tBY2/5oIVbfuCKvDruFldoGi/AmXF69mCrSTtZPErfrtdwUozrnXf9b3bkYesuszrgGC
         B4MaZkC31Y41GF44usABFeV9btDZpoJ5KBf3MhkNZNG/ccXXuLLRxJDiSp4VXBVt1pYl
         vKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865652; x=1741470452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNoDGICRIZjpFc0M3crv7zQYP0PG5C5ExoDptZTbM90=;
        b=jEheLruUwE87IbY6VOywkx/AINqnrMYIbsZUB061hM0tft3Z3C8EzWZVImR/MxO2FC
         dIZKXTkVn4SRyyeSUek55BrIU6HXaEmrR0GKuugeLsZtNnwEXpzeK/mE2VImiHy5aALA
         vYCQbNb5+KsWENXk8tuldgft4ZGrPHxn39lrEKsf8RT1NAEufjrW+p7lpgfcgeG8Ivz3
         QvrGf2ChZlSoImWvy9EWcbSYysR2wR9a3XAEtW0INaGVNFEyzVp1QFNfOo1BStU7zOCP
         JA0PYpEDP7Gu+AdKEScNxI32JNZJwcWm8UOEwgVsT6lsKOoETVvGrbvaXwC3piAlB8bn
         Sq2g==
X-Gm-Message-State: AOJu0YyLr73Thj/UKELMPK89tCGfQSASFfn7iC9JXEIc9w+k8Wfz6PEZ
	PqY0mgjSARrpbaHrWUEddQWsNJx3V8Q9m7e7NZrtbpZoQFF3AKr399fJQkom
X-Gm-Gg: ASbGnctwUqBLErWfl2dMfZJwCKR6VVGqQ938tCduauPx8RU1Lb3r1izIjdketJT8L4d
	Ih6vWmuVkd/WAUHXqlxf96A+5IzkfVBnm8AJZvRHkZhqm5LCHwlEzZZhP/+shU6hmSqrmOxmJ0r
	Wb8xs8sbkaT+uiFAQwlS45wmm1pXw77tpoEWDhh7uE1YLkMF9z+rMaW4x/HbxBvFVaJntlMQpqB
	DJeWSto2yFMRUFb7QVZQ97UEqUs+dnFbZjrQm+thqKtUmGwiip7j07v5D6HLRqJdw0tz1rb5QHi
	9qUvIQ0oGgsIW/j33EYaHg+YTPDvrnBbXd12yQo99m3X+ykzdiAuiShtSjaW0Wq4wpdR5v8/lol
	JyNus
X-Google-Smtp-Source: AGHT+IFK/km3SasBMv8OmulDTsrX7d4fQidtwanw1gZGD4FeRPKa09yG7OzzcXRT4f+vDMFxwiPmBw==
X-Received: by 2002:a5d:47c3:0:b0:38f:48ee:ddc2 with SMTP id ffacd0b85a97d-390eca47db0mr6699001f8f.37.1740865651641;
        Sat, 01 Mar 2025 13:47:31 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:30 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 7/7] Documentation: Add docs for blame format
Date: Sat,  1 Mar 2025 21:45:06 +0000
Message-ID: <20250301214652.536439-8-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation explaining the new `git blame --format` option as well
as the associated `blame.format` config option.

Include a section listing the available placeholders. Also document the
new (blame-specific) placeholders in this section.

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 Documentation/config/blame.adoc |  5 +++++
 Documentation/git-blame.adoc    | 16 ++++++++++++++++
 Documentation/placeholders.adoc |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..88ef551c04 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -35,3 +35,8 @@ blame.markUnblamableLines::
 blame.markIgnoredLines::
 	Mark lines that were changed by an ignored revision that we attributed to
 	another commit with a '?' in the output of linkgit:git-blame[1].
+
+blame.format::
+	Apply the specified format by default when invoking
+	linkgit:git-blame[1]. For supported format specifiers, see the
+	discussion of the `--format` option in linkgit:git-blame[1].
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index f75ed44790..373ff6b994 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -62,6 +62,17 @@ include::blame-options.adoc[]
 	a certain threshold for 'git blame' to consider those lines
 	of code to have been moved.
 
+-F::
+--format::
+	Emit blame information in a given '<format>'. '<format>' is a string
+	that can contain '%placeholder' specifiers, which will be expanded to
+	produce blame information.
++
+See the "PLACEHOLDERS" section to learn about all of the available specifiers.
++
+Note: you can specify the default blame format in the repository configuration
+(see `blame.format` in linkgit:git-config[1]).
+
 -f::
 --show-name::
 	Show the filename in the original commit.  By default
@@ -235,6 +246,11 @@ one) at the beginning of the "extended information" lines. That way, if
 there is ever added information (like the commit encoding or extended
 commit commentary), a blame viewer will not care.
 
+PLACEHOLDERS
+------------
+
+:git-blame: 1
+include::placeholders.adoc[]
 
 MAPPING AUTHORS
 ---------------
diff --git a/Documentation/placeholders.adoc b/Documentation/placeholders.adoc
index 7f4d0b59c7..5420a44e94 100644
--- a/Documentation/placeholders.adoc
+++ b/Documentation/placeholders.adoc
@@ -145,6 +145,10 @@ tags are added or removed at the same time.
        (like `git log --source`), only works with `git log`
 '%e':: encoding
 '%s':: subject
+ifdef::git-blame[]
+'%L':: line number
+'%F':: filename in the original commit
+endif::git-blame[]
 '%f':: sanitized subject line, suitable for a filename
 '%b':: body
 '%B':: raw body (unwrapped subject and body)
-- 
2.43.0

