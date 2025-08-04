Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3467165F13
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325224; cv=none; b=Y1sRyEjAGjeJOeAsW52ouWxTpTOxKhKTwx/pNRYce3pm0020cteKKDs1jsTZ4E43CuRRsp3EdKIR2gLvqvLLKCfLZZPg5DBc24NP+u9KtG47/69Wq7jJ6V6FG7dkfkegQ87M6LCD4x6w6tmVgb+PjTd7Oel9QDW4rNTvsIeAPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325224; c=relaxed/simple;
	bh=nL0C92n5rPLCCcEKZ0k629qg0WE455+3rpP7gN7GlMg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ikWWgEJ79jrhw5JW2Z/zFE2I6iDhSnE2sSD2RgN12/3RxMQCM8fwBugrezHb3KMKFGzrJkkdovAY2CMI4C6i3ZRrJukOuCu3Sgcp9nAnMFRao+hwRvrkHdzcioc8d5Yi9MUYKz1/ovbnpQ3OIiK0Qd9yN1LKm3HT8Hq5QaAFYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4bwhvK50hLzRnmN;
	Mon,  4 Aug 2025 18:33:33 +0200 (CEST)
Message-ID: <e4feeed9-2807-4e6b-9641-350d91a97a59@kdbg.org>
Date: Mon, 4 Aug 2025 18:33:33 +0200
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
Subject: [GIT PULL] git-gui: Tcl-9, no 8.6 on macOS, polish Windows, clean msg
 after hooks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 436dad00c5a717d56bf4feb8a1f5d39126579fe6:

  Merge branch 'ml/abandon-old-versions' (2025-07-22 17:37:33 +0200)

are available in the Git repository at:

  https://github.com/j6t/git-gui.git master

for you to fetch changes up to e3923e3e90da55e12545b5ef5aa34f21e97409d8:

  Merge branch 'cb/no-tcl86-on-macos' (2025-08-04 18:27:03 +0200)

----------------------------------------------------------------
Alexander Shopov (2):
      git-gui i18n: Update Bulgarian translation (557t)
      git-gui i18n: Remove the locations within the Bulgarian translation

Carlo Marcelo Arenas Belón (5):
      git-gui: remove uname_O in Makefile
      git-gui: fix dependency of GITGUI_MAIN on generator
      git-gui: retire Git Gui.app
      git-gui: honor TCLTK_PATH in git-gui--askpass
      git-gui: ensure own version of git-gui--askpass is used

Johannes Sixt (5):
      Merge branch 'ml/windows-tie-loose-ends'
      Merge branch 'master' of https://github.com/alshopov/git-gui
      Merge branch 'ml/tcl90'
      Merge branch 'strip-post-hooks' of github.com:orgads/git-gui
      Merge branch 'cb/no-tcl86-on-macos'

Mark Levedahl (13):
      git-gui: do not add directories to PATH on Windows
      git-gui: let nice work on Windows
      git-gui: Windows tk_getSaveFile is not useful for shortcuts
      git-gui: use /cmd/git-gui.exe for shortcut
      git-gui: assure -eofchar {} on all channels
      git-gui: translation binary defines iso8859-1
      git-gui: replace encoding binary with iso8859-1
      git-gui: do not mix -translation binary and -encoding
      git-gui: remove EOL translation for gets
      git-gui: themed.tcl: use full namespace for color
      git-gui: use -profile tcl8 for file input with Tcl 9
      git-gui: use -profile tcl8 on encoding conversions
      git-gui: Allow Tcl 9.0

Orgad Shaneh (1):
      git-gui: strip the commit message after running commit-msg hook

 .gitignore                              |   2 +-
 GIT-GUI-BUILD-OPTIONS.in                |   1 -
 Makefile                                |  61 +--
 generate-macos-app.sh                   |  30 --
 generate-macos-wrapper.sh               |  35 --
 generate-script.sh                      |  22 +
 git-gui--askpass => git-gui--askpass.sh |   0
 git-gui.sh                              |  58 ++-
 lib/blame.tcl                           |   9 +-
 lib/branch.tcl                          |   4 +-
 lib/browser.tcl                         |   2 +-
 lib/checkout_op.tcl                     |   2 +-
 lib/choose_rev.tcl                      |   4 +-
 lib/commit.tcl                          |  83 ++--
 lib/diff.tcl                            |   3 +-
 lib/index.tcl                           |   3 -
 lib/mergetool.tcl                       |   4 +-
 lib/remote_branch_delete.tcl            |   1 -
 lib/shortcut.tcl                        |  52 ++-
 lib/spellcheck.tcl                      |   1 -
 lib/themed.tcl                          |   8 +-
 macosx/AppMain.tcl                      |  29 --
 macosx/Info.plist                       |  30 --
 macosx/git-gui.icns                     | Bin 28866 -> 0 bytes
 meson.build                             |  79 +---
 po/bg.po                                | 714 +-------------------------------
 windows/git-gui.sh                      |  12 +-
 27 files changed, 197 insertions(+), 1052 deletions(-)
 delete mode 100755 generate-macos-app.sh
 delete mode 100755 generate-macos-wrapper.sh
 create mode 100755 generate-script.sh
 rename git-gui--askpass => git-gui--askpass.sh (100%)
 delete mode 100644 macosx/AppMain.tcl
 delete mode 100644 macosx/Info.plist
 delete mode 100644 macosx/git-gui.icns
