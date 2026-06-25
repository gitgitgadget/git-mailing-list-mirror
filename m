Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65753B14D1
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403295; cv=none; b=dtdQszpGMGkNE8G+bsVoDgSO5DdSAbsbtAvFJ65EOECO/6+pwi2WXlS2UTAGA4AcH0mG4LpdRTlVOFKLyOmuWXFTHv7FVH9kMEMbE96O6WohdS0aRbt3zFmvx1ADbpiwUYe07TxrJY2TYdYKAMNZH9ANcICKNYScxb4oAuWaYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403295; c=relaxed/simple;
	bh=HK5lsPyC0O1lQ2Acqg7s/xzMa1vpbMBkANNHsqLNQcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=fUUJyyC2PNDYk+ca4o7tzBNH46qS1p6MJ8bg6B8dUyHPzve4dcA/+f1dGvEIUB5+jUc+63w5eCvp5Wm5x31XLbCDKC9dfE+7D7nWZQH2DbWerAxV9r3DaELvNyTgd/DzOwmHFyWJV4m8wOy6LVVzYx5/O3AZnV94dpQZxFfXmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9nUJVjq; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9nUJVjq"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69ed219d3ecso2063934eaf.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403292; x=1783008092; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtyBN0/8Lp8l09gXAfrolABTlMPgYoeTcozRjapH7NQ=;
        b=o9nUJVjqiwANX7OIFKb3OGoPzsVfq9SUUCeHRNXjvWKB5WpT90vIz904YobG67ODZI
         85uRpTJtGrKgRXGaZlfERQLsGRoD5UoI9x/1RxY5Us4ij19N/9xA76fCFLfsFCuhl8Uz
         XA/1L1UYfNkydCgG1nJIEj1w0qsOtu1WV19UbiDQazq2T6hKwIL5FYUG1bgIR34FRIdn
         A6mYW/T4uQZt9JfcdRY3l1iUZUSHGgjWLj7l76ru7K2n6al9wCihVqntwopxiou/SeLI
         cvoLSXiSXk134QBV59v7TpkXAA/PwaOlfh2WGycGW7FsEH2sBg11Z/hOxXzNQ+nluA63
         A4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403292; x=1783008092;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MtyBN0/8Lp8l09gXAfrolABTlMPgYoeTcozRjapH7NQ=;
        b=cSe/rXVGWjB/v3PcenuBvk8S9EEcl0KNxD04o4hUU2fZHN69tH2lUKJFRQfmoU+XiV
         ZbSjDV2XM0i9JWLW76iNccEjzaepuohL7Ho2YR4us4/+6ifibzSBtSgVkVYfHI/zj6aq
         pTu30dBGtDUqHOK4PPj2hL+m8IzuoKToiesUQhzhLtyGZKqkcrORFYGB5Z5gE39AV5fn
         u4sq39a6VwwX7hpP82bTPzY346woYv5rLb08fOTfYtchQTVkD/qkSCcb8vTiGhGMAYst
         qTVILih+kIxyDWyEowRzOzF/0Ul3cMsUXPPD/LF0yzdlU1xd114wmzLMve+SQS6ROMqM
         hUvA==
X-Gm-Message-State: AOJu0Yxu5Cqfy5DaOIOWgleQk4ny06ggRNbvEqhT+ZKhA4bmEc0xVsD0
	sMiI0YI1niX4eNXXXdS9m2+hqsBZpCnG65Dnp+3hrQaPqFRFTQDpA08Y6mtJsg==
X-Gm-Gg: AfdE7clTZzkMZrRG5bYrhde9Iw4yEoI+XwQJcBM21MPVix1NQCZ9P8XiOX+VzGbMdeW
	shVGJzl4SehgqLlkI1Q2M0KkvQhFHl5CJ1VjehF3YdQ4nXBziSoIeO/Y2Hy39yoo78pZWggWd5U
	58YYM4W1TY7cCOh8iekHh6fXjhR9nnai1e1G9LNDxQ/gYdmmeLjcS/OwGcTm6XwaStWHA9hoh7j
	Hz+JV0hOFiv6IF8LsAGqkGn/Qfmf8z/yearGGversLco6GRL7AtT28J1ZVQCrds1Lecc2Im+1i0
	ZWf8YYtQQsn3Zrb3Vya/MvWrjNQ07DwR/uJKG4FKgy7R5SkeO13wHoB4FhJWHKsh7NbhLZJh+l9
	bTgn1+AwFUIa3lUE1KsCIRw17KksZR2pKCW/CZTSOwlstvMpgTXNvNNN6z56u1QufufoPdOozq4
	tVBtBdDatoZ5gLhnmBMhbZZGb+bfjZhY1gggep5Sp+FMf02RvLFJSCl63ZcURcIbY3S4ji5dnP1
	ZGwOYRy7PXnC9XxdfEbeeioKe5ijnEP4zMRpXRncAIVt2oY3a92BWIlTAshv0kZG67ZmQZHKIU4
	rxviijk9GEHMa+20mP5PV3/BpndQ/tSrvqDB2faH5G25mdg0UtCI
