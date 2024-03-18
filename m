Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1458AC7
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800669; cv=none; b=B78ZTe/jWXKPVPTEQGdMNxen6nChgwj2W/EhtCHCywshdPFOI97LTwy5iCTBKMBDSZPA4PAlCLdiXLp7V+agXjywLvYmB8pkePG1d3i8lSlitQRCh8QakcWQBfTXz+uvnfSPuiav78yc6Q1ur0MUJg8rDgAvDvVbQp10OpoiaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800669; c=relaxed/simple;
	bh=FjfECXNSEupii7tzrk+K4YXjCrVe6Fzt2S4ZvntMT8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ObYoV0MetHcrd9WPszVYtIkbPfgQxO/MH1lzFYyPy2I8l/6D7eBxPL6fQEyPyY1y/9sJAjv+5BRCO+snxqmdquFVwDZBbQEpHJpJDmjnhYwRRb+V5q3UEs3XNMKzUI8B/sM8fk9LP7MiUQ5Pl7g0mVP5yj5XZLta97dlpkRpX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=s+xqze8V; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="s+xqze8V"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710800666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lOlxmy7JIBC5a112BW8irT05DPqZhP+iCFnSJoCJot8=;
	b=s+xqze8VuNH7fsJtGhDrTP0+aQUTAglrDDTfyTNByxVCXR72fDlJ1ofgyLblccLuJvOunW
	0l4N8QOxKE3TdcigsTn2NU5WzlejF49zhRkNXURDC9MxaAOQO+zpcQLYwUqBMZpDrPKrOQ
	O4R3LRH1iDRbrLUYw/gMF5YXYVF003uNiP24r3fW8LGNgr9t/phZUD0/IzYfbr8sU2lpnE
	SlTNcbKAZ5P5PJKLrkBOafPR0p6VH+CPhSJoQ4BXYr48KN6+rY6lUYiXb8YrZCXLKCX5ct
	Rf4kJtoecX2Ihl4AkUWzesRLtLSjwezl+h73I1nv9ZhYv3ApsmUQ2ubuHvHwAg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v3 0/4] Fix a bug in configuration parsing, and improve tests and documentation
Date: Mon, 18 Mar 2024 23:24:18 +0100
Message-Id: <cover.1710800549.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series is an evolvement from another recent series, [1] as a result
of a decision to fix a longstanding bug in the parsing of configuration
option values, instead of documenting the status quo. [2][3]

The bufgix introduced in this series _should_ have no hidden negative
effects.  All of the configuration-related tests, both the old and the
new ones, pass with the patches applied.

In v2, this series had five patches in total, out of which the third patch
(i.e. patch 3/5) was dropped in v3. [4]  Other changes in v2 and v3 are
described in each of the patches.

There will be follow-up patches, to address the majority of the points
raised during the review of this series. [5]

Link to v2: https://lore.kernel.org/git/cover.1710646998.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/git/cover.1710258538.git.dsimic@manjaro.org/T/#u
[2] https://lore.kernel.org/git/ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org/
[3] https://lore.kernel.org/git/11be11f231f3bf41d0245c780c20693f@manjaro.org/
[4] https://lore.kernel.org/git/514d832b0399ccdbc354675068477fea@manjaro.org/
[5] https://lore.kernel.org/git/f37d753485094a3ba66fde5e85d0e2dc@manjaro.org/

Dragan Simic (4):
  config: minor addition of whitespace
  config: really keep value-internal whitespace verbatim
  t1300: add more tests for whitespace and inline comments
  config.txt: describe handling of whitespace further

 Documentation/config.txt |  19 ++++---
 config.c                 |  15 ++++--
 t/t1300-config.sh        | 112 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 130 insertions(+), 16 deletions(-)

