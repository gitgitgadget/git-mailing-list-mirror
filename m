Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67324E010
	for <git@vger.kernel.org>; Tue, 20 May 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759033; cv=none; b=YjKA1Fl+yVkIdqBewp8uymfdTJazDwrwnKUiZqWhfe/RBwAZzb2fKLv2vNeP6y4WSmzAlQcuor4cILrFlmk6RRpsel393OF+1WlpK+LRjfAsvCKhmUSu2Sqz66w+fHKUNZRY5YMuxLy6RPkh0n6QcTq0Inw0mFNLrHhFY3DGBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759033; c=relaxed/simple;
	bh=0haLes/ZMIoQ/7OxNpbWLQcpDo6URgfPZFRsf6Wd3AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5a/FKUe3TLscb16ResL6U2Lj/3INi7NA2hb8RYoyetLl4H1UNBsIGtYrWFiMQnhSeCfqasYe9PFc0zYb88yaBUFrB2kBBvef4j02Pp8B4A4BJaIzJo/L0m1N8tBMwt1Dpn58qfnARBZpxm+oMXxgKYQz93atLEMfD7pmcEjn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ksEWax; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ksEWax"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40331f302f1so3795589b6e.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759030; x=1748363830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+jyJZrhaosVJbak7yy6wM+4LI/Bs9RPINPRqfol31s=;
        b=e1ksEWaxYKptZfMWtVCeaxwKzr/43nXg2n0HXypMFxKEo77CM5FyurDVcbHHYmmI5H
         gGQv9/83wUM/JxB2imhB4qpjd2Zj7rA0Wx6GBppNFq9NLX3xPu/vDL8wLgxeB5OeFe7e
         4NMqDZ9WyaGOzlP4y4rbQqjGUjwJVJnUDkM+2sT5lK7AHDICRXOFK07fntqz1FerZPrM
         c672JiZZBL/sj+F56dk3RTOdb4UakQzK7sPXf4YpS2HsblDVk3MozX5XH28b1RQ7+LHY
         z0CEXF/92tp06OjHNWBLB0OuZVuHu2WqUWMAfX8+DnOabQlYYApjZe0ZEKpKCHl6dJPn
         XP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759030; x=1748363830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+jyJZrhaosVJbak7yy6wM+4LI/Bs9RPINPRqfol31s=;
        b=HwLO+HEZmuoKKuUIjmg/6AsqvE52Et/GFBBMrBDMTYeeSYVo6wHh/KMmvlH8/oKJez
         y4Ycl/paGfz8SdxXZO1dAZN82b5wPCI3cSJobmpEXbdwMMHoT3tTBhn5T5XkAxKWafIr
         3ekpwI7c5mmo5XPxjVu4USTT+Ub8K7RO6oee+pVC9A6YzJ4LLhiPISiFsj+KfwyBf9jo
         R0qERXMK462pYy0WsA+DezdjXivLE031AGqqFAhcf5rVAI6ZccwnUPlwQqDjPWhMUpLU
         TXtJEjfSbhzQidrLGCfk0vMVr0oQ6JSUYaENeodFUhoSaWqsxpeWTg/Yd6YCCmaSbZEJ
         xAiw==
X-Gm-Message-State: AOJu0YyLzioH0LMu3aK4Rs1dpy+gbG6sebnO8BTQ/IzhOVshxRkLp71Q
	zoCPP5BO7Ew2pbyah7HRUXljox7Q0TFN9SS49cOWvkeKyK04COJgUK5wmH0//mfv
X-Gm-Gg: ASbGncuvv1a7m4O9xuQdz8stpECDgBn4HlpyEpzgBPeIGYKIUFGCYQINCwkYKwzBLuh
	1yt3/xbNgUAcA5mAa2UZvF2/ZFW8AUwHoOOQmgVvEEKl6j1nZEFDD/Mp2vQl+/U+KQjoldoZIPl
	VXor1ENR9LFfWucffaMyxWjUuuQyRsy9AROHCAIimFbxo4gGt8nIWacVzLPLLXxF8rTRVl7bdWL
	jiyO6BEugMkK+LlcjrNFXQArrzMLAovOUPBbaec2AGhTbLHN3FKxQLicV3ClPmfXPzeirK+aN/i
	EAPE/GO6h1xqqix8e/0YKLrbpbgZLyqq8RPo9vGvpv9G5vH58VDTQ5xV7+M=
