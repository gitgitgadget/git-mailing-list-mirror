From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/8] valgrind series
Date: Wed, 4 Feb 2009 00:25:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040020380.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfK-00078h-MH
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbZBCXZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbZBCXZY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:40771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751134AbZBCXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:23 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 04 Feb 2009 00:25:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dqBt2dCKdWLm0CV4A0EaDsZEd3hPkWGAe9GJQ1W
	SQzt24zm2lFor1
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108266>

Yes, it has grown a little bit.

The main differences since last time:

- split out some parts that Peff thought were independent of valgrind

- added some convenience, such as "--tee" to output not only to the 
  terminal, but also to files named after the tests

- fixed half a bug in test-lib.sh (the templates were assumed to be 
  located relative to the binaries, not relative to the TEST_DIRECTORY)

- found the cause (sort of) of the spurious zlib "error".  Mark promised 
  that next zlib will contain a fix for that.

- tested.  A lot.

Note: I am not quite sure if the order is okay, but I really spent quite 
some time to reorder and resplit all the patches.

Jeff King (1):
  valgrind: ignore ldso and more libz errors

Johannes Schindelin (7):
  Add valgrind support in test scripts
  Valgrind support: check for more than just programming errors
  test-lib.sh: optionally output to test-results/$TEST.out, too
  t/Makefile: provide a 'valgrind' target
  Add a script to coalesce the valgrind outputs
  Tests: let --valgrind imply --verbose and --tee
  test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH

 t/Makefile              |    5 ++-
 t/README                |   18 +++++++-
 t/test-lib.sh           |   91 +++++++++++++++++++++++++++++++++-
 t/valgrind/.gitignore   |    2 +
 t/valgrind/analyze.sh   |  123 +++++++++++++++++++++++++++++++++++++++++++++++
 t/valgrind/default.supp |   43 ++++++++++++++++
 t/valgrind/valgrind.sh  |   13 +++++
 7 files changed, 290 insertions(+), 5 deletions(-)
 create mode 100644 t/valgrind/.gitignore
 create mode 100755 t/valgrind/analyze.sh
 create mode 100644 t/valgrind/default.supp
 create mode 100755 t/valgrind/valgrind.sh
