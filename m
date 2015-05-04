From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 0/3] git help: group common commands by theme
Date: Mon,  4 May 2015 22:28:07 +0200
Message-ID: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 22:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpMya-0001lx-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 22:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbbEDU2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 16:28:25 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35457 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbEDU2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 16:28:23 -0400
Received: by widdi4 with SMTP id di4so135220325wid.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=r+fivPSk3TIK3sBqVMdVi9ZjdarxmJkj3jkrLhVAx3M=;
        b=neN7vARCi2U+CtSH+sW3OAkcu0XCevyCOkK02QeY8m2OExkMr7EYMfstRHUtvLD6H9
         aF6L4L/fI5waRQrEBoE2WH2jMw9DJGvLmdWztrxxiRqwywMJ+Lm0fOPP1sKJKcA/9Lco
         1HIpV6n8BFsOfp2xW4s9pAVfgTz38iUcSQoCg7qRO7Wg4WhZUAfVekx4r/CG10g7crqn
         /gpKzj2Iiok7zuT8DLXoj7Bkt3biudHCoDkkDBqcjnyl9C65I4uy88TGjoT6JXmdq3oY
         bdV0uQ2j9z1Evd+fgSJI1sbvSVhJ2qg+ZtXKzP2usTHzPnVYMgFbM8CtHO2RBxP7yINZ
         47mA==
X-Received: by 10.180.108.147 with SMTP id hk19mr499882wib.51.1430771302741;
        Mon, 04 May 2015 13:28:22 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id xb3sm22164354wjc.38.2015.05.04.13.28.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 13:28:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268348>

This v4 includes the following suggestions:

In command-list.txt:
- Add a [groups] block containing names and description for groups:

   [groups]
   init                   starting a working area
   worktree               working on the current change
   remote                 working with others
   info                   examining the history and state
   history                growing, marking and tweaking your history

- Add a [commands] header on top of the known command list, and
  group names as a third column.

   [commands]
   git-add            mainporcelain                common-worktree
   git-am             mainporcelain
   git-annotate       ancillaryinterrogators
   git-apply          plumbingmanipulators
   git-archimport     foreignscminterface
   git-archive        mainporcelain
   git-bisect         mainporcelain
   git-blame          ancillaryinterrogators
   git-branch         mainporcelain                common-history

This produces the following output of $ git help:

[...]
The most commonly used git commands are:

   * starting a working area:
      clone      Clone a repository into a new directory
      init       Create an empty Git repository or reinitialize [...]

   * working on the current change:
      add        Add file contents to the index
      reset      Reset current HEAD to the specified state

   * working with others:
      fetch      Download objects and refs from another repository
      pull       Fetch from and integrate with another repository [...]
      push       Update remote refs along with associated objects

   * examining the history and state:
      log        Show commit logs
      status     Show the working tree status

   * growing, marking and tweaking your history:
      branch     List, create, or delete branches
      checkout   Checkout a branch or paths to the working tree
      commit     Record changes to the repository
      diff       Show changes between commits, commit and working [...]
      merge      Join two or more development histories together
[...]

I removed from the list of common commands: rebase, rm, mv, bisect=20
because [1] they are not really common to an unfamiliar user, [2] to
save vertical space occupied by group headers.

Thanks to Junio and Eric for their suggestions.

S=C3=A9bastien Guimmara (3):
  command-list.txt: group common commands by theme
  generate-cmdlist.sh: parse common group commands
  git help: group common commands by theme

 command-list.txt    | 64 +++++++++++++++++++++++++++++++--------------=
--------
 generate-cmdlist.sh | 43 +++++++++++++++++++++++++----------
 help.c              | 28 ++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 40 deletions(-)

--=20
2.4.0
