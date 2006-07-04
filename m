From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 0/2] Fix handling of merges in git-annotate
Date: Mon, 03 Jul 2006 21:30:00 -0400
Message-ID: <11519766021208-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 03:33:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZmc-0000N0-I8
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWGDBcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGDBcw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:32:52 -0400
Received: from h4x0r5.com ([70.85.31.202]:60932 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751179AbWGDBcv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:32:51 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FxZkI-0004EK-Nz; Mon, 03 Jul 2006 18:30:35 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FxZjm-00042X-Uk; Mon, 03 Jul 2006 21:30:03 -0400
To: junkio@cox.net
X-Mailer: git-send-email 1.4.1.g8fced
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23233>

This 2-patch series is a major overhaul to the way git-annotate calculates the blame for each line.

Instead of parsing each diff in reverse, this uses the output from "git
diff-tree --combined", so that merges can be handled sanely.

Ryan Anderson:
      annotate: Support annotation of files on other revisions.
      annotate: Correct most merge following to annotate correctly.

 git-annotate.perl   |  197 ++++++++++++++++++++++++++++++++++++---------------
 t/t8001-annotate.sh |    6 ++
 2 files changed, 145 insertions(+), 58 deletions(-)
