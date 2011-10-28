From: Andrew Eikum <aeikum@codeweavers.com>
Subject: imap-send badly handles commit bodies beginning with "From <"
Date: Fri, 28 Oct 2011 13:00:44 -0500
Message-ID: <20111028180044.GA3966@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 20:17:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJqzb-00015n-BE
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab1J1SRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:17:19 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:43313 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab1J1SRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:17:18 -0400
X-Greylist: delayed 985 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2011 14:17:18 EDT
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>)
	id 1RJqjc-0003tU-Q0
	for git@vger.kernel.org; Fri, 28 Oct 2011 13:00:52 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184422>

Ran into this today. I had a commit message that looked like:

---
Do something

>From <http://url>:
Words
---

I put it through imap-send to email it to my project, and ended up
with this output:

sending 1 messages
 200% (2/1) done

On the server side, it was split into two mails on either side of that
commit message's From line with neither mail actually containing the
From line. To fix it, I just changed it to "Copied from <url>:" :-P

Ain't mbox grand?
