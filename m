From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/3] Refactor useful notes functions into notes-utils.[ch]
Date: Wed, 12 Jun 2013 02:12:58 +0200
Message-ID: <1370995981-1553-1-git-send-email-johan@herland.net>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org,
	johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 12 02:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYgu-0005AG-OH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 02:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab3FLAN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 20:13:29 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:40184 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309Ab3FLAN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 20:13:28 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so5709113lbi.11
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 17:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9MYP6kPy1LMbY15EPTzc3A7aRBIzMAe6wceibEPEnls=;
        b=fSVdEZS1EkUigwXhPfHIQtzyqfyJ/xEQfrPGr6MNh2LJJRcOQbS59BLr/FbCdQGBAN
         hkiB5MzeJrUunPLuwT5nhiecDH1BNfRTBQ8RG32MdJcef/LWEumPb7H1/VFJnlqTkdYj
         Hl9daUXL6V6w2G5Ax8oZ0McCDec3nqWGd1dJTluXq3mJqzyLtEoZ/JfDEyEQ8HNxEkVb
         gergSTD3fy7W7501C0JKBrKfS8Wj4jlLQ9pD829EBh1sAkR7mdXcfSmCQ12xWxj1SztN
         gInwgMlrw2Xv/9k3s+cf+JAuZIWbwOj+vB8EA8ABc7eXGbZdbn/2pVOXZuAsUTPX3B8/
         n+bQ==
X-Received: by 10.112.168.66 with SMTP id zu2mr9911792lbb.90.1370996006772;
        Tue, 11 Jun 2013 17:13:26 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id x3sm7102525lag.6.2013.06.11.17.13.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 17:13:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227580>

> There is only one right solution.  If a useful function is buried in
> builtin/*.o as a historical accident (i.e. it started its life as a
> helper for that particular command, and nobody else used it from
> outside so far) and that makes it impossible to use the function
> from outside builtin/*.o, refactor the function and its callers and
> move it to libgit.a.

Here goes...

...Johan

Johan Herland (3):
  finish_copy_notes_for_rewrite(): Let caller provide commit message
  Move copy_note_for_rewrite + friends from builtin/notes.c to notes-utils.c
  Move create_notes_commit() from notes-merge.c into notes-utils.c

 Makefile         |   2 +
 builtin.h        |  16 ------
 builtin/commit.c |   3 +-
 builtin/notes.c  | 136 ++---------------------------------------------
 notes-merge.c    |  27 +---------
 notes-merge.h    |  14 -----
 notes-utils.c    | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes-utils.h    |  37 +++++++++++++
 8 files changed, 203 insertions(+), 189 deletions(-)
 create mode 100644 notes-utils.c
 create mode 100644 notes-utils.h

-- 
1.8.1.3.704.g33f7d4f
