Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1951D52B
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233341; cv=none; b=pNnzsUms54fKfVxKpUlpkjqlCBsG4SWDF14KbMXi0Z6WeryPQb27VvwF+gq0TCdoFzdz0/r5MPGbnsTgDfquD5r5fosFBGsOzTl0QXMbROmRtXoDhWIA53FBQQlTdEU9NwEyOyXL+rPFNf6WGrZCjP4rPww/4gHAg+SpJyiL5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233341; c=relaxed/simple;
	bh=7xNun+Ns+UQ51EfN6CCFSleDxYqhX/l/aChHA6uCtss=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TPivqmzlqaG8kGjzdpt9mY9SEtva/gDmTWL5pNRG7dTV+BswqSwwB+VfnsncmZR8WZViqbUj+rgVEcAelaxLM5b18YIlgn6xUlSp+OmBHO7ahgwf3z7BLMCX0zhTgaMzDff8JFhV1k0wNp5CGDVY57+RXkMWdaYLYX2bChCTp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN5v1SQZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN5v1SQZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc52394c92so6862415ad.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233339; x=1721838139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc7+cugLDfxBxyEMYl9MfDKJvZE8+rlSBS/tmjFQ+nM=;
        b=VN5v1SQZNyJx8CrEbcqnoyH1o0kVn4ZW6WiO9Jjpj4wXgQB0VsQ1SSQ95xtDh+AP97
         8Y/+3eV3/P2Vpw4PbHsdh2CB/yrnGE/qMo+/HlJd7el9TZeuAptKuo3jYfIOG1aM0MC4
         bLjUW31mTAMx+vlHtGZAss5eynrAwW5925TGrblB+tGCUKUTdOxwqV8y919XhG5m3A6F
         4bGbjLPT5i7U6r0r4mm4KrXzSK0sK6mF9rJp0kBWk9nmNbC8UBqoPKBVJju1qkaORftx
         bWWhl5zR3Ogv1Y0LF8yhPBWiAU/yNbTq1vnd7EZtGwv/R8uphDZmd5YUrHS4YHPl42bE
         P1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233339; x=1721838139;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jc7+cugLDfxBxyEMYl9MfDKJvZE8+rlSBS/tmjFQ+nM=;
        b=hvmH74ch7crUCyEsSRD4s55uSBY9pu95qx0eamfQUgDcKmWOyMbVSo5SYoeKza+Jlj
         ON+RgqmgGJsWPPg0s7dMNTqgV3HDodktEZW8WUKE1mbhf7k6S7Gh+wtQEA2rSeu6usB4
         VbaxjqZYo3GtwfJpXl8VVSYK0XUhQ6iDGCzLu3yVBjhbqAhSHLm3DLhciQO/gvXHAlCi
         3w3BgIwiJyqMCRo/y+3V+2fOSWi4emZ+0pGni+8OIWKUTOdGhPV9VZfKtqMVlbr2Wff+
         h7YUVcTC/HRFOQEBTD//GN71C6X1hW4kqDAdLZj3JFUTl268rdc4aYUO8ND1C4HqSu4V
         50aQ==
X-Gm-Message-State: AOJu0YxXDl9+UQAfuwJFMoJObtO7mENx6xRRFAzZwV9xTGfRejMud8uL
	7YsHJeyZQK5erJmHNAXEWd5vK0oUVRo/W4YefZ//jgHYoL/RT4zI9UGySg==
X-Google-Smtp-Source: AGHT+IE+NVSNSAh7sthapNRqZMj4B6vwm2+6X86/HJvM6ZcIsfYbdzUfyHQwnNutzZWUSyB/HXfAxw==
X-Received: by 2002:a17:902:db07:b0:1fb:9b91:d7c9 with SMTP id d9443c01a7336-1fc4e166163mr19342135ad.4.1721233339487;
        Wed, 17 Jul 2024 09:22:19 -0700 (PDT)
Received: from gmail.com (29.238.148.210.bn.2iij.net. [210.148.238.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc50951sm76643335ad.276.2024.07.17.09.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 09:22:18 -0700 (PDT)
Message-ID: <42a04aac-3f60-4259-9c9e-f46e9b6e33b3@gmail.com>
Date: Thu, 18 Jul 2024 01:22:16 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] add-patch: end "add -p" gracefully on EOF
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we receive an EOF during the loop in `patch_update_file()`, we break
the loop.  However, the loop in `run_add_p()` could brings us back to
`patch_update_file()`, to only receive EOF again.

This is a sample output:

   $ touch a b c
   $ git add -N a b c
   $ printf "%s\n" Z | git add -p
   diff --git a/a b/a
   new file mode 100644
   index 0000000..e69de29
   (1/1) Stage addition [y,n,q,a,d,?]? Unknown command 'Z' (use '?' for help)
   (1/1) Stage addition [y,n,q,a,d,?]?
   diff --git a/b b/b
   new file mode 100644
   index 0000000..e69de29
   (1/1) Stage addition [y,n,q,a,d,?]?
   diff --git a/c b/c
   new file mode 100644
   index 0000000..e69de29
   (1/1) Stage addition [y,n,q,a,d,?]?

When we see a "quit", this is the, much more expected, result:

   $ printf "%s\n" Z q | git add -p
   diff --git a/a b/a
   new file mode 100644
   index 0000000..e69de29
   (1/1) Stage addition [y,n,q,a,d,?]? Unknown command 'Z' (use '?' for help)
   (1/1) Stage addition [y,n,q,a,d,?]?

We can assume that EOF is a synonym for 'q'.  Let's do that.

We've had this behavior since before the port to C of "add -p", which
was ported faithfully.  Let's fix it today and live happily ever after.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                |  4 +++-
 t/t3701-add-interactive.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 6e176cd21a..d8c5496a9b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1508,8 +1508,10 @@ static int patch_update_file(struct add_p_state *s,
 		if (*s->s.reset_color)
 			fputs(s->s.reset_color, stdout);
 		fflush(stdout);
-		if (read_single_character(s) == EOF)
+		if (read_single_character(s) == EOF) {
+			quit = 1;
 			break;
+		}
 
 		if (!s->answer.len)
 			continue;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac1..6bf0c0b6ca 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -56,6 +56,19 @@ test_expect_success 'unknown command' '
 	test_cmp expect actual
 '
 
+test_expect_success 'end gracefully on EOF' '
+	test_when_finished "git reset --hard; rm -f a b" &&
+	touch a b &&
+	git add -N a b &&
+	git diff a >expect &&
+	cat >>expect <<-EOF &&
+	(1/1) Stage addition [y,n,q,a,d,?]? Unknown command ${SQ}R${SQ} (use ${SQ}?${SQ} for help)
+	(1/1) Stage addition [y,n,q,a,d,?]?$SP
+	EOF
+	test_write_lines R | git add -p >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
-- 
2.45.1
