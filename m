From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Fix longstanding "git am" bug
Date: Thu,  4 Dec 2008 18:22:56 -0800
Message-ID: <1228443780-3386-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 03:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QMj-0002RA-Ba
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbYLECXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbYLECXG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYLECXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 200F9846D5
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 77FBF846D4 for
 <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:02 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.60.g1d1d7
X-Pobox-Relay-ID: A4B2CE42-C273-11DD-BA9E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102390>

Simon Schubert rerolled a patch to add "git am --directory=<dir>" from
three months ago, which is a good complement to existing "git am -p<n>",
but it had the same issue of duplicating an existing bug to the new feature.

Let's fix the existing bug first, before accepting any new feature, which
will happen after 1.6.1 goes final.

Junio C Hamano (4):
  git-am --whitespace: do not lose the command line option
  git-am: propagate -C<n>, -p<n> options as well
  git-am: propagate --3way options as well
  Test that git-am does not lose -C/-p/--whitespace options

 git-am.sh             |   15 +++++++++----
 t/t4252-am-options.sh |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t4252/am-test-1-1   |   19 +++++++++++++++++
 t/t4252/am-test-1-2   |   21 +++++++++++++++++++
 t/t4252/am-test-2-1   |   19 +++++++++++++++++
 t/t4252/am-test-2-2   |   21 +++++++++++++++++++
 t/t4252/am-test-3-1   |   19 +++++++++++++++++
 t/t4252/am-test-3-2   |   21 +++++++++++++++++++
 t/t4252/am-test-4-1   |   19 +++++++++++++++++
 t/t4252/am-test-4-2   |   22 ++++++++++++++++++++
 t/t4252/file-1-0      |    7 ++++++
 t/t4252/file-2-0      |    7 ++++++
 12 files changed, 239 insertions(+), 5 deletions(-)
 create mode 100755 t/t4252-am-options.sh
 create mode 100644 t/t4252/am-test-1-1
 create mode 100644 t/t4252/am-test-1-2
 create mode 100644 t/t4252/am-test-2-1
 create mode 100644 t/t4252/am-test-2-2
 create mode 100644 t/t4252/am-test-3-1
 create mode 100644 t/t4252/am-test-3-2
 create mode 100644 t/t4252/am-test-4-1
 create mode 100644 t/t4252/am-test-4-2
 create mode 100644 t/t4252/file-1-0
 create mode 100644 t/t4252/file-2-0
