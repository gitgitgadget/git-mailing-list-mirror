From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 0/2] merge --summary vs. merge.summary
Date: Thu,  3 Apr 2008 11:03:14 +0200
Message-ID: <1207213396-17370-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLSB-0005iF-6d
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYDCJJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:09:07 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbYDCJJG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:09:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50697 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbYDCJJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:09:06 -0400
Received: from elysium (p5B133679.dip0.t-ipconnect.de [91.19.54.121])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1JhLLp0gGI-0000q7; Thu, 03 Apr 2008 11:03:19 +0200
Received: from fzi.de (neumann.wired [192.168.1.2])
	by elysium (Postfix) with SMTP id BC0FA1241FE;
	Thu,  3 Apr 2008 11:03:16 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.rc2.38.g3b417
X-Provags-ID: V01U2FsdGVkX1++cGXIeIfdT05afFZrgTyGpka0zwhqVTlg4FE
 PrVVFpS1tHSwimJ74dEU7JROkfyjqhiNSJ87P4TdOi+SE80L+S
 z9LsG04Addxw3zn5yfwCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78735>

The documentation of 'git merge' says the following:

    --summary
    	Show a diffstat at the end of the merge. The diffstat is also
    	controlled by the configuration option merge.diffstat.
   =20
    -n, --no-summary
    	Do not show diffstat at the end of the merge.

and

    merge.summary
	Whether to include summaries of merged commits in newly created
	merge commit. False by default.

So the '--summary' option controls the printing of diffstat, while the
'merge.summary' config variable controls the behaviour of 'fmt-merge-ms=
g',
and '--summary' and 'merge.diffstat' are controlling the same thing.  T=
his
is inconsistent and quite confusing.  In fact, it took me quite a while=
 to
figure out, how Junio generates those nice merge commit messages, as I
have never actually read the meaning of 'merge.summary', thinking that =
it
must do the same as '--summary'.

These two patches will resolve this issue.


Best,
G=C3=A1bor



SZEDER G=C3=A1bor (2):
  merge, pull: rename '--summary' option to '--diffstat'
  merge, pull: add option to put summary into the merge commit message

 Documentation/git-merge.txt            |    2 +-
 Documentation/merge-options.txt        |   13 +++++++++++--
 contrib/completion/git-completion.bash |    3 ++-
 git-merge.sh                           |   18 +++++++++++++-----
 git-pull.sh                            |   24 ++++++++++++++----------
 t/t7600-merge.sh                       |   22 ++++++++++++++++++----
 6 files changed, 59 insertions(+), 23 deletions(-)
