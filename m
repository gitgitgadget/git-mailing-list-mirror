Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69A17BB1C
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063975; cv=none; b=gYH1kSkbv5n8/k2ig7l6ErmDu2XbzsxUF/tsBecKfYFy3J8ywsh8/qquUZrIlP5260WA+5X9ADdP6+lBvD6BAKEJNcvfrau54tJ3Aupyn78xpJy6K/iN6egq/eP6Ok5ZPjk6oHrhMWu591/+SjaQjEh9ULQJAp9ZONfWrJuVJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063975; c=relaxed/simple;
	bh=/wSKxZTrU22j569uKR7huncXSg3Q/OWuWlviOh6JC1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJcqRP1ODgXXXVEqxwIqGcqxHuE342PDT2dRLGhI9uq0cQDTFdRbslkNBSGOWHueapXSSQUUlbLA1uLp5Tw4Ec+kz/Dl35YZ3lXkXGAyxod51k+tVdDiE0coTs8/3RYhn0iTblch7kOXY9olXu8wuRA9ipLHSoBOo9N2NRKOYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9LcsiBF; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9LcsiBF"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f2e2608681so674343eaf.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 20:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734063972; x=1734668772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlOonv7ZZB3DRJLrvwKYl5X5XBixCpW9VudPFRNg22E=;
        b=M9LcsiBFa6ZJvVLwGzoxoaqCvyqSP9oY2EkCrIPhAKdiSBV5sQ+O/WVLcKWt1jpObx
         U0gHyTygUVNoMrZhuD0MGZFTGgA2YxYDvQWCSbyThMGr9iu+ah3ulofavkZLhA/C8QkM
         nGC8440J8sr1C+suP2aUgZyNSLX0KlhFyqPjODcAOGTI7KpMK35zz73ZhZ+0kRO4oNnt
         oYI+/zZnyp5e9Oja4j7zSJcumsmBJ6w1p9ZzNt7tPok5fiaQ7YwXWpz04A7KdD4SOfga
         eQRpkhgQqBbcaCzG01eMRZE6jZE518zfZ4SudMDxE3rg9YjRhi7HEEefaObJTxn/vTjA
         PUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734063972; x=1734668772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlOonv7ZZB3DRJLrvwKYl5X5XBixCpW9VudPFRNg22E=;
        b=WjO8uM7rXPUZhwNkT13wgOy/PhFlT6RlIH0rJgBw2fvneIgqMukeL3dc8qpiZpHbUC
         Y9LDndA0J8PeTq/3ViUDg7WjOii5G4k0s4EjUpIp4jorJMyaQSnV6OSns3hHU5nprxFN
         mNHRVWWfcb7KbNHjbHCbJh6PF8hOu2BsywJ9Jascl3MoLkR8b3ONZvtOr3SXJkL0waVi
         EfrMjxE1PDEOH5uh51EVBHl6vMSvSfhb5zdds599FdGwHeY975WqZ51W1mpK2xZbmx5v
         9bQWLz2YAlxXhCM07GFTbnvAYAs882XOlnjg3yQHvsCbJb4mog0Rcgl/0WyVtNk1CIcr
         eLOw==
X-Gm-Message-State: AOJu0YxaL3BWJjCC62j/8H2WcAbYW70egr162eeaiLAWORZk0Z5lcQFJ
	Npbqd3+dVpBXuomT0znoV8uQ316NHvkmHAb5eIw09RQHR+uroYW0/N1Tfg==
X-Gm-Gg: ASbGncv1tXoK6EuJHqxVHqt/NxhZLBl7x59Z3UYDE9WrDEnkDZ2SxepHkerAunF1Nuv
	E0lL+QNMNVgJk0mZG4W7+yMdKmTyyGNItKV1yYLNRMhOkZeiRJIhG4N7rbNB8ItF1OE0ZIvKCAL
	wgmTt8ZHH2EkJwn1mAWTG/dykxHgCXHQ/Ugj7xDS9ultN72SAqcYu+JL5avrIDq9oenoaz/aGKp
	WEAszd5/23248CLA2w6kbeRSDyZ85ZDNiMTE3AET+/2wUzoW2mKZKX10BF8wz38
