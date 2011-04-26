From: Elias Persson <delreich@takeit.se>
Subject: git diff-index ignores color config
Date: Tue, 26 Apr 2011 17:04:21 +0200
Message-ID: <1303830261.3387.21.camel@dhcp-141.kontor.deklomp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 17:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEkAK-0001nD-Ls
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 17:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab1DZP07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 11:26:59 -0400
Received: from customer.fxs.se ([62.20.50.25]:46464 "EHLO mail.takeit.se"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab1DZP06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 11:26:58 -0400
X-Greylist: delayed 1352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Apr 2011 11:26:58 EDT
Received: from [85.24.215.141] (unknown [85.24.215.141])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.takeit.se (Postfix) with ESMTP id D9D874FF02
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 17:04:21 +0200 (CEST)
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172100>

Having color.ui (and/or color.diff) set to auto, doing

   git diff-index --check <some refspec>

on a set with e.g. trailing whitespace does not produce colored
output.

If providing the option on the command line, e.g.

   git diff-index --check --color=auto <some refspec>

output _is_ colored, so obviously not an issue with tty
detection. Doesn't work when configured to 'true' either.


Documentation indicates that the config option is considered
(see under --no-color), so to me it seems like there's a bug
here, somewhere.


Most likely way of coming across this issue would be turning on
the shipped pre-commit hook sample, at least that's how I found
it. It ends (and does most of its work) with

    exec git diff-index --check --cached $against --

where $against is normally HEAD.


git --version: 1.7.4.4
uname -srio: Linux 2.6.35.12-88.fc14.i686 i386 GNU/Linux


// Delreich
