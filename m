From: "glpk xypron" <xypron.glpk@gmx.de>
Subject: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 00:28:20 +0100
Message-ID: <20121111232820.284510@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 00:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXgx9-0001Pa-EG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 00:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab2KKX2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 18:28:22 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:35166 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750810Ab2KKX2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 18:28:21 -0500
Received: (qmail 28279 invoked by uid 0); 11 Nov 2012 23:28:20 -0000
Received: from 78.35.180.50 by www080.gmx.net with HTTP;
 Mon, 12 Nov 2012 00:28:20 +0100 (CET)
X-Authenticated: #41704822
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX18qazsrgwQq+3xSY+oCO2N3VGCxCqzw9TOsNj+/8H
 kT0lB2ZOp+07tZuiYcYEGN/pu3Vxij+kXE0A== 
X-GMX-UID: w1HScEcOeSEqVxc+F3YhifJ+IGRvb8D6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209456>

Gitweb can be used to generate an RSS feed.

Arbitrary tags can be inserted into the XML document describing
the RSS feed by careful construction of the URL.

Example
http://server/?p=project.git&a=rss&f=</title><script>alert(document.cookie)</script><title>

The generated XML contains
<script>alert(document.cookie)</script>

Depending on the system used to render the XML this might lead
to the execution of javascript in the security context of the
gitweb server pages.

Please, escape all URL parameters.

Version tested:
gitweb v.1.8.0.dirty with git 1.7.2.5

Best regards

Heinrich Schuchardt