X-Google-Smtp-Source: AGHT+IGKL0j3zvO09hFCloxgNGCrmoTLuX3179WFX1f7uvQ9Hh3sTEFr9xnRMFlO0ClHNfbdLTstDQ==
X-Received: by 2002:a05:6808:6f96:b0:3fa:8bfd:773f with SMTP id 5614622812f47-404d865e524mr11817545b6e.2.1747759029886;
        Tue, 20 May 2025 09:37:09 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-609f4be9734sm1903975eaf.7.2025.05.20.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:37:09 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/2] builtin/receive-pack: introduce option to skip connectivity checks
Date: Tue, 20 May 2025 11:32:16 -0500
Message-ID: <20250520163218.263921-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250520014920.201736-1-jltobler@gmail.com>
References: <20250520014920.201736-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

At GitLab, we are interested in introducing an optional means to bypass
the connectivity checks performed through git-receive-pack(1). This
series implements a `--skip-connectivity-check` option to facilitate
this.

For some background, we have a transaction management system that runs
in our Git RPC service and wraps all repository operations. Operations
that write to a repository are first recorded and staged outside of the
repository. When committing a transaction, the connectivity of newly
written objects is checked by walking the object graph containing only
the new objects from the updated tips and identifying the missing
objects which represent the boundary between the new objects and the
repository. The boundary objects are then checked in the canonical
repository to ensure the new objects will connect as expected. All
repository operations are run in a transaction and conflict checked
before being applied serially to the canonical repository. This ensures
that operations that would break the repository are not applied.

For our specific use case, the conflict checks performed by
git-receive-pack(1) are redundant and thus we would like to introduce an
option that allows connectivity checks to be skipped.

Thanks for taking a look.

-Justin

Justin Tobler (2):
  t5410: test receive-pack connectivity check
  builtin/receive-pack: add option to skip connectivity check

 Documentation/git-receive-pack.adoc | 12 ++++
 builtin/receive-pack.c              | 40 +++++++------
 t/meson.build                       |  2 +-
 t/t5410-receive-pack-alternates.sh  | 44 ---------------
 t/t5410-receive-pack.sh             | 87 +++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+), 63 deletions(-)
 delete mode 100755 t/t5410-receive-pack-alternates.sh
 create mode 100755 t/t5410-receive-pack.sh

Range-diff against v1:
1:  f659612c9d = 1:  f659612c9d t5410: test receive-pack connectivity check
2:  31e5f41983 ! 2:  f6dbb02778 builtin/receive-pack: add option to skip connectivity check
    @@ Commit message
         During git-receive-pack(1), connectivity of the object graph is
         validated to ensure that the received packfile does not leave the
         repository in a broken state. This is done via git-rev-list(1) and
    -    walking the objects which can be expensive for large repositories.
    +    walking the objects, which can be expensive for large repositories.
     
         Generally, this check is critical to avoid an incomplete received
         packfile from corrupting a repository. Server operators may have
         additional knowledge though around exactly how Git is being used on the
         server-side which can be used to facilitate more efficient connectivity
    -    computatation of incoming objects.
    +    computation of incoming objects.
     
         For example, if it can be ensured that all objects in a repository are
         connected and do not depend on any missing objects, the connectivity of
    @@ Documentation/git-receive-pack.adoc: OPTIONS
      	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
      
     +--skip-connectivity-check::
    -+	Bypasses the connectivity checks performed to validate incoming
    -+	objects. This option exists for server operators that may want to
    -+	implement their own object connectivity check outside of Git. This is
    -+	useful in such cases where the server-side knows additional information
    -+	about how Git is being used and thus can rely on guarantees to more
    -+	efficiently compute object connectivity that Git itself cannot make.
    -+	Usage of this option without a separate mechanism to validate and
    -+	ensure incoming objects connect properly to the references risks a
    -+	repository becoming corrupted and should not be used in the general
    -+	case.
    ++	Bypasses the connectivity checks that validate the existence of all
    ++	objects in the transitive closure of reachable objects. This option is
    ++	intended for server operators that want to implement their own object
    ++	connectivity validation outside of Git. This is useful in such cases
    ++	where the server-side knows additional information about how Git is
    ++	being used and thus can rely on certain guarantees to more efficiently
    ++	compute object connectivity that Git itself cannot make. Usage of this
    ++	option without a reliable external mechanism to ensure full reachable
    ++	object connectivity risks corrupting the repository and should not be
    ++	used in the general case.
     +
      PRE-RECEIVE HOOK
      ----------------
    @@ t/t5410-receive-pack.sh: test_expect_success 'receive-pack missing objects fails
     +
     +	test_grep ! "missing necessary objects" actual &&
     +	test_must_be_empty err &&
    -+	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
    ++	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
    ++	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
     +'
     +
      test_done

base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
-- 
2.49.0.111.g5b97a56fa0

