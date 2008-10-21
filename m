From: Paul Mackerras <paulus@samba.org>
Subject: git command to read
Date: Tue, 21 Oct 2008 22:21:09 +1100
Message-ID: <18685.47909.354146.487700@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:22:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFJl-0004Jm-4j
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbYJULVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYJULVR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:21:17 -0400
Received: from ozlabs.org ([203.10.76.45]:47062 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbYJULVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:21:16 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7E85DDDDE1; Tue, 21 Oct 2008 22:21:15 +1100 (EST)
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98775>

Junio,

Is there a command in git at the moment that will read commit IDs on
standard input and print the contents of each commit on standard
output (without waiting for EOF on stdin)?

I tried git rev-list --stdin --no-walk --header, but it seems to
collect all the IDs from stdin and eliminate duplicates before
outputting anything, which is not what I want.  What I want is a
process that I can run from gitk where I can write IDs to its stdin
whenever gitk needs to know the contents of some commits, and know
that those contents will be turning up on the pipe from its stdout in
a timely fashion, without having to start a new process each time.  Is
there a way to do that currently?

The reason I want this is to reduce gitk's memory usage.  At present
it reads all the commits into memory, which takes about 160MB on the
current kernel tree just to store the contents of all the commits
(since Tcl stores strings internally as 2 bytes/character).  Instead I
plan to make gitk keep a cache of commits and read in commits as
needed from an external process.  When doing a search, we may need to
read in nearly all the commits, and we'll need to do it quickly.

Thanks,
Paul.
