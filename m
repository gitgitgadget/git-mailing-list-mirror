From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] branch: do not attempt to track HEAD implicitly
Date: Wed, 15 Dec 2010 16:26:35 +0100
Message-ID: <201012151626.35366.trast@student.ethz.ch>
References: <6ee1f0174b757e25ab873d2d037545ac7db698ee.1292351886.git.trast@student.ethz.ch> <AANLkTi=PPx-pLEeR4gLw0KzV_=ZnuqqH_CGc6L7RzU7M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PStIM-0006HS-RX
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab0LOP0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 10:26:37 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:22226 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab0LOP0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:26:36 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:26:27 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:26:35 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-16-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <AANLkTi=PPx-pLEeR4gLw0KzV_=ZnuqqH_CGc6L7RzU7M@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163784>

Martin von Zweigbergk wrote:
> On Tue, Dec 14, 2010 at 1:38 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> > Silently drop the HEAD candidate in the implicit (i.e. without -t
> > flag) case, so that the branch starts out without an upstream.
> 
> Thanks. This has been on my todo list for a while.
> 
> Should it only check for HEAD? How about ORIG_HEAD and FETCH_HEAD?
> Simply anything outside of refs/ maybe? Would that make sense?

Good point.  It seems HEAD wins the dwim_ref() over the rest:

$ g rev-parse HEAD ORIG_HEAD FETCH_HEAD
79f9a226d33659f0e6a69429931d66b5f70c9708
79f9a226d33659f0e6a69429931d66b5f70c9708
79f9a226d33659f0e6a69429931d66b5f70c9708
$ g branch test
$ g config -l | grep branch.test.

Not sure through which mechanism, however.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
