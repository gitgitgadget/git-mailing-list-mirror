Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5314B99D8
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792329976; cv=none; b=ssaK69yUttjykZ6qcEOiTt8miPp0nU4oIoGLU1/KzoEB8CPGhKHsPq8CdTR8qrZmNFSTMdwc6WlNmEjQDxkM0pnlln89seN2YEL8t38QQUFwwRtVOQprAnrydI5+iCFAiUWqpW1YrQNtfFFH2MAyDWWYwc/up7bYVk5IHBzC7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792329976; c=relaxed/simple;
	bh=YG2TbqBlG6R2LlchOVZeH9s2CAk5OuUOsaLVqsiHWbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrTNiCwnSaSLywkYNLVW2avVjk4GJvbH5oaDuZ4rgRdyd+N+pqwTfRyu6KZaLRrqYabJmWtWB1SqKA/34TmaJQULioag5M/ivt3ERalEpb3DO9KGQ5ZHPnVMoeVO3zjwyX0/+Ocb92K9JBaQH2m0fsVpzECBFCG1NvRdEAZBjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h32hWUfh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h32hWUfh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c434376dbebso65205566b.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792329973; x=1792934773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X6FuOB0zNsZhlgZ4+imDL53icjTydUlZQCX/VwvnW3o=;
        b=h32hWUfhC4/cmlVWiSQEqds7EQstXuF7s6L+L3Y47nbrLnkiHK/M0TRwHDpMN5OMAI
         8HlsUzpSjGXjLNqsEqqjDr1ljiccEQmyiPcb+ZJ96MwUndcTGyHOcxYo7QYEmYJG7UOt
         HoYq18jP3fkZ7Cd6bPqQIwQk2ZPbpQ6xes/WJc2nlrpGutWSeweyS4hQIzQnXTAQRfIS
         B4yLryzhuceLkZlkGZ9oqkGLF26YCtlsXDc+FzZm4r5tOJzUc9NUwPNfmNzUsc242OAC
         A22NgNAssjpeWmBFQF+OHgkPPQjtC7TLSVEWCck0MClNKHzBdimEYaHaCiytz1EPdlpA
         /WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792329973; x=1792934773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X6FuOB0zNsZhlgZ4+imDL53icjTydUlZQCX/VwvnW3o=;
        b=iGHPJ35SseLsHhGJSBAhgtdKSHDOgDxLgPp4U4JIlxldKkA5bCgZMOOXR7qrU1A43n
         SLIIz8IsZBvi23P3jt11MFpIgj1MM8ZVqdBJ3n7wzVLsC0PdS1iZ1bWiazjqe2YmPs4n
         eh4mbQYPWgKNApo5tWriqvDRZJKkWwXJNIk8DBFZE0lPSh9QZviW8lTzhqhRqvqtOnLA
         HXGd73rhOuZav7lEXGb8FiHr5AKvYKRBtKRf06TynN2pTrcizXwXAXY/G40CHZNsDLGV
         t5/YVP6o5bMiRCinvOO47uWqZWpGNf3QIuC0lUi6AfxDwRh/By/g8rgd+nA0ao+1q+OK
         hUkw==
X-Gm-Message-State: AFq9FYIeDo8KFLaIlFvQAK9ZviiyFS1lE5trXhDGn2sHA62Dh5bQLPDm
	pvfLUINlJW8nbrhZ2MyeirCFM1AmBaQJ/dSXMn4Dr9qMEYCs9kjdJCCHSOAJ+fE1Ev0igA==
X-Gm-Gg: AYBFou1aTd1NBl8GKcwsTbhkaRHqjQGuq26XAdlhhz1hQPC2b9wmMDRqSs3QHhPNtJ3
	gA4GcMkW+t63aeVa5SAnmG8cFBMrCbUiodWLzaeB9q3IvfLnzYtSefa+6tmBrzHe6zrHW2lgzde
	w5+/1oF8QVRNDIIwGREC+iS2sDj6rCtNHcyanE3qmlypt37d6PBn/G2/8VhiyibvuATpXO9rRsS
	cp1KSqbJZxQ4KGG3nzUr5+wTUBgAiHfkQVeCtFZ6ggrsuV0AgqqslE1WJ+C+ZC8K0bpQA/l0nRF
	7KN3XOGXm17zbFaqR1zA68i3L98IW36zxOa3ZF+oo2s2IdOCr9kDPWawbHYiTq2aA03cW5UsMGT
	YGwFCCGFYB/AhMP8Q/UDNWEzX7B/T5jd+jN4QZmD7CMOYrNvzW1J7sLD2SipQVYHAk1aRi7EMBs
	SmM7I1nD4d79tuFcflTr5YH10X1ScljbG0LbUD3cbPhtz9R5PzHdN4fZ/QgHllSnYhEYi9FK8=
X-Received: by 2002:a17:907:72cf:b0:c2e:22f7:59c5 with SMTP id a640c23a62f3a-c40206fb12emr661591466b.7.1792329973209;
        Sun, 18 Oct 2026 06:26:13 -0700 (PDT)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40918c5f47sm269119366b.51.2026.10.18.06.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:26:11 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: git@vger.kernel.org
Cc: Omri Sarig <omri.sarig13@gmail.com>,
	Jeff King <peff@peff.net>,
	Julia Evans <julia@jvns.ca>,
	Li Chen <me@linux.beauty>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: git-rebase: Update incompatible options
Date: Sun, 18 Oct 2026 15:25:41 +0200
Message-ID: <20261018132541.131506-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several options in the rebase man page were described as incompatible,
where this is no longer the case:

- Commit 1a66d8c6f658051a02b6d8f024e80e06fccdcd11 removed
  `--allow-empty-message` for the incompatible option list, but did not
  update the the documentation of the option itself.
- Commit a74b35081c51adbde3ef01870ba03e859db33be6 removed the
  `--preserve-merges` option from rebase, which removes all
  incompatbiilty references to `--ignore-date, --reset-author-date` and
  `--signoff`.

Update the description of these option, to no longer reference the
INCOMPATIBLE OPTIONS section.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

I've also found out that the option `--onto` is now mentioned in the
INCOMPATIBLE OPTIONS section, but is not referencing it from its own
documentation. If this is not intentional, I'll happily send another patch/V2
to address this issue as well.

 Documentation/git-rebase.adoc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6536ebdc90..9fd3cf8ce2 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -334,8 +334,6 @@ See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -m::
 --merge::
@@ -489,15 +487,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
