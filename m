From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Is there a way to control the number of revisions will be saved
 by git
Date: Wed, 03 Dec 2008 12:22:43 +0100
Message-ID: <49366C03.5080506@viscovery.net>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tzury Bar Yochay <tzury.by@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 12:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ppu-0001Vi-7y
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYLCLWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbYLCLWt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:22:49 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20669 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYLCLWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 06:22:48 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L7poa-0007W4-7C; Wed, 03 Dec 2008 12:22:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0CA9AA865; Wed,  3 Dec 2008 12:22:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tzury Bar Yochay schrieb: > Hello Happy Gitters, > > Say I
	wish to save only 100 generations back (per branch). > Is it possible to
	configure git so it will save only N records back. No. > If git cannot be
	configured for that, Is there a way to shrink the repository > manually so
	it will contain the last N generations? [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102243>

Tzury Bar Yochay schrieb:
> Hello Happy Gitters,
> 
> Say I wish to save only 100 generations back (per branch).
> Is it possible to configure git so it will save only N records back.

No.

> If git cannot be configured for that, Is there a way to shrink the repository
> manually so it will contain the last N generations?

Yes:

  $ git rev-parse HEAD~$N >> .git/info/grafts
  $ git filter-branch HEAD

This assumes that your history is strictly linear and you do not have
tags. It also rewrites the $N commits so that they now have different
SHA1s. For this reason, don't share this repository with anyone - it leads
to confusion.

-- Hannes
