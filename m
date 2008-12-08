From: "Li Frank" <Frank.Li@freescale.com>
Subject: RE: Can Git push only first parent history commits?
Date: Mon, 8 Dec 2008 11:11:30 +0800
Message-ID: <402F4B33D9C9DE4083DB96B416549FAF9E2D@zch01exm23.fsl.freescale.net>
References: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net> <7v7i6bbcc6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 04:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WYY-0006HK-KH
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 04:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbYLHDLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 22:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYLHDLr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 22:11:47 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:60389 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbYLHDLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2008 22:11:47 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id mB83BcGD024872
	for <git@vger.kernel.org>; Sun, 7 Dec 2008 20:11:38 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mB83BbeW012504
	for <git@vger.kernel.org>; Sun, 7 Dec 2008 21:11:37 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7v7i6bbcc6.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can Git push only first parent history commits?
Thread-Index: AclY4Tl/49DFvoEzQoWWXlbbsavX1AAAId2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102524>

I don't know the detail of git internal.  Or my email subject
description have some problem. 
 
I just want to combine some commits to one commit and push combined
commit to remote.  And at same time, keep commits history at my local
repository.  Rebase will make original history lost. 
 

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Monday, December 08, 2008 11:00 AM
To: Li Frank-B20596
Cc: git@vger.kernel.org
Subject: Re: Can Git push only first parent history commits?

Your drawing nor explanation unfortunately does not make much sense to
me, so I'll respond only to the subject.

Pushing only first parent history would mean that the commits you will
be transferring will still record their true parents, but you are not
sending any parents but the first ones.  The repository that receives
such a push would not pass fsck, in other words, you are deliberately
corrupting the repository.

Naturally we won't support such an operation by default.

It is plausible that you can implement an option to do so, but it would
make it hard at the receiving end to tell between a true repository
corruption and a corruption you are deliberately introducing by such a
push, so it won't be useful unless accompanied by a corresponding option
to fsck to make it not complain when parent commits and associated
objects that are not necessary for first parent history.