X-Received: by 2002:a05:6820:188b:b0:69e:855b:5ead with SMTP id 006d021491bc7-6a1350534c2mr2720051eaf.4.1782403291179;
        Thu, 25 Jun 2026 09:01:31 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([208.80.35.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51106a09sm71417371cf.0.2026.06.25.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:01:29 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Jun 2026 12:01:18 -0400
Subject: [PATCH v4] doc: clarify --follow and log.follow for git log
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-document-log-no-follow-v4-1-9bb233248b8f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQ6CMBQE4KuYrq3pDxR15T2MC/r6gBpoDQXUE
 O5uwQ0xMbqcZOabkQRsLQZy3IykxcEG610MyXZDoMpdidSamIlgQrGUZdR46Bt0Ha19SZ2nha9
 rf6eZACkN8JTxjMTxrcXCPhb4fHnn0OsrQjdrc6OyofPtc3ke+Nz7eTJwymmiAJlIDgx1fiqb3
 NY78A2ZTwbxHyMig5hp0BoVF8UnI1cMZ18ZGRmjjJRqDyrRes1M0/QCiEwsyFwBAAA=
X-Change-ID: 20260507-document-log-no-follow-72c33dc15017
In-Reply-To: <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
References: <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Junio C Hamano <gitster@pobox.com>, Miklos Vajna <vmiklos@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1782403286; l=3114;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=HK5lsPyC0O1lQ2Acqg7s/xzMa1vpbMBkANNHsqLNQcE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFzARFWeXMJXKmk2dV89hJ/82gQtnBp4ItkRHEBS7vqobn+9BFXNDDqreN8GgKkXRNA0KDuBZeE
 7YXMMYqVpdgM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

aebbcf5797 (diff: accept --no-follow option, 2012-09-21) added the
--no-follow option, but git-log(1) only documents --follow.

Document --no-follow alongside --follow, and note that it overrides
the log.follow configuration.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v4:
- Limit the patch to `--no-follow` and its `log.follow` override; leave
  the existing `--follow` limitations unchanged.
- Link to v3: https://patch.msgid.link/20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com

This conflicts textually with `mv/log-follow-mergy` in `next`. Keep that
topic's shorter limitation text and append the `--no-follow` override.

Changes in v3:
- Retitle the patch to avoid the awkward `doc: git-log:` subject.
- List `--no-follow` before `--follow`.
- Clarify that `--follow` follows a single file across renames, even
  though the option is accepted with exactly one pathspec.
- Document the directory-pathspec case: directory renames are not
  followed, but `--follow` still uses file-follow traversal, disabling
  normal pathspec pruning and possibly changing which commits,
  especially merges, are shown.
- Link to v2: https://patch.msgid.link/20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com

Changes in v2:
- Document --follow as limited to a single pathspec, not a single file.
- Adjust the log.follow documentation to use the same wording.
- Link to v1: https://patch.msgid.link/20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com
---
 Documentation/config/log.adoc | 2 +-
 Documentation/git-log.adoc    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index f20cc25cd7..58147dff9b 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -54,7 +54,7 @@ This is the same as the `--decorate` option of the `git log`.
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
+	on non-linear history.  This can be overridden by `--no-follow`.
 
 `log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index fb3ac11283..64fbec0f57 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -27,9 +27,12 @@ each commit introduces are shown.
 OPTIONS
 -------
 
+`--no-follow`::
 `--follow`::
 	Continue listing the history of a file beyond renames
-	(works only for a single file).
+	(works only for a single file).  `--no-follow` disables this
+	behavior, including when it was enabled by the
+	`log.follow` configuration variable.
 
 `--no-decorate`::
 `--decorate[=(short|full|auto|no)]`::

---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260507-document-log-no-follow-72c33dc15017

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

