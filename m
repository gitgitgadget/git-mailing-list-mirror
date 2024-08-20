Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE4610B
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112481; cv=none; b=i70oZfy9Mn0QSAGoeig3XxUCQflbQnd4EFLBowNi0S9t0GzKiaGGZT210IEx1pOWbZOwo5r3QMm/AcBdSf1Hbm9MvtfDi2gJ6W3fyF5I+Dmu0Ym39Tv7ih9VzA0hWuPALLsiGzFsxj5qUlQnYvBvzMc68Y1GdY6wMYRyXiAwtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112481; c=relaxed/simple;
	bh=Tq4f7bN1dblmpBgI8ColD25iH7WGkdAvB4mTkIKGs1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=tE5DN/ClINh7flNrUx83THem0I//jq2pmZlDoANa0eHuAtxMMk6+b8Pb0gGsBBth6HBCZTP1xy8cL+BvIkn8ZanEUMHjqOom1xB676REYQ+5/u7skAA85eUuQRBsBIdrsL1JPUNaVXYE3+M1MzP2cHRU02DC194jVAZA970b9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dREW0enb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dREW0enb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724112479; x=1755648479;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to;
  bh=Tq4f7bN1dblmpBgI8ColD25iH7WGkdAvB4mTkIKGs1s=;
  b=dREW0enbk/IG5Ckv1RpQYNfiNqkaPgenWsw/56esAGwGtEbAGoDiXbJc
   rhCtJ3dzeaQRUiGvV891Yoo2qS/8mDv6MgiBc69Au9xVKcb7i+18zDlW0
   3NZNmwkJek92vbCBelbyW4KA9YrywbH+NEwPPRQnC4yL0KtCIIRrog8om
   xoKnjwl9fI2Ryyol2lvzVEyYuHQkQL56oDQadzzsgmKllp+r1OVN0N+c/
   bU3v4OjF7KeFk1WQShtOkW0t4v071TWQpUorgN7tdUQ7RCdIGZCVy18eZ
   0+bPYi//GrKf3mASxNFhWCac/KM7WPye1KuBlIHM8DlMgA5DbrzExjaaF
   g==;
X-CSE-ConnectionGUID: FFID865AS3eCtEt8KQvxZA==
X-CSE-MsgGUID: /bZQtWBRQFCMDKBEQ0jskg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33542524"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33542524"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:07:58 -0700
X-CSE-ConnectionGUID: b7xlIBDMRfGp/TRyPlXrkQ==
X-CSE-MsgGUID: 8xeX6OJKSqmN6dQ9z263ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="91277717"
Received: from unknown (HELO localhost.localdomain) ([10.166.241.20])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 17:07:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/3] send-email: add --mailmap support
Date: Mon, 19 Aug 2024 17:07:48 -0700
Message-Id: <20240819-jk-send-email-mailmap-support-v2-0-d212c3f9e505@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTew2YC/42NQQ6CMBBFr0Jm7Zi2wVJdcQ/DopYRRoU2LRIN4
 e4WTuDmJ+/n5/0FEkWmBJdigUgzJ/ZjBnUowPV27Ai5zQxKqFIYqfHxxERjizRYfuEWgw2Y3iH
 4OKG0ZzLa6MpVCrIjRLrzZ/dfm8w9p8nH7343y6391zxLFKiNs6dbabWoTN1tk6PzAzTruv4Ad
 HahO8oAAAA=
To: Josh Steadmon <steadmon@google.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.0

I recently sent a series to enable mailmap support in format patch. The
discussion led me to realize that the true problem we wanted solved is to
map addresses at send time, so that we do not accidentally include a dead
mail address when sending an old change.

Instead of worrying about what the formatted patch has, this series
implements support for mailmap at the send-email, which will translate all
addresses, and not just the author/commit addresses for a patch, but also
the email for any trailers.o

With v2, we now have a configuration option (sendemail.mailmap) to enable
this behavior. In addition, I enabled support for email-specific mailmap
files.

The intention of these is to allow a maintainer to map the known-dead
addresses of former colleagues onto a current email for an owner within the
team. This would be used to update the send addresses to avoid including
no-longer-valid addresses when sending patches. This is intended for cases
where the original author is no longer valid such as when they are no
longer employed to work on the project. While sometimes pointing to a
canonical public address of that person may make sense, in other contexts,
removing them from the email makes sense.

I believe this version solves the use case we have of ensuring that we stop
sending emails with invalid addresses, and may be useful for others as
well.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v2:
- Loosen restriction on git check-mailmap by default, rather than
  introducing a specific --no-brackets option.
- Re-write commit message for the send-email changes.
- Add --mailmap-file and --mailmap-blob options to git check-mailmap.
- Add configuration options to git send-email for enabling mailmap support
  by default, as well as providing send-email specific mailmap files.
- Link to v1: https://lore.kernel.org/r/20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com
- Link to previous "v0": https://lore.kernel.org/r/20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com

---
Jacob Keller (3):
      check-mailmap: accept "user@host" contacts
      [1] check-mailmap: add options for additional mailmap sources
      send-email: add mailmap support via sendemail.mailmap and --mailmap

 mailmap.h                           |   7 +++
 builtin/check-mailmap.c             |  25 +++++---
 mailmap.c                           |   9 +--
 Documentation/git-check-mailmap.txt |  18 ++++--
 git-send-email.perl                 |  20 ++++++
 t/t4203-mailmap.sh                  |  33 +++++++++-
 t/t9001-send-email.sh               | 122 ++++++++++++++++++++++++++++++++++++
 7 files changed, 215 insertions(+), 19 deletions(-)
---
base-commit: 87a1768b93a67d0420255a43d9e07387b2e805ad
change-id: 20240816-jk-send-email-mailmap-support-1a9e86867c72

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

