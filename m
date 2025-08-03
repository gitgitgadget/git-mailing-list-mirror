Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F05194098
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237442; cv=none; b=fmsLz+EyHJeTEDSf44R42LPSk10ApZSRf8Tz3MoKYn6BYdtFMf5Zxh1QcgT4vYpfo8icaLt5z4uBB+PAn86ugLQRXnRXh0k4MoZMLj8B4/6MnDraNgchVmkGv8paLgY4omdGVm/3JC3ZYYa3dHe+gSJzu9cQNxu/leq9krim57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237442; c=relaxed/simple;
	bh=yd3xqV9hK7wnJMTr119/DR/Nu40l86gxU96Zb6cvvhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsSzJJFpV/7gauPC5X6/k9vWr7xpkYCLYF0W3HKXoyDg5pYW+QODuzuS18FMill2Zn8jTBIacMIFI7hLemF2oP+vSDY8TM/1HGbU888NohSCcnsKkkKhHrJiXA79+W/X+8pZfZt2HE9eMejfzi08Sd9IJFv8vAHvBOR29Y9pbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzH8zzfG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzH8zzfG"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8fd5c86675so2474642276.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754237439; x=1754842239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8fX6oie618tbVKWbM/ugBFJPaJIMic7dixQu6FG9U4=;
        b=RzH8zzfGKY+bmCjKBEGuuuWXFWm+65e3lOV8h6IgXaVZLWhNQvcFMv1PQUzsUEDJw3
         GwGTv1lUqQpbP6Zx4L38cRygbC+xHaxoXwYUDgW4baq+faKuODSsQ0nLKdbCGQ0P4KLz
         88DU9ljG2rXUfW9gw6cMUy7zX8IIaa12CRLwFmVGBF3iqyGZGycavw1v+eQS9kEBuK/J
         cFaaYyC0D5cviIU2NPvtTYoJpYKzek17O1EBKVupV3Duu11btQ5WnhpzVc52YGjjC/zs
         KXpjfJifjIcWB8h7CD0MOa2lFWVCJjWlSfC3CE/z2mxjTY2xtWzDQYo30oJFBbfKNMQ+
         MOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754237439; x=1754842239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8fX6oie618tbVKWbM/ugBFJPaJIMic7dixQu6FG9U4=;
        b=Y0YOyTTkp9E+BzXI3XLnhDIryJEMt24x0zLM7RyqrCNoU09WjCEJTKj/p602Z2ufc2
         AVYp3OnU0VzGAmHv1RlJGU6149eHjbxWJXQoQ+Oz14i4pCeIKTa8/Df2jADIyjVPH/lX
         yRm26JpWiGpV/5i1qamMspNQdQeWAVgDM+cwQN7hgdcL+TEojJc4q7nK9Kj+5ajPlUZ9
         hmm4+mh6hcC+cyaFnqW82X8llAH7ZL39T9uRexPRomiZc++7T5XoEPaPD2k7LkHB9sk/
         Q5/cY6wavy25b6VaM/8laAua8r8/yq6XCK2wl6ZxVlHF9EUSWyokSmXaJ+ifjmOcWzwy
         jXAQ==
X-Gm-Message-State: AOJu0Yw7VHtqz/mkZU837mAYCVr/wMhl/KcKdeaagcECoR4jKd6iwFJV
	qIfvkI2CdkKBhz87yDOlqbPVWsQldQNd0C3NjKPH59m6BR5GQ1jrWTmWZOyj4ebc
X-Gm-Gg: ASbGncv7/eY9AtTTAuAbGoszTpGPMXHF7qxRiuoIJFSmy1tWSPBsVbJgm3jHw+pXEmp
	1tVq2K8FVTTls1OmYKcO9VOhOqlfhunuZ16yHmngbMTz8DMIDtX4ASCv9dTxHaieqQUU4yuVmxN
	JcFndgfARcXYPSKgFYF0Vu+MeUHaG/nj7191Gzj9j6RQeJpgtLQmknNxEYnlcOicg9W5MAJfv6j
	VhsSSbgP/6UxKENTMUz8HlcHycaxptC9QiOBzbWWpu35V+rEKheXxxA9F7Pue5aKH+Y69s+5HK1
	LwOhjkIzwPCQgkNS1+PM5ViPrhDvbwezZFOy8UQYoBwAVfKI0hn/RxhQ0SbhPjD5HMS+yk/LyMp
	Ln/gmULNlSRSbBfD8YyJVw8KIoQozB6ophUCmClpAT4Inm7hxVlGAXE8+3u7f3KImMx+pm/0=
