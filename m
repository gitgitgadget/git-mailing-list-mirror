From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: autopacking twice?
Date: Sun, 22 Jun 2014 08:51:54 +0300
Message-ID: <20140622055154.GA13819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 07:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyagj-0001Wt-7N
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jun 2014 07:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbaFVFv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 01:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaFVFv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 01:51:28 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5M5pRMu001452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 22 Jun 2014 01:51:27 -0400
Received: from redhat.com (ovpn-116-23.ams2.redhat.com [10.36.116.23])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5M5pPGA021184
	for <git@vger.kernel.org>; Sun, 22 Jun 2014 01:51:26 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252306>

I noticed this:
remote: Counting objects: 302, done.
remote: Compressing objects: 100% (195/195), done.
remote: Total 209 (delta 169), reused 15 (delta 14)
Receiving objects: 100% (209/209), 42.83 KiB | 0 bytes/s, done.
Resolving deltas: 100% (169/169), completed with 67 local objects.
From git://git.qemu.org/qemu
   6baa963..427e175  master     -> origin/master
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
First, rewinding head to replay your work on top of it...
Applying: vhost: block migration if backend does not log memory
Applying: vhost: fix resource leak in error handling
Applying: qapi/hmp: use 'backend' instead of 'device' with memory
backend
Applying: libqemustub: add more stubs for qemu-char
Applying: qtest: fix qtest for vhost-user
Applying: qtest: fix vhost-user-test unbalanced mutex locks
Applying: e1000: emulate auto-negotiation during external link status
change
Applying: e1000: improve auto-negotiation reporting via mii-tool
Applying: e1000: signal guest on successful link auto-negotiation
Applying: e1000: move e1000_autoneg_timer() to after set_ics()
Applying: e1000: factor out checking for auto-negotiation availability
Applying: fixup! libqemustub: add more stubs for qemu-char
Applying: qapi/string-output-visitor: fix human output
Applying: tests: add human format test for string output visitor
Applying: Revert "fixup! libqemustub: add more stubs for qemu-char"
Applying: fixup! libqemustub: add more stubs for qemu-char
warning: notes ref refs/notes/commits is invalid
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.

Why did it auto-pack twice in a single pull?
None of the changes applied are very large.

Guess: auto-packing was started in background, did not
complete in time, and was restarted for the second time?
If true, some kind of lock file would be useful
to prevent this.

-- 
MST
