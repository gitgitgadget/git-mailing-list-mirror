From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Sat, 23 Apr 2016 01:51:06 +0200
Message-ID: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 01:51:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atkrO-0007Rh-PI
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 01:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbcDVXv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 19:51:29 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:33010 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbcDVXv0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 19:51:26 -0400
Received: by mail-qg0-f68.google.com with SMTP id 7so10698590qgj.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 16:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5rsG8QuNWGXaRjZne71JBGHBdA4xDE1UjUbOEw1Lvvg=;
        b=PfmyzqiZgTaBiAZXggJGSGCetlDttvKRqP8EowxpMicK1bPVIkPW1ft+I0mnT0ZmCk
         4OmbB+pbqr/05J6b94RmLi4ly25K57nJdACshknUXdEVro6T1p2qzsIBXTsOhInEw57s
         B1vm/GqCT1SS7aa+/JAQpoUjBfV+wAdCTxYf0a9Iiy3f7k2Jp/oGW289UUCNbIhjoJBX
         a19DObrfZ1h8kWN4pBhFgqQxv34lr2JyCrbl1c3p2rtXU4Kz63yFSbs3y1QXlmULUSgN
         UBeO+9XTY1qNb0rwMmfBXgHQI35/gy79z24qsKsLGTHFW2OOOlpRwkwAe+A1U0maRJ8z
         mZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5rsG8QuNWGXaRjZne71JBGHBdA4xDE1UjUbOEw1Lvvg=;
        b=ORW51sH4c6q7S8NssRtZqqQJqCOII3SsKSeG2nqTdDAG+vMjryOPBHmZ06Kq1kCyXy
         p1p15jNMZyEkR6rl3srpiyz2d6vHfKkLgBchIQvpwkzsD2gDCqfGS07uQ/rCcOUyBkHm
         TobIhm6xk+M7vPgq3h/jjopuBjo3RAyronXAaG/AYf/KV+Vs9lLZCJTfIjpZhUUVriiY
         qBy6006OYancAQtbN+wVzUDTZg1g2873DoTUL/T245MG8kEvPfVwryKtBjfE5VHiZPvQ
         eN3Xri6WDgoAN2MFErMK5zPwYBMnajxbrWNwDsV1X4u+cLBj8vodFBtosmgLDaFUYQbU
         FiBQ==
X-Gm-Message-State: AOPr4FVZ/D/5Aq+eWNoCQxaZ4ewFYUHnv7dIl5VUbliTcuV1rPJkx4tBRsmzYfBoGQRy5vQZeT29dwUhvL8UHA==
X-Received: by 10.140.142.144 with SMTP id 138mr25272991qho.84.1461369085799;
 Fri, 22 Apr 2016 16:51:25 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Fri, 22 Apr 2016 16:51:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292291>

On Sat, Apr 23, 2016 at 1:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change the hardcoded lookup for .git/hooks/* to optionally lookup in
> $(git config core.hooksDirectory)/* instead if that config key is set=
=2E

I think this'll do for my use-case, but I started with a rather more
ambitious patch that I could forsee not finishing today.

I wanted to support executing e.g. the pre-commit hook, in order, from =
any of:

    .git/hooks/pre-commit
    .git/hooks/pre-commit.d/*
     [We could add some ~-wide path here I guess...]
     /etc/git/hooks/pre-commit
     /etc/git/hooks/pre-commit.d/*

Where the * would be resolved in glob() order.

The motivation was solving the use-case I'm solving with
core.hooksDirectory, perhaps with a config variable to set whether you
wanted to skip per-repo or system-wide hooks, but also having
something more general.

The reason for supporting the *.d directories was that I spotted a lot
of hooks people had hacked up at work using the pee(1) command[1] to
run sequences of other unrelated hook commands.

Just symlinking stuff is simpler and more portable if we do the work
in git.git once. We'd run  The pee(1) command also doesn't quit on the
first command that returns nonzero, which would make sense e.g. for
pre-commit hooks.

I have it working for the hooks that use the simple run_hook_ve()
interface, but the ones that have to e.g. pass input on stdin just
find_hook() directly & do a custom run_command(), so all of those
callsites would have to be patched and/or I'd have to hack up some
custom callback mechanism.

1. http://manpages.ubuntu.com/manpages/xenial/en/man1/pee.1.html
