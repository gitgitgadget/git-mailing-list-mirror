Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728A1F6694
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255626; cv=none; b=QJ8cjTKF/2IaQCZPBWjpv4A9jvHEuZeQSzTY0rhRYKCZoeeaTK0t8Nx68fLvy5tekKz/TMD1Sv0oyCBOyEZErLX8qaEDmXc/OoAkZoQtv9Tg8SNLw57/e33jwJ63l6DQaRgdGXHeu4ag/wJeYoJaqWntVnGnyvaGOoK63EUrf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255626; c=relaxed/simple;
	bh=5E86UAIRVki/RstuLbimFv8YluuLCUF4L1rwW3v4fpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ3DxxWfB3bMvKI7Cyp++UU+P+t8jSSI5rOIyKZGZbghyBzP3TLeVUG/XKQX2SHZ9TXCu+SrkQQcbiYLUnEzBk8pnSnpI7db3dC5z+K8MlaDMyKBa/eV1KYfOhelibZ3qLbMlIUuOrYL+G+1LZ7FIOj6xY9L9AKhh+6e4+bLr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ1MatV6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ1MatV6"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a3673e12c4so1293025f8f.2
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255622; x=1748860422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msKT2lRY4c5xL4RndDLKP5KXYary1q5q86Mjofq2u5o=;
        b=QJ1MatV6X42L38rk/NS+JN9XrFqQC5D2EQAtZYQVuqjbAZSKReyI6ZEcu0pUlDteR6
         GV64RuozKLTJ2s1seHLZBXGShw6qi3wqN4IUGm85MiWSkDqYfrto8LeFc4AUIq4Pi9ry
         YsmQPMOzvOKCYhBLJMcYBnncE2kQ0w0zD0sqF5l9LNZhqtk5X0DVonhUjvulD0kHIcnD
         zB2yPNWC4jeHq71+DjfFNmJqF8po4YEONlySP1QgsEfdfgd5AH5qizrXccZ/LRDi7yU3
         HLMDmtqeyXnnsaPDxinlfo47KoeDCgG7K3b8tMXIvE427m7F4BQRFXrjabxdVuLmQk0Q
         Ljnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255622; x=1748860422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msKT2lRY4c5xL4RndDLKP5KXYary1q5q86Mjofq2u5o=;
        b=fHuDSP6ARs1KzlojDt3m+mluSnpSV1RA939PMPrZYXPHRlORW/+kUzHZKHuLxQu+1D
         Glcu/lrdVaup/z+0SLL8MPzDAm+zdMV/cWdyToZ0IQDuK5LMI/A9xdjOGL3gNhl9BMAB
         /+TW+94IgKWRehF8fiXniA+N2zmYsFSbzTIfNpSMouM4Nr/2lMEKufNulQQXhSrXz2/j
         8JhzN1REMaMsXCiaKcc3Em56K95c4rXlZ+L25xz3enTxCxK1xl79Bam+ImR6qYXZYE73
         Rjhw/L5XgYRWOBjj+LQN02jMnpOBgMmUG6DgySDyowrvCcBu/1qWScDPIKmAzj1qAA3w
         J1gw==
X-Gm-Message-State: AOJu0Yz1qj2nQWzznwQy6RTTM6xX8MkPX652GR1jiVJ9vL8iYXXYtZye
	2BYB3rmqQoaM3Snry7GexKE/jpyFEQdXjbXCkL32UY8IWU8lPr4i9HGp0SB7HuFX
X-Gm-Gg: ASbGnctJAS3aiOiBSQaHwmfExvD7KY7exCi9mdgbvqwZ8C3GMwO+WFOxjmdds0YPVaD
	l3ZyHImfRhftCZ+J8aEleyXuOCh091WCx1kBK5f0QcxRblKxwTgH/j9QiLH4CwmEczUmv2hRsl3
	joECny+5qmuR5otK4rrhpsObcVpbowdxCQEaXv+HQcx5yS/KGimIFuTEPzY3ffA0xUU1XpxVXTI
	MekBwO4SHjxyy2/k76IVc42kPFzpsDkok6E42GqFpgNOIEGssuUxp6nt4N+aFsyUHLIhn/SaKa5
	SyOHFY8c6nu3uNkQukjY1ZJEujLHG9ZKtJmuz3Nt9ygxL0zRtj/hkRQEqcW4oJ95i/oglNnC05X
	kvy+jMoIceAqN2g5e27Jkti6Dh7I5tsMgde/h
