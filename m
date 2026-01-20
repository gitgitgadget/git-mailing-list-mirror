Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5E34575D
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947544; cv=none; b=sGNuwLQnIlRlvn774TkLqP6J7wZTrL3+cNnAmXAb0LsRN1nhrxbPLlxezh2xEXPAO9VQqm7H4w9buIaGlQqs8sVxmKWxmNXe+vwJLdzvq6kIeZBztVbRWYlAsuAkJaQNb7rrTvZ0H49mZmJQUHEy5gLLVqOP3kRWOD6Qju1rXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947544; c=relaxed/simple;
	bh=GvBwNKK04YhFvXbdBsG/YrJiwmAbyCTw2CAwQegYxkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFb0ZjrK85PqIY7mbAq0bgXx+/cnujvtjfLsUBG/iot12UinnGreYBRaH2o7t14oY10a3DcxMf9W5aXDvde9LbXvugQ2/UB6TQ2odMEc818hMbZ3y/dh2V2fHacQ1nUWmk4wL+NrTvoQGrgWERjP2bExjLe0SufSeZ/TjAD4/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSgxp/35; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSgxp/35"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fc0f33998so55521497b3.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768947537; x=1769552337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qLfst+Ynn4dkb0Y+PBERHRy5KVETXbXJ4L3+lhBf3g=;
        b=fSgxp/352gycQceVaVMo7C0ivVZaFG8aQEXZcIgrkueJ1p/Fns1EV2U/ELMoAUWyQz
         UcwyCaKFvUNnY7y2u5aLmoqzeXMif/h0A6fHIGI2ZJORk3dhnVoP9xWMbqtXy7pHP5Ob
         TkyrQHFBKIL1EgC5CLOb7LeX5S5h2xBGj6M8t6ZUGP+0qD6VEiqvXSJwWL/E3HpxgGqs
         +D38zt8V29DeyFJ55D06IKafwIeIF7KYMg8Sd9pVLsYPQg65WtkelVCErt4YAUCg3a7E
         C50UYLvFzJs7aitNrNLzaKVAaKaBK9NKh6zZmzNBXCR9whdLTOvVd3OCla4i2GXGqZz6
         8xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768947537; x=1769552337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qLfst+Ynn4dkb0Y+PBERHRy5KVETXbXJ4L3+lhBf3g=;
        b=VR02TBJPPgrj7nlW/cxVMRQ6uDBsZvLLlqdCW2HDb+gbvSJIS9Uf1ZrHatCa8WYZzK
         5SvMIUqA++x05k0592W/u/cua236o44c1HV5IlILCKFXWi/hM9s1WVTkKSCxAoe3LDc8
         dMF5xg0NBehZiZCu3rADdEwqgLmN1s9KU6pV6Duz1X/n4wKPj+kowCxeyrsN+8Pqetdr
         GAICP9A4c/k3/OlMCWG8wg3cGafpk2Me3qbxYQRqYSvRwOku8WNCnqCOiX3N2eAliE65
         UcpGml4na8qKSpvztzlrBgans5zN1mW9n7nEgGqN6PyyewZ5chtTmsw2vSXxbCyeM8zI
         xnGw==
X-Forwarded-Encrypted: i=1; AJvYcCXiOjCBeC7CDJgL4Fs4iGTVdavxKnT8m9X6L9X9QnRIa9S00Z09nmTUFERjhgcnFvG6R3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1JDgp61J573MBcS84QREINvq0ebt7hLVrUnLe4J7rf2oqAPK
	WITX8YPUBUdMcastMIasgmHPDK8z6cpwtJY3I7Psp6phtpGg5ps4nH4a
X-Gm-Gg: AZuq6aIWU71jMqJxXJZNBy98eMKkDfELvFuwGOtGdvajtiJoHZGGCqTZAiqg7gKpl2m
	0jVb20dMmQstoUd1zhGhbYrDHQR3qIDaNrGbwslrS45ymxGPBnTxQQg+Ac9em4OYDNpeiO8RNhY
	U+kdQS6UK1GCTGG5eKrrS7RLZs5PpBZ/Zupk9WFlnj+A597jfHxHND9qDd1jIF7NmoVk2xLvNQY
	5gU4/vMAT5Cb7HQUq81manIqNMjEZmrLn4ODvMeUSrVkUcylYlnb/j/kVlt5OWbRUQennY1gurJ
	AbZHzHz9h1G1rFOfoRipdG+gxfsXeWraPcHWwx+a5zgYPZwNzT6MXnibQvX3EjHpq3cOmz0A1LO
	d7orhgNVzE1nSxhRpHkbfGSIdfKmAfIMChvbMXLuYr7SOzZSmTAd7vdOePOyda0JxpwF2A5Fwwc
	RxoNnQKYnzZi+tDUZS0+4KZf2FLlN04KCr3L/ohoaybApoHJhpMBUgXuumFIqM9OiqLvQK9tbuq
	O77
