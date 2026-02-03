Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E542F39C2
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113889; cv=none; b=dMhHxLEP19q4BGJDsLA5ZGQLR7HQ6vXpIJTs0mlxhN5BJyPNk49gFZKMSwG0Wj+LWNVtT59eZxIrl2hzsLzkc3/i8C7JVsKjZdMiYDF/3rIEXaN5zZGdCOLf3feWfmvEhCqSBAe+yO/2YntSVru461GVw9H2yXJbjATbjc8ZQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113889; c=relaxed/simple;
	bh=Cgk/TKGusUnhk2HpNyDXru/CJj4AniOGkd63DKxgFmg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m4i5ANURDZKZgl18GKWw11HTvw7dIgnmCtLu6fylXp65zzeOqUItRn08EKcry17MI9zEElXRyEIiVER2AigUEAOZfcrGaOYTjpdOPnTZBBUjmsJ9IKFYaSZVvBfXws/vGaH7lb/KICosq7jUJ893iek/yM/FHbSg86N6ctMtKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUbtFx9m; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUbtFx9m"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-124566b6693so2889234c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113887; x=1770718687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJR5jHV8C0qbUnZGwNEHZcAVYZdGp2v2S5bvTxkTgzg=;
        b=HUbtFx9mvKAxcOyg08vA1o/09KgUqerazQAqP7H5Qj6amrbmFX/AruF+dHDS5k1goW
         i1xcImmgXlkdmQYxaxHsOky62NDdZ576TEpuW7HXreqPavzKiiGrk/zT+rRbdQSc4oqo
         9CgkIojmWH7nFbei2WrtdKjLTHgdpu0enAZbWJayTHls+cCXsA+iXPVYFYw13xHoTUWa
         MvmLk66LWKXvljXqp8ZUnS3KW4jhuUNQihlQDLDi3kudkHIqytw+dHFy5VzwiG/Qwl10
         9xUyCokLUm8Py0ww5Ll3R9EgmwrsnupQeiZiiXnckTKPgp9/pAZqZs71hjjrJBwagoCl
         SAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113887; x=1770718687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJR5jHV8C0qbUnZGwNEHZcAVYZdGp2v2S5bvTxkTgzg=;
        b=t78c2j1QfpdNEYSub8C0dok4mYB41ICJUsrRmn8vZuAl7Zax7NyCfSbrhDf704FhfQ
         hs2FJ4dHIj/s0j2N7iyShvdK/YcScvnRFJzZf5b8e89wwzoa4FXntUBjMMeUtugm9Rt6
         XckzDieJqNR5gX5+VCdZegIyQIKzPvTA96DF85k2nrrgRWgBi7/Rlt9bLy3s8Sq9MJ7N
         +oLGb0K+9wWjBjfTEco+gwsgMmIXcZqJeEi3h9uClRb81HmpW+gCbgzVzKhXUqwcifd2
         T8tQ/5If0MJZusUFGQzsvhYVyZk9XpKcHj/kZrwgMaCx/8bSsWtkgSVC5vaZKgS+qQo0
         DavA==
X-Gm-Message-State: AOJu0YwbdBRqUBG/5Gxl5kEZHRq8qyL8SPSx4KhfKO0A5OzZ3yhhcG7F
	UvXGoUh1ePU6XB9UuzWx49WtLKFPaUkYNL4Mfh2OB2AV3ZL7bzhnVsG1rJiNFJr0
X-Gm-Gg: AZuq6aJdtRxzJOJFYGOHw2kQK7diKMJ/p8YaDACmS7eUSGCpTjyqNBJNHYMnoPtdCW1
	MJR24QiyEOkikwWi5R23WeVJo5BNMFFI9c0wEBInye7FSnlqQZC4xaPP/2fV+ju/9W5zQXTjpf2
	cBoF7Br94yD2ZSLqr43y7ekfk8d0PDNezmBsY8TyizU3W5BH9JWdAFi4um2YnSiJlNjSUSExjL9
	b4OXTyOfrP01K9fFx86JiuGwAO1hj0J+/qtmcAnW04WXw9/ZcxODNZyWHBvoBDjRzgNU5/gPMDw
	Nz2umeOWgudsajzzk6Js/L23OkXduxMS2r+qdmj/OqubQU7NWQEmUJ+t0M006FVDBWAherxipw/
	W+j/D72J8EtCMolnPWZ0pc5FRuqHpQfMOYD5HA/Di3w66qIPeuw6qd5z5irnN9SpF9Q1yZpk9eg
	djx4Q1+0fZAANp27ZrqRgv05Er
X-Received: by 2002:a05:7022:2481:b0:119:e569:f268 with SMTP id a92af1059eb24-125c0ff2341mr7324924c88.17.1770113887072;
        Tue, 03 Feb 2026 02:18:07 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm23023577c88.0.2026.02.03.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:06 -0800 (PST)
Message-Id: <7addb9ca529ddf9baf0350f95388516cc27525c2.1770113882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:17:57 +0000
Subject: [PATCH v4 1/6] sideband: mask control characters
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The output of `git clone` is a vital component for understanding what
has happened when things go wrong. However, these logs are partially
under the control of the remote server (via the "sideband", which
typically contains what the remote `git pack-objects` process sends to
`stderr`), and is currently not sanitized by Git.

This makes Git susceptible to ANSI escape sequence injection (see
CWE-150, https://cwe.mitre.org/data/definitions/150.html), which allows
attackers to corrupt terminal state, to hide information, and even to
insert characters into the input buffer (i.e. as if the user had typed
those characters).

To plug this vulnerability, disallow any control character in the
sideband, replacing them instead with the common `^<letter/symbol>`
(e.g. `^[` for `\x1b`, `^A` for `\x01`).

There is likely a need for more fine-grained controls instead of using a
"heavy hammer" like this, which will be introduced subsequently.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sideband.c                          | 17 +++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 12 ++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index ea7c25211e..c1bbadccac 100644
--- a/sideband.c
+++ b/sideband.c
@@ -66,6 +66,19 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
+{
+	strbuf_grow(dest, n);
+	for (; n && *src; src++, n--) {
+		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
+			strbuf_addch(dest, *src);
+		} else {
+			strbuf_addch(dest, '^');
+			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
+		}
+	}
+}
+
 /*
  * Optionally highlight one keyword in remote output if it appears at the start
  * of the line. This should be called for a single line only, which is
@@ -81,7 +94,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 	int i;
 
 	if (!want_color_stderr(use_sideband_colors())) {
-		strbuf_add(dest, src, n);
+		strbuf_add_sanitized(dest, src, n);
 		return;
 	}
 
@@ -114,7 +127,7 @@ static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 		}
 	}
 
-	strbuf_add(dest, src, n);
+	strbuf_add_sanitized(dest, src, n);
 }
 
 
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index fa5de4500a..aa5b570571 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -98,4 +98,16 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+test_expect_success 'disallow (color) control sequences in sideband' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep ! RED decoded
+'
+
 test_done
-- 
gitgitgadget

