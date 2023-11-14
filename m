Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3033079
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJeLMxaA"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366AD5
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d81864e3fso3606556f8f.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699998268; x=1700603068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vlW9w0enT3adxfbXpcGi6xgX6s4EOCoMyy4tz5x/Jo=;
        b=BJeLMxaAI+2/QoP93tsMAoQWbEgJS3tYltGwQLfFGClLpBrYPFhqEppcWQdMdFv7fo
         X42nuwoMVjIkZDpgHBXE9cJzkAm3AVuV+auQdquMSi1Qoj2SDnJfUsRnQT8VGJ6qn/En
         2EyeUAJuomSKn6C1KtZ8Z4VW/U+LwV/1F+knMsA1Kb4jz2PlPg6b7gKQApeFc0YHuHFW
         unkPFy6MtCFpqnkOP/5D//1IIeeey/3ZY8TjVyqnseYFykxk3vA4tI+LoI0iwAuZltll
         xxFBK/Fpmh5LmcMpmWHHtj4L/bP1fO8nGJijX1Re2BPjDwPAchT9f0ghGioQ8c6SRsLW
         4B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998268; x=1700603068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vlW9w0enT3adxfbXpcGi6xgX6s4EOCoMyy4tz5x/Jo=;
        b=N9n4lD7EG32+J5uIT/wERYjaTD30emAjDVaE4Ki5Gl2XBskNLSO8aA+E8GsmAmmQCC
         afuepK4gOLILhQqlOW85Nc4wo2/qD8LxxiwnXrIrHoghRb8T4GxoyuIerx4VypcoFPmq
         PDGIrXi3gqzS7mA+4iXx9/+IKC1PLXWXE2QFJ0kM0XXPnl6F/8zOzuH4qewTHQoFW+sX
         HNEdyaF+U5AzZd2MjqLdmzJEW+rbgIHtlWIVrMo82gbbmtsE9fYqVk3guPnAxGzPSmXz
         VIkJ+3obI2OY/EG5hZtqcCw5lnivWYX3U+mX7xBMBJ5sueAuiDGck+UfrdQWyNx/5gdU
         wr8Q==
X-Gm-Message-State: AOJu0YxVP/DnrJs1hMfpTaTAwh/E5C5UYGgyFlpCyTB9hsWgzXiwdNlr
	+RDUZ8vB65zQr8XJQ4MKfVpHvGqtSzY0+g==
X-Google-Smtp-Source: AGHT+IEPwOX+k8E8o4dF/NcIc72mH0p97iQwJf31Vu843dGY+U0VSlc6Y9F9y8YN4ii/J5hR/WXFAw==
X-Received: by 2002:a5d:6c61:0:b0:32d:8819:4620 with SMTP id r1-20020a5d6c61000000b0032d88194620mr8362322wrz.14.1699998268458;
        Tue, 14 Nov 2023 13:44:28 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040651505684sm12804379wmq.29.2023.11.14.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:44:28 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 3/3] rebase: rewrite --(no-)autosquash documentation
Date: Tue, 14 Nov 2023 21:43:39 +0000
Message-ID: <20231114214339.10925-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc2
In-Reply-To: <20231114214339.10925-1-andy.koppe@gmail.com>
References: <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231114214339.10925-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the description of the rebase --(no-)autosquash options to try
to make it a bit clearer. Don't use "the '...'" to refer to part of a
commit message, mention how --interactive can be used to review the
todo list, and add a bit more detail on commit --squash/amend.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/git-rebase.txt | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 10548e715c..1dd6555f66 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -589,21 +589,27 @@ See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
-	When the commit log message begins with "squash! ..." or "fixup! ..."
-	or "amend! ...", and there is already a commit in the todo list that
-	matches the same `...`, automatically modify the todo list of
-	`rebase`, so that the commit marked for squashing comes right after
-	the commit to be modified, and change the action of the moved commit
-	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
-	matches the `...` if the commit subject matches, or if the `...` refers
-	to the commit's hash. As a fall-back, partial matches of the commit
-	subject work, too. The recommended way to create fixup/amend/squash
-	commits is by using the `--fixup`, `--fixup=amend:` or `--fixup=reword:`
-	and `--squash` options respectively of linkgit:git-commit[1].
+	Automatically squash commits with specially formatted messages into
+	previous commits being rebased.  If a commit message starts with
+	"squash! ", "fixup! " or "amend! ", the remainder of the subject line
+	is taken as a commit specifier, which matches a previous commit if it
+	matches the subject line or the hash of that commit.  If no commit
+	matches fully, matches of the specifier with the start of commit
+	subjects are considered.
 +
-If the `--autosquash` option is enabled by default using the
-configuration variable `rebase.autoSquash`, this option can be
-used to override and disable this setting.
+In the rebase todo list, the actions of squash, fixup and amend commits are
+changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
+are moved right after the commit they modify.  The `--interactive` option can
+be used to review and edit the todo list before proceeding.
++
+The recommended way to create commits with squash markers is by using the
+`--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
+linkgit:git-commit[1], which take the target commit as an argument and
+automatically fill in the subject line of the new commit from that.
++
+Settting configuration variable `rebase.autoSquash` to true enables
+auto-squashing by default for interactive rebase.  The `--no-autosquash`
+option can be used to override that setting.
 +
 See also INCOMPATIBLE OPTIONS below.
 
-- 
2.43.0-rc2

