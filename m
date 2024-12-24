Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CA1990CE
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735040755; cv=none; b=TDBxIuAWpbygSfxiX4B2odkOUX4NC0uVq/3d/9regeBnB2+2jt/uY8xfcaw1XcC4aiAmSvXgCy6DXaq8CarW+DVg0XWH9QSMd1dqjcpyrP8nbngT9YE6f1/4594pzqLehLZ0c/Wk8d6Tk/hGsbg01pPUmOkibM+8nRjAcneuveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735040755; c=relaxed/simple;
	bh=M7Nw1kbIFQe1k262SwzNd3QHz7oi7cTmfozmrqhiDlA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=vDoNwFjG/UXFWtdErW6PK6f+dKLS3q3PWuqDPtSvHxiBYiMBaySwN5MebvRuvpUyZNHGJ7ZeKChINU/1NIKDMRfmOaDxkZbbtvZCDJDleaL7qJONfLVFuFOoPKRMMPFRlF/iRYRSulCFXaPt9O3aGSsVBfN64v2G5xhyjgiQFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YHY4H0L81zRnmM;
	Tue, 24 Dec 2024 12:45:50 +0100 (CET)
Message-ID: <0e91e811-5f0d-42c5-94be-8dafa575f6cb@kdbg.org>
Date: Tue, 24 Dec 2024 12:45:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [GIT PULL] git-gui: console encoding, no automatic empty-diff-rescan
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit e5033898da23b6e2f6b77320bd0aa613595a50a1:

  Merge branch 'ob/strip-comments-on-commit' (2024-11-09 14:37:45 +0100)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to 5c95773eacee6eeecc16506fad3ca7fe6bf249be:

  Merge branch 'js/no-rescan-on-empty-diff' (2024-12-21 14:06:33 +0100)

This comes with the following feature:

 * No longer show a "No difference detected" popup that must be
   confirmed with a mouse click, but show a message in the diff panel
   instead. The rescan that was started automatically when a popup was
   confirmed must now be requested explicitly. This helps when a rescan
   does not get rid of the empty diffs, such as after a change of the
   core.autocrlf configuration.

There is also a bug fix:

 * Treat the output of git commands that is shown in the console window
   as text in the system encoding instead of as binary bytes.

----------------------------------------------------------------
Johannes Sixt (3):
      git-gui: Remove forced rescan of stat-dirty files.
      Merge branch 'yk/console-encoding'
      Merge branch 'js/no-rescan-on-empty-diff'

Yuri Konotopov (1):
      git-gui: use system encoding to show console output

 git-gui.sh      |  3 ++-
 lib/console.tcl |  2 +-
 lib/diff.tcl    | 26 ++++++--------------------
 3 files changed, 9 insertions(+), 22 deletions(-)