X-Google-Smtp-Source: AGHT+IFUInDnemMOus1cYcd2p8YowlLRMpeiSxkA47q0FzI7+LLCWuIwmC3A+7q9Ltqe1zfuEFcJHg==
X-Received: by 2002:a05:6902:1791:b0:e8f:c910:9770 with SMTP id 3f1490d57ef6-e8fee03119amr7129284276.16.1754237438988;
        Sun, 03 Aug 2025 09:10:38 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:a173:55da:e3b1:53f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713e9fsm3100175276.5.2025.08.03.09.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 09:10:38 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] permit -h/--help-all in more scenarios
Date: Sun,  3 Aug 2025 12:10:24 -0400
Message-ID: <20250803161033.77696-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803012613.54086-1-ben.knoble+github@gmail.com>
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v2:
- Rebase on unpublished ua/t1517… v5 (https://lore.kernel.org/git/20250803020744.1037392-1-usmanakinyemi202@gmail.com/)
  which is rebased on master
- Changed fixup to account for instaweb Perl dependency

Changes from v1:
- tweak refactor commit message to indicate no behavior is changed;
- use #define'd constants instead of an enum for internal flags;
- drop controversial [4/4]

QQ: Is there a better way to add --cc's to format-patch than grabbing
the right folks off threads from lore.kernel.org/git? (I could also grab
them out of my mail client.) I assume this is where using tools like b4
starts to really shine? To be clear: I mean CC's _in addition to_ the
use of

    sendemail.ccCmd = perl contrib/contacts/git-contacts

to keep folks that participated in prior rounds of discussion abreast of the
next version.

--------
Original
--------

This series depends on ua/t1517-short-help-tests with some fixes, which
show up in the first patch. Start a new topic from the (unpublished)
v5 of that branch:

    git switch -c topic origin/master
    git am ua/t1517-short-help-tests-v5.mbox

Then apply this series.

This series enables --help-all outside of repository contexts, and
allows -h with other arguments (without breaking existing ls-remote/grep
usage).

It consists of preparatory steps (fixes for a dependency branch;
refactoring to make an internal helper's arguments clearer) followed by
the main commits.

v1: https://lore.kernel.org/git/20250726165320.4039-1-ben.knoble+github@gmail.com/
v2: https://lore.kernel.org/git/20250803012613.54086-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/git/tree/help-all-tweaks

D. Ben Knoble (3):
  t1517: fixup for ua/t1517-short-help-tests
  parse-options: refactor flags for usage_with_options_internal
  builtin: also setup gently for --help-all

 builtin/merge-recursive.c |  3 ++-
 git.c                     |  2 +-
 parse-options.c           | 30 +++++++++++++++++++++++-------
 t/t1517-outside-repo.sh   | 12 +++++++++++-
 usage.c                   |  3 ++-
 5 files changed, 39 insertions(+), 11 deletions(-)

Diff-intervalle contre v2 :
1:  e552926bc4 < -:  ---------- t/t1517: automate `git subcmd -h` tests outside a repository
2:  344c7067e6 < -:  ---------- t5200: move `update-server-info -h` test from t1517
3:  7a3e0a601d < -:  ---------- t1517: fixup for ua/t1517-short-help-tests
-:  ---------- > 1:  855931592f t1517: fixup for ua/t1517-short-help-tests
4:  db74b1eff7 = 2:  2392039374 parse-options: refactor flags for usage_with_options_internal
5:  cb4113f77d ! 3:  4dfc046e6d builtin: also setup gently for --help-all
    @@ t/t1517-outside-repo.sh
      		test_expect_code 129 nongit git $cmd -h >usage &&
      		test_grep "[Uu]sage: git $cmd " usage
      	'
    -+	test_$expect_outcome "'git $cmd --help-all' outside a repository" '
    ++	test_$expect_outcome $prereq "'git $cmd --help-all' outside a repository" '
     +		test_expect_code 129 nongit git $cmd --help-all >usage &&
     +		test_grep "[Uu]sage: git $cmd " usage
     +	'
      done
      
    - test_expect_success 'prune does not crash with -h' '
    + test_done
     
      ## usage.c ##
     @@ usage.c: static void show_usage_if_asked_helper(const char *err, ...)

base-commit: 866e6a391f466baeeb98bc585845ea638322c04b
prerequisite-patch-id: eb2c55de73b2b733aa0c8c94469a45d9bc361d81
prerequisite-patch-id: 12ddad29e334853cf61c797a2c08302893f4b909
prerequisite-patch-id: 250bae2541030fcdfc5b35ede44c23e1138c7a3c
-- 
2.48.1

