Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE9392C55
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498115; cv=none; b=E22t3LBCbqFCx/izOPbzxotrW7D6+67zaCfOsAeDxGQjzeNoxffs2YCawhUx7LkiOIe4/xmhHNqfy/1KjHhZDx0cbBL1l8gZ7Z71SjAiq+A4IPc+DLSa2oCorWpNyzRLCJHop5YdneFApieHdJUxBgVs+9tWB5fQ/HSRwUwSRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498115; c=relaxed/simple;
	bh=okdl+0uUaqS6blDRN4er+hR3UqeoFu6NWPRmZZPDXeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J6CeSK7T+wzpp8EvXoH98A9JZGbqP+5qiVScSft24i6TlWMPqGmmOzGnW55i3WAJYKmQGbybicKm6tEYFtMvnpkntIqrL/jZZ+eGlzcvXRqnDWBH1CkKVHv1cVsAyz97e/csf8966CeUXubANdF/noF5bfQa05q0dT3lAO591ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTLzih8I; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTLzih8I"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-127380532eeso1539731c88.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498113; x=1776102913; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=OTLzih8IFGE/vvxIKFesLzN4ETj+KefXFx0aE84LtZW6igktZxvengz1KfQNE4LWvs
         AYDXEU1BThmW6cXrvyYrnvKnvBmpL0lXqvY4RbufEKgLdFtkNZpwyQHvPGo9sJs1ZB4X
         2dBBwQz8SzAl2hn6yriLHNzH4jVXk+maiuvq6ZfJcj9XzVvzIxBVqv8dl6uDYO1UNxXx
         S79I+x50pdOLXJF9oUWqalmmBZTHnGyelxB5ZmRQ1qVuMedNy7n5SAhz31G3GowJHEjd
         wr+GYe6fGwMmLv7L1KerA9Mt7wqhDRQuiyIukcmAyvkzX8qrVUZGp6EDHoFf0CNVAmv0
         hk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498113; x=1776102913;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=sFIlVRwfpjdjvSmg37gpJZmTUnM8OS0Q2iBVinHgvP7p5JWjcSELhc/X0CeqF/r7Ij
         LC2QxWfAf8W1szDrsoVLbK2qVO2JhNo1RzrX9l5EsP+GM/cufEYgfGCJZ9591SvI7iPF
         qJB6UwYzf4+mtv+lh1xy6XV0uISChb6Trh3+ZnDVhOrin/knz8/774gvihVGH5mAQ//0
         3fZfummFb+kkqMCtcIFNEs6UW8bX3rMUm2vVLfFtH2yRUecIudGzsRehqMFKaQc8b3ZX
         RbRAX1jVy8k3NbClUQaapeEcvFtjnl/G4qnRmFGvMJdVrEO8qCuYqBDY32075zejDsxJ
         cZnw==
X-Gm-Message-State: AOJu0Yx199pZQvvpe04g6x5uK59M94eXHekFwKOKZ8hJA75TCNyUD2IU
	WTKurLwdYeQIiLkYkgae9Uh/hcyE16KrmsmW0jkR48BbiCgXbtiq3VsO5tk6mg==
X-Gm-Gg: AeBDieunNjt3D9RYFdLcBHA7q1tXlt3kpxuw8t/BoyIHcBpO9wKiSTAx4mfUfNItZZ+
	8bp89RUB1vsACEBBxoANfMIvoR63tAGjj9+yNlk/D3IAW4X9YtOGNHbLnjpMejh1WmL+mrOEO3t
	5fQPgLVRYBxjpk/5uNUgkw3xxKf7st1EnGLqxdyM3+CqbfJtwTugffnQh8qoP0XYyJ1CtdPGakd
	YWnpRBcBBrkmGHIsyMwbcIS1Cqqq+8JTrVXajGoyWlNbh1EzqaPoTZLqRX+eD15byL+f9acap2+
	1ZiPr7a03bsUzWJmfFh0sqe6K7I9E/hr1ZhFKvCleHKxYVAq9hMlew7BKwSFrwSj24Id/wM491O
	LArC4o8b2tRZmtaTR50YGWkyLbbuUvaq/iKYbCLcMcpGkhS70xi6DlyEvf3c2TREF8PNuyqDAz6
	jGP0o3bCQGc0kJ6Ta/MKoclOkkFPI=
X-Received: by 2002:a05:7300:ac83:b0:2c8:409:a9b5 with SMTP id 5a478bee46e88-2cbfc55c2a0mr6486197eec.26.1775498113072;
        Mon, 06 Apr 2026 10:55:13 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cae7e3ec57sm15061357eec.1.2026.04.06.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:12 -0700 (PDT)
Message-Id: <7ce0ab87fbdb80e6a781ebc3fc3070af793682c6.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:54 +0000
Subject: [PATCH v13 09/13] run-command: add close_fd_above_stderr option
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a close_fd_above_stderr flag to struct child_process.  When set,
the child closes file descriptors 3 and above between fork and exec
(skipping the child-notifier pipe), capped at sysconf(_SC_OPEN_MAX)
or 4096, whichever is smaller.  This prevents the child from
inheriting pipe endpoints or other descriptors from the parent
environment (e.g., the test harness).

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 12 ++++++++++++
 run-command.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..f4361906c9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -546,6 +546,7 @@ static void atfork_parent(struct atfork_state *as)
 		"restoring signal mask");
 #endif
 }
+
 #endif /* GIT_WINDOWS_NATIVE */
 
 static inline void set_cloexec(int fd)
@@ -832,6 +833,17 @@ fail_pipe:
 			child_close(cmd->out);
 		}
 
+		if (cmd->close_fd_above_stderr) {
+			long max_fd = sysconf(_SC_OPEN_MAX);
+			int fd;
+			if (max_fd < 0 || max_fd > 4096)
+				max_fd = 4096;
+			for (fd = 3; fd < max_fd; fd++) {
+				if (fd != child_notifier)
+					close(fd);
+			}
+		}
+
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..fdaa01e140 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,15 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * Close file descriptors 3 and above in the child after forking
+	 * but before exec.  This prevents the child from inheriting
+	 * pipe endpoints or other descriptors from the parent
+	 * environment (e.g., the test harness).
+	 */
+	unsigned close_fd_above_stderr:1;
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
-- 
gitgitgadget