X-Received: by 2002:a05:690c:e3eb:b0:789:61ca:88f6 with SMTP id 00721157ae682-7940a0e6743mr66455697b3.4.1768947537393;
        Tue, 20 Jan 2026 14:18:57 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494080138fsm863351d50.20.2026.01.20.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:18:56 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: ps@pks.im
Cc: Johannes.Schindelin@gmx.de,
	ben.knoble@gmail.com,
	cb@256bit.org,
	collin.funk1@gmail.com,
	contact@hacktivis.me,
	eschwartz@gentoo.org,
	ezekielnewren@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	newren@gmail.com,
	phillip.wood123@gmail.com,
	pierre-emmanuel.patry@embecosm.com,
	sam@gentoo.org,
	sandals@crustytoothpaste.net,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: RE: [PATCH RFC v4 1/9] meson: add infrastructure to build internal
Date: Tue, 20 Jan 2026 17:18:42 -0500
Message-ID: <20260120221844.6085-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.569.g0e1cb519e9.dirty
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Patrick,

> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> new file mode 100755
> index 00000000000..f29745beb36
> --- /dev/null
> +++ b/src/cargo-meson.sh
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +if test "$#" -lt 2
> +then
> +	exit 1
> +fi
> +
> +SOURCE_DIR="$1"
> +BUILD_DIR="$2"
> +BUILD_TYPE=debug
> +
> +shift 2
> +
> +for arg
> +do
> +	case "$arg" in
> +	--release)
> +		BUILD_TYPE=release;;
> +	esac
> +done
> +
> +cargo build --lib --quiet --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
> +RET=$?
> +if test $RET -ne 0
> +then
> +	exit $RET
> +fi

As far as I can tell, v4 of the Rust series introduced this script [1]. I didn't
notice any comments on or about the use of "--quiet" here, and Gentoo's been
carrying a patch to remove it [2] (also attached below). I don't think it's been
sent upstream, but we could… any thoughts on "why --quiet" or objections to such
a patch?

---- 8< ----
From 35f637fbabb3b8181a29ba7d96a505b49ea0ba0d Mon Sep 17 00:00:00 2001
Message-ID: <35f637fbabb3b8181a29ba7d96a505b49ea0ba0d.1763489487.git.sam@gentoo.org>
From: Sam James <sam@gentoo.org>
Date: Tue, 18 Nov 2025 18:10:03 +0000
Subject: [PATCH 1/2] rust: don't pass --quiet to cargo

This obscures that cargo is being invoked at all and it means even
ninja --verbose has no mention of it other than invoking the target.

Signed-off-by: Sam James <sam@gentoo.org>
---
 src/cargo-meson.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 3998db0435..63a5e7c6ac 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -19,7 +19,7 @@ do
 	esac
 done
 
-cargo build --lib --quiet --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
+cargo build --lib --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
 RET=$?
 if test $RET -ne 0
 then

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.51.2
---- >8 ----

(While I'm thinking of it, we also have a patch to allow specifying CARGO [3],
in case there are comments on that.)

---- 8< ----
From 1eba2788aab9f63ff55ac453b0d885aaa60c77af Mon Sep 17 00:00:00 2001
Message-ID: <1eba2788aab9f63ff55ac453b0d885aaa60c77af.1763489487.git.sam@gentoo.org>
In-Reply-To: <35f637fbabb3b8181a29ba7d96a505b49ea0ba0d.1763489487.git.sam@gentoo.org>
References: <35f637fbabb3b8181a29ba7d96a505b49ea0ba0d.1763489487.git.sam@gentoo.org>
From: Sam James <sam@gentoo.org>
Date: Tue, 18 Nov 2025 18:10:47 +0000
Subject: [PATCH 2/2] rust: respect $CARGO environment variable

Respect the CARGO environment variable if set. Gentoo uses this to
control the version of rust/cargo for a build.

Signed-off-by: Sam James <sam@gentoo.org>
---
 src/cargo-meson.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 63a5e7c6ac..bbf3f91178 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -19,7 +19,7 @@ do
 	esac
 done
 
-cargo build --lib --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
+${CARGO:-cargo} build --lib --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
 RET=$?
 if test $RET -ne 0
 then
-- 
2.51.2
---- >8 ----

[1]: https://lore.kernel.org/git/20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im/
[2]: https://github.com/gentoo/gentoo/blob/master/dev-vcs/git/files/git-2.52.0-0001-rust-don-t-pass-quiet-to-cargo.patch
[3]: https://github.com/gentoo/gentoo/blob/master/dev-vcs/git/files/git-2.52.0-0002-rust-respect-CARGO-environment-variable.patch
