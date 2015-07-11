From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Fri, 10 Jul 2015 23:57:28 -0700
Message-ID: <CAPc5daWJ7T9UFi_457MvTBN7hoxAD0mEwwbQE1R076=Z+BWu7w@mail.gmail.com>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
 <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com> <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net>
 <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com> <1436596266437-7635513.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: norricorp <john@norricorp.f9.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:57:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDojQ-0001qb-SL
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbbGKG5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:57:49 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34364 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbGKG5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:57:48 -0400
Received: by obbkm3 with SMTP id km3so203349324obb.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WwSo9zV4LozmhpHchyh4LA9xt2RssitjXJXQm1fSeic=;
        b=MZk0Qqp01tViqkvkLJUy1cCFq0eF+RhCU5UavDqUCkpGe9Du9q+UTEG/Snrkc62pCa
         Z02TZ3Tmz3gadJCMpK1bkotL3FXn9v2/1liT0RIy3Jzki08yj5pVNbEnfxXm6YhbbujW
         7hmgKn+rmY89FMwkNr+zLPF/aaUm9k62CcWM+u14HEGCH0zChwV1/Kz0L+OMYSFyL+zP
         0mLlO/KCaaLyrl1SZ0t8eUGIl2OhVR+tnKSSXoUrkvdhHJnFQhLFU+80xliYL8pcxLT9
         Z5XuMufFi1hbI87SeTYXZRyRls4rRHfESSDgtqx6oajHOwHvzidouqcCPRKH+Bfs3Nta
         sjyg==
X-Received: by 10.60.33.74 with SMTP id p10mr23074396oei.62.1436597867969;
 Fri, 10 Jul 2015 23:57:47 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Fri, 10 Jul 2015 23:57:28 -0700 (PDT)
In-Reply-To: <1436596266437-7635513.post@n2.nabble.com>
X-Google-Sender-Auth: wfxZ1UHQ-ZWKOchR9rf-VJr66-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273850>

On Fri, Jul 10, 2015 at 11:31 PM, norricorp <john@norricorp.f9.co.uk> wrote:
>
> This is the output I got from using V=1 with make
> gcc  -g -O2 -I. -D_LARGE_FILES -DNO_D_TYPE_IN_DIRENT -DNO_NSEC -DOLD_ICONV
> -pthread -DHAVE_PATHS_H -DHAVE_
> LIBCHARSET_H -DHAVE_STRINGS_H -DSHA1_HEADER='<openssl/sha.h>'
> -DFREAD_READS_DIRECTORIES -DNO_STRCASESTR -
> DNO_STRLCPY -Icompat/fnmatch -DNO_FNMATCH_CASEFOLD -DUSE_WILDMATCH
> -DNO_MKSTEMPS -DINTERNAL_QSORT -Icompat
> /regex -DDEFAULT_PAGER='"more"' -DSHELL_PATH='"/bin/sh"' -o
> git-credential-store   credential-store.o libg
> it.a xdiff/lib.a  -lz  -liconv -lintl  -lcrypto -pthread
>
> Also, the undefined symbol errors - does anyone know which library these are
> supposed to be in?
> So when I grep for one undefined symbol
> $: git-2.4.5 $ grep -R diff_queued_diff *
> builtin/blame.c:        if (!diff_queued_diff.nr) {
> builtin/blame.c:                for (i = 0; i < diff_queued_diff.nr; i++) {
> builtin/blame.c:                        p = diff_queued_diff.queue[i];
> ......
> builtin/diff.c: diff_queue(&diff_queued_diff, one, two);
> builtin/fast-export.c:  for (i = 0; i < diff_queued_diff.nr; i++)
> builtin/fast-export.c:          if
> (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
> builtin/fast-export.c:
> export_blob(diff_queued_diff.queue[i]->two->sha1);
> ........
> diff.c: struct diff_queue_struct *q = &diff_queued_diff;
> diff.c: struct diff_queue_struct *q = &diff_queued_diff;
>
> So it is obviously a structure or variable that is being used so does anyone
> know the library that this is defined in?

Most of our objects should be found in libgit.a (you can see it on your
command line) that our Makefile builds.

Now, it has been more than a decade since I last had to deal with a
system that needs this the last time, but perhaps AIX linker needs the
archives explicitly prepared with ranlib(1)? Just a shot in the dark...
