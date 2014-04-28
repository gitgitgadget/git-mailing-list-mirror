From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 00:36:50 -0700 (PDT)
Message-ID: <1398670610456-7608792.post@n2.nabble.com>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 09:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WegO8-0002zM-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 09:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbaD1Hxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 03:53:46 -0400
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:54658
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaD1Hxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 03:53:44 -0400
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Apr 2014 03:53:44 EDT
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <marat@slonopotamus.org>)
	id 1Weg7d-00088F-FR
	for git@vger.kernel.org; Mon, 28 Apr 2014 00:37:05 -0700
In-Reply-To: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247241>

Silvola Tuomas wrote
> Hello,
> 
> I installed git for windows 1.9.0 but any push operation I tried with it
> produced an error message saying "git: 'http-push' is not a git command".
> Other commands like pull, add, and commit worked just fine.
> At the end of this day I noticed that C:\Program Files
> (x86)\Git\libexec\git-core just didn't have the file git-http-push. There
> were git-http-backend, git-http-fetch and git-imap-send and such but no
> git-http-push.
> 
> I resolved my issue by uninstalling 1.9.0, installing an older version
> instead (1.8.1.2; this is when push started working) and 1.9.0 right on
> top of the older version. Now git push command works as expected.
> 
> Br,
> Tuomas Silvola

>From Makefile:

	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null |
sort -r | sed -ne 2p)
	ifeq "$(curl_check)" "070908"
		ifndef NO_EXPAT
			PROGRAM_OBJS += http-push.o
		endif
	endif

if there's no curl-config, http-push.c is silently skipped. This check also
doesn't play with cross-compiling when you cannot call curl-config because
it is for other arch.

There's also a mystic git-http-push$X that is not referenced from anywhere.



--
View this message in context: http://git.661346.n2.nabble.com/git-version-1-9-0-missing-git-http-push-tp7608787p7608792.html
Sent from the git mailing list archive at Nabble.com.