X-Google-Smtp-Source: AGHT+IFfdKk9Cca95Cx02tKrAHokn8rGTGvWgErSZoz4C8DHUlWw/qsaAhy1UuooWqtUCGJrjTmqYQ==
X-Received: by 2002:a05:6000:178d:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3a4cb45f8e9mr6664781f8f.23.1748255622366;
        Mon, 26 May 2025 03:33:42 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d26caf92sm5071512f8f.66.2025.05.26.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:33:41 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/6] gpg-interface: extract SSH key type from signature status output
Date: Mon, 26 May 2025 12:33:13 +0200
Message-ID: <20250526103314.1542316-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.614.g649fb04ae6
In-Reply-To: <20250526103314.1542316-1-christian.couder@gmail.com>
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <20250526103314.1542316-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit extracted the hash algorithm from GPG/GPGSM signature
status output and stored it in a new 'sig_algo' member of 'struct
signature_check'.

For SSH signatures, it's more interesting and easier to extract the key
type (like "RSA", "ECDSA", "Ed25519", ...) rather than the hash
algorithm which often depends on the key type. For example "Ed25519"
has SHA-512 integrated into its design, and "ECDSA" and "RSA" are
typically used with SHA-256.

Let's improve the `gpg-interface` parsing logic to capture the SSH key
type when parsing the SSH signature status output.

Similarly as the hash algorithm for GPG/GPGSM signatures, this
information can be useful for Git commands or external tools that
process signature information. For example, it could be used when
displaying signature verification results to users or when working with
various signature formats in tools like fast-export and fast-import.

As they share a common usage, we also store the SSH key type in the new
'sig_algo' member of 'struct signature_check'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 15687ede43..182e579769 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -456,11 +456,27 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
+static char *extract_ssh_key_type(const char *type_start, const char *type_end)
+{
+	if (!type_end || type_end <= type_start)
+		return NULL;
+
+	/* Back up over any spaces before " key " */
+	while (type_end > type_start && *(type_end - 1) == ' ')
+		type_end--;
+
+	if (type_end <= type_start)
+		return NULL;
+
+	return xmemdupz(type_start, type_end - type_start);
+}
+
 static void parse_ssh_output(struct signature_check *sigc)
 {
 	const char *line, *principal, *search;
 	char *to_free;
 	char *key = NULL;
+	const char *after_last_with = NULL;
 
 	/*
 	 * ssh-keygen output should be:
@@ -485,8 +501,10 @@ static void parse_ssh_output(struct signature_check *sigc)
 		principal = line;
 		do {
 			search = strstr(line, " with ");
-			if (search)
+			if (search) {
 				line = search + 1;
+				after_last_with = search + 6;
+			}
 		} while (search != NULL);
 		if (line == principal)
 			goto cleanup;
@@ -499,6 +517,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 		/* Valid signature, but key unknown */
 		sigc->result = 'G';
 		sigc->trust_level = TRUST_UNDEFINED;
+		after_last_with = line;
 	} else {
 		goto cleanup;
 	}
@@ -507,6 +526,9 @@ static void parse_ssh_output(struct signature_check *sigc)
 	if (key) {
 		sigc->fingerprint = xstrdup(key + 4);
 		sigc->key = xstrdup(sigc->fingerprint);
+
+		if (after_last_with)
+			sigc->sig_algo = extract_ssh_key_type(after_last_with, key);
 	} else {
 		/*
 		 * Output did not match what we expected
-- 
2.49.0.609.g63c55177e5

