From: nemo <nemo@ikkoku.de>
Subject: Conflict removed lines from the change set
Date: Fri, 10 May 2013 14:10:47 +0200
Message-ID: <1368187847.18427.8.camel@nemo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 14:16:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UamFs-0008Eu-9q
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 14:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab3EJMQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 08:16:52 -0400
Received: from kyoko.ikkoku.de ([5.9.116.230]:60378 "EHLO kyoko.ikkoku.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752530Ab3EJMQv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 08:16:51 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 May 2013 08:16:51 EDT
Received: by kyoko.ikkoku.de (Postfix, from userid 113)
	id 4FDA2C04E8; Fri, 10 May 2013 14:11:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kyoko.ikkoku.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.2
Received: from [192.168.1.102] (p578EB331.dip0.t-ipconnect.de [87.142.179.49])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: nemo)
	by kyoko.ikkoku.de (Postfix) with ESMTPSA id D2C65BFA29
	for <git@vger.kernel.org>; Fri, 10 May 2013 14:11:05 +0200 (CEST)
X-Mailer: Evolution 3.6.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223836>

It seems that on conflict git 1.8.1.2 removes lines
below the preserved line.

Before merging my master branch onto my staging branch
I have this in the soon to be conflicting file:

  [... stuff ...]
  lib.printMenuBottom.10.20.typolink.additionalParams =
&print=1&no_cache=1
  [... stuff ...]

The changes from master look like this:

  [... stuff ...]
+
+ [globalVar = GP:tx_gois24api_piModeratedShow|action|show = expose]
+ lib.printMenuBottom.10.20.typolink.additionalParams =
&print=1&no_cache=1&type=26
+ [else]
  lib.printMenuBottom.10.20.typolink.additionalParams =
&print=1&no_cache=1
 +[global]
  [... stuff ...]

After merging and having a conflict git-diff reports this:

++<<<<<<< HEAD
++=======
+ 
+ [globalVar = GP:tx_gois24api_piModeratedShow|action|show = expose]
+ lib.printMenuBottom.10.20.typolink.additionalParams =
&print=1&no_cache=1&type=26
+ [else]
++>>>>>>> master
  lib.printMenuBottom.10.20.typolink.additionalParams =
&print=1&no_cache=1
 -[global]
 -

Why is the [global] line marked for removal? I presume that this
should not be the case.
