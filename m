From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 0/6] Use git conflict handling on push
Date: Mon, 20 Aug 2007 10:11:57 +0200
Message-ID: <11875975232619-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2ka-0000iq-DW
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbXHTIgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:35 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbXHTIge
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:34 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52181 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbXHTIgd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 386FF200A21D;
	Mon, 20 Aug 2007 10:12:05 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17409-01-6; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id A7E9E200A1F4;
	Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 41045BFC8A; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56191>

This series of patches updates "stg push" to leave conflicts in the
index, in the normal git fashion.

This means that conflict handling and resolution are handled by git
and not stg, which should make it possible to simplify stg quite a
bit.  For instance, the 'conflicts' file should go away.

Unfortunately, this patch series isn't complete, since it doesn't
remove all uses of the stg merge code.  The remaining client of that
code is the "sync" command, which I have never used, and haven't
studied very much.  But if that command is changed somehow, then most
of the code in gitmergeonefile.py will go simply away. And the
'conflicts' file will not be used.


See also previous discussions:

https://gna.org/task/?5140
http://thread.gmane.org/gmane.comp.version-control.git/48271

--=20
David K=C3=A5gedal
