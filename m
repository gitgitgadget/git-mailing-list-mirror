From: <Patrick.Higgins@cexp.com>
Subject: Windows symlinks
Date: Tue, 24 Jun 2008 16:42:49 -0600
Message-ID: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHGE-0006BF-Ry
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYFXWoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYFXWoU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:44:20 -0400
Received: from mx02.cexp.com ([170.131.136.83]:17800 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbYFXWnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 18:43:49 -0400
Received: from uscobrmfa-se-05 (uscobrmfa-se-05.cexp.com [170.131.144.36])
	by mx02.cexp.com (Postfix) with ESMTP id C393D416D55
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 16:43:48 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.36]) by USCOBRMFA-SE-52.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 24 Jun 2008 16:43:48 -0600
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Windows symlinks
Thread-Index: AcjWS6EKqcEXYDfEEd2H9gASPzin7A==
X-OriginalArrivalTime: 24 Jun 2008 22:43:48.0171 (UTC) FILETIME=[C42501B0:01C8D64B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86163>

It looks like one of the bigger (biggest?) hurdles for git adoption at my company is going to be handling symlinks on Windows. We may be able to sidestep the issue entirely by having developers run Linux in a virtual machine (or better yet, Windows in a VM) because we deploy to Linux and thus can make a very strong argument that developers should develop on Linux, too. That run into an image problem where people might start blaming git for needing to have an extra operating system around just for revision control.

We currently use Clearcase snapshot views on Windows and it has some kind of magic to be able to deal with symlinks. I haven't actually used the Windows version of Clearcase so I don't know how it does it, but my understanding is that it handles them with copies, and I guess it somehow knows to update all the copies when a change is made.

Has anyone thought about a way for git to handle symlinks? Vista seems to have added native symlinks, but you need have elevated privilege to create them. NTFS junction points seem helpful for older versions of Windows, but don't work for anything except directories, and seem to be dangerous to use with tools that do recursive deletes. Neither junction points nor native symlinks sound like great options.

Cygwin's clever symlink trick seems to work pretty well in practice. I'm not exactly sure what it's doing, but it seems to create a shortcut that it's own programs understand. Some other non-Cygwin programs seem to understand them, too, but Java does not which is a big problem for me.

I just don't see any good solutions here. Does anyone have any better ideas?

Thanks,
Patrick
