Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82C327C00
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882578; cv=none; b=TPZiznVH3Y710NQitpfPMY0FhtYiFGdUfOjOWxuGNiQ3wgLZFBY9K5IMB4nCZwsX9YgV38xnl06s+oxkIQkVLUlBC8coW/2lobk7NHxfviFfMD7ZBEozqR/MbLtAcUrk++qzSbKzeM9qwsCEKahk2DGB84aFRsNrlyu1YJqnFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882578; c=relaxed/simple;
	bh=riSwAIShIdSpdsGqiECyTgneYE2Vp1oarkmv4+f9NRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxKqbcUcUzTy81w2YKs7bZN4JA1/bBOmu/TUpzXfk3U1ZrUWC/ro20Ib2SzjzVbFGQoRVvviCNVK9c1p9xprFJN4EPbbaY7lK7KZR42DUbnc+Kmrb/KgIUJnhzBu813rlzDDqvCh96EaEv2N7TyJkgoSvDgPTfy7xVCF8HzDaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqG1CrC1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqG1CrC1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bddba676613so922276a12.2
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 13:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764882576; x=1765487376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6LDbc2NF6W5hcZxA1XK5qJOlffwSNYQ/Y8AUtcX6Mk=;
        b=VqG1CrC1I6wYkrw6Jhuq2TK2LdLUQPGcjpV+9S/RYM5kmTZ6GeTgWLYaHx82IPDb8I
         uLnGwAKb+BJlImYB2BZr+YF79OorDbGM0vYkPOxYoFbDLUZoGwKCxP7QK+k5LDZxGsHb
         dsfvBqLlWMYz29motDynLIQOjPHdNn7QTQFCtOc42VXpJSlKmcK/hNaeRaOyUG+eG4As
         k3RAP8Wc+DShG2ILKbkBt46ivIyqm5ajhHGglDcZSk0o+7SvaSSYtTnn5hhuaNqtk0Df
         34kf3O4KDR6U89T8u5TSsIqVkf9pvEAjDUMVf/T9nLdwgwANN8HBRO2ME5Bi0My+mGZn
         +zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882576; x=1765487376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6LDbc2NF6W5hcZxA1XK5qJOlffwSNYQ/Y8AUtcX6Mk=;
        b=LwZySvefhbGUB7/ZOSb+EXxe/mFYJ/CsV7j4mNeEMHxRqZx2Sv8/3s71gjEikjcJ/B
         uynZdIwgsuhEknX9HIbmWVnrAAbSjWUl39dhf3VX9lY7WWxhJ8GEa4x/vuc1QFfkGy5H
         ZZLN2ISBu22jg7DpREYiTPU+xAIrgiHWL3s3snrjhCRS7L5otmFKx0KTdykl3f3OGYzp
         RU2dj4CqT2ZVNZO0AJpOu0QEtgIoj4TcZ+XKlRMbOI7nP8eKudUwV1eonQccNfowLm0K
         8RCX48T6PpopGOd3sP66V+mf8DkhOutRrGvLDmDeUYfEKKmC2T6cMFV23m7PbeazYIke
         pzgg==
X-Gm-Message-State: AOJu0YyOLRw2dJDKSlcfZD7iy+CvydVPBJez0sIFQaF6lrGTRPxu+Sm6
	KG2xUuWWwoqojzSSx1ishVCJ8+X7vDBjP7Ed+d1Gydewuqxayg+hIR8LWLNDyg==
X-Gm-Gg: ASbGncubPLloRES39bjza7unQKcNvKMRAWb2crFnwep28gL0PCsIm+p+5J3fHbGsWhy
	woMJZCp3448BpoacbmScV/Yj6YWUae5zGKqw0mnki8mcdjh7vBvzpnoDHaI4r21RfadGAEJutcg
	CHAH7pgZa7fFjsGojkO6TdmMh8kcyzPNx5ryK3l+AgSb/im1yVHtF7FBV9MjBoa9BktwQA8E9AA
	JYAdnASF+DEYZTXCPijd9R9HdLRPgz34eRpN24TT49b2Jp+j2hzYFjpYaEOmvA4kAJgYzWFQSTa
	Q4gmYxYxaJFhf1m2phYIUF0NciXtehwcqxO9GPM57m6sLRHMsLYaN/YG7Il5ppPb5yLidK7nb+z
	LY+9kOFt1OvFh5jW0dgY86C8HUjKe9ElmTudJZyt6W3OGDIeV2y9S37MTG7E5Qdef7vLNiRXZQk
	AJrVXz01Nxb5jez31LXLwcZXY8f6qk0btJZ/4tNSbaEHhwVjd+4aUKt/Q/R/xfHoWf
