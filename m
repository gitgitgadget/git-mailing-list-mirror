From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-diff-files -z output
Date: Sun, 22 May 2005 19:05:40 +0200
Message-ID: <20050522170540.GO15178@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 19:06:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZttk-0000LE-TQ
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVEVRG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVEVRG7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:06:59 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:62406 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261833AbVEVRFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:05:41 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MH5eS8016501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 17:05:40 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MH5eHE016500
	for git@vger.kernel.org; Sun, 22 May 2005 19:05:40 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
is this correct?

(faui00u) [~/work/git/yagf] git-diff-files -z | xxd
0000000: 3a31 3030 3634 3420 3030 3030 3030 2031  :100644 000000 1
0000010: 6663 3834 3639 6366 6332 6631 3436 3332  fc8469cfc2f14632
0000020: 3734 3333 3363 3062 6562 6162 3065 3465  74333c0bebab0e4e
0000030: 3439 3562 6336 6220 3030 3030 3030 3030  495bc6b 00000000
0000040: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
0000050: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
0000060: 0064 6966 662e 6800 6469 6666 2e68 003a  .diff.h.diff.h.:
0000070: 3130 3037 3535 2031 3030 3735 3520 6464  100755 100755 dd
0000080: 3633 6533 3535 3463 3137 6431 3861 3039  63e3554c17d18a09
0000090: 3137 3931 3038 3264 3164 3632 3864 3835  1791082d1d628d85
00000a0: 3162 3933 3038 2030 3030 3030 3030 3030  1b9308 000000000
00000b0: 3030 3030 3030 3030 3030 3030 3030 3030  0000000000000000
00000c0: 3030 3030 3030 3030 3030 3030 3030 3000  000000000000000.
00000d0: 6769 7400 6769 7400                      git.git.

Eg the fields are seperated by space/tab and only the filenames by \0?

I am adopting to the new format.

Are the fields supposed to be seperated by space or tab?

static void diff_flush_raw(struct diff_filepair *p)
{
        /*
         * We used to reject rename/copy but new diff-raw can express them.
         */
        printf(":%06o %06o %s ",
               p->one->mode, p->two->mode, sha1_to_hex(p->one->sha1));
        printf("%s%c%s%c%s%c",
               sha1_to_hex(p->two->sha1), inter_name_termination,
               p->one->path, inter_name_termination,
               p->two->path, line_termination);
}


Gruesse,
	Thomas
