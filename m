From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 16:20:24 +0200
Message-ID: <20080728142023.GC6701@neumann>
References: <20080721002354.GK10151@machine.or.cz>
	<20080721002508.26773.92277.stgit@localhost>
	<7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 16:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNTbM-00046U-Ss
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 16:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYG1OU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 10:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbYG1OU0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 10:20:26 -0400
Received: from francis.fzi.de ([141.21.7.5]:50933 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751375AbYG1OU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 10:20:26 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 28 Jul 2008 16:20:23 +0200
Content-Disposition: inline
In-Reply-To: <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 28 Jul 2008 14:20:23.0712 (UTC) FILETIME=[12EDD200:01C8F0BD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90462>

Hi,

there is a race somewhere in these 'git-mv: Keep moved index entries
inact' changes.

The test cases 'git mv should overwrite symlink to a file' or 'git mv
should overwrite file with a symlink' fail occasionaly.  It's quite
non-deterministic:  I have run t7001-mv.sh in a loop (see below) and
one or the other usually fails around 50 runs (but sometimes only
after 150).  Adding some tracing echos to the tests shows that both
tests fail when running 'git diff-files' at the end.

Regards,
G=E1bor


---
#!/bin/bash

ret=3D0
i=3D0
while test $ret =3D 0 ; do
        GIT_TEST_OPTS=3D'--verbose --debug' make t7001-mv.sh
        ret=3D$?
        i=3D$((i+1))
done
echo "Failed at ${i}th run"
