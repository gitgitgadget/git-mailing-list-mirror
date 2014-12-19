From: ydirson@free.fr
Subject: [BUG] interactive rebase loses instruction sheet when aborting to
 avoid overwriting files
Date: Fri, 19 Dec 2014 10:42:55 +0100 (CET)
Message-ID: <1075489045.367270447.1418982175581.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <1009315412.367253372.1418981868176.JavaMail.root@zimbra39-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: dirson@bertin.fr, ydirson@free.fr
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 10:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1uCf-0001Qk-2f
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 10:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbaLSJuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 04:50:24 -0500
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:53605 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaLSJuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 04:50:20 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Dec 2014 04:50:19 EST
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 230CA77DC93
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 10:42:57 +0100 (CET)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp1-g21.free.fr (Postfix) with ESMTP id B79169400BA;
	Fri, 19 Dec 2014 10:42:05 +0100 (CET)
In-Reply-To: <1009315412.367253372.1418981868176.JavaMail.root@zimbra39-e7.priv.proxad.net>
X-Originating-IP: [62.23.137.162]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261553>

[using v2.1.3]

When using "rebase -i" and the working dir contains untracked files that are present
in the new base, we correctly get a "would be overwritten by checkout" error, but then
the whole rebase interrupts the (long) listing of the incriminated files in the middle
of a line and terminates with:

Aborting
could not detach HEAD

And consequently we are not rebasing any more, and the precious instruction sheet has been
lost.
