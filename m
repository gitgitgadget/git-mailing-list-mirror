From: norricorp <john@norricorp.f9.co.uk>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Fri, 10 Jul 2015 23:31:06 -0700 (MST)
Message-ID: <1436596266437-7635513.post@n2.nabble.com>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net> <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com> <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net> <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 08:37:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDoPo-0007M2-Nt
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbGKGhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:37:32 -0400
Received: from mwork.nabble.com ([162.253.133.43]:61186 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbbGKGhb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:37:31 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2015 02:37:31 EDT
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 2276D2334191
	for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:31:06 -0700 (PDT)
In-Reply-To: <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273845>

This is the output I got from using V=1 with make
gcc  -g -O2 -I. -D_LARGE_FILES -DNO_D_TYPE_IN_DIRENT -DNO_NSEC -DOLD_ICONV
-pthread -DHAVE_PATHS_H -DHAVE_ 
LIBCHARSET_H -DHAVE_STRINGS_H -DSHA1_HEADER='<openssl/sha.h>' 
-DFREAD_READS_DIRECTORIES -DNO_STRCASESTR - 
DNO_STRLCPY -Icompat/fnmatch -DNO_FNMATCH_CASEFOLD -DUSE_WILDMATCH
-DNO_MKSTEMPS -DINTERNAL_QSORT -Icompat 
/regex -DDEFAULT_PAGER='"more"' -DSHELL_PATH='"/bin/sh"' -o
git-credential-store   credential-store.o libg 
it.a xdiff/lib.a  -lz  -liconv -lintl  -lcrypto -pthread 

Also, the undefined symbol errors - does anyone know which library these are
supposed to be in?
So when I grep for one undefined symbol
$: git-2.4.5 $ grep -R diff_queued_diff * 
builtin/blame.c:        if (!diff_queued_diff.nr) { 
builtin/blame.c:                for (i = 0; i < diff_queued_diff.nr; i++) { 
builtin/blame.c:                        p = diff_queued_diff.queue[i]; 
...... 
builtin/diff.c: diff_queue(&diff_queued_diff, one, two); 
builtin/fast-export.c:  for (i = 0; i < diff_queued_diff.nr; i++) 
builtin/fast-export.c:          if
(!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode)) 
builtin/fast-export.c:                 
export_blob(diff_queued_diff.queue[i]->two->sha1); 
........ 
diff.c: struct diff_queue_struct *q = &diff_queued_diff; 
diff.c: struct diff_queue_struct *q = &diff_queued_diff; 

So it is obviously a structure or variable that is being used so does anyone
know the library that this is defined in?




--
View this message in context: http://git.661346.n2.nabble.com/Building-git-2-4-5-on-AIX-6-1-problems-tp7635435p7635513.html
Sent from the git mailing list archive at Nabble.com.