X-Google-Smtp-Source: AGHT+IGbEqINB1SNKL1Edb0Qlc2So3pImzeMuw9cH06FqwLLPdYyhqxydKblAuzVoUEOVTrCKxw1eg==
X-Received: by 2002:a05:7301:e8f:b0:2a4:3593:c7c8 with SMTP id 5a478bee46e88-2ab92da160fmr6319772eec.8.1764882576003;
        Thu, 04 Dec 2025 13:09:36 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:32:8e1d:1817:8b3:9658:8ab6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba822b615sm7882624eec.0.2025.12.04.13.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 13:09:35 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jltobler@gmail.com,
	ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 0/3] repo: add -z as an alias for --format=nul to git-repo-structure
Date: Thu,  4 Dec 2025 17:10:09 -0300
Message-ID: <20251204210843.79411-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

The main objective of this patchset is to add -z to git-repo-structure as
an alias for --format=nul. I'm including two other related patches here:

- a patch removing an extra line in the documentation, which was leaking an + to
  the generated files

- a patch replacing `[--format=...] [-z]` by `[--format=... | -z]` in
  git-repo-info's synopsis

Lucas Seiki Oshiro (3):
  repo: remove blank line from Documentation/git-repo.adoc
  repo: use [--format=... | -z] instead of [-z] in git-repo-info
    synopsis
  repo: add -z as an alias for --format=nul to git-repo-structure

 Documentation/git-repo.adoc | 11 ++++++-----
 builtin/repo.c              |  8 ++++++--
 t/t1901-repo-structure.sh   |  7 +++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  bfd4ff5db0 repo: remove blank line from Documentation/git-repo.adoc
-:  ---------- > 2:  e5eac8713c repo: use [--format=... | -z] instead of [-z] in git-repo-info synopsis
1:  f051cd41de ! 3:  0ccec7037d repo: add -z as an alias for --format=nul to git-repo-structure
    @@ Documentation/git-repo.adoc
     @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
    - git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
    + git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
     -git repo structure [--format=(table|keyvalue|nul)]
    -+git repo structure [--format=(table|keyvalue|nul)] [-z]
    ++git repo structure [--format=(table|keyvalue|nul) | -z]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: supported:
      `-z` is an alias for `--format=nul`.
      
     -`structure [--format=(table|keyvalue|nul)]`::
    -+`structure [--format=(table|keyvalue|nul)] [-z]`::
    ++`structure [--format=(table|keyvalue|nul) | -z]`::
      	Retrieve statistics about the current repository structure. The
      	following kinds of information are reported:
      +
    @@ Documentation/git-repo.adoc: supported:
      	the delimiter between the key and value instead of '='. Unlike the
      	`keyvalue` format, values containing "unusual" characters are never
      	quoted.
    +++
     +`-z` is an alias for `--format=nul`.
      
      INFO KEYS
    @@ builtin/repo.c
     @@
      
      static const char *const repo_usage[] = {
    - 	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
    + 	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
     -	"git repo structure [--format=(table|keyvalue|nul)]",
    -+	"git repo structure [--format=(table|keyvalue|nul)] [-z]",
    ++	"git repo structure [--format=(table|keyvalue|nul) | -z]",
      	NULL
      };
      
    @@ t/t1901-repo-structure.sh: test_expect_success 'keyvalue and nul format' '
     +		test_cmp expect_nul out &&
     +		test_line_count = 0 err &&
     +
    -+		# Check -z
    -+		git repo structure --format=nul >out 2>err &&
    ++		# "-z", as a synonym to "--format=nul", participates in the
    ++		# usual "last one wins" rule.
    ++		git repo structure --format=table -z >out 2>err &&
     +
      		test_cmp expect_nul out &&
      		test_line_count = 0 err
-- 
2.50.1 (Apple Git-155)

