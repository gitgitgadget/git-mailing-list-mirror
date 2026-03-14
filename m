Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714DB234984
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530464; cv=none; b=anSzLOgIYBryjxgGtCjHhvpH+0TE48RZsH48wDC6vgYzax4stKeiz/xk5T0HF0b5d8p/hb3ghFlwvuW7l4vs11yv4vRlPwHmMvIwD6GBDk27s82DTEd5eT2ZQkAloH9akYSka690Tgmzql9YGddHdnZVbQIk5qXxMu6SZbeb2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530464; c=relaxed/simple;
	bh=v6HV9lYeq9kpDOi4Au8BaIIympCxww+hqAq0GOmKhsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGppovqTIUUt5DtYkfZHDLpk7AlZyisWpuo7YmIh9s+Wz/TfDwiWy/OHjnLr54LTIvxWnE2soFDoVyHaLwCUkRxgLFk6dfbxb1awLZyLOz/ANgyLwV221IJRyPvVnIQV1UuB10UBXJoLPmQ5TTCwC86/TkIS95qPFLC76RO/WT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=CfzK3Ivx; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="CfzK3Ivx"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gObqMQ03uLqCw7a7eVYZoVC2mvCGHccBesra8tRp5S4=;
	b=CfzK3IvxDbyvvImg9vuipvX1rpveC0xj9wrVrmu4kFqhwutPFkY7u154u+CCM2mw7qPvI8
	lo915pxzV4pLsPNWEboDLAxKUVQ1QVC4CIn+OUltUEhrCxu8dCaf8YHcjuTAlY+7b2DQSg
	ySct2OLs7Y8Jv8SDG8XKwk0tGamnFzNrnFMDXAxyUl9MsnKYSKVIXXct2TN10La1a+izV5
	XbcFDwcicu6nsW07Cb0r2BBQwqzkZtvmpwB+plRMNENIIQUCceCB341/W2SgDwffCOwl+y
	Gw0NF5d4ro9s6Dg8gvKZ2A1Qfc9/A7rd+3BojBAzXYJ7+8mJdQ/G6aqqVPFBEw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 0/7] improve "git format-patch --commit-list-format"
Date: Sun, 15 Mar 2026 00:20:43 +0100
Message-ID: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=mroik@delayed.space; h=from:subject:message-id; bh=v6HV9lYeq9kpDOi4Au8BaIIympCxww+hqAq0GOmKhsk=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezCNB3xN1HFbVwD4vz2Xx/Yj9CzupaLgXmB1 /Bm3nmfxt+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswgAKCRBIeX6hnBm+ 0dvNEACMz8pX6/fRimLrU2QZnt2g1GRXOd/ROcI1dthKbqOeX5fh0m6RphPnCXbIfwiVQJylISr O52GNA3aaFheeQ8v4/PIv2QTa4VjbXdGt8ohXotGpN2Ymjq5YLs9+7q2eCTPyANn7hpfi0LD2t3 XMkpjAFYRH0L8zD7gEeYeLY2Fy+eIYGOl4W1FoPlMkym6VUaqg5rAtpD5gal8gaEn0m9A1VQYGR Gqu0fc4sfeCPGURqCWraxciO/a1VU66I9FI/2YSo0eyh0HEz+0nIybrzN9sNaTy2Fwq0XRlIC8g p1DcTd/BzZT/AMzEibTl+qJHS4AQ8OIYXyKsHr4JswGWG4dzGKIC5r3heXduK3TJiEqtacwFQeX TdMHMC8/0+driiiLBnlSd9P6zsel20kJHSYKyM3Gvqlzm8JoC8gYNQ3xflYxwJh9vN/7AUb8OtQ NiZX84XZgetyJw8nQIrk4E18+47P/DDmnSMHMfMqeKUAhdO78VB4PiYCVMkGygNcVHWukbZl+fz n3YquMxVOpXS0SryxL8bsPVOVKIenwFNny8LeeysF6YBTL99jJZ87bL0bsIl5uGtYOTuoArWtWl FAYx1orBjGZcswx6DhkvUjdx5peU6E8TlJGeuWa9h37KehsY/I2GmHHuq4RPsrdhhcoMOW31pys YB5PrkHrk
 vexkHw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

This series aims to improve the --commit-list-format (former
--cover-letter-format) option for format-patch by improving a bit the
user interaction with the option (and its configuration variable
counterpart), removing the ability to use the configuration variable in
an ambiguous way (which also causes problems when interacting with it
through the cli interface) and introducing a new format preset.

This series is based on top of 67006b9db8 (The 15th batch, 2026-03-12)
with the following series merged into it:
  - mf/format-patch-cover-letter-format at 51ed9f7e72 (docs: add usage
	for the cover-letter fmt feature, 2026-03-07)

[1/7] pretty.c: better die message %(count) and %(total) (Mirko Faina)
[2/7] format-patch: refactor generate_commit_list_cover (Mirko Faina)
[3/7] format-patch: rename --cover-letter-format option (Mirko Faina)
[4/7] format.commitListFormat: strip meaning from empty (Mirko Faina)
[5/7] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
[6/7] format-patch: add preset for --commit-list-format (Mirko Faina)
[7/7] format-patch: --commit-list-format without prefix (Mirko Faina)

 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 19 ++++----
 builtin/log.c                       | 35 +++++++-------
 pretty.c                            |  4 +-
 t/t4014-format-patch.sh             | 72 +++++++++++++++++++----------
 t/t9902-completion.sh               |  1 -
 6 files changed, 80 insertions(+), 53 deletions(-)

-- 
2.53.0.959.g497ff81fa9