X-Google-Smtp-Source: AGHT+IEfjv22x3pq9DlvbABhMO8SPQqbWG8bzg/yv3Jl769EGu5fyavmhUTDpB5G5pfYif9JFrmeTg==
X-Received: by 2002:a05:6820:1b8c:b0:5ee:db2e:9f76 with SMTP id 006d021491bc7-5f328fc6729mr808226eaf.0.1734063972400;
        Thu, 12 Dec 2024 20:26:12 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e37410edfsm342736a34.67.2024.12.12.20.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:26:11 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/3] batch blob diff generation
Date: Thu, 12 Dec 2024 22:23:09 -0600
Message-ID: <20241213042312.2890841-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1) it is possible to generate a diff directly between
two blobs. This is particularly useful when the pre-image and post-image
blobs are known and we only care about the diff between them.
Unfortunately, if a user has a batch of known blob pairs to compute
diffs for, there is currently not a way to do so via a single Git
process.

To enable support for batch diffs of multiple blob pairs, this
series introduces a new diff plumbing command git-diff-blob(1). Similar
to git-diff-tree(1), it provides a "--stdin" option that reads a pair of
blobs on each line of input and generates the diffs. This is intended to
be used for scripting purposes where more fine-grained control for diff
generation is desired. Below is an example for each usage:

    $ git diff-blob HEAD~5000:README.md HEAD:README.md

    $ git diff-blob --stdin <<EOF
    88f126184c52bfe4859ec189d018872902e02a84 665ce5f5a83647619fba9157fa9b0141ae8b228b
    HEAD~5000:README.md HEAD:README.md
    EOF

Some alternative approaches that were considered:
Instead of creating a new plumbing command, the existing git-diff(1)
could have been extended with a similar "--batch" option ("--stdin" is
techinically already handled through setup_revisions() since it isn't
disabled). This option could read from stdin and generate diffs for any
valid revision pair that gets provided (not just blob diffs). The
primary reason for not going down this route was that git-diff-tree(1)
already has support for batch diff generation for commits/trees through
its "--stdin" option and teaching git-diff(1) a superset of this
functionality would further complicate this porcelain interface for
something that seems like more of a plumbing feature.

Another idea was to extend the existing git-diff-tree(1) to support
generating diffs for blob pairs through its "--stdin" option. This
didn't seem like a good fit either though as it is really outside the
scope of responsibilities for that command.

Ultimately I couldn't find an existing place that seemed like a good fit
thus the new plumbing command route was chosen. I'm still not sure
though if a standalone "diff-blob" command is the right choice here
either. Its primary function of generating a single blob pair diff is a
direct subset of git-diff(1) and is thus largely redundant. The only
additional value comes from its "--stdin" option which enables batch
processing. To an extent it seems much of the existing diff plumbing
commands feature set can also be accessed through git-diff(1) so maybe
this isn't a big deal. Feedback and suggestions are much appreciated.

This series is structured as follows:

    - Patch 1 introduces the "diff-blob" plumbing command and its
      surrounding setup.

    - Patch 2 teaches "diff-blob" the "--stdin" option which allows
      multiple blob pair diffs to be specified and processed.

    - Patch 3 teaches "diff-blob" the "-z" option which, when used
      with "--stdin", uses the NUL character to delimit the inputed
      blobs and outputted diffs.

The series is built on top of caacdb5d (The fifteenth batch, 2024-12-10)
with ps/build at 904339ed (Introduce support for the Meson build system,
2024-12-06) merged into it. This is done so the new command is
integrated with the meson build system.

-Justin

Justin Tobler (3):
  builtin: introduce diff-blob command
  builtin/diff-blob: add "--stdin" option
  builtin/diff-blob: Add "-z" option

 .gitignore                      |   1 +
 Documentation/git-diff-blob.txt |  39 +++++++
 Documentation/meson.build       |   1 +
 Makefile                        |   1 +
 builtin.h                       |   1 +
 builtin/diff-blob.c             | 200 ++++++++++++++++++++++++++++++++
 command-list.txt                |   1 +
 git.c                           |   1 +
 meson.build                     |   1 +
 t/t4063-diff-blobs.sh           | 108 ++++++++++-------
 10 files changed, 309 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/git-diff-blob.txt
 create mode 100644 builtin/diff-blob.c

-- 
2.47.1

