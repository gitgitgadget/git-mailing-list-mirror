From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/8] Support coverage testing with GCC/gcov
Date: Thu, 19 Feb 2009 12:13:34 +0100
Message-ID: <cover.1235041345.git.trast@student.ethz.ch>
References: <7v7i3nqk0x.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sE-00008u-Ta
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZBSLNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbZBSLNy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:13:54 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbZBSLNy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:13:54 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <7v7i3nqk0x.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0134 (UTC) FILETIME=[25530A60:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110672>

Junio C Hamano wrote:
> [Will merge to 'next' soon]
> 
> * tr/gcov (Sun Feb 15 23:25:45 2009 +0100) 8 commits
>  - Test git-patch-id
>  - Test rev-list --parents/--children
>  - Test log --decorate
>  - Test fsck a bit harder
>  - Test log --graph
>  - Test diff --dirstat functionality
>  - Test that diff can read from stdin
>  - Support coverage testing with GCC/gcov

I noticed two small things that I'd like to fix before this goes
'next', so here they are:

* [1/8] Support coverage testing with GCC/gcov

  Changed it so the compilation (but not the testing) uses the same -j
  flags as the caller, so that compilation can be done in parallel.
  (It's rather minor compared to the slow testing with optimizations
  turned off, but still.)

* [5/8] Test fsck a bit harder

  Fixed an invocation of hash-objects that lacked --stdin.  I also
  added some debugging cats to make it easier to fix the grep
  invocation when fsck actually starts printing errors for these
  corruptions.

Apart from that it's the same.

Thanks!


Thomas Rast (8):
  Support coverage testing with GCC/gcov
  Test that diff can read from stdin
  Test diff --dirstat functionality
  Test log --graph
  Test fsck a bit harder
  Test log --decorate
  Test rev-list --parents/--children
  Test git-patch-id

 Makefile                                      |   24 ++++
 t/t1450-fsck.sh                               |   67 +++++++++++
 t/t4002-diff-basic.sh                         |    8 ++
 t/t4013-diff-various.sh                       |    5 +
 t/t4013/diff.diff_--dirstat_master~1_master~2 |    3 +
 t/t4013/diff.log_--decorate_--all             |   34 ++++++
 t/t4013/diff.rev-list_--children_HEAD         |    7 +
 t/t4013/diff.rev-list_--parents_HEAD          |    7 +
 t/t4202-log.sh                                |  148 +++++++++++++++++++++++++
 t/t4203-patch-id.sh                           |   38 +++++++
 10 files changed, 341 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.diff_--dirstat_master~1_master~2
 create mode 100644 t/t4013/diff.log_--decorate_--all
 create mode 100644 t/t4013/diff.rev-list_--children_HEAD
 create mode 100644 t/t4013/diff.rev-list_--parents_HEAD
 create mode 100755 t/t4203-patch-id.sh
