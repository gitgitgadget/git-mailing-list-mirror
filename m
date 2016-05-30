From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/6] worktree lock/unlock
Date: Mon, 30 May 2016 17:49:33 +0700
Message-ID: <20160530104939.28407-1-pclouds@gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Klx-0005Cm-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbcE3KuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 06:50:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33396 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbcE3KuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id b124so21436085pfb.0
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUqdhZGJz1p+oWnMTUApfm+WigAklMMptpsGhT9ES2I=;
        b=v0u1LCnDCr7UAKV0zpFAlz4ZUd5btp4ZEIRHRH4h43ro8pOXhS+uvQHWiC9GtiSwWK
         31499pX1Ohw0qxNsopBVXX7gFTBHR3k2Nx+369A4UsZ8eIAkhcs6hkcbhTn/dx2qeuFo
         Zc6rsvBHOEVZb4xJqHbcXQ3J2Lpnpc8iKuyyeCS6HFLnN/9BvYjOJnkaV89gZgiOM4aB
         JgseE92UvbHPjZ6vjVPMQuEeBomDre8tRMcFdUEYWi+o9nkRq6xx6FkAiBowjQZ88maS
         0qAi4pir5nGrwtbvIMsz02Kcl8RAY6wiqgoTqpvmxDsIWt9AgF2u02gAXtmTWSSrCVuu
         1KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUqdhZGJz1p+oWnMTUApfm+WigAklMMptpsGhT9ES2I=;
        b=Nmj4x2SYfWG12pFhUVHlXCUscVveS9S9Jw/eF4pytHZ58dowr2yzogWcbZIF0aEB48
         pyrCex6HnjEr3NfRwvNp5yoYQj17EQlPXc8M07QaMHP3eH//6w3jS+wwk3NqAoof++0m
         1tVEHHLCfR9/a7ch8jYoaivAFPCTNtr9T8THxIU7sMoMpEIYbWUxw9hHRxOH50vwJN0j
         b1EEngH/gdMHzO7pW/ROYblWXiU+iFybOa1benPMyOfsYhjk3qC6XCoyGzeTL8wBxoOr
         w6IBdrllIOc4J5plWyquGSYn5rX6c6iCYMzsbQ/cHtjvtvr59bMH648VAWZfhEkrrwaN
         8fgA==
X-Gm-Message-State: ALyK8tIOEne4GuhWOixcsii/0BXvRRTrNfrOQwsvlrzZQJgLjn5q2RcSS/XaIyQLmfNsTw==
X-Received: by 10.98.149.20 with SMTP id p20mr45381655pfd.95.1464605406593;
        Mon, 30 May 2016 03:50:06 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 74sm32069958pfv.8.2016.05.30.03.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:01 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522104341.656-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295879>

v3 changes almost all patches so I didn't bother with interdiff

  [1/6] worktree.c: add find_worktree()

    This replaces the old find_wortree_by_path(). It now takes both prefix
    and command line argument so it can do some intelligent things with
    them if needed.

  [2/6] worktree.c: find_worktree() learns to identify worktrees by basename

    This is from Eric's suggestion. Here we only care about the "argument"
    argument and ignore the "prefix" argument from 1/6

  [3/6] worktree.c: add is_main_worktree()
 
    This is the only unchanged patch since v2!

  [4/6] worktree.c: retrieve lock status (and optionally reason) in get_worktrees()

    This used to be is_worktree_locked()

  [5/6] worktree: add "lock" command

    Besides Eric's comments in v2, the syntax line "worktree lock <path>"
    is changed to "worktree lock <worktree>", where <worktree> could be
    either a path, or a base name, or something more in future. I'm aware
    that we don't like showing "worktrees" in user documents, favoring
    working trees. But I think <worktree> is ok in this case.

  [6/6] worktree: add "unlock" command

    Pretty much addressing comments from v2 and some more changes because
    of the new 1/6 and 4/6.

 Documentation/git-worktree.txt         | 33 +++++++++++++----
 builtin/worktree.c                     | 66 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh (new +x)      | 62 ++++++++++++++++++++++++++++++++
 worktree.c                             | 53 +++++++++++++++++++++++++++
 worktree.h                             | 14 ++++++++
 6 files changed, 226 insertions(+), 7 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

-- 
2.8.2.524.g6ff3d78
