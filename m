Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7721CC51
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649744; cv=none; b=AryDpxUHx/5FztlcKGZ3D+satSZLFXjWp8NyVoSwtVPVBQptXya3PZHwVRxnJQjgkm+wdpjpRRQmT0VgkO4aIDd/cF49rWZTuiC3LkxoglU6Ecw8xjHqME5Uf+cmGPQd/i5trUvB9R+NibhNzFWWNZ24EthJG6Wz+7V/xOE0Ii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649744; c=relaxed/simple;
	bh=TNbsKRk/zj1nJNP5/vEY6sHlFslmJ/14njb8kfTUoSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+B95WuWj70DIDh5AP4eleTsvIiwH5GJvPU13xpKtDGLPiicIw9o4aEs6lob/dD4QL9hKou3Wxkwpk2+VVRimE/QXFjyti8zJ7Cf49o/eHrGu6JbolNHDdL+pIEJWOHZjrGfZjRDkDiJWp5CVDMLbO1dXBeKxH/VK56+mtDvimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTDcxQvi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTDcxQvi"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78c6a53187dso4314557b3.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649741; x=1768254541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LElUJKuizWq1FdTDiprQikPk9ab6YydqnfNbxixUyk=;
        b=dTDcxQviZ+EbLLr+STBT9t/ugORvWpOi8ss4YrDlTAr/dK6pJXR797qfjsAkmjN9Yl
         LXB71NcJlXJX00Aak5GahGWtBXN1Lmc+K05Is9kUdWtaUTmN+BQq8eTgYNSCYyqrF3W7
         gHttMJ/BJftufJPm946TEWlhN+5FGsMlS6SiQ4E14FQes5LaJ9bhfo3CHNNa9S31gb0z
         zKXo4JBRLem1wzg3i85PKQb6KDE96mTmUum8ZoC02SVA4JbZPQoLzKzqWU7jTXbpO46Q
         CVg+fOteTS1shzHvCoEoBOcI+B8Zq+/9I3YONNO218hYV0kMk4hBAXCF7RuscIH68nfu
         j2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649741; x=1768254541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LElUJKuizWq1FdTDiprQikPk9ab6YydqnfNbxixUyk=;
        b=oytqeQ7e+hiin1MfDN2P4OUtJ1+8764gSjRSvF9G4fB9EIXeDEMnRR/SbHHEfBC9ot
         UXGOiv3SZ8TioU5DdhYCw1YQODoHVsfKfPYjJSflrHnPpm2UMoMuKWgwY1Qt+XMYeE1D
         565M7mNA4wZldAO3KqGBI4ONHmYWO80XxdPDw+7it4ANY7xMKYHYOUUye/4AB/UXOlwn
         q4tDEqOkSLbe47zWZfemr+N40u5NmKlHxGMQjKMcXv4yoa1uTvvIw29+25Jh2PIldlr4
         MQgV2ui2suX+SW2dG/0qd9l/gkSyYgxam2cBqosFiLSYf6e1kYnJg+XDrHT+Pr+N4Nm3
         jOIw==
X-Gm-Message-State: AOJu0YxcVXgnH58lxpIRuwI4qaeRRen97N6/ss71lyoUuBIKNyUe47ht
	PxdOi02O/dE3d6FMCIGw/TnyQI8Scc+k7fMaaU/RVXpxcHysYK1e3S7ct74fQw==
X-Gm-Gg: AY/fxX7hb3r+kBEFTtFNZPAoTr8W4q3b3uGLm8Yumvm5yAHhdOBY9mquiXH0l/0vTBv
	sOllJj9EQh5tChM2ifzx85HiiGcwhERQn54cxzdGt5hwmrHiqMOk6jtxnN6mObE01l7cVsPJk9y
	LfkfVpGL0bPYRYn3EScizCl3oGDSguk/A+RV7sS9XI2gyixl4KAsR5EumJBxmw6XdWdcDmqT9fU
	Tv4ZIIPpWi2MiFoK0dpzWYZXfUzssXMtwVSnDRQbXTinsyCrnPVtP5SbAkRHmSXoH8WuyWor8Si
	zMDpOwS8v91K5EXfec/hBYB6+YsYTFVYjk2QbzckNPd87X9Q+oUXtBYODn1ZUvp7Ipc9CQUa4Mu
	HRcd3HN+xibjDOwtbglPIkkR0Rp0P/1Hb0p1FTPnx2g+sBVRWp0PssQX9bToOIVzop7hW32KPVd
	bDWCokgvdRaUM6EAg=
X-Google-Smtp-Source: AGHT+IEDaoVWXRtWt5IlxafRsHvC4xTpHfKBVV4+ksvvphs2AYnN28YG4tCaq/XSSoZjALoPqspy2g==
X-Received: by 2002:a05:690c:2782:b0:78f:cdc7:3d48 with SMTP id 00721157ae682-790a8a80a6bmr9669157b3.29.1767649741378;
        Mon, 05 Jan 2026 13:49:01 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa679385sm706737b3.32.2026.01.05.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:49:00 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v4 4/4] doc: git-reset: clarify `git reset <pathspec>`
Date: Mon,  5 Jan 2026 16:48:18 -0500
Message-ID: <accf7a0673358d4724e4944117a382494404deb1.1767649692.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.426.g1df11fb20d.dirty
In-Reply-To: <cover.1767649692.git.ben.knoble+github@gmail.com>
References: <cover.1767307382.git.ben.knoble+github@gmail.com> <cover.1767649692.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback:

- Continued confusion about the terms "tree-ish" and "pathspec"
- The word "hunks" is confusing folks, use "changes" instead.
- On the part about `git restore`, there were a few comments to the
  effect of "wait, this doesn't actually update any files? What? Why?"
  Be more direct that `git reset` does not update files: there's no
  obvious reason to suggest that folks use `git reset` followed by `git
  restore`, instead suggest just using `git restore`.

Continue avoiding the use of the word "reset" to
describe what "git reset" does.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 37c868ae24..5023b50699 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -81,29 +81,25 @@ linkgit:git-add[1]).
 
 `git reset [-q] [<tree-ish>] [--] <pathspec>...`::
 `git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
+	For all specified files or directories, set the staged version to
+	the version from the given commit or tree (which defaults to `HEAD`).
 +
 This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
+<pathspec>`: it unstages all changes to the specified file(s) or
+directories. This is equivalent to `git restore --staged <pathspec>...`.
 +
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
+In this mode, `git reset` updates only the index (without updating the `HEAD` or
+working tree files). If you want to update the files as well as the index
+entries, use linkgit:git-restore[1].
 
 `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
+	Interactively select changes from the difference between the index
+	and the specified commit or tree (which defaults to `HEAD`).
+	The index is modified using the chosen changes.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+you can use it to selectively unstage changes. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to use the `--patch` option.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
-- 
2.52.0.rc0.426.g1df11fb20d.dirty

