From: Christian Couder <christian.couder@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Mon, 1 Jun 2015 01:14:41 +0200
Message-ID: <CAP8UFD1rKmKgKqCsffCLyOCny3JEACxgmBN_eqOj_=3zBW-MZg@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com>
	<CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
	<CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
	<CAKRnqNJnaLioQPWYDmSiBfLCSMGdFR21bAEXRzdpkChDBf2wgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 01:14:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzCRO-0003ZO-2c
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 01:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489AbbEaXOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 19:14:43 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36407 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbEaXOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 19:14:43 -0400
Received: by wibdq8 with SMTP id dq8so13942897wib.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=46HGAdVxs6250+L1PswxF6Cafuhr6sucQnVXLiG/ReE=;
        b=SAh7l+sGxm7B8Q1fzzcRogY6L3oLJdBKFg6P2+/ABm3bUCNZn5eU2qWA0fx5WCA0VC
         V9L/tFjewelmr2h/YSd4iTQHOUcWpKjJmDWquYMYvlTpUXixaPWnYgxUF2YXYkSH2jkV
         nMqoZRwvx0z7rwzE8pnH6pt8gUfibZCw8pBJVK/KgEVPkv9VDeaFc8KaujP0y0FqJkOA
         qv3+/Tv45OFmxSFphuaUjXtH4oF9p1H3vJCblhNV9nZT2sfSjlhPuTSaACc44TBKy7HW
         SzjnesQWb+erF070GZqsgOzMp+wSA2oAmZq0Slxz1yY6BeyiMTxyAdfAfqvdEZrvdjNs
         SLxg==
X-Received: by 10.180.88.99 with SMTP id bf3mr15273677wib.75.1433114081923;
 Sun, 31 May 2015 16:14:41 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 16:14:41 -0700 (PDT)
In-Reply-To: <CAKRnqNJnaLioQPWYDmSiBfLCSMGdFR21bAEXRzdpkChDBf2wgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270366>

On Sun, May 31, 2015 at 10:45 PM, Bruce Korb <bruce.korb@gmail.com> wrote:
> Oh, you can also clone the gnu-pw-mgr and likely get the same result:

Yeah, after cloning from http://git.savannah.gnu.org/r/gnu-pw-mgr.git
I get the following backtrace:

Program received signal SIGSEGV, Segmentation fault.
0x00000000004b26b1 in clear_commit_marks_1 (plist=0x7fffffffbf78,
commit=0x84e8d0, mark=139) at commit.c:528
528                     while ((parents = parents->next))
(gdb) bt
#0  0x00000000004b26b1 in clear_commit_marks_1 (plist=0x7fffffffbf78,
commit=0x84e8d0, mark=139) at commit.c:528
#1  0x00000000004b2743 in clear_commit_marks_many (nr=-1,
commit=0x7fffffffbfa0, mark=139) at commit.c:544
#2  0x00000000004b2771 in clear_commit_marks (commit=0x84e8d0,
mark=139) at commit.c:549
#3  0x00000000004537cc in get_patch_ids (rev=0x7fffffffd190,
ids=0x7fffffffc910) at builtin/log.c:832
#4  0x0000000000455580 in cmd_format_patch (argc=1,
argv=0x7fffffffdc20, prefix=0x0) at builtin/log.c:1425
#5  0x0000000000405807 in run_builtin (p=0x80cac8 <commands+840>,
argc=5, argv=0x7fffffffdc20) at git.c:350
#6  0x0000000000405a15 in handle_builtin (argc=5, argv=0x7fffffffdc20)
at git.c:532
#7  0x0000000000405b31 in run_argv (argcp=0x7fffffffdafc,
argv=0x7fffffffdb10) at git.c:578
#8  0x0000000000405d29 in main (argc=5, av=0x7fffffffdc18) at git.c:686

(Please don't top post if you reply to this email as it is frown upon
on this list.)
