Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE61A00FE
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913824; cv=none; b=pXssnZgQe293O02JRxTK9V7dr5/KAP7qKzICxGXB4hiCZ5dfBjN3ZV4Ea7uWMUr8d31y8wTrhSR4Fl+vtGfminDBJ7IrlO1Y+cF3IWUIzGbdsUnSppCDFpSTuccM3iHUDacNipzzg+91UbcV6mhHgdqd1XupHymg8g4HXSbD8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913824; c=relaxed/simple;
	bh=oLeZo3SdKIxrSDzhqDAvNEdDk8c/aNdOlk4ohCgskAI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lsaw3J4mX2alm4UdbtVOuTRD1anks22TlyqbLK8yhMEPppmJFtaJLsyMePB7qM1bhEgQg94EKuVXRQmnjiSsI5QpyrPfHqc3R/AyUiY1Slf6sqCz3AGjcmy0BZCo5by7JagQtam43ziJlEWGD6tiEX4091rV2d2BHAYpFpIojmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlINYNCP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlINYNCP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21ddab8800bso24924305ad.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913822; x=1739518622; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSpCJ8RnIrjODVwSlSZsxywiPJ3oFm2+PCdTC9ui45I=;
        b=BlINYNCPE1jQCjh4AHvKRZdrIfnTY8LXpsafRW1DG5N/zg7f+TOraqyGTV1PoiLrOH
         g/y+Xx4z25cSL2ZROwYcPV8UqKGWm9xLHaMgWLrqY91OfvXwFUyxThiGn7M2gePJl0Pu
         aOppKVWIDuszDklPTKDEhtRUqndxmd1+BS6pMhWat5kPj5Igd/wEFd1XFctSKJBgEL7y
         6NQGJhfiMZXu3TGFxjUq/hl70Ksn42cEBI8ZgVwvObq2Pm0u94UMHWyetEWKZOaLN+8c
         htR9QuA1mifyoVqTJgXtbF9QK/ALnmL1D8QRpTkw2T4L9qRsqHqddWH9rYpvqZpkmj1b
         440g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913822; x=1739518622;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSpCJ8RnIrjODVwSlSZsxywiPJ3oFm2+PCdTC9ui45I=;
        b=R1zBiMT3mxCjDxDIOAYpuCMwp00UPnXojb5mZGcBkk/VFsqK95IYWrIRjbLpEplamj
         /W8P76ElERrUMA7K+tLye6LbUQrCMEBlntcLHhlh5Qg6e6sEeWeodpIicE2SQs94L/aY
         vup2q3m0NotOo1cvnIZ0XyFKkH7PEGXViiWXpsRhiRg/fd2QEovXfGj8atLrcTqZVdWs
         fa8ytmv+Z2K3mTcNKDIV9LwRhPwlZKVRfkn95xdZ3nxXSkEOcHz+CO7JJUqKDYVZx1dH
         pdkimi/E0vQKupzJB7LCzjuJEqfjxpfHIeRzitNdCgC4HT3LWqGfKjOJeQzDnJUfQVi5
         qAbQ==
X-Gm-Message-State: AOJu0YzUk1EdaRHf6CX8TKogJRvFwYzcVwDIjR8dcz3Ndpf54/XWRLaY
	FAWMqgLwzdJykzeIXa67Ecx+TvRDmQGgPr6ItUpNgNJfAvCGVrNSZNC7kHyR
X-Gm-Gg: ASbGncsktls9KsZVUhzaZKaGzP4mGLiH+2eg2ZGpzE3zZlrAbyaTj0kRQ4iXypsGL4W
	SnYQykGcOtWIuL4C6cTzJtWZ4RvKFe93bk9/JoZy5srAj505rQZK21xKskoEqyw+4dhnvxDLL8j
	YAVGbbXxF+DBOHIKX0XvTUFqwTzwMyoTKA7B7XnvTCf+WmBEpdqBrFRzbY0Ltq9ET5q2uLqWx3I
	kI+KM/EYs+9JuXG02EmJotXM/ANi6WKD92NkIPU8DAY/So6cgmLrCUk53cl844bwzzUdfJmeWfH
	npiYkmX7MWsMlMMoRkLaeg==
X-Google-Smtp-Source: AGHT+IH3ULGlOY0/lszoS1UytjJGzCy5VzYkmxVHBaxYXKWVmr/0fZUpmFXzn1tbSiGhRpES9mM/GQ==
X-Received: by 2002:a05:6a21:9205:b0:1e0:c8c5:9b1c with SMTP id adf61e73a8af0-1ee03a2395fmr4525896637.9.1738913821953;
        Thu, 06 Feb 2025 23:37:01 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:01 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/6] refs: introduce support for partial reference
 transactions
