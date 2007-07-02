From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 20:09:37 +0200
Message-ID: <46893F61.5060401@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 20:16:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5QRm-0008AS-2s
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 20:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbXGBSQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 14:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbXGBSQX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 14:16:23 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:59922 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752566AbXGBSQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 14:16:22 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2007 14:16:21 EDT
Received: (qmail 20219 invoked from network); 2 Jul 2007 18:09:39 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 2 Jul 2007 18:09:39 -0000
Received: (qmail 7285 invoked from network); 2 Jul 2007 18:09:38 -0000
Received: from unknown (HELO ?10.0.21.1?) (10.0.21.1)
  by elvis-jaeger.mine.nu with SMTP; 2 Jul 2007 18:09:38 -0000
User-Agent: Icedove 1.5.0.12 (X11/20070607)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51391>

Hello

I'm coming from cogito. There you can run:

  cg-add $file ; cg-rm $file

and everything is as before; it adds the file to the directory
index/cache, and just removes it again from the latter.

Whereas with git,

  git-add $file; git-rm $file

is giving the error

  error: '..file..' has changes staged in the index (hint: try -f)

And sure enough, git rm -f $file will remove the file from the index,
but also unlink it from the directory. (Ok, I did remember that cogito's
-f option is unlinking the file, so I was cautious and didn't try it on
an important file, but still...)

Turns out that

  git rm  -f --cached $file

will do the same action as cg-rm $file.

Why so complicated? Why not just make git-rm without options behave like
cg-rm? (Or at the very least, I'd change the hint to say "try -f --cached".)

Christian.
