From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFD: Misleading log --graph online
Date: Mon, 16 May 2011 10:58:41 +0200
Message-ID: <4DD0E741.1050303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 10:58:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLtda-0003Zm-3f
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 10:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab1EPI6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 04:58:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58267 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215Ab1EPI6n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 04:58:43 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 600A0206D9
	for <git@vger.kernel.org>; Mon, 16 May 2011 04:58:43 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 16 May 2011 04:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=bGs/C/rz+7V3wSMHfLb56uwD0Ko=; b=TXPCFVweeGjvMZnKfZ3ahWbYrIPbjjKMwf8Zh7NzW7pVzNHblSQOdw5ME3S64MP7Y72NXlnLKkWmN9f2mHkq8Iy6iGUqjEcEBkLbApsrWVwz3+B8MgXI+sW96PhwHr5x+cDDTzedo30R53vShJylVfNC3B5TTu4yQG67msbiueY=
X-Sasl-enc: 7ZcELfaAT4TU+QFQ16w6iViQPc+Ekj72ktsNGgV3wk2N 1305536323
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 053C1442530
	for <git@vger.kernel.org>; Mon, 16 May 2011 04:58:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173716>

Consider these snippets of output:
git log --graph --oneline --decorate --all

* ca19d2e (upstream/trunk, upstream/master, svn/trunk) update upload data
* cd2cb19 update download url
...
* ab11781 new filelocator module
* 8125929 fix: dodata->doplot
| * e234268 (svn-tags/pyx_0_11) tagging release 0.11
| * 580cbdf (svn-tags/pyx_0_11@3128) documentation update...
...
| * ffa2e8f *** empty log message ***
| * 90dd12c *** empty log message ***
| * 2c29cab (svn-tags/pyx_0_10) tagging 0.10
|/
* 42fdff5 (tag: svn/pyx_0_10) some updates to the webpage
* fac723b some adjustments to keep support for a broad range...
...

Obviously, there is a side branch svn-tags/pyx_0_11 which forked off
42fdff5, right?

No, in fact 90dd12c is the root commit of that branch! 2c29cab is the
tip of svn-tags/pyx_0_10.

In other words, our graph output can be very misleading in a case like
that. I would suggest to mark a root commit with "o" like we do for
boundary commits. (tig uses "o" or "*" for ordinary commits and "I" for
a root.)

But I'm not sure that we don't create misleading output like that in
other situations also, like for A@{1}..A where we produce "virtual
roots" as well.

The main problem appears to be that "*" does not convey any connectivity
information. Wondering whether we could use graphic symbols from some
charset...

Michael