Date: Fri, 07 Feb 2025 08:34:35 +0100
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIu3pWcC/x2NywqEMAwAf0VyNlC7VdRfEQ/ZGjXgo7RVdhH/3
 eJxGJi5ILAXDtBmF3g+Jci+JSjyDOxM28QoQ2LQSptCqwq1KdGRj0LL8keK+yoWPY94uIEiB2x
 Grr+qVh9TWkgZl6T83kXX3/cDvjX69nIAAAA=
X-Change-ID: 20241206-245-partially-atomic-ref-updates-9fe8b080345c
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3337; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=oLeZo3SdKIxrSDzhqDAvNEdDk8c/aNdOlk4ohCgskAI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBoBa1+IrwLY6uuEORq+Eem8wu1/ZX41G
 KiOr20uAqnAY4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgaAAoJED7VnySO
 Rox/OIkL/12yvZD4fNVaW3EJo5jU9XHYBPmnTqkJYlV0acF4pGZMXgNTYrtd7j2cGuBpTfgmJJW
 fzdttRnVUyEAZNqF1MTHmGH2xH+3c+FPU7efNKLrn1cN++m382WycPZG5BoGD9NFl8aCMGseyAp
 k92iOjFW2EInkimX88kjcv1mZaTokJUdazftbZTjTMwd12kHTdKw9MOxLx4W+D36LT0Vk8nRb4S
 eb8UqdhSuEK0zfte1afR4eEnrOeuPbKjwP75DnArAD/MtvgcKlyTsaVhnxaoaBWi6sJy6gDqusc
 nE/n9Y7NkW2/EwUlcHLVZOAXKXw7QJNCLHJWdnDWZZ2vI/iTvEJFKliZxvjVoO0fuLvyBunmtVB
 wjWGaGtBa/F75Wc7oNtvhKdgsAJEeWD0Zv/d2hlpJoC+hF8O8+cjb3uQ+yBOvYvWSPJOjVBWUYD
 gqA9TjXP02nNoy1PDJ2xZ3tRJuiO6iD19h08LmOsa9kpbsWkghTPQU5TVzn9UsCAE9O/gFHGuu8
 VM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git's reference updates are traditionally atomic - when updating
multiple references in a transaction, either all updates succeed or none
do. While this behavior is generally desirable, it can be limiting in
certain scenarios, particularly with the reftable backend where batching
multiple reference updates is more efficient than performing them
sequentially.

This series introduces support for partial reference transactions,
allowing individual reference updates to fail while letting others
proceed. This capability is exposed through git-update-ref's
`--allow-partial` flag, which can be used in `--stdin` mode to batch
updates and handle failures gracefully.

The changes are structured to carefully build up this functionality:

First, we clean up and consolidate the reference update checking logic.
This includes removing duplicate checks in the files backend and moving
refname tracking to the generic layer, which simplifies the codebase and
prepares it for the new feature.

We then restructure the reftable backend's transaction preparation code,
extracting the update validation logic into a dedicated function. This
not only improves code organization but sets the stage for implementing
partial transaction support.

With this groundwork in place, we implement the core partial transaction
support in the refs subsystem. This adds the necessary infrastructure to
track and report rejected updates while allowing transactions to proceed.
All reference backends are modified to support this behavior when enabled.

Finally, we expose this functionality to users through
git-update-ref(1)'s `--allow-partial` flag, complete with test coverage
and documentation. The flag is specifically limited to `--stdin` mode
where batching multiple updates is most relevant.

This enhancement improves Git's flexibility in handling reference
updates while maintaining the safety of atomic transactions by default.
It's particularly valuable for tools and workflows that need to handle
reference update failures gracefully without abandoning the entire batch
of updates.

This series is based on top of bc204b7427 (The seventh batch, 2025-02-03).
There were no conflicts noticed with topics in 'seen' or 'next'.

---
Karthik Nayak (6):
      refs/files: remove duplicate check in `split_symref_update()`
      refs: move duplicate refname update check to generic layer
      refs/files: remove duplicate duplicates check
      refs/reftable: extract code from the transaction preparation
      refs: implement partial reference transaction support
      update-ref: add --allow-partial flag for stdin mode

 Documentation/git-update-ref.txt |  12 +-
 builtin/update-ref.c             |  53 ++++-
 refs.c                           |  58 ++++-
 refs.h                           |  22 ++
 refs/files-backend.c             |  97 ++------
 refs/packed-backend.c            |  49 ++--
 refs/refs-internal.h             |  19 +-
 refs/reftable-backend.c          | 494 +++++++++++++++++++--------------------
 t/t1400-update-ref.sh            | 191 +++++++++++++++
 9 files changed, 633 insertions(+), 362 deletions(-)
---



---

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20241206-245-partially-atomic-ref-updates-9fe8b080345c

Thanks
- Karthik

