From: Stephan Beyer <s-beyer@gmx.net>
Subject: git-rebase-i migration to sequencer
Date: Tue,  1 Jul 2008 04:39:26 +0200
Message-ID: <1214879968-17944-1-git-send-email-s-beyer@gmx.net>
References: <1214879914-17866-5-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 04:40:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVnG-0005Ky-IP
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727AbYGACjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbYGACjf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:39:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:54674 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756431AbYGACje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:39:34 -0400
Received: (qmail invoked by alias); 01 Jul 2008 02:39:32 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp064) with SMTP; 01 Jul 2008 04:39:32 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19IsTVeE7FIDSYWgxDnbhGU1+tRygTsD+a69/c/am
	EtoWeGCIZEUKL0
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KDVmC-0004fr-Q8; Tue, 01 Jul 2008 04:39:28 +0200
X-Mailer: git-send-email 1.5.6.1.130.ga8860.dirty
In-Reply-To: <1214879914-17866-5-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86991>

Hi,

the patches for rebase-i migration follow.

Why this intermediate mail?
Because the patches will not apply to master/next/pu/whatever.
It needs js/rebase-i-sequencer, that is "dropped for now" from
git.git.  So you have to do some extra work to apply.

Well, I could've just added a "Squashed js/rebase-i-sequencer patch"
or something, but
 1. I didn't write the patches so I don't want to claim I'm the author,
 2. It's an opportunity to try sequencer, as follows:

If you still have the commits (a freshly cloned repo hasn't),
you can do:

git sequencer <<EOF
#pick 367bcc9cbc3d903c076f # optional: "fake-editor: output TODO list if unchanged"
pick 0fa413ebc6e073a52d88
pick -R 88b1f0b8094638b1f953 # just to prevent a silly conflict
pick 966fdf0ab272a64250fb
pick 45d6022d611fd86a13c5
pick 051e0cfb88cd1d2a24bd
# note: the following patches will make t3404 fail until migration to sequencer
pick d9711a80796fd00169ca
pick 10046a6f8adaccac0ea1
pick abe32eafcd8302c387ed
pick d481bcc93f393bbfaaef
pick dbcd70439f697deeb317
pick b1ba88d812434a51889f
pick cc76fdac36ff25eaa77b
pick f8e037d76a224bd87236
pick 777790a3bdfeb91ee4a6
pick 7cdf70106412f44b9116
pick 14a4f1e0a804ccc905d7
EOF

If this results in a lot of "is not a commit" errors, then do
	git sequencer --abort
	(You may also have a look at git sequencer --status, if you like)
and fetch the missing commits:
	git fetch git://repo.or.cz/git/sbeyer.git seq-proto-dev2
and then redo the example above.

When the patches are applied, the following patches will apply, too.

Regards,
  Stephan

PS: Sorry, for the nastiness of the patch application ;-)
