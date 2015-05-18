From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v8 0/5] group common commands by theme
Date: Mon, 18 May 2015 21:18:12 +0200
Message-ID: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 21:18:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQYV-0000u6-CH
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbbERTSW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 15:18:22 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:32792 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbbERTSW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:18:22 -0400
Received: by wicmx19 with SMTP id mx19so95623551wic.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=eU8bCa3EwQ2dmR610Kh5ojlrtrmq3X1COkF7+RMo3xI=;
        b=bdCKCLIvYfwZjXTxGO+y51TZkVasZcZV6MocYILjlX4UlHENGcv3m+0fkIA++arNDD
         nc+lcQ1bZj5pUNGFEDd9JKNj3gAeQZdZ4okGzL3dcMu/qkdNmE+lErfZJ062uIHaunjw
         HpQxEnLmwZN2LpksZEcpZyBroDMB5yq7tuXgWQClxiiqCo6ElHnWoafUdOIhYnP3CkOf
         msgeWF//oSz5mCUpcBksbzTN4r91w/P9lpkG1NKSCfoKqIEUiIXnM8fiVdRykNaTplKx
         isflgmY5NNzUnetrnPBSGHKiQRo5Hl18eHypfBXFdNw+RXz0569VzI8j1ZhM0IzTlvMs
         WSGg==
X-Received: by 10.195.13.70 with SMTP id ew6mr47795330wjd.59.1431976700906;
        Mon, 18 May 2015 12:18:20 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id z12sm18259450wjq.12.2015.05.18.12.18.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 12:18:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269305>

No major improvement over v7 [1], this v8 drops the [common] and=20
[commands] headers, instead relying on commented headers=20
"### command list" and "### common groups." to avoid ulgy looking=20
sed/awk parsing.

generate-cmdlist.awk: slight modification to allow parsing of those
headers.

git help: the colon at the end of each group is dropped.

Summary: to help unfamiliar users grok the Git workflow, rework the=20
output of 'git help' by grouping the commands by theme:

   The typical Git workflow includes:

   start a working area (see also: git help tutorial)
      clone      Clone a repository into a new directory
      init       Create an empty Git repository or reinitialize an [...=
]

   work on the current change (see also: git help everyday)
      add        Add file contents to the index
      mv         Move or rename a file, a directory, or a symlink
      reset      Reset current HEAD to the specified state
      rm         Remove files from the working tree and from the index
   [...]

This series depends on bf990a2 (command-list: fix whitespace=20
inconsistency)[2]

[1] http://thread.gmane.org/gmane.comp.version-control.git/269167
[2] http://thread.gmane.org/gmane.comp.version-control.git/268649

Eric Sunshine (2):
  command-list: prepare machinery for upcoming "common groups" section
  generate-cmdlist: parse common group commands

S=C3=A9bastien Guimmara (3):
  command-list.txt: add the common groups block
  command-list.txt: drop the "common" tag
  help: respect new common command grouping

 Documentation/cmd-list.perl |  4 ++++
 Makefile                    |  9 ++++----
 command-list.txt            | 53 +++++++++++++++++++++++++++----------=
--------
 generate-cmdlist.awk        | 39 +++++++++++++++++++++++++++++++++
 generate-cmdlist.sh         | 23 --------------------
 help.c                      | 24 +++++++++++++++++++-
 6 files changed, 103 insertions(+), 49 deletions(-)
 create mode 100644 generate-cmdlist.awk
 delete mode 100755 generate-cmdlist.sh

--=20
2.4.0.GIT
